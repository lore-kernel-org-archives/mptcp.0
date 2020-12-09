Content-Type: multipart/mixed; boundary="===============2570816900441470895=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 01/11] mptcp: unify ADD_ADDR and echo
 suboptions writing
Date: Wed, 09 Dec 2020 15:51:18 -0800
Message-ID: <20201209235128.175473-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7106

--===============2570816900441470895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

There are two differences between ADD_ADDR suboption and ADD_ADDR echo
suboption: The length of the former is 8 octets longer than the length
of the latter. The former's echo-flag is 0, and latter's echo-flag is 1.

This patch added two local variables, len and echo, to unify ADD_ADDR
and ADD_ADDR echo suboptions writing.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b63f26bf348f..a061b2106cfe 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1076,15 +1076,16 @@ void mptcp_write_options(__be32 *ptr, const struct =
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
@@ -1095,15 +1096,15 @@ void mptcp_write_options(__be32 *ptr, const struct =
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

2.29.2

--===============2570816900441470895==--
