Content-Type: multipart/mixed; boundary="===============6263198457486467757=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 9/9] mptcp: Cleanup after removals
Date: Tue, 01 May 2018 13:35:38 -0700
Message-ID: <20180501203538.95477-10-cpaasch@apple.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 594

--===============6263198457486467757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that those modules have been removed, we can get rid of some of the
unused callbacks, fields and memory.

Make also some of the functions static that are now only used in
mptcp_sched.c.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h     | 12 +-----------
 net/mptcp/mptcp_ctrl.c  |  3 ---
 net/mptcp/mptcp_ipv4.c  |  3 ---
 net/mptcp/mptcp_ipv6.c  |  3 ---
 net/mptcp/mptcp_sched.c | 20 ++++++++------------
 5 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 1523299fec10..8abb6985d852 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -187,7 +187,7 @@ struct mptcp_tcp_sock {
 	u8	loc_id;
 	u8	rem_id;
 =

-#define MPTCP_SCHED_SIZE 16
+#define MPTCP_SCHED_SIZE 4
 	u8	mptcp_sched[MPTCP_SCHED_SIZE] __aligned(8);
 =

 	int	init_rcv_wnd;
@@ -230,8 +230,6 @@ struct mptcp_pm_ops {
 	void (*add_raddr)(struct mptcp_cb *mpcb, const union inet_addr *addr,
 			  sa_family_t family, __be16 port, u8 id);
 	void (*rem_raddr)(struct mptcp_cb *mpcb, u8 rem_id);
-	void (*init_subsocket_v4)(struct sock *sk, struct in_addr addr);
-	void (*init_subsocket_v6)(struct sock *sk, struct in6_addr addr);
 	void (*delete_subflow)(struct sock *sk);
 =

 	char		name[MPTCP_PM_NAME_MAX];
@@ -250,7 +248,6 @@ struct mptcp_sched_ops {
 						struct sock **subsk,
 						unsigned int *limit);
 	void			(*init)(struct sock *sk);
-	void			(*release)(struct sock *sk);
 =

 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
@@ -902,13 +899,6 @@ void mptcp_init_scheduler(struct mptcp_cb *mpcb);
 void mptcp_cleanup_scheduler(struct mptcp_cb *mpcb);
 void mptcp_get_default_scheduler(char *name);
 int mptcp_set_default_scheduler(const char *name);
-bool mptcp_is_available(struct sock *sk, const struct sk_buff *skb,
-			bool zero_wnd_test);
-bool mptcp_is_def_unavailable(struct sock *sk);
-bool subflow_is_active(const struct tcp_sock *tp);
-bool subflow_is_backup(const struct tcp_sock *tp);
-struct sock *get_available_subflow(struct sock *meta_sk, struct sk_buff *s=
kb,
-				   bool zero_wnd_test);
 extern struct mptcp_sched_ops mptcp_sched_default;
 =

 /* Initializes function-pointers and MPTCP-flags */
diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 62aa8c5e177b..5b8320687122 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1412,9 +1412,6 @@ void mptcp_del_sock(struct sock *sk)
 	mpcb =3D tp->mpcb;
 	tp_prev =3D mpcb->connection_list;
 =

-	if (mpcb->sched_ops->release)
-		mpcb->sched_ops->release(sk);
-
 	if (mpcb->pm_ops->delete_subflow)
 		mpcb->pm_ops->delete_subflow(sk);
 =

diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index 66c8205342c6..061377f79a18 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -340,9 +340,6 @@ int mptcp_init4_subsockets(struct sock *meta_sk, const =
struct mptcp_loc4 *loc,
 		    ntohs(loc_in.sin_port), &rem_in.sin_addr,
 		    ntohs(rem_in.sin_port), loc->if_idx);
 =

-	if (tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v4)
-		tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v4(sk, rem->addr);
-
 	ret =3D kernel_connect(sock, (struct sockaddr *)&rem_in,
 			     sizeof(struct sockaddr_in), O_NONBLOCK);
 	if (ret < 0 && ret !=3D -EINPROGRESS) {
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index 1c274ed7c524..c968de95709e 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -348,9 +348,6 @@ int mptcp_init6_subsockets(struct sock *meta_sk, const =
struct mptcp_loc6 *loc,
 		    ntohs(loc_in.sin6_port), &rem_in.sin6_addr,
 		    ntohs(rem_in.sin6_port), loc->if_idx);
 =

-	if (tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v6)
-		tcp_sk(meta_sk)->mpcb->pm_ops->init_subsocket_v6(sk, rem->addr);
-
 	ret =3D kernel_connect(sock, (struct sockaddr *)&rem_in,
 			     sizeof(struct sockaddr_in6), O_NONBLOCK);
 	if (ret < 0 && ret !=3D -EINPROGRESS) {
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index 2b10a6683c5e..1881eaec4f3e 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -15,7 +15,7 @@ static struct defsched_priv *defsched_get_priv(const stru=
ct tcp_sock *tp)
 	return (struct defsched_priv *)&tp->mptcp->mptcp_sched[0];
 }
 =

-bool mptcp_is_def_unavailable(struct sock *sk)
+static bool mptcp_is_def_unavailable(struct sock *sk)
 {
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 =

@@ -34,7 +34,6 @@ bool mptcp_is_def_unavailable(struct sock *sk)
 =

 	return false;
 }
-EXPORT_SYMBOL_GPL(mptcp_is_def_unavailable);
 =

 static bool mptcp_is_temp_unavailable(struct sock *sk,
 				      const struct sk_buff *skb,
@@ -96,13 +95,12 @@ static bool mptcp_is_temp_unavailable(struct sock *sk,
 }
 =

 /* Is the sub-socket sk available to send the skb? */
-bool mptcp_is_available(struct sock *sk, const struct sk_buff *skb,
-			bool zero_wnd_test)
+static bool mptcp_is_available(struct sock *sk, const struct sk_buff *skb,
+			       bool zero_wnd_test)
 {
 	return !mptcp_is_def_unavailable(sk) &&
 	       !mptcp_is_temp_unavailable(sk, skb, zero_wnd_test);
 }
-EXPORT_SYMBOL_GPL(mptcp_is_available);
 =

 /* Are we not allowed to reinject this skb on tp? */
 static int mptcp_dont_reinject_skb(const struct tcp_sock *tp, const struct=
 sk_buff *skb)
@@ -115,17 +113,15 @@ static int mptcp_dont_reinject_skb(const struct tcp_s=
ock *tp, const struct sk_bu
 		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
 }
 =

-bool subflow_is_backup(const struct tcp_sock *tp)
+static bool subflow_is_backup(const struct tcp_sock *tp)
 {
 	return tp->mptcp->rcv_low_prio || tp->mptcp->low_prio;
 }
-EXPORT_SYMBOL_GPL(subflow_is_backup);
 =

-bool subflow_is_active(const struct tcp_sock *tp)
+static bool subflow_is_active(const struct tcp_sock *tp)
 {
 	return !tp->mptcp->rcv_low_prio && !tp->mptcp->low_prio;
 }
-EXPORT_SYMBOL_GPL(subflow_is_active);
 =

 /* Generic function to iterate over used and unused subflows and to select=
 the
  * best one
@@ -212,8 +208,9 @@ static struct sock
  *
  * Additionally, this function is aware of the backup-subflows.
  */
-struct sock *get_available_subflow(struct sock *meta_sk, struct sk_buff *s=
kb,
-				   bool zero_wnd_test)
+static struct sock *get_available_subflow(struct sock *meta_sk,
+					  struct sk_buff *skb,
+					  bool zero_wnd_test)
 {
 	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct sock *sk;
@@ -258,7 +255,6 @@ struct sock *get_available_subflow(struct sock *meta_sk=
, struct sk_buff *skb,
 		TCP_SKB_CB(skb)->path_mask =3D 0;
 	return sk;
 }
-EXPORT_SYMBOL_GPL(get_available_subflow);
 =

 static struct sk_buff *mptcp_rcv_buf_optimization(struct sock *sk, int pen=
al)
 {
-- =

2.16.2


--===============6263198457486467757==--
