Content-Type: multipart/mixed; boundary="===============1470377699705125793=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 05/25] tcp: Make smc_parse_options return 1 on
 success
Date: Mon, 27 Nov 2017 21:57:06 -0800
Message-ID: <20171128055726.430-6-cpaasch@apple.com>
In-Reply-To: 20171128055726.430-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 179

--===============1470377699705125793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be needed to allow extra_options to parse experimental TCP options.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_input.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a97f54005452..843061955973 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3668,19 +3668,22 @@ static void tcp_parse_fastopen_option(int len, cons=
t unsigned char *cookie,
 	foc->exp =3D exp_opt;
 }
 =

-static void smc_parse_options(const struct tcphdr *th,
-			      struct tcp_options_received *opt_rx,
-			      const unsigned char *ptr,
-			      int opsize)
+static int smc_parse_options(const struct tcphdr *th,
+			     struct tcp_options_received *opt_rx,
+			     const unsigned char *ptr,
+			     int opsize)
 {
 #if IS_ENABLED(CONFIG_SMC)
 	if (static_branch_unlikely(&tcp_have_smc)) {
 		if (th->syn && !(opsize & 1) &&
 		    opsize >=3D TCPOLEN_EXP_SMC_BASE &&
-		    get_unaligned_be32(ptr) =3D=3D TCPOPT_SMC_MAGIC)
+		    get_unaligned_be32(ptr) =3D=3D TCPOPT_SMC_MAGIC) {
 			opt_rx->smc_ok =3D 1;
+			return 1;
+		}
 	}
 #endif
+	return 0;
 }
 =

 /* Look for tcp options. Normally only called on SYN and SYNACK packets.
@@ -3790,9 +3793,9 @@ void tcp_parse_options(const struct net *net,
 					tcp_parse_fastopen_option(opsize -
 						TCPOLEN_EXP_FASTOPEN_BASE,
 						ptr + 2, th->syn, foc, true);
-				else
-					smc_parse_options(th, opt_rx, ptr,
-							  opsize);
+				else if (smc_parse_options(th, opt_rx, ptr,
+							   opsize))
+					break;
 				break;
 =

 			}
-- =

2.15.0


--===============1470377699705125793==--
