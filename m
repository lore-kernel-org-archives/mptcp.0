Content-Type: multipart/mixed; boundary="===============0830822173440182131=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: add rm_list in
 mptcp_out_options"
Date: Mon, 15 Feb 2021 22:04:20 +0800
Message-ID: <63b2db13675a3030ae18229a63c5af926052b002.1613397693.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7804

--===============0830822173440182131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixed the following smatch warnings:
net/mptcp/options.c:687 mptcp_established_options_rm_addr() error: uninitia=
lized symbol 'align'.

Reported-by: kernel test robot <lkp(a)intel.com>
Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 14 ++++++--------
 net/mptcp/protocol.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e41410475f0e..73c712a5c6e6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -673,21 +673,19 @@ static bool mptcp_established_options_rm_addr(struct =
sock *sk,
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_rm_list rm_list;
-	u8 i, align;
+	int i, len;
 =

 	if (!mptcp_pm_should_rm_signal(msk) ||
 	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
 		return false;
 =

-	if (rm_list.nr > 1)
-		align =3D 5;
-	if (rm_list.nr > 5)
-		align =3D 9;
-
-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE + align)
+	len =3D mptcp_rm_addr_len(rm_list);
+	if (len < 0)
+		return false;
+	if (remaining < len)
 		return false;
 =

-	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE + align;
+	*size =3D len;
 	opts->suboptions |=3D OPTION_MPTCP_RM_ADDR;
 	opts->rm_list =3D rm_list;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd6bc475f848..c26875a1f192 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -708,6 +708,21 @@ static inline unsigned int mptcp_add_addr_len(int fami=
ly, bool echo, bool port)
 	return len;
 }
 =

+static inline int mptcp_rm_addr_len(struct mptcp_rm_list rm_list)
+{
+	u8 align =3D 1;
+
+	if (rm_list.nr <=3D 0 || rm_list.nr >=3D MPTCP_RM_IDS_MAX)
+		return -EINVAL;
+
+	if (rm_list.nr > 1)
+		align =3D 5;
+	if (rm_list.nr > 5)
+		align =3D 9;
+
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + align;
+}
+
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
-- =

2.29.2

--===============0830822173440182131==--
