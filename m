Content-Type: multipart/mixed; boundary="===============3959478040674902970=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 3/9] mptcp: use rm_ids array in
 mptcp_options_received
Date: Tue, 02 Feb 2021 15:20:54 +0800
Message-ID: <098e4b48d30601d1714b36f6839f5b7d5ff0a4c6.1612250255.git.geliangtang@gmail.com>
In-Reply-To: 0905122212bc3da3b02b5d59f62ccf23daa5c241.1612250255.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7582

--===============3959478040674902970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the member rm_id in struct mptcp_options_received as an
array of the removing address ids, and renamed it to rm_ids.

In mptcp_parse_option, parsed the RM_ADDR suboption and filled them into
the ids array in struct mptcp_options_received.

In mptcp_incoming_options, passed this ids array to the function
mptcp_pm_rm_addr_received.

It alse changed the parameter type of mptcp_pm_rm_addr_received.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 15 +++++++++++----
 net/mptcp/pm.c       | 10 ++++++----
 net/mptcp/protocol.h |  4 ++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a6a4fdf03d6c..ed2b8af89ab8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -26,6 +26,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	int expected_opsize;
 	u8 version;
 	u8 flags;
+	u8 i, nr;
 =

 	switch (subtype) {
 	case MPTCPOPT_MP_CAPABLE:
@@ -272,14 +273,20 @@ static void mptcp_parse_option(const struct sk_buff *=
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
+		memset(mp_opt->rm_ids, 0, MPTCP_RM_IDS_MAX);
+		nr =3D opsize - TCPOLEN_MPTCP_RM_ADDR_BASE;
+		for (i =3D 0; i < nr; i++)
+			mp_opt->rm_ids[i] =3D *ptr++;
+		pr_debug("RM_ADDR: ids_nr=3D%d", nr);
+		for (i =3D 0; i < nr; i++)
+			pr_debug(" -> id[%d]=3D%d", i, mp_opt->rm_ids[i]);
 		break;
 =

 	case MPTCPOPT_MP_PRIO:
@@ -1040,7 +1047,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
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
index 7207d1dc87ad..88bc35303f73 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -205,17 +205,19 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *ms=
k)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 =

-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_ids[])
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
+	u8 i;
 =

-	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
+	pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, mptcp_get_rm_ids_nr(rm_ids));
 =

-	mptcp_event_addr_removed(msk, rm_id);
+	for (i =3D 0; i < MPTCP_RM_IDS_MAX && rm_ids[i]; i++)
+		mptcp_event_addr_removed(msk, rm_ids[i]);
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_id;
+	pm->rm_id =3D rm_ids[0];
 	spin_unlock_bh(&pm->lock);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ae225ef202db..aeb589384824 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -140,7 +140,7 @@ struct mptcp_options_received {
 		mpc_map:1,
 		__unused:2;
 	u8	addr_id;
-	u8	rm_id;
+	u8	rm_ids[MPTCP_RM_IDS_MAX];
 	union {
 		struct in_addr	addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -661,7 +661,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_ids[]);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
-- =

2.29.2

--===============3959478040674902970==--
