Content-Type: multipart/mixed; boundary="===============6009219385087770377=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/4] mptcp: move to next addr when
 timeout
Date: Mon, 22 Feb 2021 11:50:54 +0800
Message-ID: <5d018ffbdfeaf4162064732bcbcbd28b4107afe8.1613965565.git.geliangtang@gmail.com>
In-Reply-To: 75805ea33291f243d15785862ff2f41d9931a3bf.1613965565.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7878

--===============6009219385087770377==
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
index 9396f9635231..9ff94674b22b 100644
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

--===============6009219385087770377==--
