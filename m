Content-Type: multipart/mixed; boundary="===============8769995699322842362=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Add sock_put() call on error path
Date: Mon, 12 Aug 2019 16:57:58 -0700
Message-ID: <20190812235758.8530-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1630

--===============8769995699322842362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Per final review comment

squashto: Add handling of outgoing MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 448c9e7f567a..27afc64d377f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -257,6 +257,7 @@ int subflow_connect(struct sock *sk, struct sockaddr_in=
 *local,
 	return err;
 =

 failed:
+	sock_put(sf->sk);
 	sock_release(sf);
 	return err;
 }
-- =

2.17.2


--===============8769995699322842362==--
