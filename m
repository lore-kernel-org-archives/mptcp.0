Content-Type: multipart/mixed; boundary="===============6559527447966107353=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 4/7] mptcp: pass subflow socket to a few helpers
Date: Thu, 14 Jan 2021 18:36:51 +0100
Message-ID: <20210114173654.7618-5-fw@strlen.de>
In-Reply-To: 20210114173654.7618-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7385

--===============6559527447966107353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass the first/initial subflow to the existing functions so they can
pass this on to the notification handler in the next patch.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 4 ++--
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 4 ++--
 net/mptcp/subflow.c  | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9643344a8d7..d42e61ca8c1e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -866,7 +866,7 @@ static bool check_fully_established(struct mptcp_sock *=
msk, struct sock *ssk,
 		clear_3rdack_retransmission(ssk);
 		mptcp_pm_subflow_established(msk, subflow);
 	} else {
-		mptcp_pm_fully_established(msk);
+		mptcp_pm_fully_established(msk, ssk, GFP_ATOMIC);
 	}
 	return true;
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 192ebd424cd6..309c44f13436 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -68,7 +68,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 lo=
cal_id)
 =

 /* path manager event handlers */
 =

-void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side)
+void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ss=
k, int server_side)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

@@ -116,7 +116,7 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock *m=
sk,
 	return true;
 }
 =

-void mptcp_pm_fully_established(struct mptcp_sock *msk)
+void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock =
*ssk, gfp_t gfp)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ecf440b7ec40..30986c4008c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2993,7 +2993,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
 =

-	mptcp_pm_new_connection(msk, 0);
+	mptcp_pm_new_connection(msk, ssk, 0);
 =

 	mptcp_rcv_space_init(msk, ssk);
 }
@@ -3237,7 +3237,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		list_add(&subflow->node, &msk->conn_list);
 		sock_hold(msk->first);
 		if (mptcp_is_fully_established(newsk))
-			mptcp_pm_fully_established(msk);
+			mptcp_pm_fully_established(msk, msk->first, GFP_KERNEL);
 =

 		mptcp_copy_inaddrs(newsk, msk->first);
 		mptcp_rcv_space_init(msk, msk->first);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac83cc50c981..419aff080621 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -571,8 +571,8 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg,=
 int len, void *hmac);
 =

 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
-void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
-void mptcp_pm_fully_established(struct mptcp_sock *msk);
+void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ss=
k, int server_side);
+void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock =
*ssk, gfp_t gfp);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 31cc362a4638..77b84d3d47ea 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -629,7 +629,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			 * created mptcp socket
 			 */
 			new_msk->sk_destruct =3D mptcp_sock_destruct;
-			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
+			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
 			ctx->conn =3D new_msk;
 			new_msk =3D NULL;
-- =

2.26.2

--===============6559527447966107353==--
