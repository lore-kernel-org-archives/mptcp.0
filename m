Content-Type: multipart/mixed; boundary="===============2462749153814958450=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 3/6] Squash to "mptcp: add rm_list
 in mptcp_options_received"
Date: Thu, 04 Mar 2021 14:42:45 +0800
Message-ID: <20210304064248.9636-4-geliangtang@gmail.com>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8012

--===============2462749153814958450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/pm.c       | 11 ++++++-----
 net/mptcp/protocol.h |  3 ++-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0aae63bc4f7d..55b5b13f4c9b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1047,7 +1047,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 	}
 =

 	if (mp_opt.rm_addr) {
-		mptcp_pm_rm_addr_received(msk, mp_opt.rm_list);
+		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
 		mp_opt.rm_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9a97992a44cd..0cd06743ed3f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -204,19 +204,20 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock *ms=
k)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 =

-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list)
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
+			       const struct mptcp_rm_list *rm_list)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
 	u8 i;
 =

-	pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, rm_list.nr);
+	pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, rm_list->nr);
 =

-	for (i =3D 0; i < rm_list.nr; i++)
-		mptcp_event_addr_removed(msk, rm_list.ids[i]);
+	for (i =3D 0; i < rm_list->nr; i++)
+		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_id =3D rm_list.ids[0];
+	pm->rm_id =3D rm_list->ids[0];
 	spin_unlock_bh(&pm->lock);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bf270538ebe9..cd3d4eea6b57 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -647,7 +647,8 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
+			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
-- =

2.29.2

--===============2462749153814958450==--
