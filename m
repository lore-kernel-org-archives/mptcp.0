Content-Type: multipart/mixed; boundary="===============0038217568350841917=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 03/11] mptcp: add rm_list in
 mptcp_options_received
Date: Wed, 10 Feb 2021 10:19:52 +0800
Message-ID: <86af9b2958301bb4d0bb3e5d1013ba871c2d3fbd.1612922705.git.geliangtang@gmail.com>
In-Reply-To: d403b6e72c7636faf3faff160a92ba4b6a8f3cda.1612922705.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7733

--===============0038217568350841917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the member rm_id in struct mptcp_options_received as a
list of the removing address ids, and renamed it to rm_list.

In mptcp_parse_option, parsed the RM_ADDR suboption and filled them into
the rm_list in struct mptcp_options_received.

In mptcp_incoming_options, passed this rm_list to the function
mptcp_pm_rm_addr_received.

It alse changed the parameter type of mptcp_pm_rm_addr_received.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 12 ++++++++----
 net/mptcp/pm.c       | 10 ++++++----
 net/mptcp/protocol.h |  4 ++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e41410475f0e..ea4cacff0f5f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -26,6 +26,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	int expected_opsize;
 	u8 version;
 	u8 flags;
+	u8 i;
 =

 	switch (subtype) {
 	case MPTCPOPT_MP_CAPABLE:
@@ -272,14 +273,17 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
 		break;
 =

 	case MPTCPOPT_RM_ADDR:
-		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
+		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
+		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
 			break;
 =

 		ptr++;
 =

 		mp_opt->rm_addr =3D 1;
-		mp_opt->rm_id =3D *ptr++;
-		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
+		mp_opt->rm_list.nr =3D opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
+		for (i =3D 0; i < mp_opt->rm_list.nr; i++)
+			mp_opt->rm_list.ids[i] =3D *ptr++;
+		pr_debug("RM_ADDR: rm_list_nr=3D%d", mp_opt->rm_list.nr);
 		break;
 =

 	case MPTCPOPT_MP_PRIO:
@@ -1040,7 +1044,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 	}
 =

 	if (mp_opt.rm_addr) {
-		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
+		mptcp_pm_rm_addr_received(msk, mp_opt.rm_list);
 		mp_opt.rm_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 32f203f186a2..75e1651b5e9f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -205,17 +205,19 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *ms=
k)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 =

-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
+	u8 i;
 =

-	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
+	pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, rm_list.nr);
 =

-	mptcp_event_addr_removed(msk, rm_id);
+	for (i =3D 0; i < rm_list.nr; i++)
+		mptcp_event_addr_removed(msk, rm_list.ids[i]);
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_id;
+	pm->rm_id =3D rm_list.ids[0];
 	spin_unlock_bh(&pm->lock);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7fbfa0c5eba8..8783f1b428a5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -141,7 +141,7 @@ struct mptcp_options_received {
 		mpc_map:1,
 		__unused:2;
 	u8	addr_id;
-	u8	rm_id;
+	struct mptcp_rm_list rm_list;
 	union {
 		struct in_addr	addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -647,7 +647,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
-- =

2.29.2

--===============0038217568350841917==--
