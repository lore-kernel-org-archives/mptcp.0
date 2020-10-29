Content-Type: multipart/mixed; boundary="===============1264935236632744279=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 5/8] mptcp: add the incoming
 ADD_ADDR port support
Date: Thu, 29 Oct 2020 14:39:25 +0800
Message-ID: <b179cd8cddc1deb12561370d1fda19ad885b048d.1603952836.git.geliangtang@gmail.com>
In-Reply-To: 443a19151dd71160ce92b6ab3dbc6a62e4cdddd8.1603952836.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6468

--===============1264935236632744279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The port field in mptcp_options_received should be big-endian, since we
use the following assignment statement in mptcp_parse_option:

  mp_opt->port =3D get_unaligned_be16(ptr);

And the addr.port is also big-endian, so we need to drop htons in
mptcp_incoming_options.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 3 ++-
 net/mptcp/protocol.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f983deb534ae..87998edcce4e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -269,6 +269,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 			mp_opt->ahmac =3D get_unaligned_be64(ptr);
 			ptr +=3D 8;
 		}
+		pr_debug("port=3D%d, ahmac=3D%llu", ntohs(mp_opt->port), mp_opt->ahmac);
 		break;
 =

 	case MPTCPOPT_RM_ADDR:
@@ -936,7 +937,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb)
 	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
 		struct mptcp_addr_info addr;
 =

-		addr.port =3D htons(mp_opt.port);
+		addr.port =3D mp_opt.port;
 		addr.id =3D mp_opt.addr_id;
 		if (mp_opt.family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			addr.family =3D AF_INET;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f2cf09afd542..4c3350ed8d92 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -136,7 +136,7 @@ struct mptcp_options_received {
 #endif
 	};
 	u64	ahmac;
-	u16	port;
+	__be16	port;
 };
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
-- =

2.26.2

--===============1264935236632744279==--
