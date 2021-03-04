Content-Type: multipart/mixed; boundary="===============0853910710741950505=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 6/6] Squash to "mptcp: remove multi
 addresses and subflows in PM"
Date: Thu, 04 Mar 2021 14:42:48 +0800
Message-ID: <20210304064248.9636-7-geliangtang@gmail.com>
In-Reply-To: 20210304064248.9636-1-geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8015

--===============0853910710741950505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of argument rm_list from "struct mptcp_rm_list
rm_list" to "const struct mptcp_rm_list *rm_list".

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1840d9dd6c52..e0a88f808707 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1243,11 +1243,11 @@ static void mptcp_pm_remove_addrs_and_subflows(stru=
ct mptcp_sock *msk,
 =

 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, alist);
+		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
 	if (slist.nr)
-		mptcp_pm_remove_subflow(msk, slist);
+		mptcp_pm_remove_subflow(msk, &slist);
 }
 =

 static void mptcp_nl_remove_addrs_list(struct net *net,
-- =

2.29.2

--===============0853910710741950505==--
