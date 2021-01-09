Content-Type: multipart/mixed; boundary="===============1865168792121544402=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 7/8] mptcp: add the mibs for MP_PRIO
Date: Fri, 08 Jan 2021 16:48:01 -0800
Message-ID: <20210109004802.341602-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210109004802.341602-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7295

--===============1865168792121544402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the mibs for MP_PRIO, MPTCP_MIB_MPPRIOTX for transmitting
of the MP_PRIO suboption, and MPTCP_MIB_MPPRIORX for receiving of it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/mib.c        | 2 ++
 net/mptcp/mib.h        | 2 ++
 net/mptcp/options.c    | 1 +
 net/mptcp/pm_netlink.c | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b921cbdd9aaa..8ca196489893 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -31,6 +31,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
+	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
+	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 47bcecce1106..63914a5ef6a5 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -24,6 +24,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
+	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
+	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adfa96dd991c..c9643344a8d7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1034,6 +1034,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 =

 	if (mp_opt.mp_prio) {
 		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
 		mp_opt.mp_prio =3D 0;
 	}
 =

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8f80099f1657..9b1f6298bbdb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -452,6 +452,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		struct sock *sk =3D (struct sock *)msk;
 		struct mptcp_addr_info local;
 =

 		local_address((struct sock_common *)ssk, &local);
@@ -461,6 +462,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		subflow->backup =3D bkup;
 		subflow->send_mp_prio =3D 1;
 		subflow->request_bkup =3D bkup;
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 =

 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for mp_prio");
-- =

2.30.0

--===============1865168792121544402==--
