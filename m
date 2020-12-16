Content-Type: multipart/mixed; boundary="===============8741046127210223330=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/4] mptcp: fix security context on server socket
Date: Wed, 16 Dec 2020 12:48:32 +0100
Message-ID: <1bf3ee9b0c79a1e619fe4749d926aab71f0a7bcc.1608114076.git.pabeni@redhat.com>
In-Reply-To: cover.1608114076.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7189

--===============8741046127210223330==
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
index b812aaae8044..d24243a28fce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2699,6 +2699,8 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
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

--===============8741046127210223330==--
