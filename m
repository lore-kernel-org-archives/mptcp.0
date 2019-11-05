Content-Type: multipart/mixed; boundary="===============5765671135176150654=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/5] mptcp: Switch to CONFIG_MPTCP_IPV6
Date: Tue, 05 Nov 2019 11:05:56 -0800
Message-ID: <20191105190557.6405-4-peter.krystad@linux.intel.com>
In-Reply-To: 20191105190557.6405-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2404

--===============5765671135176150654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h | 2 +-
 net/mptcp/options.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index eba39a881767..1196a5588ce1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -35,7 +35,7 @@ struct mptcp_out_options {
 	u64 rcvr_key;
 	union {
 		struct in_addr addr;
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		struct in6_addr addr6;
 #endif
 	};
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5b6df7aead1d..e050a3966280 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -223,7 +223,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
 			break;
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
 			break;
@@ -235,7 +235,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
 				 mp_opt->addr.s_addr, mp_opt->addr_id);
 		}
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else {
 			mp_opt->add_addr =3D 1;
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
@@ -472,7 +472,7 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
 		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
 	}
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (saddr.ss_family =3D=3D AF_INET6) {
 		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
 			return false;
@@ -668,7 +668,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 		ptr +=3D 1;
 	}
 =

-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
 				      TCPOLEN_MPTCP_ADD_ADDR6,
-- =

2.17.2

--===============5765671135176150654==--
