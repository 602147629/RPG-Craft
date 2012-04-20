#include "main.h"

using namespace std;
using boost::asio::ip::tcp;

void connect() {
	// Send level data
	// Set player in XML
	// Send notice to logged in players
	// Create a logout leese?
}

void handleRequests() {
	try
	{
		boost::asio::io_service io_service;

		Json::StyledWriter writer;
		string file_as_string = writer.write( root );

		int x;
		int y;
		int z;
		
		tcp::endpoint endpoint(tcp::v4(), 13);
		tcp::acceptor acceptor(io_service, endpoint);
		for (;;)
		{
			tcp::iostream stream;
			acceptor.accept(*stream.rdbuf());

			/*Also I seem to recall that Flash needed terminating null-bytes on each packet,
			so instead of send(socket,szData,strlen(szData),0); use send(socket,szData,strlen(szData)+1,0); to send a string :)*/
			stream << file_as_string;
			stream >> x;
			stream >> y;
			stream >> z;

			//root[].
		}
	}
	catch (std::exception& e)
	{
		std::cerr << e.what() << std::endl;
	}
	/*if (stream) {
	}
	login 
		serve json
		login player
	movement
	store_json
	new_cubes
	delete_cubes*/
}

bool loadJSON() {
	fstream myfile;
	string file_as_string;
	string line;

	// Change file into string
	myfile.open (file);
	
	if (myfile.is_open()) {
		while ( myfile.good() ) {
			getline (myfile,line);
			file_as_string += line;
			file_as_string += "\n";
		}
		myfile.close();
	}
	else {
		cout << "Unable to open file\n"; 
		return false;
	}

	bool parsingSuccessful = reader.parse( file_as_string, root );
	if ( !parsingSuccessful )
	{
		// report to the user the failure and their locations in the document.
		cout  << "Failed to parse json\n" << reader.getFormattedErrorMessages();

		return false;
	}

	return true;
}

bool storeJSON() {
	// Make a new JSON document and preserve original comments.
	Json::StyledWriter writer;
	string file_as_string = writer.write( root );

	cout << file_as_string;

	ofstream myfile (file);
	if (myfile.is_open()) {
		myfile << file_as_string;
		myfile.close();
	}
	else {
		cout << "Unable to open file\n";
		return false;
	}

	return true;

	// You can also use streams.  This will put the contents of any JSON
	// stream at a particular sub-value, if you'd like.
	//std::cin >> root["subtree"];
}

int main() {
	cout << "Server for Flash game RPG project Abertay University 2012" << endl;
	cout << "Loading JSON...." << endl;

	if (loadJSON()) {
		bool isAlive = true;

		while (isAlive) {
			char key = updateInput();

			if (key == 'Q')
				isAlive = false;

			handleRequests();
		}
		storeJSON();
	}

	system("PAUSE");
}
