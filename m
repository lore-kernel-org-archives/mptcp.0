Content-Type: multipart/mixed; boundary="===============4607470561430972688=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: add rm_list in
 mptcp_out_options" - fix RM_ADDR option writing
Date: Sun, 07 Mar 2021 00:40:30 +0800
Message-ID: <52fb04d94e8afc909702fc670442491d69cf0788.1615048750.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8062

--===============4607470561430972688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The original RM_ADDR option writing can only deal with 8 addresses, this
patch fixed it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

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

-- =

2.29.2

--===============4607470561430972688==--
