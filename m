Content-Type: multipart/mixed; boundary="===============7432403036030657931=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Change options handling so in_addr are in
 network byte order
Date: Fri, 23 Aug 2019 18:56:32 -0700
Message-ID: <20190824015633.3070-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1695

--===============7432403036030657931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0e7abcea5bae..63ae21e573ef 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -209,7 +209,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 		mp_opt->addr_id =3D *ptr++;
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			mp_opt->add_addr =3D 1;
-			mp_opt->addr.s_addr =3D get_unaligned_be32(ptr);
+			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
 				 mp_opt->addr.s_addr, mp_opt->addr_id);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -593,7 +593,8 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_ADD_ADDR,
 				      MPTCP_ADDR_IPVERSION_4, opts->addr_id);
-		*ptr++ =3D htonl(opts->addr.s_addr);
+		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
+		ptr +=3D 1;
 	}
 =

 #if IS_ENABLED(CONFIG_IPV6)
-- =

2.17.2


--===============7432403036030657931==--
