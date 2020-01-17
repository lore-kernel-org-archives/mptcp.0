Content-Type: multipart/mixed; boundary="===============5515265814562243639=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Deal with family field being removed from
 mptcp_options_received
Date: Thu, 16 Jan 2020 23:01:23 -0800
Message-ID: <20200117070123.5937-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3390

--===============5515265814562243639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use individual add_addr flags instead.

squashto: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3f15cd1620d3..b03e97eefbf4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -621,15 +621,18 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 	if (!check_fourth_ack(subflow, skb, mp_opt))
 		return;
 =

-	if (msk && mp_opt->add_addr) {
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
+	if (msk) {
+		if (mp_opt->add_addr) {
 			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
+			mp_opt->add_addr =3D 0;
+		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
+		else if (mp_opt->add_addr6) {
 			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
-					   mp_opt->addr_id);
+					   mp_opt->addr6_id);
+			mp_opt->add_addr6 =3D 0;
+		}
 #endif
-		mp_opt->add_addr =3D 0;
 	}
 =

 	if (!mp_opt->dss)
-- =

2.17.2

--===============5515265814562243639==--
