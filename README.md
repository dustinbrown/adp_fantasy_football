This is a simple sinatra app to help with fantasy football drafting.  It displays players with the average draft position from http://www.myfantasyleague.com

Start it:
ruby bin/app.rb

Access it by browser:
http://localhost:8080

  # Ensure devpi pip module is installed
  # Use a virtual environment if desired
  pip install devpi

  # Use jama pypi server; Short hand - devpi use root/hosted
  devpi use https://devpi.jamacloud.com/root/hosted/+simple/

  # Login to pypi server
  # Get password from team member/devops
  devpi login root

  # Verify $PROJECT_HOME/parse_database/setup.py has correct meta data
  # Version is generally modified

  # Upload new pip module
  cd $PROJECT_HOME/parse_database
  devpi upload
