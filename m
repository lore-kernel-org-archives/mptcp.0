Content-Type: multipart/mixed; boundary="===============8086673556861460602=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 01/10] mptcp: unify ADD_ADDR and
 echo suboptions writing
Date: Sat, 31 Oct 2020 23:24:32 +0800
Message-ID: <d6a11bb2d1498158ce76822247ffaf34037d04d6.1604156723.git.geliangtang@gmail.com>
In-Reply-To: cover.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6503

--===============8086673556861460602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are two differences between ADD_ADDR suboption and ADD_ADDR echo
suboption: The length of the former is 8 octets longer than the length
of the latter. The former's echo-flag is 0, and latter's echo-flag is 1.

This patch added two local variables, len and echo, to unify ADD_ADDR
and ADD_ADDR echo suboptions writing.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 248e3930c0cb..0fe3f224b00a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1067,15 +1067,16 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 =

 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		if (opts->ahmac)
-			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR, 0,
-					      opts->addr_id);
-		else
-			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR_BASE,
-					      MPTCP_ADDR_ECHO,
-					      opts->addr_id);
+		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
+		u8 echo =3D MPTCP_ADDR_ECHO;
+
+		if (opts->ahmac) {
+			len +=3D sizeof(opts->ahmac);
+			echo =3D 0;
+		}
+
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+				      len, echo, opts->addr_id);
 		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
 		ptr +=3D 1;
 		if (opts->ahmac) {
@@ -1086,15 +1087,15 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
-		if (opts->ahmac)
-			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR6, 0,
-					      opts->addr_id);
-		else
-			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-					      TCPOLEN_MPTCP_ADD_ADDR6_BASE,
-					      MPTCP_ADDR_ECHO,
-					      opts->addr_id);
+		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+		u8 echo =3D MPTCP_ADDR_ECHO;
+
+		if (opts->ahmac) {
+			len +=3D sizeof(opts->ahmac);
+			echo =3D 0;
+		}
+		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+				      len, echo, opts->addr_id);
 		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
 		ptr +=3D 4;
 		if (opts->ahmac) {
-- =

2.26.2

--===============8086673556861460602==--
