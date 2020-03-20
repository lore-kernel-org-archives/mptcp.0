Content-Type: multipart/mixed; boundary="===============3896701217250480603=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Include ADD_ADDR port value for path
 manager
Date: Fri, 20 Mar 2020 10:51:51 -0700
Message-ID: <20200320175151.4665-3-peter.krystad@linux.intel.com>
In-Reply-To: 20200320175151.4665-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4025

--===============3896701217250480603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Include the port value in the addr info passed to
mptcp_pm_add_addr_received().

squashto: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d951f7d325a3..e8cb7d836cb7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -652,7 +652,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	if (mp_opt->add_addr && add_addr_hmac_valid(msk, mp_opt)) {
 		struct mptcp_addr_info addr;
 =

-		addr.port =3D 0;
+		addr.port =3D htons(mp_opt->port);
 		addr.id =3D mp_opt->addr_id;
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			addr.family =3D AF_INET;
-- =

2.17.2

--===============3896701217250480603==--
