Content-Type: multipart/mixed; boundary="===============6082020529801956956=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/2] mptcp: drop unneeded checks
Date: Fri, 06 Mar 2020 17:45:33 +0100
Message-ID: <2b314e8d827f3a7cc62fd3248bf26aa4972d8041.1583511159.git.pabeni@redhat.com>
In-Reply-To: cover.1583511159.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3891

--===============6082020529801956956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the previous patch subflow->conn is always !=3D NULL and
is never changed. We can drop a bunch of now unneeded checks

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c |  2 +-
 net/mptcp/subflow.c | 18 +++++++-----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b9a8305bd934..eb6cd0accf99 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -362,7 +362,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 =

 	opts->ext_copy.use_ack =3D 0;
 	msk =3D mptcp_sk(subflow->conn);
-	if (!msk || !READ_ONCE(msk->can_ack)) {
+	if (!READ_ONCE(msk->can_ack)) {
 		*size =3D ALIGN(dss_size, 4);
 		return ret;
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 047b088e4617..8434c7f5f712 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -112,7 +112,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

-	if (subflow->conn && !subflow->conn_finished) {
+	if (!subflow->conn_finished) {
 		pr_debug("subflow=3D%p, remote_key=3D%llu", mptcp_subflow_ctx(sk),
 			 subflow->remote_key);
 		mptcp_finish_connect(sk);
@@ -439,9 +439,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	if (subflow->data_avail)
 		return true;
 =

-	if (!subflow->conn)
-		return false;
-
 	msk =3D mptcp_sk(subflow->conn);
 	for (;;) {
 		u32 map_remaining;
@@ -561,11 +558,10 @@ static void subflow_data_ready(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	if (!parent || !subflow->mp_capable) {
+	if (!subflow->mp_capable) {
 		subflow->tcp_data_ready(sk);
 =

-		if (parent)
-			parent->sk_data_ready(parent);
+		parent->sk_data_ready(parent);
 		return;
 	}
 =

@@ -579,7 +575,7 @@ static void subflow_write_space(struct sock *sk)
 	struct sock *parent =3D subflow->conn;
 =

 	sk_stream_write_space(sk);
-	if (parent && sk_stream_is_writeable(sk)) {
+	if (sk_stream_is_writeable(sk)) {
 		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
@@ -694,7 +690,7 @@ static bool subflow_is_done(const struct sock *sk)
 static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-	struct sock *parent =3D READ_ONCE(subflow->conn);
+	struct sock *parent =3D subflow->conn;
 =

 	__subflow_state_change(sk);
 =

@@ -702,10 +698,10 @@ static void subflow_state_change(struct sock *sk)
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
 	 */
-	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk))
+	if (subflow->mp_capable && mptcp_subflow_data_available(sk))
 		mptcp_data_ready(parent, sk);
 =

-	if (parent && !(parent->sk_shutdown & RCV_SHUTDOWN) &&
+	if (!(parent->sk_shutdown & RCV_SHUTDOWN) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
 		subflow->rx_eof =3D 1;
 		parent->sk_shutdown |=3D RCV_SHUTDOWN;
-- =

2.21.1

--===============6082020529801956956==--
