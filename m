Content-Type: multipart/mixed; boundary="===============6508923041704311743=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/20] mptcp: Remove cnt_subflows
Date: Fri, 14 Sep 2018 10:25:11 -0700
Message-ID: <20180914172524.67961-10-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 728

--===============6508923041704311743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Our goal is to make subflow establishment lockless. cnt_subflows would
need to either become an atomic variable, or we can remove it.

Well, let's remove it! In the general case it is not needed at all. Some
exotic schedulers need cnt_subflows, but we don't care if we add
complexity in these schedulers.

Something special in mptcp_verif_dss_csum(). There the access was actually
wrong. Simply because cnt_subflows > 1, it doesn't mean we have a
working subflow. So, we fix that. I don't think this issue is big enough
to backport it.

Finally mptcp_sched.c was also using cnt_subflows but merely for
speeding up things to avoid going through the whole scheduler code when
there is only one subflow. So, we can remove it and trade performance
for a better design.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit b079a187260f0591ee292655f00526a5c8371cfe)
---
 include/net/mptcp.h          | 12 +++++++++++-
 net/mptcp/mptcp_ctrl.c       | 15 ++++++---------
 net/mptcp/mptcp_input.c      | 11 ++++++++++-
 net/mptcp/mptcp_ndiffports.c |  2 +-
 net/mptcp/mptcp_output.c     |  2 +-
 net/mptcp/mptcp_sched.c      | 11 -----------
 6 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 62b06ed5520c..a1b9413689e3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -277,7 +277,6 @@ struct mptcp_cb {
 		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
 =

 	/* socket count in this connection */
-	u8 cnt_subflows;
 	u8 cnt_established;
 =

 #define MPTCP_SCHED_DATA_SIZE 8
@@ -1267,6 +1266,17 @@ static inline bool mptcp_can_new_subflow(const struc=
t sock *meta_sk)
 	       !tcp_sk(meta_sk)->mpcb->send_infinite_mapping;
 }
 =

+static inline int mptcp_subflow_count(const struct mptcp_cb *mpcb)
+{
+	struct sock *sk;
+	int i =3D 0;
+
+	mptcp_for_each_sk(mpcb, sk)
+		i++;
+
+	return i;
+}
+
 /* TCP and MPTCP mpc flag-depending functions */
 u16 mptcp_select_window(struct sock *sk);
 void mptcp_tcp_set_rto(struct sock *sk);
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index a329046f695d..5020724b4431 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1401,7 +1401,6 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock =
*sk, u8 loc_id, u8 rem_id,
 	mpcb->connection_list =3D tp;
 	tp->mptcp->attached =3D 1;
 =

-	mpcb->cnt_subflows++;
 	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
 		   &meta_sk->sk_rmem_alloc);
 =

@@ -1421,23 +1420,21 @@ int mptcp_add_sock(struct sock *meta_sk, struct soc=
k *sk, u8 loc_id, u8 rem_id,
 	sk->sk_destruct =3D mptcp_sock_destruct;
 =

 	if (sk->sk_family =3D=3D AF_INET)
-		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%d, cnt=
_subflows now %d\n",
+		mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d dst_addr:%pI4:%d\n",
 			    __func__ , mpcb->mptcp_loc_token,
 			    tp->mptcp->path_index,
 			    &((struct inet_sock *)tp)->inet_saddr,
 			    ntohs(((struct inet_sock *)tp)->inet_sport),
 			    &((struct inet_sock *)tp)->inet_daddr,
-			    ntohs(((struct inet_sock *)tp)->inet_dport),
-			    mpcb->cnt_subflows);
+			    ntohs(((struct inet_sock *)tp)->inet_dport));
 #if IS_ENABLED(CONFIG_IPV6)
 	else
-		mptcp_debug("%s: token %#x pi %d, src_addr:%pI6:%d dst_addr:%pI6:%d, cnt=
_subflows now %d\n",
+		mptcp_debug("%s: token %#x pi %d, src_addr:%pI6:%d dst_addr:%pI6:%d\n",
 			    __func__ , mpcb->mptcp_loc_token,
 			    tp->mptcp->path_index, &inet6_sk(sk)->saddr,
 			    ntohs(((struct inet_sock *)tp)->inet_sport),
 			    &sk->sk_v6_daddr,
-			    ntohs(((struct inet_sock *)tp)->inet_dport),
-			    mpcb->cnt_subflows);
+			    ntohs(((struct inet_sock *)tp)->inet_dport));
 #endif
 =

 	return 0;
