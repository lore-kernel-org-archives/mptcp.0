Content-Type: multipart/mixed; boundary="===============4441040759057951240=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 4/6] Squash to "mptcp: add
 rm_list_rx in mptcp_pm_data"
Date: Thu, 04 Mar 2021 14:42:46 +0800
Message-ID: <20210304064248.9636-5-geliangtang@gmail.com>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8013

--===============4441040759057951240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b11e3ec85a0f..316226da56c2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -217,7 +217,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 =

 	spin_lock_bh(&pm->lock);
 	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_list_rx =3D rm_list;
+	pm->rm_list_rx =3D *rm_list;
 	spin_unlock_bh(&pm->lock);
 }
 =

-- =

2.29.2

--===============4441040759057951240==--
