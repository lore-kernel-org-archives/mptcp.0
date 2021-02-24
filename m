Content-Type: multipart/mixed; boundary="===============8319671343206334461=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 3/5] mptcp: move to next addr
 when timeout
Date: Wed, 24 Feb 2021 11:56:56 +0800
Message-ID: <6492f78910e7ef643281ab3ffcdcf06a2c7a5ca2.1614138509.git.geliangtang@gmail.com>
In-Reply-To: f9f1b135e3d23ea0432e219446efdf0e8b062b5f.1614138509.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7930

--===============8319671343206334461==
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
index 659757439e11..e1d11c659a7c 100644
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

--===============8319671343206334461==--
