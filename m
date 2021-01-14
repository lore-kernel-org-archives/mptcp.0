Content-Type: multipart/mixed; boundary="===============3612150232305955405=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/5] mptcp: simplify
 mptcp_pm_nl_add_addr_send_ack debug log
Date: Thu, 14 Jan 2021 13:40:20 +0800
Message-ID: <7e16f6bc56bb1f0fb9f6253ee67f1f74832f1cce.1610602400.git.geliangtang@gmail.com>
In-Reply-To: 05676dcdd1fe45f8776a5a605930c87a264edff7.1610602400.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7370

--===============3612150232305955405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Print out the debug log of mptcp_pm_nl_add_addr_send_ack in a single line
when more than one mptcp_addr_signal_status are set.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed4231efa822..8f4bd2457a97 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -500,13 +500,15 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
 	subflow =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), n=
ode);
 	if (subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		char buf[32] =3D { 0 };
 		u8 add_addr;
 =

 		spin_unlock_bh(&msk->pm.lock);
 		if (mptcp_pm_should_add_signal_ipv6(msk))
-			pr_debug("send ack for add_addr6");
+			strcat(buf, "[ipv6]");
 		if (mptcp_pm_should_add_signal_port(msk))
-			pr_debug("send ack for add_addr_port");
+			strcat(buf, "[port]");
+		pr_debug("send ack for add_addr %s", buf);
 =

 		lock_sock(ssk);
 		tcp_send_ack(ssk);
-- =

2.29.2

--===============3612150232305955405==--
