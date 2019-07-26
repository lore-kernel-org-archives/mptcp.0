Content-Type: multipart/mixed; boundary="===============4315224847416634816=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 03/10] Fix parsing MP_JOIN third ACK.
Date: Thu, 25 Jul 2019 18:58:20 -0700
Message-ID: <20190726015827.10637-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190726015827.10637-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1559

--===============4315224847416634816==
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
index 62a46b75ba62..cafc51dcbfb2 100644
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


--===============4315224847416634816==--
