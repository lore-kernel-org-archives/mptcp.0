Content-Type: multipart/mixed; boundary="===============2812644495247212966=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/9] pass subflow socket to mptcp_finish_connect
Date: Sat, 30 Nov 2019 23:48:58 +0100
Message-ID: <20191130224900.8694-8-fw@strlen.de>
In-Reply-To: 20191130224900.8694-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2720

--===============2812644495247212966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unlike _join(), we pass the mptcp socket and then use msk->subflow
to get back the subflow socket.

Just pass the subflow directly.

Right now we take the mptcp socket from the subflow context
(subflow->conn), pass that to mptcp_finish_connect and then use
the msk->subflow pointer to get to the subflow socket, i.e.
we do:

subflow_ctx(ssk)->mptcp_socket->subflow

just to get what the caller already had: ssk.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bca290c05839..0c61487a587d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1172,15 +1172,16 @@ static int mptcp_get_port(struct sock *sk, unsigned=
 short snum)
 	return inet_csk_get_port(msk->subflow->sk, snum);
 }
 =

-void mptcp_finish_connect(struct sock *sk, int mp_capable)
+void mptcp_finish_connect(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct sock *sk;
 =

-	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
+	subflow =3D mptcp_subflow_ctx(ssk);
+	sk =3D subflow->conn;
 =

-	if (mp_capable) {
-		struct sock *ssk =3D msk->subflow->sk;
+	if (subflow->mp_capable) {
+		struct mptcp_sock *msk =3D mptcp_sk(sk);
 		u64 ack_seq;
 =

 		/* sk (new subflow socket) is already locked, but we need
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7f559436fc9b..90af5a84f16c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -289,7 +289,7 @@ int mptcp_read_actor(read_descriptor_t *desc, struct sk=
_buff *skb,
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

-void mptcp_finish_connect(struct sock *sk, int mp_capable);
+void mptcp_finish_connect(struct sock *sk);
 bool mptcp_finish_join(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index edec2ecbd93f..a89513210ea1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -209,7 +209,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 	if (subflow->mp_capable && !subflow->conn_finished) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
-		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
+		mptcp_finish_connect(sk);
 		subflow->conn_finished =3D 1;
 =

 		if (skb) {
-- =

2.23.0

--===============2812644495247212966==--
