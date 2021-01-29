Content-Type: multipart/mixed; boundary="===============4816172573916663122=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/8] mptcp: remove multi addrs on
 incoming path
Date: Fri, 29 Jan 2021 18:26:46 +0800
Message-ID: <24bcce4d373eea4ca0a1071e92132fd6103ed2c6.1611914854.git.geliangtang@gmail.com>
In-Reply-To: 39063864f13dfbaf09623e0eeec9556503584dc5.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7525

--===============4816172573916663122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of rm_id in struct mptcp_options_received from
u8 to u64, and renamed it to rm_ids.

In mptcp_parse_option, parsed the RM_ADDR suboption and filled them into
the ids map in struct mptcp_options_received.

In mptcp_incoming_options, passed this ids map to the function
mptcp_pm_rm_addr_received.

It alse changed the parameter type of mptcp_pm_rm_addr_received.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 13 +++++++++----
 net/mptcp/pm.c       |  8 ++++----
 net/mptcp/protocol.h |  4 ++--
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 11f6182b8319..53035c2ec40f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -25,6 +25,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	u8 subtype =3D *ptr >> 4;
 	int expected_opsize;
 	u8 version;
+	u8 *p, i;
 	u8 flags;
 =

 	switch (subtype) {
@@ -272,14 +273,18 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
 		break;
 =

 	case MPTCPOPT_RM_ADDR:
-		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
+		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
+		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + 8)
 			break;
 =

 		ptr++;
 =

 		mp_opt->rm_addr =3D 1;
-		mp_opt->rm_id =3D *ptr++;
-		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
+		mp_opt->rm_ids =3D 0;
+		p =3D (u8 *)&mp_opt->rm_ids;
+		for (i =3D 0; i < opsize - TCPOLEN_MPTCP_RM_ADDR_BASE; i++)
+			*p++ =3D *ptr++;
+		pr_debug("RM_ADDR: ids=3D%llu", mp_opt->rm_ids);
 		break;
 =

 	case MPTCPOPT_MP_PRIO:
@@ -1041,7 +1046,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 	}
 =

 	if (mp_opt.rm_addr) {
-		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
+		mptcp_pm_rm_addr_received(msk, mp_opt.rm_ids);
 		mp_opt.rm_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7ec1d2a1582b..1c10011e5abf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -205,17 +205,17 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *ms=
k)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 =

-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u64 rm_ids)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

-	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
+	pr_debug("msk=3D%p remote_ids=3D%llu", msk, rm_ids);
 =

-	mptcp_event_addr_removed(msk, rm_id);
+	mptcp_event_addr_removed(msk, rm_ids);
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_id;
+	pm->rm_id =3D rm_ids;
 	spin_unlock_bh(&pm->lock);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 962cc1b4dd48..dd6899ab1f19 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -139,7 +139,7 @@ struct mptcp_options_received {
 		mpc_map:1,
 		__unused:2;
 	u8	addr_id;
-	u8	rm_id;
+	u64	rm_ids;
 	union {
 		struct in_addr	addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -654,7 +654,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u64 rm_ids);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
-- =

2.29.2

--===============4816172573916663122==--
