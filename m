Content-Type: multipart/mixed; boundary="===============0836120075564542813=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-net-next 04/12] mptcp: Remove support for
 subflow-priorities (aka backup)
Date: Mon, 17 Dec 2018 17:38:00 -0800
Message-ID: <20181218013808.4819-5-cpaasch@apple.com>
In-Reply-To: 20181218013808.4819-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 921

--===============0836120075564542813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---

Notes:
    v2: * Make sure that we detect NETDEV_CHANGE events unsetting the IFF_N=
OMULTIPATH flag

 include/linux/tcp.h          |   1 -
 include/net/mptcp.h          |  42 +-----------
 include/uapi/linux/if.h      |   1 -
 net/core/dev.c               |   2 +-
 net/mptcp/mptcp_ctrl.c       |   6 --
 net/mptcp/mptcp_fullmesh.c   | 151 +++++++++++----------------------------=
----
 net/mptcp/mptcp_input.c      |  36 -----------
 net/mptcp/mptcp_ipv4.c       |   5 +-
 net/mptcp/mptcp_ipv6.c       |   5 +-
 net/mptcp/mptcp_ndiffports.c |   4 +-
 net/mptcp/mptcp_output.c     |  27 +-------
 net/mptcp/mptcp_pm.c         |   2 +-
 net/mptcp/mptcp_sched.c      |  20 +-----
 13 files changed, 46 insertions(+), 256 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f38bf1e18e58..cc896f842c31 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -109,7 +109,6 @@ struct tcp_out_options {
 			__u32	sender_nonce;
 					/* random number of the sender */
 			__u32	token;	/* token for mptcp */
-			u8	low_prio:1;
 		} mp_join_syns;
 	};
 =

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a512e9386296..a4f46ac7051b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -56,7 +56,6 @@
 =

 struct mptcp_loc4 {
 	u8		loc4_id;
-	u8		low_prio:1;
 	int		if_idx;
 	struct in_addr	addr;
 };
