Content-Type: multipart/mixed; boundary="===============6996571398470405690=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 07/12] mptcp: Remove cnt_subflows
Date: Mon, 26 Mar 2018 09:32:10 +0200
Message-ID: <20180326073215.83607-8-cpaasch@apple.com>
In-Reply-To: 20180326073215.83607-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 414

--===============6996571398470405690==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Our goal is to make subflow establishment lockless. cnt_subflows would
need to either become an atomic variable, or we can remove it.

Well, let's remove it! In the general case it is not needed at all. Some
exotic schedulers need cnt_subflows, but we don't care if we add
complexity in these schedulers.

One place where it was used is in the /proc/net/mptcp_net/mptcp output.
We don't guarantee backwards compatibility, so we can just change the
output. I will submit a follow-up patch for net-tools.

Another place is mptcp_verif_dss_csum(). There the access was actually
wrong. Simply because cnt_subflows > 1, it doesn't mean we have a
working subflow. So, we fix that. I don't think this issue is big enough
to backport it.

Finally mptcp_sched.c was also using cnt_subflows but merely for
speeding up things to avoid going through the whole scheduler code when
there is only one subflow. So, we can remove it and trade performance
for a better design.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h          |  1 -
 net/mptcp/mptcp_binder.c     | 17 +++++++++++++++--
 net/mptcp/mptcp_ctrl.c       | 16 ++++++----------
 net/mptcp/mptcp_input.c      | 11 ++++++++++-
 net/mptcp/mptcp_ndiffports.c | 17 +++++++++++++++--
 net/mptcp/mptcp_output.c     |  2 +-
 net/mptcp/mptcp_sched.c      | 11 -----------
 7 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 647183460200..523abc8ce01d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -280,7 +280,6 @@ struct mptcp_cb {
 		rcv_hiseq_index:1; /* Index in rcv_high_order of rcv_nxt */
 =

 	/* socket count in this connection */
-	u8 cnt_subflows;
 	u8 cnt_established;
 =

 #define MPTCP_SCHED_DATA_SIZE 8
diff --git a/net/mptcp/mptcp_binder.c b/net/mptcp/mptcp_binder.c
index 58a342dc1620..d6ef9c5b6ce5 100644
--- a/net/mptcp/mptcp_binder.c
+++ b/net/mptcp/mptcp_binder.c
@@ -287,6 +287,18 @@ static int mptcp_parse_gateway_ipv4(char *gateways)
 	return -1;
 }
 =

+static int mptcp_binder_subflow_count(const struct mptcp_cb *mpcb)
+{
+	struct sock *sk;
+	int i =3D 0;
+
+	mptcp_for_each_sk(mpcb, sk) {
+		i++;
+	}
+
+	return i;
+}
+
 /**
  * Create all new subflows, by doing calls to mptcp_initX_subsockets
  *
@@ -301,7 +313,7 @@ static void create_subflow_worker(struct work_struct *w=
ork)
 						     subflow_work);
 	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
 	struct sock *meta_sk =3D mpcb->meta_sk;
-	int iter =3D 0;
+	int iter =3D 0, subflow_cnt;
 =

 next_subflow:
 	if (iter) {
@@ -322,8 +334,9 @@ static void create_subflow_worker(struct work_struct *w=
ork)
 	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
 		goto exit;
 =

+	subflow_cnt =3D mptcp_binder_subflow_count(mpcb);
 	if (mptcp_binder_ndiffports > iter &&
-	    mptcp_binder_ndiffports > mpcb->cnt_subflows) {
+	    mptcp_binder_ndiffports > subflow_cnt) {
 		struct mptcp_loc4 loc;
 		struct mptcp_rem4 rem;
 =

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 321a8578e9c3..b1109ee9770f 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1379,7 +1379,6 @@ int mptcp_add_sock(struct sock *meta_sk, struct sock =
*sk, u8 loc_id, u8 rem_id,
 	mpcb->connection_list =3D tp;
 	tp->mptcp->attached =3D 1;
 =

-	mpcb->cnt_subflows++;
 	atomic_add(atomic_read(&((struct sock *)tp)->sk_rmem_alloc),
 		   &meta_sk->sk_rmem_alloc);
 =

@@ -1399,23 +1398,21 @@ int mptcp_add_sock(struct sock *meta_sk, struct soc=
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
@@ -1452,7 +1449,6 @@ void mptcp_del_sock(struct sock *sk)
 			}
 		}
 	}
-	mpcb->cnt_subflows--;
 	if (tp->mptcp->establish_increased)
 		mpcb->cnt_established--;
 =

@@ -2816,8 +2812,8 @@ static int mptcp_pm_seq_show(struct seq_file *seq, vo=
id *v)
 					   ntohs(isk->inet_dport));
 #endif
 			}
-			seq_printf(seq, " %02X %02X %08X:%08X %lu",
-				   meta_sk->sk_state, mpcb->cnt_subflows,
+			seq_printf(seq, " %02X %08X:%08X %lu",
+				   meta_sk->sk_state,
 				   meta_tp->write_seq - meta_tp->snd_una,
 				   max_t(int, meta_tp->rcv_nxt -
 					 meta_tp->copied_seq, 0),
diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index ba9e3fe62824..126c961ec55a 100644
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
index 10147d5e3cca..fe73ade7ba24 100644
--- a/net/mptcp/mptcp_ndiffports.c
+++ b/net/mptcp/mptcp_ndiffports.c
@@ -18,6 +18,18 @@ static int num_subflows __read_mostly =3D 2;
 module_param(num_subflows, int, 0644);
 MODULE_PARM_DESC(num_subflows, "choose the number of subflows per MPTCP co=
nnection");
 =

+static int mptcp_ndiffports_subflow_count(const struct mptcp_cb *mpcb)
+{
+	struct sock *sk;
+	int i =3D 0;
+
+	mptcp_for_each_sk(mpcb, sk) {
+		i++;
+	}
+
+	return i;
+}
+
 /**
  * Create all new subflows, by doing calls to mptcp_initX_subsockets
  *
@@ -32,7 +44,7 @@ static void create_subflow_worker(struct work_struct *wor=
k)
 						     subflow_work);
 	struct mptcp_cb *mpcb =3D pm_priv->mpcb;
 	struct sock *meta_sk =3D mpcb->meta_sk;
-	int iter =3D 0;
+	int iter =3D 0, subflow_cnt;
 =

 next_subflow:
 	if (iter) {
@@ -53,7 +65,8 @@ static void create_subflow_worker(struct work_struct *wor=
k)
 	    !tcp_sk(mpcb->master_sk)->mptcp->fully_established)
 		goto exit;
 =

-	if (num_subflows > iter && num_subflows > mpcb->cnt_subflows) {
+	subflow_cnt =3D mptcp_ndiffports_subflow_count(mpcb);
+	if (num_subflows > iter && num_subflows > subflow_cnt) {
 		if (meta_sk->sk_family =3D=3D AF_INET ||
 		    mptcp_v6_is_v4_mapped(meta_sk)) {
 			struct mptcp_loc4 loc;
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index fc950a98ce31..cc1a4f7d39e9 100644
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
index 2b10a6683c5e..c831515fd7f0 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -219,14 +219,6 @@ struct sock *get_available_subflow(struct sock *meta_s=
k, struct sk_buff *skb,
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
@@ -268,9 +260,6 @@ static struct sk_buff *mptcp_rcv_buf_optimization(struc=
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


--===============6996571398470405690==--
