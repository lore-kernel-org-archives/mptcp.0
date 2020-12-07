Content-Type: multipart/mixed; boundary="===============3825277514972716782=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: parse and act on
 incoming FASTCLOSE option": a small cleanup
Date: Mon, 07 Dec 2020 16:25:11 +0800
Message-ID: <6445f54afb5b2ac4a7acd32a6a5e6900778af7b5.1607329397.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7064

--===============3825277514972716782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just a small cleanup.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cdb7f7f265a8..a7262c807f63 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -281,6 +281,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->rm_id =3D *ptr++;
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
+
 	case MPTCPOPT_MP_FASTCLOSE:
 		if (opsize !=3D TCPOLEN_MPTCP_FASTCLOSE)
 			break;
@@ -290,6 +291,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		ptr +=3D 8;
 		mp_opt->fastclose =3D 1;
 		break;
+
 	default:
 		break;
 	}
-- =

2.26.2

--===============3825277514972716782==--
