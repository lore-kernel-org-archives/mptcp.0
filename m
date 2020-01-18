Content-Type: multipart/mixed; boundary="===============0238994136512399928=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Remove protocol spec comments from
 mptcp_parse_option
Date: Fri, 17 Jan 2020 16:21:25 -0800
Message-ID: <20200118002125.9042-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3414

--===============0238994136512399928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

They are already out-of-date. Let them read the spec, or least
look at the pictures!

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 60 ---------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 81d8704cbd3f..51290ec970bd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -24,12 +24,6 @@ void mptcp_parse_option(const struct sk_buff *skb, const=
 unsigned char *ptr,
 	u8 flags;
 =

 	switch (subtype) {
-	/* MPTCPOPT_MP_CAPABLE
-	 * 0: 4MSB=3Dsubtype, 4LSB=3Dversion
-	 * 1: Handshake flags
-	 * 2-9: Sender key
-	 * 10-17: Receiver key (optional)
-	 */
 	case MPTCPOPT_MP_CAPABLE:
 		/* strict size checking */
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
@@ -102,22 +96,6 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
 			 mp_opt->rcvr_key, mp_opt->data_len);
 		break;
 =

-	/* MPTCPOPT_MP_JOIN
-	 * Initial SYN
-	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
-	 * 1: Address ID
-	 * 2-5: Receiver token
-	 * 6-9: Sender random number
-	 * SYN/ACK response
-	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
-	 * 1: Address ID
-	 * 2-9: Sender truncated HMAC
-	 * 10-13: Sender random number
-	 * Third ACK
-	 * 0: 4MSB=3Dsubtype, 0000
-	 * 1: 0 (Reserved)
-	 * 2-21: Sender HMAC
-	 */
 	case MPTCPOPT_MP_JOIN:
 		mp_opt->mp_join =3D 1;
 		if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYN) {
@@ -150,17 +128,6 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 		}
 		break;
 =

-
-	/* MPTCPOPT_DSS
-	 * 0: 4MSB=3Dsubtype, 0000
-	 * 1: 3MSB=3D0, F=3DData FIN, m=3DDSN length, M=3Dhas DSN/SSN/DLL/checksu=
m,
-	 *    a=3DDACK length, A=3Dhas DACK
-	 * 0, 4, or 8 bytes of DACK (depending on A/a)
-	 * 0, 4, or 8 bytes of DSN (depending on M/m)
-	 * 0 or 4 bytes of SSN (depending on M)
-	 * 0 or 2 bytes of DLL (depending on M)
-	 * 0 or 2 bytes of checksum (depending on M)
-	 */
 	case MPTCPOPT_DSS:
 		pr_debug("DSS");
 		ptr++;
@@ -243,12 +210,6 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 =

 		break;
 =

-	/* MPTCPOPT_ADD_ADDR
-	 * 0: 4MSB=3Dsubtype, 4LSB=3DIP version (4 or 6)
-	 * 1: Address ID
-	 * 4 or 16 bytes of address (depending on ip version)
-	 * 0 or 2 bytes of port (depending on length)
-	 */
 	case MPTCPOPT_ADD_ADDR:
 		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
@@ -282,11 +243,6 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 #endif
 		break;
 =

-	/* MPTCPOPT_RM_ADDR
-	 * 0: 4MSB=3Dsubtype, 0000
-	 * 1: Address ID
-	 * Additional bytes: More address IDs (depending on length)
-	 */
 	case MPTCPOPT_RM_ADDR:
 		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR)
 			break;
@@ -296,22 +252,6 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->addr_id);
 		break;
 =

-	/* MPTCPOPT_MP_PRIO
-	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
-	 * 1: Address ID (optional, current addr implied if not present)
-	 */
-
-	/* MPTCPOPT_MP_FAIL
-	 * 0: 4MSB=3Dsubtype, 0000
-	 * 1: 0 (Reserved)
-	 * 2-9: DSN
-	 */
-
-	/* MPTCPOPT_MP_FASTCLOSE
-	 * 0: 4MSB=3Dsubtype, 0000
-	 * 1: 0 (Reserved)
-	 * 2-9: Receiver key
-	 */
 	default:
 		break;
 	}
-- =

2.17.2

--===============0238994136512399928==--
