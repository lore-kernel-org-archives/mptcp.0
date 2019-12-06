Content-Type: multipart/mixed; boundary="===============6551870441513881917=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/5] mptcp: pass subflow to mptcp_finish_connect()
Date: Fri, 06 Dec 2019 13:22:44 +0100
Message-ID: <46b107983ced3df9f8c24ce1e97f54458a26c231.1575634848.git.pabeni@redhat.com>
In-Reply-To: cover.1575634848.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2814

--===============6551870441513881917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we avoid going throw 'msk->fallback' to fetch such
pointer.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 8 +++-----
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a5601f10a92..71c8f00a1e37 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -632,14 +632,12 @@ static int mptcp_get_port(struct sock *sk, unsigned s=
hort snum)
 	return inet_csk_get_port(msk->subflow->sk, snum);
 }
 =

-void mptcp_finish_connect(struct sock *sk, int mp_capable)
+void mptcp_finish_connect(struct sock *sk,
+			  struct mptcp_subflow_context *subflow)
 {
-	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
-
-	if (mp_capable) {
+	if (subflow->mp_capable) {
 		u64 ack_seq;
 =

 		/* sk (new subflow socket) is already locked, but we need
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 070d8a3885a9..7e8a37f5b35c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -185,7 +185,8 @@ int mptcp_read_actor(read_descriptor_t *desc, struct sk=
_buff *skb,
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

-void mptcp_finish_connect(struct sock *sk, int mp_capable);
+void mptcp_finish_connect(struct sock *sk,
+			  struct mptcp_subflow_context *subflow);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 03c9e52d376b..b47cabeaccae 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -119,7 +119,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	if (subflow->conn && !subflow->conn_finished) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
-		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
+		mptcp_finish_connect(subflow->conn, subflow);
 		subflow->conn_finished =3D 1;
 =

 		if (skb) {
-- =

2.21.0

--===============6551870441513881917==--
