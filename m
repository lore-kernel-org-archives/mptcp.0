Content-Type: multipart/mixed; boundary="===============7270930657434450606=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 2/3] mptcp: send out dedicated
 ADD_ADDR packet
Date: Sat, 10 Oct 2020 18:07:24 +0800
Message-ID: <5df8d67258bfb5c2bce9b108e15b8a558ba318b9.1602323760.git.geliangtang@gmail.com>
In-Reply-To: 4e6e17e8ca4879f101c7e649031fe1b174ee4c1d.1602323760.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6280

--===============7270930657434450606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When ADD_ADDR suboption includes an IPv6 address, the size is 28 octets.
It will not fit when other MPTCP suboptions are included in this packet,
e.g. DSS. So here we send out an ADD_ADDR dedicated packet to carry only
ADD_ADDR suboption, no other MPTCP suboptions.

In mptcp_pm_announce_addr, we check whether this is an IPv6 ADD_ADDR.
If it is, we set the flag MPTCP_ADD_ADDR_IPV6 to true. Then we call
mptcp_send_dedicated_add_addr_packet to sent out a new pure ACK packet.

In mptcp_established_options_add_addr, we check whether this is a pure
ACK packet for ADD_ADDR. If it is, we drop all other MPTCP suboptions
in this packet, only put ADD_ADDR suboption in it.

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 23 ++++++++++++++++++++---
 net/mptcp/pm.c         |  9 +++++++--
 net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  3 +++
 4 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d601dd1ebe5e..7de9b5af72db 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -243,7 +243,9 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->add_addr =3D 1;
 		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
+		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d",
+			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -572,17 +574,30 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2=
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

+	if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6) &&
+	    msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_SEND_ACK) &&
+	    skb && skb_is_tcp_pure_ack(skb)) {
+		msk->pm.add_addr_signal &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
+
+		pr_debug("drop other suboptions");
+		opts->suboptions =3D 0;
+		remaining +=3D opt_size;
+		drop_other_suboptions =3D true;
+	}
+
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
 		return false;
@@ -592,6 +607,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 		return false;
 =

 	*size =3D len;
+	if (drop_other_suboptions)
+		*size -=3D opt_size;
 	opts->addr_id =3D saddr.id;
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
@@ -671,7 +688,7 @@ bool mptcp_established_options(struct sock *sk, struct =
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
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5f453db36e54..da99f8e24702 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -22,6 +22,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
 	if (echo)
 		msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_ECHO);
+	if (addr->family =3D=3D AF_INET6)
+		msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_IPV6);
 	return 0;
 }
 =

@@ -150,10 +152,13 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
 =

 	spin_lock_bh(&pm->lock);
 =

-	if (!READ_ONCE(pm->accept_addr))
+	if (!READ_ONCE(pm->accept_addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
-	else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
+		if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6))
+			mptcp_send_dedicated_add_addr_packet(msk);
+	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
+	}
 =

 	spin_unlock_bh(&pm->lock);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed60538df7b2..9ca0603bfa19 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -229,6 +229,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!mptcp_pm_should_add_signal(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6))
+			mptcp_send_dedicated_add_addr_packet(msk);
 		entry->retrans_times++;
 	}
 =

@@ -306,6 +308,31 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 =

+void mptcp_send_dedicated_add_addr_packet(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (list_empty(&msk->conn_list))
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		if (!(msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_SEND_ACK))) {
+			msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_SEND_ACK);
+
+			spin_unlock_bh(&msk->pm.lock);
+			pr_debug("send ack for add_addr6");
+			tcp_send_ack(ssk);
+			spin_lock_bh(&msk->pm.lock);
+
+			msk->pm.add_addr_signal &=3D ~BIT(MPTCP_ADD_ADDR_SEND_ACK);
+
+			return;
+		}
+	}
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct mptcp_addr_info remote =3D { 0 };
@@ -329,6 +356,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(str=
uct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
+
+				if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6)) {
+					spin_unlock_bh(&msk->pm.lock);
+					msleep(500);
+					spin_lock_bh(&msk->pm.lock);
+					mptcp_send_dedicated_add_addr_packet(msk);
+				}
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -399,6 +433,9 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true);
+
+	if (msk->pm.add_addr_signal & BIT(MPTCP_ADD_ADDR_IPV6))
+		mptcp_send_dedicated_add_addr_packet(msk);
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9eb2b1bff7f5..6aeedbd46c82 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -168,6 +168,8 @@ enum mptcp_pm_status {
 enum mptcp_add_addr_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
+	MPTCP_ADD_ADDR_IPV6,
+	MPTCP_ADD_ADDR_SEND_ACK,
 };
 =

 struct mptcp_pm_data {
@@ -506,6 +508,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
+void mptcp_send_dedicated_add_addr_packet(struct mptcp_sock *msk);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

-- =

2.26.2

--===============7270930657434450606==--
