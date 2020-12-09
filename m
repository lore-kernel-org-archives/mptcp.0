Content-Type: multipart/mixed; boundary="===============6076565878073820024=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 08/11] mptcp: print out port and ahmac when
 receiving ADD_ADDR
Date: Wed, 09 Dec 2020 15:51:25 -0800
Message-ID: <20201209235128.175473-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7116

--===============6076565878073820024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch printed out more debugging information for the ADD_ADDR
suboption parsing on the incoming path.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6a290c622ccf..1ca60d9da3ef 100644
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

2.29.2

--===============6076565878073820024==--
