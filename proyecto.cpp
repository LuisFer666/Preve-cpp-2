#include <iostream> // cin, cout, cin.get
#include <fstream> // ifstream
#include <string>
#include <regex>

using namespace std;

void leerContenido();

string contenido;

int main(){    
    leerContenido();
        
    string lenguajeFake = "((AB?(CDF?E(GH)+(((I|J|k)|L)+M)+)?)+(((A?(B|(L|(N|Ñ|O|P))))+(Q(R|S))?)*)(DFG)?)*";
    
    string lenguajeOK = "((AB?(CDF?E(GH)+(((IJK)|L)+M)+)?)+(((A?(B|(L|(N|Ñ|O|P))))+(Q(R|S))?)*)(DFG)?)*";
    
    string a1 = "(a2)*";
    string a2 = "(a3)+()(DFG)?";
    string a3 = "AB?()?";
    string a4 = "CDF?E(GH)+()+"
    
    regex expresion("(DFG)?");    
    bool cosa = regex_match(contenido, expresion);    
    cout << (cosa)?"Si\n":"No\n";
}

void leerContenido(){
    string archivo;
    cout << "File name: ";
    cin >> archivo;
    
    ifstream is(archivo); // Iniciar el buffer
        
    if(is.is_open()){ // Revisar si el archivo se abrio
        char c;
        while(is.get(c)){ // Leer caracteres
            contenido+=c;
        }
        cout << archivo << " abierto\n";
        cout << "Contenido:\n[" << contenido <<"]\n";
        is.close(); // Cerrar el buffer
    }else{
        cout << "No se pudo abrir el archivo\n";
        is.close(); // Cerrar el buffer
        exit(0);
    }
}

