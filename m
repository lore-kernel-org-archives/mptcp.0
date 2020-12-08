Content-Type: multipart/mixed; boundary="===============5840336810071170870=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 5/6] mptcp: add the mibs for
 MP_PRIO
Date: Tue, 08 Dec 2020 14:01:22 +0800
Message-ID: <14db6505e4a3f2f2121e9454f94b38218b54bb5e.1607406914.git.geliangtang@gmail.com>
In-Reply-To: 8e666503e0f3092b3acd3794cd8d57ff726d9b18.1607406914.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7072

--===============5840336810071170870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the mibs for MP_PRIO, MPTCP_MIB_MPPRIOTX for transmitting
of the MP_PRIO suboption, and MPTCP_MIB_MPPRIORX for receiving of it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c        | 2 ++
 net/mptcp/mib.h        | 2 ++
 net/mptcp/options.c    | 1 +
 net/mptcp/pm_netlink.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 84d119436b22..dd399b978fb0 100644
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
index a054a9c36842..4da76c68a21e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1029,6 +1029,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 =

 	if (mp_opt.mp_prio) {
 		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
 		mp_opt.mp_prio =3D 0;
 	}
 =

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 761cb5afa922..31d3a1cc0483 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -462,6 +462,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		subflow->backup =3D bkup;
 		subflow->send_mp_prio =3D 1;
 		subflow->request_bkup =3D bkup;
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
 =

 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for mp_prio");
-- =

2.26.2

--===============5840336810071170870==--
