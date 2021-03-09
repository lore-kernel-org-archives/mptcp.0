Content-Type: multipart/mixed; boundary="===============3951760016746627579=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: add rm_list in
 mptcp_out_options" - bugfix
Date: Tue, 09 Mar 2021 11:30:07 +0800
Message-ID: <1013371d28c0219e3bdd904539094a90d7d3ffae.1615260023.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8080

--===============3951760016746627579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The original RM_ADDR option writing can only deal with 8 addresses, this
patch fixed it.

It also fixed a bug in mptcp_rm_addr_len too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
v3:
 - set 'i =3D 1'.
v2:
 - add the bugfix for mptcp_rm_addr_len.
---
 net/mptcp/options.c  | 22 +++++++++++-----------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 595b4b4279f7..c99d8172a50e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1222,22 +1222,22 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 	}
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
-		u8 i;
+		u8 i =3D 1;
 =

-		for (i =3D opts->rm_list.nr; i < MPTCP_RM_IDS_MAX; i++)
-			opts->rm_list.ids[i] =3D TCPOPT_NOP;
 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
 				      TCPOLEN_MPTCP_RM_ADDR_BASE + opts->rm_list.nr,
 				      0, opts->rm_list.ids[0]);
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
+
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
index 4566f6d41d21..133e2e09f55a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -711,7 +711,7 @@ static inline unsigned int mptcp_add_addr_len(int famil=
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

--===============3951760016746627579==--
