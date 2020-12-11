Content-Type: multipart/mixed; boundary="===============1749719842981656271=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [mptcp-net PATCH] mptcp: fix security context on server socket
Date: Fri, 11 Dec 2020 17:28:10 +0100
Message-ID: <3a0d657c067957c1dc18310c63179fade8f9a563.1607704071.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7150

--===============1749719842981656271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently MPTCP is not propagating the security context
from the ingress request socket to newly created msk
at clone time.

Address the issue invoking the missing security helper.

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections=
")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 88f2a7a0ccb8..967ce9ccfc0d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2081,6 +2081,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	/* will be fully established after successful MPC subflow creation */
 	inet_sk_state_store(nsk, TCP_SYN_RECV);
+
+	security_inet_csk_clone(nsk, req);
 	bh_unlock_sock(nsk);
 =

 	/* keep a single reference */
-- =

2.26.2

--===============1749719842981656271==--
