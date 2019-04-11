Content-Type: multipart/mixed; boundary="===============0577555058996278139=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/2] mptcp: two minor improvements
Date: Thu, 11 Apr 2019 13:43:23 +0200
Message-ID: <20190411114325.29375-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1062

--===============0577555058996278139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

First patch makes it so CONFIG_MPTCP=3Dn build is same as
building a kernel with all mptcp patches reverted.

Second patch provides minor size reduction of tcp_sock struct
by closing a 6-byte hole in mptcp rx option struct.

As usual, feel free to squash them as needed.



--===============0577555058996278139==--
