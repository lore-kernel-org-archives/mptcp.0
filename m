Content-Type: multipart/mixed; boundary="===============8257241349567016414=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: add rm_list_tx in
 mptcp_pm_data"
Date: Mon, 15 Feb 2021 22:04:21 +0800
Message-ID: <8557847ae1d94d4b4cb4067407253011925c46f7.1613397714.git.geliangtang@gmail.com>
In-Reply-To: 63b2db13675a3030ae18229a63c5af926052b002.1613397693.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7805

--===============8257241349567016414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the length of RM_ADDR suboption in mptcp_pm_rm_addr_signal.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 32f203f186a2..8e97f90cbdec 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -260,7 +260,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     struct mptcp_rm_list *rm_list)
 {
-	int ret =3D false;
+	int ret =3D false, len;
 =

 	spin_lock_bh(&msk->pm.lock);
 =

@@ -268,7 +268,10 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 =

-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+	len =3D mptcp_rm_addr_len(msk->pm.rm_list_tx);
+	if (len < 0)
+		goto out_unlock;
+	if (remaining < len)
 		goto out_unlock;
 =

 	*rm_list =3D msk->pm.rm_list_tx;
-- =

2.29.2

--===============8257241349567016414==--
