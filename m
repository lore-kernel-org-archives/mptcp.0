Content-Type: multipart/mixed; boundary="===============8995538020851122641=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] options: fix __sum16 degrades to integer sparse
 warning
Date: Tue, 10 Sep 2019 01:17:23 +0200
Message-ID: <20190909231725.4952-3-fw@strlen.de>
In-Reply-To: 20190909231725.4952-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1809

--===============8995538020851122641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

options.c:714:42: warning: incorrect type in assignment (different base typ=
es)
options.c:714:42:    expected restricted __sum16 [assigned] [usertype] chec=
ksum
options.c:714:42:    got int
options.c:715:32: warning: restricted __sum16 degrades to integer
options.c:715:32: warning: restricted __sum16 degrades to integer

squashto: mptcp: Write MPTCP DSS headers to outgoing data packets

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b82557af3fae..1645006d59c4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -701,7 +701,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 		}
 =

 		if (mpext->use_map) {
-			__sum16 checksum;
+			__u16 checksum;
 =

 			pr_debug("Writing map values");
 			put_unaligned_be64(mpext->data_seq, ptr);
@@ -709,7 +709,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 			*ptr++ =3D htonl(mpext->subflow_seq);
 =

 			if (mpext->use_checksum)
-				checksum =3D mpext->checksum;
+				checksum =3D (u16 __force)mpext->checksum;
 			else
 				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
 			*ptr =3D htonl(mpext->data_len << 16 | checksum);
-- =

2.21.0


--===============8995538020851122641==--