@@ -69,7 +68,6 @@ struct mptcp_rem4 {
 =

 struct mptcp_loc6 {
 	u8		loc6_id;
-	u8		low_prio:1;
 	int		if_idx;
 	struct in6_addr	addr;
 };
@@ -103,8 +101,6 @@ struct mptcp_request_sock {
 	u8				loc_id;
 	u8				rem_id; /* Address-id in the MP_JOIN */
 	u8				is_sub:1, /* Is this a new subflow? */
-					low_prio:1, /* Interface set to low-prio? */
-					rcv_low_prio:1,
 					mptcp_ver:4;
 };
 =

@@ -115,11 +111,6 @@ struct mptcp_options_received {
 		is_mp_join:1,
 		join_ack:1,
 =

-		saw_low_prio:2, /* 0x1 - low-prio set for this subflow
-				 * 0x2 - low-prio set for another subflow
-				 */
-		low_prio:1,
-
 		saw_add_addr:2, /* Saw at least one add_addr option:
 				 * 0x1: IPv4 - 0x2: IPv6
 				 */
@@ -131,7 +122,6 @@ struct mptcp_options_received {
 		mp_fail:1,
 		mp_fclose:1;
 	u8	rem_id;		/* Address-id in the MP_JOIN */
-	u8	prio_addr_id;	/* Address-id in the MP_PRIO */
 =

 	const unsigned char *add_addr_ptr; /* Pointer to add-address option */
 	const unsigned char *rem_addr_ptr; /* Pointer to rem-address option */
@@ -169,9 +159,6 @@ struct mptcp_tcp_sock {
 		include_mpc:1,
 		mapping_present:1,
 		map_data_fin:1,
-		low_prio:1, /* use this socket as backup */
-		rcv_low_prio:1, /* Peer sent low-prio option to us */
-		send_mp_prio:1, /* Trigger to send mp_prio on this socket */
 		pre_established:1; /* State between sending 3rd ACK and
 				    * receiving the fourth ack of new subflows.
 				    */
@@ -220,7 +207,7 @@ struct mptcp_pm_ops {
 	void (*new_remote_address)(struct sock *meta_sk);
 	void (*subflow_error)(struct sock *meta_sk, struct sock *sk);
 	int  (*get_local_id)(sa_family_t family, union inet_addr *addr,
-			     struct net *net, bool *low_prio);
+			     struct net *net);
 	void (*addr_signal)(struct sock *sk, unsigned *size,
 			    struct tcp_out_options *opts, struct sk_buff *skb);
 	void (*add_raddr)(struct mptcp_cb *mpcb, const union inet_addr *addr,
@@ -395,11 +382,6 @@ struct mptcp_cb {
 #define MPTCP_SUB_REMOVE_ADDR	4
 #define MPTCP_SUB_LEN_REMOVE_ADDR	4
 =

-#define MPTCP_SUB_PRIO		5
-#define MPTCP_SUB_LEN_PRIO	3
-#define MPTCP_SUB_LEN_PRIO_ADDR	4
-#define MPTCP_SUB_LEN_PRIO_ALIGN	4
-
 #define MPTCP_SUB_FAIL		6
 #define MPTCP_SUB_LEN_FAIL	12
 #define MPTCP_SUB_LEN_FAIL_ALIGN	12
@@ -429,7 +411,6 @@ extern bool mptcp_init_failed;
 #define OPTION_MP_JOIN		(1 << 6)
 #define OPTION_MP_FCLOSE	(1 << 7)
 #define OPTION_REMOVE_ADDR	(1 << 8)
-#define OPTION_MP_PRIO		(1 << 9)
 =

 /* MPTCP flags: both TX and RX */
 #define MPTCPHDR_SEQ		0x01 /* DSS.M option is present */
@@ -614,23 +595,6 @@ struct mp_fclose {
 	__u64	key;
 } __attribute__((__packed__));
 =

-struct mp_prio {
-	__u8	kind;
-	__u8	len;
-#if defined(__LITTLE_ENDIAN_BITFIELD)
-	__u8	b:1,
-		rsv:3,
-		sub:4;
-#elif defined(__BIG_ENDIAN_BITFIELD)
-	__u8	sub:4,
-		rsv:3,
-		b:1;
-#else
-#error	"Adjust your <asm/byteorder.h> defines"
-#endif
-	__u8	addr_id;
-} __attribute__((__packed__));
-
 static inline int mptcp_sub_len_dss(const struct mp_dss *m)
 {
 	return 4 + m->A * (4 + m->a * 4) + m->M * (10 + m->m * 4);
@@ -1048,9 +1012,6 @@ static inline void mptcp_init_mp_opt(struct mptcp_opt=
ions_received *mopt)
 	mopt->is_mp_join =3D 0;
 	mopt->join_ack =3D 0;
 =

-	mopt->saw_low_prio =3D 0;
-	mopt->low_prio =3D 0;
-
 	mopt->saw_add_addr =3D 0;
 	mopt->more_add_addr =3D 0;
 =

@@ -1065,7 +1026,6 @@ static inline void mptcp_reset_mopt(struct tcp_sock *=
tp)
 {
 	struct mptcp_options_received *mopt =3D &tp->mptcp->rx_opt;
 =

-	mopt->saw_low_prio =3D 0;
 	mopt->saw_add_addr =3D 0;
 	mopt->more_add_addr =3D 0;
 	mopt->saw_rem_addr =3D 0;
diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 7255e08393db..51540df75bf8 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -133,7 +133,6 @@ enum net_device_flags {
 #endif /* __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO */
 =

 #define IFF_NOMULTIPATH	0x80000		/* Disable for MPTCP 		*/
-#define IFF_MPBACKUP	0x100000	/* Use as backup path for MPTCP */
 =

 #define IFF_VOLATILE	(IFF_LOOPBACK|IFF_POINTOPOINT|IFF_BROADCAST|IFF_ECHO|\
 		IFF_MASTER|IFF_SLAVE|IFF_RUNNING|IFF_LOWER_UP|IFF_DORMANT)
diff --git a/net/core/dev.c b/net/core/dev.c
index 95cff2426ea1..c5cafaac7f58 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7487,7 +7487,7 @@ int __dev_change_flags(struct net_device *dev, unsign=
ed int flags)
 =

 	dev->flags =3D (flags & (IFF_DEBUG | IFF_NOTRAILERS | IFF_NOARP |
 			       IFF_DYNAMIC | IFF_MULTICAST | IFF_PORTSEL |
-			       IFF_AUTOMEDIA | IFF_NOMULTIPATH | IFF_MPBACKUP)) |
+			       IFF_AUTOMEDIA | IFF_NOMULTIPATH)) |
 		     (dev->flags & (IFF_UP | IFF_VOLATILE | IFF_PROMISC |
 				    IFF_ALLMULTI));
 =

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 8061b934e0d5..927f8c014c0b 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -2218,11 +2218,6 @@ struct sock *mptcp_check_req_child(struct sock *meta=
_sk,
 		goto teardown;
 	}
 =

-	/* The child is a clone of the meta socket, we must now reset
-	 * some of the fields
-	 */
-	child_tp->mptcp->rcv_low_prio =3D mtreq->rcv_low_prio;
-
 	/* We should allow proper increase of the snd/rcv-buffers. Thus, we
 	 * use the original values instead of the bloated up ones from the
 	 * clone.
@@ -2438,7 +2433,6 @@ void mptcp_join_reqsk_init(const struct mptcp_cb *mpc=
b,
 	mtreq->mptcp_hash_tmac =3D *(u64 *)mptcp_hash_mac;
 =

 	mtreq->rem_id =3D mopt.rem_id;
-	mtreq->rcv_low_prio =3D mopt.low_prio;
 	inet_rsk(req)->saw_mpc =3D 1;
 =

 	MPTCP_INC_STATS(sock_net(mpcb->meta_sk), MPTCP_MIB_JOINSYNRX);
diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index 23f42a06cc70..5043f231bb4c 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -12,7 +12,6 @@
 enum {
 	MPTCP_EVENT_ADD =3D 1,
 	MPTCP_EVENT_DEL,
-	MPTCP_EVENT_MOD,
 };
 =

 #define MPTCP_SUBFLOW_RETRY_DELAY	1000
@@ -52,8 +51,7 @@ struct mptcp_loc_addr {
 struct mptcp_addr_event {
 	struct list_head list;
 	unsigned short	family;
-	u8	code:7,
-		low_prio:1;
+	u8	code:7;
 	int	if_idx;
 	union inet_addr addr;
 };
@@ -491,7 +489,6 @@ static void create_subflow_worker(struct work_struct *w=
ork)
 =

 		loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
 		loc.loc4_id =3D 0;
-		loc.low_prio =3D 0;
 		loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
 =

 		rem.addr.s_addr =3D inet_sk(meta_sk)->inet_daddr;
@@ -541,7 +538,6 @@ static void create_subflow_worker(struct work_struct *w=
ork)
 =

 			loc.addr =3D inet6_sk(meta_sk)->saddr;
 			loc.loc6_id =3D 0;
-			loc.low_prio =3D 0;
 			loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
 =

 			rem.addr =3D meta_sk->sk_v6_daddr;
@@ -763,33 +759,25 @@ static void mptcp_address_worker(struct work_struct *=
work)
 					   &event->addr, event->if_idx);
 		int j =3D i;
 =

-		if (j < 0) {
-			/* Not in the list, so we have to find an empty slot */
-			if (event->family =3D=3D AF_INET)
-				i =3D __mptcp_find_free_index(mptcp_local->loc4_bits,
-							    mptcp_local->next_v4_index);
-			if (event->family =3D=3D AF_INET6)
-				i =3D __mptcp_find_free_index(mptcp_local->loc6_bits,
-							    mptcp_local->next_v6_index);
-
-			if (i < 0) {
-				mptcp_debug("%s no more space\n", __func__);
-				goto duno;
-			}
+		/* Found the address and it's thus all the same */
+		if (j >=3D 0)
+			goto duno;
 =

-			/* It might have been a MOD-event. */
-			event->code =3D MPTCP_EVENT_ADD;
-		} else {
-			/* Let's check if anything changes */
-			if (event->family =3D=3D AF_INET &&
-			    event->low_prio =3D=3D mptcp_local->locaddr4[i].low_prio)
-				goto duno;
-
-			if (event->family =3D=3D AF_INET6 &&
-			    event->low_prio =3D=3D mptcp_local->locaddr6[i].low_prio)
-				goto duno;
+		/* Not in the list, so we have to find an empty slot */
+		if (event->family =3D=3D AF_INET)
+			i =3D __mptcp_find_free_index(mptcp_local->loc4_bits,
+						    mptcp_local->next_v4_index);
+		if (event->family =3D=3D AF_INET6)
+			i =3D __mptcp_find_free_index(mptcp_local->loc6_bits,
+						    mptcp_local->next_v6_index);
+
+		if (i < 0) {
+			mptcp_debug("%s no more space\n", __func__);
+			goto duno;
 		}
 =

+		event->code =3D MPTCP_EVENT_ADD;
+
 		old =3D mptcp_local;
 		mptcp_local =3D kmemdup(mptcp_local, sizeof(*mptcp_local),
 				      GFP_ATOMIC);
@@ -799,21 +787,19 @@ static void mptcp_address_worker(struct work_struct *=
work)
 		if (event->family =3D=3D AF_INET) {
 			mptcp_local->locaddr4[i].addr.s_addr =3D event->addr.in.s_addr;
 			mptcp_local->locaddr4[i].loc4_id =3D i + 1;
-			mptcp_local->locaddr4[i].low_prio =3D event->low_prio;
 			mptcp_local->locaddr4[i].if_idx =3D event->if_idx;
 =

-			mptcp_debug("%s updated IP %pI4 on ifidx %u prio %u id %u\n",
+			mptcp_debug("%s updated IP %pI4 on ifidx %u id %u\n",
 				    __func__, &event->addr.in.s_addr,
-				    event->if_idx, event->low_prio, i + 1);
+				    event->if_idx, i + 1);
 		} else {
 			mptcp_local->locaddr6[i].addr =3D event->addr.in6;
 			mptcp_local->locaddr6[i].loc6_id =3D i + MPTCP_MAX_ADDR;
-			mptcp_local->locaddr6[i].low_prio =3D event->low_prio;
 			mptcp_local->locaddr6[i].if_idx =3D event->if_idx;
 =

-			mptcp_debug("%s updated IP %pI6 on ifidx %u prio %u id %u\n",
+			mptcp_debug("%s updated IP %pI6 on ifidx %u id %u\n",
 				    __func__, &event->addr.in6,
-				    event->if_idx, event->low_prio, i + MPTCP_MAX_ADDR);
+				    event->if_idx, i + MPTCP_MAX_ADDR);
 		}
 =

 		if (j < 0) {
@@ -965,37 +951,6 @@ static void mptcp_address_worker(struct work_struct *w=
ork)
 					announce_remove_addr(loc_id, meta_sk);
 				}
 			}
-
-			if (event->code =3D=3D MPTCP_EVENT_MOD) {
-				struct mptcp_tcp_sock *mptcp;
-
-				mptcp_for_each_sub(mpcb, mptcp) {
-					struct sock *sk =3D mptcp_to_sock(mptcp);
-					struct tcp_sock *tp =3D tcp_sk(sk);
-					if (event->family =3D=3D AF_INET &&
-					    (sk->sk_family =3D=3D AF_INET ||
-					     mptcp_v6_is_v4_mapped(sk)) &&
-					     inet_sk(sk)->inet_saddr =3D=3D event->addr.in.s_addr) {
-						if (event->low_prio !=3D tp->mptcp->low_prio) {
-							tp->mptcp->send_mp_prio =3D 1;
-							tp->mptcp->low_prio =3D event->low_prio;
-
-							tcp_send_ack(sk);
-						}
-					}
-
-					if (event->family =3D=3D AF_INET6 &&
-					    sk->sk_family =3D=3D AF_INET6 &&
-					    !ipv6_addr_equal(&inet6_sk(sk)->saddr, &event->addr.in6)) {
-						if (event->low_prio !=3D tp->mptcp->low_prio) {
-							tp->mptcp->send_mp_prio =3D 1;
-							tp->mptcp->low_prio =3D event->low_prio;
-
-							tcp_send_ack(sk);
-						}
-					}
-				}
-			}
 next:
 			bh_unlock_sock(meta_sk);
 			sock_put(meta_sk);
@@ -1042,14 +997,8 @@ static void add_pm_event(struct net *net, const struc=
t mptcp_addr_event *event)
 			break;
 		case MPTCP_EVENT_ADD:
 			mptcp_debug("%s add old_code %u\n", __func__, eventq->code);
-			eventq->low_prio =3D event->low_prio;
 			eventq->code =3D MPTCP_EVENT_ADD;
 			return;
-		case MPTCP_EVENT_MOD:
-			mptcp_debug("%s mod old_code %u\n", __func__, eventq->code);
-			eventq->low_prio =3D event->low_prio;
-			eventq->code =3D MPTCP_EVENT_MOD;
-			return;
 		}
 	}
 =

@@ -1081,7 +1030,6 @@ static void addr4_event_handler(const struct in_ifadd=
r *ifa, unsigned long event
 =

 	mpevent.family =3D AF_INET;
 	mpevent.addr.in.s_addr =3D ifa->ifa_local;
-	mpevent.low_prio =3D (netdev->flags & IFF_MPBACKUP) ? 1 : 0;
 	mpevent.if_idx  =3D netdev->ifindex;
 =

 	if (event =3D=3D NETDEV_DOWN || !netif_running(netdev) ||
@@ -1089,13 +1037,16 @@ static void addr4_event_handler(const struct in_ifa=
ddr *ifa, unsigned long event
 		mpevent.code =3D MPTCP_EVENT_DEL;
 	else if (event =3D=3D NETDEV_UP)
 		mpevent.code =3D MPTCP_EVENT_ADD;
-	else if (event =3D=3D NETDEV_CHANGE)
-		mpevent.code =3D MPTCP_EVENT_MOD;
+	else if (event =3D=3D NETDEV_CHANGE && !(netdev->flags & IFF_NOMULTIPATH))
+		mpevent.code =3D MPTCP_EVENT_ADD;
+	else
+		goto out;
 =

-	mptcp_debug("%s created event for %pI4, code %u prio %u idx %u\n", __func=
__,
-		    &ifa->ifa_local, mpevent.code, mpevent.low_prio, mpevent.if_idx);
+	mptcp_debug("%s created event for %pI4, code %u idx %u\n", __func__,
+		    &ifa->ifa_local, mpevent.code, mpevent.if_idx);
 	add_pm_event(net, &mpevent);
 =

+out:
 	spin_unlock_bh(&fm_ns->local_lock);
 	return;
 }
@@ -1143,7 +1094,6 @@ static void addr6_event_handler(const struct inet6_if=
addr *ifa, unsigned long ev
 =

 	mpevent.family =3D AF_INET6;
 	mpevent.addr.in6 =3D ifa->addr;
-	mpevent.low_prio =3D (netdev->flags & IFF_MPBACKUP) ? 1 : 0;
 	mpevent.if_idx =3D netdev->ifindex;
 =

 	if (event =3D=3D NETDEV_DOWN || !netif_running(netdev) ||
@@ -1152,12 +1102,13 @@ static void addr6_event_handler(const struct inet6_=
ifaddr *ifa, unsigned long ev
 	else if (event =3D=3D NETDEV_UP)
 		mpevent.code =3D MPTCP_EVENT_ADD;
 	else if (event =3D=3D NETDEV_CHANGE)
-		mpevent.code =3D MPTCP_EVENT_MOD;
+		goto out;
 =

-	mptcp_debug("%s created event for %pI6, code %u prio %u idx %u\n", __func=
__,
-		    &ifa->addr, mpevent.code, mpevent.low_prio, mpevent.if_idx);
+	mptcp_debug("%s created event for %pI6, code %u idx %u\n", __func__,
+		    &ifa->addr, mpevent.code, mpevent.if_idx);
 	add_pm_event(net, &mpevent);
 =

+out:
 	spin_unlock_bh(&fm_ns->local_lock);
 	return;
 }
@@ -1241,7 +1192,6 @@ static void full_mesh_new_session(const struct sock *=
meta_sk)
 	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
 	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
-	struct tcp_sock *master_tp =3D tcp_sk(mpcb->master_sk);
 	int i, index, if_idx =3D 0;
 	union inet_addr saddr, daddr;
 	sa_family_t family =3D AF_INET;
@@ -1275,12 +1225,6 @@ static void full_mesh_new_session(const struct sock =
*meta_sk)
 	if (index < 0)
 		goto fallback;
 =

-	if (family =3D=3D AF_INET)
-		master_tp->mptcp->low_prio =3D mptcp_local->locaddr4[index].low_prio;
-	else
-		master_tp->mptcp->low_prio =3D mptcp_local->locaddr6[index].low_prio;
-	master_tp->mptcp->send_mp_prio =3D master_tp->mptcp->low_prio;
-
 	full_mesh_add_raddr(mpcb, &daddr, family, 0, 0);
 	mptcp_set_init_addr_bit(mpcb, &daddr, family, index);
 =

@@ -1338,9 +1282,6 @@ static void full_mesh_new_session(const struct sock *=
meta_sk)
 	for (i =3D fmp->add_addr; i && fmp->add_addr; i--)
 		tcp_send_ack(mpcb->master_sk);
 =

-	if (master_tp->mptcp->send_mp_prio)
-		tcp_send_ack(mpcb->master_sk);
-
 	return;
 =

 fallback:
@@ -1414,7 +1355,6 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 =

 		mptcp_for_each_sub(mpcb, mptcp) {
 			struct sock *sk =3D mptcp_to_sock(mptcp);
-			struct tcp_sock *tp =3D tcp_sk(sk);
 =

 			if (sk->sk_family =3D=3D AF_INET6 &&
 			    !mptcp_v6_is_v4_mapped(sk))
@@ -1424,13 +1364,6 @@ static void full_mesh_release_sock(struct sock *meta=
_sk)
 				continue;
 =

 			found =3D true;
-
-			if (mptcp_local->locaddr4[i].low_prio !=3D tp->mptcp->low_prio) {
-				tp->mptcp->send_mp_prio =3D 1;
-				tp->mptcp->low_prio =3D mptcp_local->locaddr4[i].low_prio;
-
-				tcp_send_ack(sk);
-			}
 		}
 =

 		if (!found) {
@@ -1458,7 +1391,6 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 =

 		mptcp_for_each_sub(mpcb, mptcp) {
 			struct sock *sk =3D mptcp_to_sock(mptcp);
-			struct tcp_sock *tp =3D tcp_sk(sk);
 =

 			if (sk->sk_family =3D=3D AF_INET ||
 			    mptcp_v6_is_v4_mapped(sk))
@@ -1468,13 +1400,6 @@ static void full_mesh_release_sock(struct sock *meta=
_sk)
 				continue;
 =

 			found =3D true;
-
-			if (mptcp_local->locaddr6[i].low_prio !=3D tp->mptcp->low_prio) {
-				tp->mptcp->send_mp_prio =3D 1;
-				tp->mptcp->low_prio =3D mptcp_local->locaddr6[i].low_prio;
-
-				tcp_send_ack(sk);
-			}
 		}
 =

 		if (!found) {
@@ -1535,7 +1460,7 @@ static void full_mesh_release_sock(struct sock *meta_=
sk)
 }
 =

 static int full_mesh_get_local_id(sa_family_t family, union inet_addr *add=
r,
-				  struct net *net, bool *low_prio)
+				  struct net *net)
 {
 	struct mptcp_loc_addr *mptcp_local;
 	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(net);
@@ -1550,10 +1475,8 @@ static int full_mesh_get_local_id(sa_family_t family=
, union inet_addr *addr,
 	if (index !=3D -1) {
 		if (family =3D=3D AF_INET) {
 			id =3D mptcp_local->locaddr4[index].loc4_id;
-			*low_prio =3D mptcp_local->locaddr4[index].low_prio;
 		} else {
 			id =3D mptcp_local->locaddr6[index].loc6_id;
-			*low_prio =3D mptcp_local->locaddr6[index].low_prio;
 		}
 	}
 =

@@ -1778,8 +1701,8 @@ static int mptcp_fm_seq_show(struct seq_file *seq, vo=
id *v)
 	mptcp_for_each_bit_set(mptcp_local->loc4_bits, i) {
 		struct mptcp_loc4 *loc4 =3D &mptcp_local->locaddr4[i];
 =

-		seq_printf(seq, "%u, %u, %u, %pI4 %u\n", i, loc4->loc4_id,
-			   loc4->low_prio, &loc4->addr, loc4->if_idx);
+		seq_printf(seq, "%u, %u, %pI4 %u\n", i, loc4->loc4_id,
+			   &loc4->addr, loc4->if_idx);
 	}
 =

 	seq_printf(seq, "IPv6, next v6-index: %u\n", mptcp_local->next_v6_index);
@@ -1787,8 +1710,8 @@ static int mptcp_fm_seq_show(struct seq_file *seq, vo=
id *v)
 	mptcp_for_each_bit_set(mptcp_local->loc6_bits, i) {
 		struct mptcp_loc6 *loc6 =3D &mptcp_local->locaddr6[i];
 =

-		seq_printf(seq, "%u, %u, %u, %pI6 %u\n", i, loc6->loc6_id,
-			   loc6->low_prio, &loc6->addr, loc6->if_idx);
+		seq_printf(seq, "%u, %u, %pI6 %u\n", i, loc6->loc6_id,
+			   &loc6->addr, loc6->if_idx);
 	}
 	rcu_read_unlock_bh();
 =

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 9a4d1609b3b9..652da0439644 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -1503,14 +1503,12 @@ void mptcp_parse_options(const uint8_t *ptr, int op=
size,
 		case MPTCP_SUB_LEN_JOIN_SYN:
 			mopt->is_mp_join =3D 1;
 			mopt->saw_mpc =3D 1;
-			mopt->low_prio =3D mpjoin->b;
 			mopt->rem_id =3D mpjoin->addr_id;
 			mopt->mptcp_rem_token =3D mpjoin->u.syn.token;
 			mopt->mptcp_recv_nonce =3D mpjoin->u.syn.nonce;
 			break;
 		case MPTCP_SUB_LEN_JOIN_SYNACK:
 			mopt->saw_mpc =3D 1;
-			mopt->low_prio =3D mpjoin->b;
 			mopt->rem_id =3D mpjoin->addr_id;
 			mopt->mptcp_recv_tmac =3D mpjoin->u.synack.mac;
 			mopt->mptcp_recv_nonce =3D mpjoin->u.synack.nonce;
@@ -1613,26 +1611,6 @@ void mptcp_parse_options(const uint8_t *ptr, int ops=
ize,
 		mopt->saw_rem_addr =3D 1;
 		mopt->rem_addr_ptr =3D ptr;
 		break;
-	case MPTCP_SUB_PRIO:
-	{
-		const struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
-
-		if (opsize !=3D MPTCP_SUB_LEN_PRIO &&
-		    opsize !=3D MPTCP_SUB_LEN_PRIO_ADDR) {
-			mptcp_debug("%s: mp_prio: bad option size %d\n",
-				    __func__, opsize);
-			break;
-		}
-
-		mopt->saw_low_prio =3D 1;
-		mopt->low_prio =3D mpprio->b;
-
-		if (opsize =3D=3D MPTCP_SUB_LEN_PRIO_ADDR) {
-			mopt->saw_low_prio =3D 2;
-			mopt->prio_addr_id =3D mpprio->addr_id;
-		}
-		break;
-	}
 	case MPTCP_SUB_FAIL:
 		if (opsize !=3D MPTCP_SUB_LEN_FAIL) {
 			mptcp_debug("%s: mp_fail: bad option size %d\n",
@@ -1963,19 +1941,6 @@ bool mptcp_handle_options(struct sock *sk, const str=
uct tcphdr *th,
 		mopt->more_rem_addr =3D 0;
 		mopt->saw_rem_addr =3D 0;
 	}
-	if (mopt->saw_low_prio) {
-		if (mopt->saw_low_prio =3D=3D 1) {
-			tp->mptcp->rcv_low_prio =3D mopt->low_prio;
-		} else {
-			struct mptcp_tcp_sock *mptcp;
-
-			mptcp_for_each_sub(tp->mpcb, mptcp) {
-				if (mptcp->rem_id =3D=3D mopt->prio_addr_id)
-					mptcp->rcv_low_prio =3D mopt->low_prio;
-			}
-		}
-		mopt->saw_low_prio =3D 0;
-	}
 =

 	mptcp_data_ack(sk, skb);
 =

@@ -2077,7 +2042,6 @@ int mptcp_rcv_synsent_state_process(struct sock *sk, =
struct sock **skptr,
 		 * until the 4th ack arrives.
 		 */
 		tp->mptcp->pre_established =3D 1;
-		tp->mptcp->rcv_low_prio =3D tp->mptcp->rx_opt.low_prio;
 =

 		mptcp_hmac_sha1((u8 *)&mpcb->mptcp_loc_key,
 				(u8 *)&mpcb->mptcp_rem_key,
diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
index c808d10205f5..00c54f421ba7 100644
--- a/net/mptcp/mptcp_ipv4.c
+++ b/net/mptcp/mptcp_ipv4.c
@@ -104,7 +104,6 @@ static int mptcp_v4_join_init_req(struct request_sock *=
req, const struct sock *m
 	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	union inet_addr addr;
 	int loc_id;
-	bool low_prio =3D false;
 =

 	/* We need to do this as early as possible. Because, if we fail later
 	 * (e.g., get_local_id), then reqsk_free tries to remove the
@@ -120,11 +119,10 @@ static int mptcp_v4_join_init_req(struct request_sock=
 *req, const struct sock *m
 						    tcp_hdr(skb)->source,
 						    tcp_hdr(skb)->dest);
 	addr.ip =3D inet_rsk(req)->ir_loc_addr;
-	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr, sock_net(meta_sk), =
&low_prio);
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET, &addr, sock_net(meta_sk));
 	if (loc_id =3D=3D -1)
 		return -1;
 	mtreq->loc_id =3D loc_id;
-	mtreq->low_prio =3D low_prio;
 =

 	mptcp_join_reqsk_init(mpcb, req, skb);
 =

@@ -292,7 +290,6 @@ int mptcp_init4_subsockets(struct sock *meta_sk, const =
struct mptcp_loc4 *loc,
 	}
 =

 	tp->mptcp->slave_sk =3D 1;
-	tp->mptcp->low_prio =3D loc->low_prio;
 =

 	/* Initializing the timer for an MPTCP subflow */
 	timer_setup(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, 0);
diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
index 2d730379d5ed..7249d171c9ef 100644
--- a/net/mptcp/mptcp_ipv6.c
+++ b/net/mptcp/mptcp_ipv6.c
@@ -133,7 +133,6 @@ static int mptcp_v6_join_init_req(struct request_sock *=
req, const struct sock *m
 	const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	union inet_addr addr;
 	int loc_id;
-	bool low_prio =3D false;
 =

 	/* We need to do this as early as possible. Because, if we fail later
 	 * (e.g., get_local_id), then reqsk_free tries to remove the
@@ -149,11 +148,10 @@ static int mptcp_v6_join_init_req(struct request_sock=
 *req, const struct sock *m
 						    tcp_hdr(skb)->source,
 						    tcp_hdr(skb)->dest);
 	addr.in6 =3D inet_rsk(req)->ir_v6_loc_addr;
-	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(meta_sk),=
 &low_prio);
+	loc_id =3D mpcb->pm_ops->get_local_id(AF_INET6, &addr, sock_net(meta_sk));
 	if (loc_id =3D=3D -1)
 		return -1;
 	mtreq->loc_id =3D loc_id;
-	mtreq->low_prio =3D low_prio;
 =

 	mptcp_join_reqsk_init(mpcb, req, skb);
 =

@@ -319,7 +317,6 @@ int mptcp_init6_subsockets(struct sock *meta_sk, const =
struct mptcp_loc6 *loc,
 	}
 =

 	tp->mptcp->slave_sk =3D 1;
-	tp->mptcp->low_prio =3D loc->low_prio;
 =

 	/* Initializing the timer for an MPTCP subflow */
 	timer_setup(&tp->mptcp->mptcp_ack_timer, mptcp_ack_handler, 0);
diff --git a/net/mptcp/mptcp_ndiffports.c b/net/mptcp/mptcp_ndiffports.c
index 58acf50df752..9faef10d8b64 100644
--- a/net/mptcp/mptcp_ndiffports.c
+++ b/net/mptcp/mptcp_ndiffports.c
@@ -61,7 +61,6 @@ static void create_subflow_worker(struct work_struct *wor=
k)
 =

 			loc.addr.s_addr =3D inet_sk(meta_sk)->inet_saddr;
 			loc.loc4_id =3D 0;
-			loc.low_prio =3D 0;
 			if (mpcb->master_sk)
 				loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
 			else
@@ -79,7 +78,6 @@ static void create_subflow_worker(struct work_struct *wor=
k)
 =

 			loc.addr =3D inet6_sk(meta_sk)->saddr;
 			loc.loc6_id =3D 0;
-			loc.low_prio =3D 0;
 			if (mpcb->master_sk)
 				loc.if_idx =3D mpcb->master_sk->sk_bound_dev_if;
 			else
@@ -128,7 +126,7 @@ static void ndiffports_create_subflows(struct sock *met=
a_sk)
 }
 =

 static int ndiffports_get_local_id(sa_family_t family, union inet_addr *ad=
dr,
-				   struct net *net, bool *low_prio)
+				   struct net *net)
 {
 	return 0;
 }
diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
index f9bce20259e9..af695fafaab2 100644
--- a/net/mptcp/mptcp_output.c
+++ b/net/mptcp/mptcp_output.c
@@ -960,7 +960,6 @@ void mptcp_syn_options(const struct sock *sk, struct tc=
p_out_options *opts,
 		opts->mptcp_options |=3D OPTION_MP_JOIN | OPTION_TYPE_SYN;
 		*remaining -=3D MPTCP_SUB_LEN_JOIN_SYN_ALIGN;
 		opts->mp_join_syns.token =3D mpcb->mptcp_rem_token;
-		opts->mp_join_syns.low_prio  =3D tp->mptcp->low_prio;
 		opts->addr_id =3D tp->mptcp->loc_id;
 		opts->mp_join_syns.sender_nonce =3D tp->mptcp->mptcp_loc_nonce;
 	}
@@ -984,7 +983,6 @@ void mptcp_synack_options(struct request_sock *req,
 		opts->mp_join_syns.sender_truncated_mac =3D
 				mtreq->mptcp_hash_tmac;
 		opts->mp_join_syns.sender_nonce =3D mtreq->mptcp_loc_nonce;
-		opts->mp_join_syns.low_prio =3D mtreq->low_prio;
 		opts->addr_id =3D mtreq->loc_id;
 		*remaining -=3D MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN;
 	}
@@ -1085,15 +1083,6 @@ void mptcp_established_options(struct sock *sk, stru=
ct sk_buff *skb,
 	    mpcb->mptcp_ver < MPTCP_VERSION_1)
 		mpcb->pm_ops->addr_signal(sk, size, opts, skb);
 =

-	if (unlikely(tp->mptcp->send_mp_prio) &&
-	    MAX_TCP_OPTION_SPACE - *size >=3D MPTCP_SUB_LEN_PRIO_ALIGN) {
-		opts->options |=3D OPTION_MPTCP;
-		opts->mptcp_options |=3D OPTION_MP_PRIO;
-		if (skb)
-			tp->mptcp->send_mp_prio =3D 0;
-		*size +=3D MPTCP_SUB_LEN_PRIO_ALIGN;
-	}
-
 	return;
 }
 =

@@ -1149,7 +1138,7 @@ void mptcp_options_write(__be32 *ptr, struct tcp_sock=
 *tp,
 			mpj->len =3D MPTCP_SUB_LEN_JOIN_SYN;
 			mpj->u.syn.token =3D opts->mp_join_syns.token;
 			mpj->u.syn.nonce =3D opts->mp_join_syns.sender_nonce;
-			mpj->b =3D opts->mp_join_syns.low_prio;
+			mpj->b =3D 0;
 			mpj->addr_id =3D opts->addr_id;
 			ptr +=3D MPTCP_SUB_LEN_JOIN_SYN_ALIGN >> 2;
 		} else if (OPTION_TYPE_SYNACK & opts->mptcp_options) {
@@ -1157,7 +1146,7 @@ void mptcp_options_write(__be32 *ptr, struct tcp_sock=
 *tp,
 			mpj->u.synack.mac =3D
 				opts->mp_join_syns.sender_truncated_mac;
 			mpj->u.synack.nonce =3D opts->mp_join_syns.sender_nonce;
-			mpj->b =3D opts->mp_join_syns.low_prio;
+			mpj->b =3D 0;
 			mpj->addr_id =3D opts->addr_id;
 			ptr +=3D MPTCP_SUB_LEN_JOIN_SYNACK_ALIGN >> 2;
 		} else if (OPTION_TYPE_ACK & opts->mptcp_options) {
@@ -1252,18 +1241,6 @@ void mptcp_options_write(__be32 *ptr, struct tcp_soc=
k *tp,
 		else
 			ptr +=3D mptcp_write_dss_data_seq(tp, skb, ptr);
 	}
-	if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
-		struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
-
-		mpprio->kind =3D TCPOPT_MPTCP;
-		mpprio->len =3D MPTCP_SUB_LEN_PRIO;
-		mpprio->sub =3D MPTCP_SUB_PRIO;
-		mpprio->rsv =3D 0;
-		mpprio->b =3D tp->mptcp->low_prio;
-		mpprio->addr_id =3D TCPOPT_NOP;
-
-		ptr +=3D MPTCP_SUB_LEN_PRIO_ALIGN >> 2;
-	}
 }
 =

 /* Sends the datafin */
diff --git a/net/mptcp/mptcp_pm.c b/net/mptcp/mptcp_pm.c
index 08e3f05a9e65..fbdf8eb58d17 100644
--- a/net/mptcp/mptcp_pm.c
+++ b/net/mptcp/mptcp_pm.c
@@ -35,7 +35,7 @@ static DEFINE_SPINLOCK(mptcp_pm_list_lock);
 static LIST_HEAD(mptcp_pm_list);
 =

 static int mptcp_default_id(sa_family_t family, union inet_addr *addr,
-			    struct net *net, bool *low_prio)
+			    struct net *net)
 {
 	return 0;
 }
diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index 3662bdf97c0d..82ffe080cb5e 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -113,22 +113,11 @@ static int mptcp_dont_reinject_skb(const struct tcp_s=
ock *tp, const struct sk_bu
 		mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
 }
 =

-static bool subflow_is_backup(const struct tcp_sock *tp)
-{
-	return tp->mptcp->rcv_low_prio || tp->mptcp->low_prio;
-}
-
-static bool subflow_is_active(const struct tcp_sock *tp)
-{
-	return !tp->mptcp->rcv_low_prio && !tp->mptcp->low_prio;
-}
-
 /* Generic function to iterate over used and unused subflows and to select=
 the
  * best one
  */
 static struct sock
 *get_subflow_from_selectors(struct mptcp_cb *mpcb, struct sk_buff *skb,
-			    bool (*selector)(const struct tcp_sock *),
 			    bool zero_wnd_test, bool *force)
 {
 	struct sock *bestsk =3D NULL;
@@ -142,10 +131,6 @@ static struct sock
 		struct tcp_sock *tp =3D tcp_sk(sk);
 		bool unused =3D false;
 =

-		/* First, we choose only the wanted sks */
-		if (!(*selector)(tp))
-			continue;
-
 		if (!mptcp_dont_reinject_skb(tp, skb))
 			unused =3D true;
 		else if (found_unused)
@@ -233,16 +218,13 @@ static struct sock *get_available_subflow(struct sock=
 *meta_sk,
 =

 	/* Find the best subflow */
 restart:
-	sk =3D get_subflow_from_selectors(mpcb, skb, &subflow_is_active,
-					zero_wnd_test, &force);
+	sk =3D get_subflow_from_selectors(mpcb, skb, zero_wnd_test, &force);
 	if (force)
 		/* one unused active sk or one NULL sk when there is at least
 		 * one temporally unavailable unused active sk
 		 */
 		return sk;
 =

-	sk =3D get_subflow_from_selectors(mpcb, skb, &subflow_is_backup,
-					zero_wnd_test, &force);
 	if (!force && skb) {
 		/* one used backup sk or one NULL sk where there is no one
 		 * temporally unavailable unused backup sk
-- =

2.16.2


--===============0836120075564542813==--
