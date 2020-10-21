Content-Type: multipart/mixed; boundary="===============0264060975944906324=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 2/3] mptcp: send out dedicated
 ADD_ADDR packet
Date: Wed, 21 Oct 2020 15:19:52 +0800
Message-ID: <9f53954454bd112cceb589a8e67016bd3c899405.1603264085.git.geliangtang@gmail.com>
In-Reply-To: 2755693ec1ea78bc07088977175a73ae3bf0493d.1603264085.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6383

--===============0264060975944906324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When ADD_ADDR suboption includes an IPv6 address, the size is 28 octets.
It will not fit when other MPTCP suboptions are included in this packet,
e.g. DSS. So here we send out an ADD_ADDR dedicated packet to carry only
ADD_ADDR suboption, no other MPTCP suboptions.

In mptcp_pm_announce_addr, we check whether this is an IPv6 ADD_ADDR.
If it is, we set the flag MPTCP_ADD_ADDR_IPV6 to true. Then we call
mptcp_pm_check_send_dedicated_add_addr_packet to sent out a new pure
ACK packet.

In mptcp_established_options_add_addr, we check whether this is a pure
ACK packet for ADD_ADDR. If it is, we drop all other MPTCP suboptions
in this packet, only put ADD_ADDR suboption in it.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 25 ++++++++++++++++++++++---
 net/mptcp/pm.c         |  8 ++++++--
 net/mptcp/pm_netlink.c | 27 +++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   |  3 +++
 5 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f2d1e27a2bc1..fc6a62fbbe4c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -242,7 +242,9 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 =

 		mp_opt->add_addr =3D 1;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
+		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d",
+			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -573,17 +575,27 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2=
, u8 addr_id,
 }
 #endif
 =

-static bool mptcp_established_options_add_addr(struct sock *sk,
+static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_=
buff *skb,
 					       unsigned int *size,
 					       unsigned int remaining,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+	bool drop_other_suboptions =3D false;
+	unsigned int opt_size =3D *size;
 	struct mptcp_addr_info saddr;
 	bool echo;
 	int len;
 =

+	if (READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6) &&
+	    skb && skb_is_tcp_pure_ack(skb)) {
+		pr_debug("drop other suboptions");
+		opts->suboptions =3D 0;
+		remaining +=3D opt_size;
+		drop_other_suboptions =3D true;
+	}
+
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
 		return false;
@@ -593,6 +605,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 		return false;
 =

 	*size =3D len;
+	if (drop_other_suboptions)
+		*size -=3D opt_size;
 	opts->addr_id =3D saddr.id;
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
@@ -678,7 +692,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 =

 	*size +=3D opt_size;
 	remaining -=3D opt_size;
-	if (mptcp_established_options_add_addr(sk, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opt=
s)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
 		ret =3D true;
@@ -759,6 +773,11 @@ static bool check_fully_established(struct mptcp_sock =
*msk, struct sock *ssk,
 		goto fully_established;
 	}
 =

+	if (mp_opt->add_addr) {
+		WRITE_ONCE(msk->fully_established, true);
+		return true;
+	}
+
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP. Fallback scenarios requires a reset for
 	 * MP_JOIN subflows.
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc6619670d37..4341e140f1ff 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -24,6 +24,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
 	if (echo)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
+	if (addr->family =3D=3D AF_INET6)
+		add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
 	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
 	return 0;
 }
@@ -153,10 +155,12 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
 =

 	spin_lock_bh(&pm->lock);
 =

-	if (!READ_ONCE(pm->accept_addr))
+	if (!READ_ONCE(pm->accept_addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
-	else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
+		mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
+	}
 =

 	spin_unlock_bh(&pm->lock);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7599b0f14920..da545f11745c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -229,6 +229,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!mptcp_pm_should_add_signal(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		mptcp_pm_check_send_dedicated_add_addr_packet(msk);
 		entry->retrans_times++;
 	}
 =

@@ -306,6 +307,30 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 =

+void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (!(READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6)))
+		return;
+
+	__mptcp_flush_join_list(msk);
+	subflow =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), n=
ode);
+	if (subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		u8 add_addr;
+
+		spin_unlock_bh(&msk->pm.lock);
+		pr_debug("send ack for add_addr6");
+		tcp_send_ack(ssk);
+		spin_lock_bh(&msk->pm.lock);
+
+		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+		add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
+		WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
+	}
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct mptcp_addr_info remote =3D { 0 };
@@ -329,6 +354,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
+				mptcp_pm_check_send_dedicated_add_addr_packet(msk);
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -399,6 +425,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true);
+	mptcp_pm_check_send_dedicated_add_addr_packet(msk);
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 433ef39168e5..1699d3ed71a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -686,7 +686,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk->sk_data_ready(sk);
 }
 =

-static void __mptcp_flush_join_list(struct mptcp_sock *msk)
+void __mptcp_flush_join_list(struct mptcp_sock *msk)
 {
 	if (likely(list_empty(&msk->join_list)))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0bcfbc71631b..25ad1cdf7e58 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -169,6 +169,7 @@ enum mptcp_pm_status {
 enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
+	MPTCP_ADD_ADDR_IPV6,
 };
 =

 struct mptcp_pm_data {
@@ -467,6 +468,7 @@ bool mptcp_schedule_work(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, b=
ool use_64bit);
+void __mptcp_flush_join_list(struct mptcp_sock *msk);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->snd_data_fin_enable) &&
@@ -516,6 +518,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
+void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

-- =

2.26.2

--===============0264060975944906324==--
