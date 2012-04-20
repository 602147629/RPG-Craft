#pragma once

#include <iostream>
//#include <string>
#include <json/json.h>
#include <iostream>
#include <fstream>
#include <boost/asio.hpp>
#include <conio.h>

Json::Value root;   // will contains the root value after parsing.
Json::Reader reader;
const char *file = "level.json";

using boost::asio::ip::tcp;

char updateInput(void) {
	if (_kbhit())
	{
		// get keyboard data, and filter it
		char key = toupper(_getch());
		
		return key;
	}

	return 0;
}

/*boost::asio::io_service io_service;
tcp::endpoint endpoint(tcp::v4(), 13);
tcp::acceptor acceptor(io_service, endpoint);*/
