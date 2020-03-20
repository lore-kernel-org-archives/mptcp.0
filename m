Content-Type: multipart/mixed; boundary="===============4974340904975373146=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Parse optional port field of ADD_ADDR
Date: Fri, 20 Mar 2020 10:51:50 -0700
Message-ID: <20200320175151.4665-2-peter.krystad@linux.intel.com>
In-Reply-To: 20200320175151.4665-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4024

--===============4974340904975373146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since we allow the option lengths that include the port
field we should correctly parse the field if present.

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h |  1 +
 net/mptcp/options.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 41e5a0e3622f..1225db308957 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -109,6 +109,7 @@ struct mptcp_options_received {
 #endif
 	};
 	u64	ahmac;
+	u16	port;
 };
 #endif
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9b90bdc419ac..d9e0d82fd1b9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -205,16 +205,27 @@ void mptcp_parse_option(const struct sk_buff *skb, co=
nst unsigned char *ptr,
 		}
 =

 		mp_opt->add_addr =3D 1;
+		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
 		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
+			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT ||
+			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT) {
+				mp_opt->port =3D get_unaligned_be16(ptr);
+				ptr +=3D 2;
+			}
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else {
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
 			ptr +=3D 16;
+			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT ||
+			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT) {
+				mp_opt->port =3D get_unaligned_be16(ptr);
+				ptr +=3D 2;
+			}
 		}
 #endif
 		if (!mp_opt->echo) {
-- =

2.17.2

--===============4974340904975373146==--
