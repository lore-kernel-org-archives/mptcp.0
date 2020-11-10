Content-Type: multipart/mixed; boundary="===============6510097928037076799=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 08/13] mptcp: print out port and
 ahmac when receiving ADD_ADDR
Date: Tue, 10 Nov 2020 13:14:56 +0800
Message-ID: <a86b6f8b46a1145685cfd4d44f429c2ea49e6e18.1604984546.git.geliangtang@gmail.com>
In-Reply-To: 0829d881cc9e35ddeec5e24e000fb83014d5d776.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6635

--===============6510097928037076799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch printed out more debugging information for the ADD_ADDR
suboption parsing on the incoming path.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ff40e64c43db..ab0cf027d1bd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -242,9 +242,6 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 =

 		mp_opt->add_addr =3D 1;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d",
-			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
-			 mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -269,6 +266,9 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 			mp_opt->ahmac =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
 		}
+		pr_debug("ADD_ADDR%s: id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
+			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 mp_opt->addr_id, mp_opt->ahmac, mp_opt->echo, mp_opt->port);
 		break;
 =

 	case MPTCPOPT_RM_ADDR:
-- =

2.26.2

--===============6510097928037076799==--
