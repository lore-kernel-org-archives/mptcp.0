Content-Type: multipart/mixed; boundary="===============1899090463043608429=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: add rm_list in
 mptcp_out_options" - fix RM_ADDR option writing
Date: Sun, 07 Mar 2021 09:00:46 +0800
Message-ID: <a9a200291d259443af34bfdb3a1da76a4413d4d2.1615078654.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8063

--===============1899090463043608429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The original RM_ADDR option writing can only deal with 8 addresses, this
patch fixed it.

This patch fixed a bug in mptcp_rm_addr_len too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
 - add the bugfix for mptcp_rm_addr_len.
---
 net/mptcp/options.c  | 23 +++++++++++------------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 595b4b4279f7..46b5b276160e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1222,22 +1222,21 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 	}
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
-		u8 i;
+		u8 i =3D 0;
 =

-		for (i =3D opts->rm_list.nr; i < MPTCP_RM_IDS_MAX; i++)
-			opts->rm_list.ids[i] =3D TCPOPT_NOP;
 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
 				      TCPOLEN_MPTCP_RM_ADDR_BASE + opts->rm_list.nr,
-				      0, opts->rm_list.ids[0]);
-		if (opts->rm_list.nr > 1) {
-			put_unaligned_be32(opts->rm_list.ids[1] << 24 | opts->rm_list.ids[2] <<=
 16 |
-					   opts->rm_list.ids[3] << 8 | opts->rm_list.ids[4], ptr);
-			ptr +=3D 1;
-		}
-		if (opts->rm_list.nr > 5) {
-			put_unaligned_be32(opts->rm_list.ids[5] << 24 | opts->rm_list.ids[6] <<=
 16 |
-					   opts->rm_list.ids[7] << 8 | TCPOPT_NOP, ptr);
+				      0, opts->rm_list.ids[i++]);
+		while (i < opts->rm_list.nr) {
+			u8 id1, id2, id3, id4;
+
+			id1 =3D opts->rm_list.ids[i];
+			id2 =3D i + 1 < opts->rm_list.nr ? opts->rm_list.ids[i + 1] : TCPOPT_NO=
P;
+			id3 =3D i + 2 < opts->rm_list.nr ? opts->rm_list.ids[i + 2] : TCPOPT_NO=
P;
+			id4 =3D i + 3 < opts->rm_list.nr ? opts->rm_list.ids[i + 3] : TCPOPT_NO=
P;
+			put_unaligned_be32(id1 << 24 | id2 << 16 | id3 << 8 | id4, ptr);
 			ptr +=3D 1;
+			i +=3D 4;
 		}
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 61022ffbc85f..96704928d639 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -709,7 +709,7 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y, bool echo, bool port)
 =

 static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 {
-	if (rm_list->nr =3D=3D 0 || rm_list->nr >=3D MPTCP_RM_IDS_MAX)
+	if (rm_list->nr =3D=3D 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
 		return -EINVAL;
 =

 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
-- =

2.29.2

--===============1899090463043608429==--
