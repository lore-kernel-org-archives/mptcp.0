Content-Type: multipart/mixed; boundary="===============4403625075891833198=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/4] mptcp: move to next addr
 when timeout
Date: Tue, 23 Feb 2021 12:29:56 +0800
Message-ID: <437320b247f2edc61b956f7251d903156e87c854.1614053997.git.geliangtang@gmail.com>
In-Reply-To: 67cd1eb6fbb530597c4a0cbdd2b8745da0f902a8.1614053997.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7909

--===============4403625075891833198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch called mptcp_pm_subflow_established to move to the next address
when an ADD_ADDR has been retransmitted the maximum number of times.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4412a339e305..492cb0338e8d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -337,6 +337,9 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 =

 	spin_unlock_bh(&msk->pm.lock);
 =

+	if (entry->retrans_times =3D=3D ADD_ADDR_RETRANS_MAX)
+		mptcp_pm_subflow_established(msk);
+
 out:
 	__sock_put(sk);
 }
-- =

2.29.2

--===============4403625075891833198==--