@@ -1471,7 +1468,6 @@ void mptcp_del_sock(struct sock *sk)
 			}
 		}
 	}
-	mpcb->cnt_subflows--;
 	if (tp->mptcp->establish_increased)
 		mpcb->cnt_established--;
 =

@@ -2840,8 +2836,9 @@ static int mptcp_pm_seq_show(struct seq_file *seq, vo=
id *v)
 					   ntohs(isk->inet_dport));
 #endif
 			}
+
 			seq_printf(seq, " %02X %02X %08X:%08X %lu",
-				   meta_sk->sk_state, mpcb->cnt_subflows,
+				   meta_sk->sk_state, mptcp_subflow_count(mpcb),
 				   meta_tp->write_seq - meta_tp->snd_una,
 				   max_t(int, meta_tp->rcv_nxt -
 					 meta_tp->copied_seq, 0),
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 3825bb90990e..0ef43f8da140 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -347,6 +347,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 =

 	/* Now, checksum must be 0 */
 	if (unlikely(csum_fold(csum_tcp))) {
+		struct sock *sk_it =3D NULL;
+
 		pr_err("%s csum is wrong: %#x tcp-seq %u dss_csum_added %d overflowed %d=
 iterations %d\n",
 		       __func__, csum_fold(csum_tcp), TCP_SKB_CB(last)->seq,
 		       dss_csum_added, overflowed, iter);
@@ -359,7 +361,14 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 		 */
 		tp->mpcb->csum_cutoff_seq =3D tp->mptcp->map_data_seq;
 =

-		if (tp->mpcb->cnt_subflows > 1) {
+		/* Search for another subflow that is fully established */
+		mptcp_for_each_sk(tp->mpcb, sk_it) {
+			if (sk_it !=3D sk &&
+			    tcp_sk(sk_it)->mptcp->fully_established)
+				break;
+		}
+
+		if (sk_it) {
 			mptcp_send_reset(sk);
 			ans =3D -1;
 		} else {
diff --git a/net/mptcp/mptcp_ndiffports.c b/net/mptcp/mptcp_ndiffports.c
index 10147d5e3cca..58acf50df752 100644
--- a/net/mptcp/mptcp_ndiffports.c
+++ b/net/mptcp/mptcp_ndiffports.c
@@ -53,7 +53,7 @@ static void create_subflow_worker(struct work_struct *wor=
k)
 	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
 		goto exit;
 =

-	if (num_subflows > iter && num_subflows > mpcb->cnt_subflows) {
+	if (num_subflows > iter && num_subflows > mptcp_subflow_count(mpcb)) {
 		if (meta_sk->sk_family =3D=3D AF_INET ||
 		    mptcp_v6_is_v4_mapped(meta_sk)) {
 			struct mptcp_loc4 loc;
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index d50e49278e0d..81f5674f50c9 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -1353,7 +1353,7 @@ void mptcp_send_active_reset(struct sock *meta_sk, gf=
p_t priority)
 	struct mptcp_cb *mpcb =3D meta_tp->mpcb;
 	struct sock *sk;
 =

-	if (!mpcb->cnt_subflows)
+	if (!mpcb->connection_list)
 		return;
 =

 	WARN_ON(meta_tp->send_mp_fclose);
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index 1881eaec4f3e..a2543c60bd31 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -216,14 +216,6 @@ static struct sock *get_available_subflow(struct sock =
*meta_sk,
 	struct sock *sk;
 	bool force;
 =

-	/* if there is only one subflow, bypass the scheduling function */
-	if (mpcb->cnt_subflows =3D=3D 1) {
-		sk =3D (struct sock *)mpcb->connection_list;
-		if (!mptcp_is_available(sk, skb, zero_wnd_test))
-			sk =3D NULL;
-		return sk;
-	}
-
 	/* Answer data_fin on same subflow!!! */
 	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
 	    skb && mptcp_is_data_fin(skb)) {
@@ -264,9 +256,6 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
t sock *sk, int penal)
 	struct sk_buff *skb_head;
 	struct defsched_priv *dsp =3D defsched_get_priv(tp);
 =

-	if (tp->mpcb->cnt_subflows =3D=3D 1)
-		return NULL;
-
 	meta_sk =3D mptcp_meta_sk(sk);
 	skb_head =3D tcp_rtx_queue_head(meta_sk);
 =

-- =

2.16.2


--===============6508923041704311743==--
