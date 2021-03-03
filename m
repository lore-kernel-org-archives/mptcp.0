Content-Type: multipart/mixed; boundary="===============2381600244942607859=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 PATCH 0/2] mptcp: fix deadlock in mptcp{,6}_release
Date: Wed, 03 Mar 2021 19:43:37 +0100
Message-ID: <cover.1614796802.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 8001

--===============2381600244942607859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This address the issue the easy way: removing the bugged features
(a lot of setsockopt including all mcast related).

As suggested by Mat(s) this switch to a whitelist. Assembling the
whilelist itself is quite complex/tedious/errorprone so still RFC.

Please have a look at 1/2 for the details

Paolo Abeni (2):
  mptcp: only admit explicitly supported sockopt
  mptcp: revert "mptcp: provide subflow aware release function"$ ....$

 net/mptcp/protocol.c | 270 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 217 insertions(+), 53 deletions(-)

-- =

2.26.2

--===============2381600244942607859==--
