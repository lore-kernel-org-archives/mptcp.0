Content-Type: multipart/mixed; boundary="===============4460234842062421805=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 2/3] mptcp: move to next addr
 when subflow creation fail
Date: Fri, 19 Feb 2021 11:08:03 +0800
Message-ID: <726b3e1fa90f601526b51d0ec90d69d080c49d12.1613703548.git.geliangtang@gmail.com>
In-Reply-To: 43921930efc54abcbc10c5984ad3950231ae26e9.1613703548.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7858

--===============4460234842062421805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When an invalid address was announced, the subflow couldn't be created
for this address. Therefore mptcp_pm_nl_subflow_established couldn't be
invoked. Then the next addresses in the local address list didn't have a
chance to be announced.

This patch invokes the new function mptcp_pm_add_addr_echoed when the
address is echoed. In it, use mptcp_lookup_anno_list_by_saddr to check
whether this address is in the anno_list. If it is, PM schedules the
status MPTCP_PM_SUBFLOW_ESTABLISHED to invoke
mptcp_pm_create_subflow_or_signal_addr to deal with the next address in
the local address list.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  |  1 +
 net/mptcp/pm.c       | 15 +++++++++++++++
 net/mptcp/protocol.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b252aadad3fc..e3ba04044561 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1036,6 +1036,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
+			mptcp_pm_add_addr_echoed(msk, &addr);
 			mptcp_pm_del_add_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b559e06757f7..db2ce84d250a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -196,6 +196,21 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p", msk);
+
+	spin_lock_bh(&pm->lock);
+
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pend=
ing))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+
+	spin_unlock_bh(&pm->lock);
+}
+
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99c7f1aa7af0..6af3e259fa05 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -646,6 +646,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *ms=
k);
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_lis=
t rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
-- =

2.29.2

--===============4460234842062421805==--
