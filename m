Content-Type: multipart/mixed; boundary="===============0813052878242147194=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/3] mptcp: drop useless
 addr_signal clear
Date: Tue, 16 Mar 2021 13:27:09 +0800
Message-ID: <bd3fe0dc32c12fab55403f7ec122ebdd35fb0625.1615871979.git.geliangtang@gmail.com>
In-Reply-To: cover.1615871979.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8163

--===============0813052878242147194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

msk->pm.addr_signal is cleared in mptcp_pm_add_addr_signal, no need to
clear it in mptcp_pm_nl_add_addr_send_ack again. Drop it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f9606934104d..cd99f6b9df93 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -538,7 +538,6 @@ static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_=
sock *msk)
 	subflow =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), n=
ode);
 	if (subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		u8 add_addr;
 =

 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for add_addr%s%s",
@@ -549,13 +548,6 @@ static void mptcp_pm_nl_add_addr_send_ack(struct mptcp=
_sock *msk)
 		tcp_send_ack(ssk);
 		release_sock(ssk);
 		spin_lock_bh(&msk->pm.lock);
-
-		add_addr =3D READ_ONCE(msk->pm.addr_signal);
-		if (mptcp_pm_should_add_signal_ipv6(msk))
-			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
-		if (mptcp_pm_should_add_signal_port(msk))
-			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_PORT);
-		WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	}
 }
 =

-- =

2.30.2

--===============0813052878242147194==--
