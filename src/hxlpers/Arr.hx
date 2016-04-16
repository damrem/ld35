package hxlpers;
/**
 * Outils de manip de tableaux.
 * @author damrem
 */
class Arr
{
	/**
	 * @param array Le tableau dans lequel rechercher.
	 * @param item L'élément à rechercher.
	 * @return L'indice dans le tableau de l'élément recherché, -1 si non trouvé.
	 */
	public static function indexOf<T>(array:Array<T>, item):Int
	{
		for (i in 0...array.length)
		{
			if (array[i] == item)
			{
				return i;
			}
		}
		return -1;
	}
	
	/**
	 * @param array Le tableau dans lequel rechercher.
	 * @param item L'élément à rechercher.
	 * @return Si l'élément est contenu dans le tableau.
	 */
	public static function contains<T>(array:Array<T>, item):Bool
	{
		return (indexOf(array, item) >= 0);
	}
	
	/**
	 * Effectue un tri à bulles sur un tableau (attention, le tableau est modifié.
	 * @param	array Le tableau à trier.
	 * @param	desc Si le tri doit être obtenu dans l'ordre décroissant.
	 */
	public static function bubbleSort( array : Array<Float>, desc:Bool=false):Void
	{
		var n:UInt = array.length;
		var swapped:Bool;
		do 
		{
			swapped = false;
			
			for (i in 1...n)
			{
				if(array[i - 1] > array[i])
				{
					swap(array, i, i - 1);
					swapped = true;
				}
			}
			n = n - 1;
		}
		while (swapped);
		if (desc)
		{
			array.reverse();
		}
	}
	
	
	/**
	 * Echange dans le tableau les deux indices.
	 * @param	array Le tableau dans lequel échanger.
	 * @param	i Le premier indice à échanger.
	 * @param	j Le deuxième indice à échanger.
	 */
	public static function swap<T>(array:Array<T>, i:UInt, j:UInt):Void
	{
		var temp:T = array[i];
		array[i] = array[j];
		array[j] = temp;
					
	}
}