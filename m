Content-Type: multipart/mixed; boundary="===============0728152699951424251=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: add rm_list_tx
 in mptcp_pm_data"
Date: Thu, 18 Feb 2021 11:07:22 +0800
Message-ID: <a288a61577bc79178e8ebb8aad8cb24a5d5ee5ae.1613617491.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7836

--===============0728152699951424251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the length of RM_ADDR suboption in mptcp_pm_rm_addr_signal.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
 - clear msk->pm.addr_signal in the error case.
---
 net/mptcp/pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 32f203f186a2..f3db3adfe3fc 100644
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

@@ -268,7 +268,12 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 =

-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+	len =3D mptcp_rm_addr_len(msk->pm.rm_list_tx);
+	if (len < 0) {
+		WRITE_ONCE(msk->pm.addr_signal, 0);
+		goto out_unlock;
+	}
+	if (remaining < len)
 		goto out_unlock;
 =

 	*rm_list =3D msk->pm.rm_list_tx;
-- =

2.29.2

--===============0728152699951424251==--
