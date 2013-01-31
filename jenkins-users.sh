useradd bent -p s4apfe -m
usermod -G wheel bent
mkdir /home/bent/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAwhQpe8kj3jJC8TQbd9vR8eAticA6kwsc2IMYf79oSsECoQZDPu59HxxBH5VhnUwrem2orRu+MvD22YCHmQ1hwgZ+n1hqzPQ+81/O7BeBWZI3oR7pi4gc0RsIvvntCGTHFtKP3FL1pD5Li5zW+c1c72+xEGXY/RJkTi5/wTKvCapU1dNAaYQQXnn6xUi3CPHXwbC8ENy797S3YS/rRlkJiq3o+t0+TyWVORG4K4t3mkWE3n3QfVU2wK0Th6eKIjK3U3s5qRLAclQCI3auIAag5ARwgHe7CaqjQ9yowzc0YNGMG0eXRwYmhxKduzMmbTvNucaRORUDm4gycuhc8Lih7w== ben.teese@gmail.com" >> /home/bent/.ssh/authorized_keys2
chmod 600 /home/bent/.ssh/authorized_keys2
chown -R bent:bent /home/bent/.ssh

useradd lukea -p s4apfe -m
usermod -G wheel lukea
mkdir /home/lukea/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA1wyj1qrDgQLaMbM7mKhHJfRraafu/NXpBCxuf70m4JZFBOzmqwE0FRdeUeX2+Uob4Eah3O/nb/WSpggTriK8a9F66G+sv9VYcTsp0sJgjZ7oxqUe67PUvnW3RIAk3pq6x9U4sySzBokxYqphdgTo/EXQQNLaaIR/m+HJuxeO2Nbs/jvQglhmtpQ/yWfNTpDe/CrGQJvLNUs3sI7E2l8zsicCv3spVLTz0CL5oZNELrG86tHAOYpdMIKR+u1QQFJebPt3/V7BoaOM2OQVMqhfS+tHfRek6uGll+RfhFynfiCP6daRK0br2b4MDTD+Ys5Gk0rVztE4eq+oO4BOZMdnMw== lukea@Ali.local
---- BEGIN SSH2 PUBLIC KEY ----
Subject: w74612
Comment: ""
ModBitSize: 1024
AAAAB3NzaC1yc2EAAAADAQABAAAAgQDWfwtiFiEiWqWmUpi6sGXZBrneYqJCr+xs
9W762w7m+wXlBBbetYNKy8u0S6VZFuAEngfiOAVz+oHi0IMQ3yrf288oU8Op5xsP
UQ59/WcXz95cKW7l0bzW4xI3KFSmYOICVrFKzklRGaT37+doQNkdAceqkPJg+yPN
c7WgfWLXUw==
---- END SSH2 PUBLIC KEY ----" >> /home/lukea/.ssh/authorized_keys2
chmod 600 /home/lukea/.ssh/authorized_keys2
chown -R lukea:lukea /home/lukea/.ssh

useradd dannyb -p $1$ZwNWVZTH$uxNA9LObmaYKWEpPN8v/P0 -m
usermod -G wheel dannyb
mkdir /home/dannyb/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSa03xL6A44HnbwxjpvWuzZR9jW1nte25sHhyTqABOgYJCYicyricVxD0Jti14GF6i3klAzyEqaBNebW4MEkrT0iiHQ+gME8Hxf/izJGukJL4rZaY/vUQrR0C9UpW9wbADhXeNvuzX5h7tBYbVe+/5akH1ZOCHuM2EwE8kgoeDPV3WZZYUgcziEn4G6kM12NGuONBS98B1E2ray8lG6Q1fNFnxxKv5UlBbhJZl85Hs5n0TCaQHD7FD3/+hlFNHC3J9uW3hefBk8jCDfL0PS5kjFT44NxC2P52mvsVbmew212z/1O3INMSA39WGlzpOr0nzfqFHL6zGuupNvlbp/cgz dbrain@pixies.local" >> /home/bent/.ssh/authorized_keys2
chmod 600 /home/dannyb/.ssh/authorized_keys2
chown -R dannyb:dannyb /home/dannyb/.ssh