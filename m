Content-Type: multipart/mixed; boundary="===============3831915934176128827=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 2/2] mptcp: move
 mptcp_options_received's port initialization
Date: Mon, 19 Oct 2020 18:23:16 +0800
Message-ID: <0371a529baaaa4796406e4335afb91ef210fa813.1603102503.git.geliangtang@gmail.com>
In-Reply-To: 3ae4089622f9933c18f474e6ee954f39a40bfec3.1603102503.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6348

--===============3831915934176128827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moved mptcp_options_received's port initialization from
mptcp_parse_option to mptcp_get_options, put it together with the other
fields initializations of mptcp_options_received.

Fixes: 3df523ab582c5 ("mptcp: Add ADD_ADDR handling")
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ff3469938b6..a044dd43411d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -241,7 +241,6 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		}
 =

 		mp_opt->add_addr =3D 1;
-		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
 		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
@@ -298,6 +297,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_join =3D 0;
 	mp_opt->add_addr =3D 0;
 	mp_opt->ahmac =3D 0;
+	mp_opt->port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
 =

-- =

2.26.2

--===============3831915934176128827==--
