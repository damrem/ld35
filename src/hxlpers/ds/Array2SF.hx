package hxlpers.ds;
import de.polygonal.ds.Array2;
import hxlpers.Direction;

using hxlpers.ds.Array2SF;

/**
 * ...
 * @author damrem
 */
class Array2SF
{

	static public function getCellOf<T>(user:Array2<T>, x:T):Array2Cell
	{
		var cell = new Array2Cell();
		user.cellOf(x, cell);
		return cell;
	};
	
	static public function sameRow<T>(user:Array2<T>, x:T, y:T):Bool
	{
		return user.getCellOf(x).y == user.getCellOf(y).y;
	}
	
	static public function sameCol<T>(user:Array2<T>, x:T, y:T):Bool
	{
		return user.getCellOf(x).x == user.getCellOf(y).x;
	}
	
	static public function getNeighborCell<T>(user:Array2<T>, refCell:Array2Cell, direction:Direction, wrapped=false):Array2Cell
	{
		var cell = new Array2Cell(refCell.x, refCell.y);
		switch(direction)
		{
			default:
			case Right:
				cell.x++;
				if (cell.x >= user.getW())
				{
					if (!wrapped) return null;
					cell.x = 0;
				}
				
			case Down:
				cell.y++;
				if (cell.y >= user.getH())
				{
					if (!wrapped) return null;
					cell.y = 0;
				}
				
			case Left:
				cell.x--;
				if (cell.x < 0)
				{
					if (!wrapped) return null;
					cell.x = user.getW() - 1;
				}
				
			case Up:
				cell.y--;
				if (cell.y < 0)
				{
					if (!wrapped) return null;
					cell.y = user.getH() - 1;
				}
				
		}
		return cell;
	}
	
	static public function getNeighbor<T>(user:Array2<T>, x:T, direction:hxlpers.Direction):T
	{
		var cell = user.getNeighborCell(user.getCellOf(x), direction);
		if (cell == null) return null;
		return user.getAt(cell);
	}
	
	static public function areVNeighbors<T>(user:Array2<T>, x:T, y:T):Bool
	{
		var dy = user.getCellOf(x).y - user.getCellOf(y).y;
		return user.sameCol(x, y) && dy * dy == 1;
	}
	
	static public function areHNeighbors<T>(user:Array2<T>, x:T, y:T):Bool
	{
		var dx = user.getCellOf(x).x - user.getCellOf(y).x;
		return user.sameRow(x, y) && dx * dx == 1;
	}
	
	static public function areNeighbors<T>(user:Array2<T>, x:T, y:T):Bool
	{
		return user.areHNeighbors(x, y) || user.areVNeighbors(x, y);
	}
	
	
	static public function move<T>(user:Array2<T>, colIndex:Int, rowIndex:Int, direction:hxlpers.Direction, ?inserted:T):T
	{
		var colOrRow:Array<T> = [];
		
		var outtered:T;
		
		switch(direction)
		{
			default:
				outtered = null;
			case Direction.Right:
				user.getRow(rowIndex, colOrRow);
				outtered = colOrRow.pop();
				colOrRow.unshift(inserted == null?outtered:inserted);
				user.setRow(rowIndex, colOrRow);
				
			case Direction.Down:
				user.getCol(colIndex, colOrRow);
				outtered = colOrRow.pop();
				colOrRow.unshift(inserted == null?outtered:inserted);
				user.setCol(colIndex, colOrRow);
				
			case Direction.Left:
				user.getRow(rowIndex, colOrRow);
				outtered = colOrRow.shift();
				colOrRow.push(inserted == null?outtered:inserted);
				user.setRow(rowIndex, colOrRow);
				
			case Direction.Up:
				user.getCol(colIndex, colOrRow);
				outtered = colOrRow.shift();
				colOrRow.push(inserted == null?outtered:inserted);
				user.setCol(colIndex, colOrRow);
		}
		
		return outtered;
	}
	
}