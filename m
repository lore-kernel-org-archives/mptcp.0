Content-Type: multipart/mixed; boundary="===============2135019672861864312=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/9] Fix parsing MP_JOIN third ACK.
Date: Wed, 17 Jul 2019 15:12:50 -0700
Message-ID: <20190717221256.7358-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190717221256.7358-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1514

--===============2135019672861864312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a reserved byte of zero's in there.

squashto: Add handling of incoming MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d0d47f84adb..b5a86f47f097 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -92,7 +92,7 @@ void mptcp_parse_option(const unsigned char *ptr, int ops=
ize,
 				 mp_opt->backup, mp_opt->join_id,
 				 mp_opt->thmac, mp_opt->nonce);
 		} else if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_ACK) {
-			ptr++;
+			ptr +=3D 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac");
 		} else {
-- =

2.17.2


--===============2135019672861864312==--
