Content-Type: multipart/mixed; boundary="===============5148954498246377472=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 09:00:20 +0100
Message-ID: <accf702d273435ffe3b4d2192d5d0491fbbac5a0.1573552917.git.pabeni@redhat.com>
In-Reply-To: cover.1573552877.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2500

--===============5148954498246377472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

since such options will always fit the tcp header, modulo bugs

Squash-to: "mptcp: Write MPTCP DSS headers to outgoing data packets"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - fix typo in commit message
---
 net/mptcp/options.c | 71 ++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fa10086b5b74..cd16baea0666 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -200,7 +200,7 @@ static bool mptcp_established_options_mp(struct sock *s=
k, unsigned int *size,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 =

-	if (!subflow->fourth_ack && remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
+	if (!subflow->fourth_ack) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
@@ -220,6 +220,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 {
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
+	struct mptcp_sock *msk;
 	unsigned int ack_size;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
@@ -229,15 +230,10 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
 =

-		if (map_size <=3D remaining) {
-			remaining -=3D map_size;
-			dss_size =3D map_size;
-			if (mpext)
-				opts->ext_copy =3D *mpext;
-		} else {
-			opts->ext_copy.use_map =3D 0;
-			WARN_ONCE(1, "MPTCP: Map dropped");
-		}
+		remaining -=3D map_size;
+		dss_size =3D map_size;
+		if (mpext)
+			opts->ext_copy =3D *mpext;
 	}
 =

 	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
@@ -246,29 +242,19 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 	if (dss_size =3D=3D 0)
 		ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
 =

-	if (ack_size <=3D remaining) {
-		struct mptcp_sock *msk;
-
-		dss_size +=3D ack_size;
-
-		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
-		if (msk) {
-			opts->ext_copy.data_ack =3D msk->ack_seq;
-		} else {
-			mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
-					      NULL, &opts->ext_copy.data_ack);
-			opts->ext_copy.data_ack++;
-		}
+	dss_size +=3D ack_size;
 =

-		opts->ext_copy.ack64 =3D 1;
-		opts->ext_copy.use_ack =3D 1;
+	msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+	if (msk) {
+		opts->ext_copy.data_ack =3D msk->ack_seq;
 	} else {
-		opts->ext_copy.use_ack =3D 0;
-		WARN(1, "MPTCP: Ack dropped");
+		mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
+				      NULL, &opts->ext_copy.data_ack);
+		opts->ext_copy.data_ack++;
 	}
 =

-	if (!dss_size)
-		return false;
+	opts->ext_copy.ack64 =3D 1;
+	opts->ext_copy.use_ack =3D 1;
 =

 	*size =3D ALIGN(dss_size, 4);
 	return true;
@@ -279,22 +265,27 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 			       struct mptcp_out_options *opts)
 {
 	unsigned int opt_size =3D 0;
+	bool ret =3D true;
 =

 	if (!mptcp_subflow_ctx(sk)->mp_capable)
 		return false;
 =

-	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
-		*size +=3D opt_size;
-		remaining -=3D opt_size;
-		return true;
-	} else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
-						 opts)) {
-		*size +=3D opt_size;
-		remaining -=3D opt_size;
-		return true;
-	}
+	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
+		ret =3D true;
+	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
+						 opts))
+		ret =3D true;
 =

-	return false;
+	/* we reserved enough space for the above options, and exceeding the
+	 * TCP option space would be fatal
+	 */
+	if (WARN_ON_ONCE(opt_size > remaining))
+		return false;
+
+	*size +=3D opt_size;
+	remaining -=3D opt_size;
+
+	return ret;
 }
 =

 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
-- =

2.21.0

--===============5148954498246377472==--
