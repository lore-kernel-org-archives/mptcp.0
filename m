Content-Type: multipart/mixed; boundary="===============5404026047036707245=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Remove request_version field from
 subflow_request_sock
Date: Wed, 11 Dec 2019 20:54:48 -0800
Message-ID: <20191212045448.13439-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2880

--===============5404026047036707245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since only a single version is supported this fields presence
is misleading, it dates from when it was thought the version would
be configurable. The actual requested version is hard-coded in
mptcp_write_options().

squashto: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 1 -
 net/mptcp/protocol.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 502c464f3d69..bbd6c58154fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -123,7 +123,6 @@ static struct socket *mptcp_socket_create_get(struct mp=
tcp_sock *msk)
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
-	subflow->request_version =3D 0; /* currently only v0 supported */
 =

 	sock_hold(ssock->sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ddb3a7581d41..93d6c41b76d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -48,8 +48,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct so=
ck *sk)
 =

 /* MPTCP subflow context */
 struct mptcp_subflow_context {
-	u32	request_mptcp : 1,  /* send MP_CAPABLE */
-		request_version : 4;
+	u32	request_mptcp : 1;  /* send MP_CAPABLE */
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
 	struct	rcu_head rcu;
-- =

2.17.2

--===============5404026047036707245==--
