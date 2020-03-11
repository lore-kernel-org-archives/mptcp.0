Content-Type: multipart/mixed; boundary="===============2726381967221460152=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 3/5] mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
Date: Wed, 11 Mar 2020 10:25:58 -0700
Message-ID: <20200311172600.4185-4-peter.krystad@linux.intel.com>
In-Reply-To: 20200311172600.4185-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3922

--===============2726381967221460152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Validate incoming ADD_ADDR options

squash-to: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 411ae3ad8c9e..d157e32fb001 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -592,6 +592,30 @@ static bool check_fourth_ack(struct mptcp_subflow_cont=
ext *subflow,
 	return true;
 }
 =

+static bool add_addr_hmac_valid(struct mptcp_subflow_context *subflow,
+				struct mptcp_options_received *mp_opt)
+{
+	u64 hmac;
+
+	if (mp_opt->echo)
+		return true;
+
+	if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
+		hmac =3D add_addr_generate_hmac(subflow->remote_key,
+					      subflow->local_key,
+					      mp_opt->addr_id, &mp_opt->addr);
+	else
+		hmac =3D add_addr6_generate_hmac(subflow->remote_key,
+					       subflow->local_key,
+					       mp_opt->addr_id, &mp_opt->addr6);
+
+	pr_debug("subflow=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
+		 subflow, (unsigned long long)hmac,
+		 (unsigned long long)mp_opt->ahmac);
+
+	return hmac =3D=3D mp_opt->ahmac;
+}
+
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
@@ -604,7 +628,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	if (!check_fourth_ack(subflow, skb, mp_opt))
 		return;
 =

-	if (msk && mp_opt->add_addr) {
+	if (msk && mp_opt->add_addr && add_addr_hmac_valid(subflow, mp_opt)) {
 		struct mptcp_addr_info addr;
 =

 		addr.port =3D 0;
@@ -619,7 +643,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 			addr.addr6 =3D mp_opt->addr6;
 		}
 #endif
-		mptcp_pm_add_addr_received(msk, &addr);
+		if (!mp_opt->echo)
+			mptcp_pm_add_addr_received(msk, &addr);
 		mp_opt->add_addr =3D 0;
 	}
 =

-- =

2.17.2

--===============2726381967221460152==--
