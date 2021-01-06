Content-Type: multipart/mixed; boundary="===============7043049640660820354=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/5] mptcp: simplify
 mptcp_pm_nl_add_addr_send_ack debug log
Date: Wed, 06 Jan 2021 18:22:43 +0800
Message-ID: <5a87151c09e1e20509cc87a7fb1edcad8879b5f5.1609925558.git.geliangtang@gmail.com>
In-Reply-To: b25cd1f786a479bcf6088f60c5b42e33130faed6.1609925558.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7279

--===============7043049640660820354==
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
index 9a8a5d9c1633..06c9ec12c538 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -501,13 +501,15 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
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

--===============7043049640660820354==--
