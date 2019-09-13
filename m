Content-Type: multipart/mixed; boundary="===============2988756500177601830=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] mptcp: partial recvmsg() refactor
Date: Fri, 13 Sep 2019 10:47:26 +0200
Message-ID: <cover.1568363662.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1832

--===============2988756500177601830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This 2 patches start the recvmsg() refactor discussed in last mtg.
The explicit 'duplicate data' handling in 1/2 fix some stream corruption I
observe with re-injection, and the 2nd one fix another stream corruption at
the end of the stream, still triggered  by re-injection.

With the above 2 patches I still stream corruptions with re-injection, are
almost gone - even if I can still hit them with in at least a very rare cor=
ner
case.

Paolo Abeni (2):
  mptcp: refactor recvmsg()
  mptcp: recvmsg() should really try to deliver 'len' bytes to
    user-space

 net/mptcp/protocol.c | 119 +++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 66 deletions(-)

-- =

2.21.0


--===============2988756500177601830==--
