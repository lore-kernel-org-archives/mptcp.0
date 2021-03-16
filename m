Content-Type: multipart/mixed; boundary="===============0348264275271170189=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/3] mptcp: rename
 mptcp_pm_nl_add_addr_send_ack
Date: Tue, 16 Mar 2021 13:27:11 +0800
Message-ID: <2785b2cfc88c31b8794320d1803cc1b72d5aedb8.1615871979.git.geliangtang@gmail.com>
In-Reply-To: b6c36865d72a9fc55d3a926ebdbfad6b95390cea.1615871979.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8165

--===============0348264275271170189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since mptcp_pm_nl_add_addr_send_ack is now used for both ADD_ADDR and
RM_ADDR cases, rename it to mptcp_pm_nl_addr_send_ack.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 2 +-
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index efa7deb96139..9d00fa6d22e9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -53,7 +53,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const st=
ruct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx =3D *rm_list;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_add_addr_send_ack(msk);
+	mptcp_pm_nl_addr_send_ack(msk);
 	return 0;
 }
 =

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eab8014179d1..a62f887c5198 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -437,7 +437,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_add_addr_send_ack(msk);
+				mptcp_pm_nl_addr_send_ack(msk);
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -519,10 +519,10 @@ static void mptcp_pm_nl_add_addr_received(struct mptc=
p_sock *msk)
 =

 add_addr_echo:
 	mptcp_pm_announce_addr(msk, &msk->pm.remote, true);
-	mptcp_pm_nl_add_addr_send_ack(msk);
+	mptcp_pm_nl_addr_send_ack(msk);
 }
 =

-void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
+void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

@@ -663,7 +663,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
 		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_nl_add_addr_send_ack(msk);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 34fddb1fcd1e..e53a9568d587 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -667,7 +667,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
-- =

2.30.2

--===============0348264275271170189==--
