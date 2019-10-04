Content-Type: multipart/mixed; boundary="===============1993827902235846904=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] options: copy entire extension area to option
 struct
Date: Fri, 04 Oct 2019 13:21:24 +0200
Message-ID: <20191004112124.20726-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2014

--===============1993827902235846904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No reason to copy each member individually, just copy everything.
This means we will also copy ext->data_fin which was not done before.

squashto: "mptcp: Write MPTCP DSS headers to outgoing data packets"

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a33c202db009..d00e86550d8b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -402,13 +402,8 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 		if (map_size <=3D remaining) {
 			remaining -=3D map_size;
 			dss_size =3D map_size;
-			if (mpext) {
-				opts->ext_copy.data_seq =3D mpext->data_seq;
-				opts->ext_copy.subflow_seq =3D mpext->subflow_seq;
-				opts->ext_copy.data_len =3D mpext->data_len;
-				opts->ext_copy.use_map =3D 1;
-				opts->ext_copy.dsn64 =3D mpext->dsn64;
-			}
+			if (mpext)
+				opts->ext_copy =3D *mpext;
 		} else {
 			opts->ext_copy.use_map =3D 0;
 			WARN_ONCE(1, "MPTCP: Map dropped");
-- =

2.21.0

--===============1993827902235846904==--
