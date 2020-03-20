Content-Type: multipart/mixed; boundary="===============9003575843217651725=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 2/4] Squash-to: "mptcp: Add path manager interface"
Date: Fri, 20 Mar 2020 01:59:47 +0100
Message-ID: <0ac753915c4ab6b460306e46e1efa59037c04cf5.1584665521.git.pabeni@redhat.com>
In-Reply-To: cover.1584665520.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4009

--===============9003575843217651725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to move mptcp_pm_new_connection() at msk
creation time, or later subflows may access an
unintialized 'server_side' field.

That would lead to missing fourth ack

Additionally drop unneeded cast in the nearby code.

add_addr_hmac_valid() must use msk's keys: MPJ subflows
can have uninitializated values there. Instead of copying
keys on every subflow, just use msk's values.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 16 ++++++++--------
 net/mptcp/protocol.c |  2 --
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 49f78c625993..45760c2d94fa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -600,7 +600,7 @@ static bool check_fully_established(struct mptcp_subflo=
w_context *subflow,
 	return true;
 }
 =

-static bool add_addr_hmac_valid(struct mptcp_subflow_context *subflow,
+static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 				struct mptcp_options_received *mp_opt)
 {
 	u64 hmac =3D 0;
@@ -609,18 +609,18 @@ static bool add_addr_hmac_valid(struct mptcp_subflow_=
context *subflow,
 		return true;
 =

 	if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
-		hmac =3D add_addr_generate_hmac(subflow->remote_key,
-					      subflow->local_key,
+		hmac =3D add_addr_generate_hmac(msk->remote_key,
+					      msk->local_key,
 					      mp_opt->addr_id, &mp_opt->addr);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else
-		hmac =3D add_addr6_generate_hmac(subflow->remote_key,
-					       subflow->local_key,
+		hmac =3D add_addr6_generate_hmac(msk->remote_key,
+					       msk->local_key,
 					       mp_opt->addr_id, &mp_opt->addr6);
 #endif
 =

-	pr_debug("subflow=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
-		 subflow, (unsigned long long)hmac,
+	pr_debug("msk=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
+		 msk, (unsigned long long)hmac,
 		 (unsigned long long)mp_opt->ahmac);
 =

 	return hmac =3D=3D mp_opt->ahmac;
@@ -638,7 +638,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	if (!check_fully_established(subflow, skb, mp_opt))
 		return;
 =

-	if (msk && mp_opt->add_addr && add_addr_hmac_valid(subflow, mp_opt)) {
+	if (mp_opt->add_addr && add_addr_hmac_valid(msk, mp_opt)) {
 		struct mptcp_addr_info addr;
 =

 		addr.port =3D 0;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba3ff0e0eeb2..4479ef04cfa7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -917,8 +917,6 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		msk =3D mptcp_sk(new_mptcp_sock);
 		msk->first =3D newsk;
 =

-		mptcp_pm_new_connection(msk, 1);
-
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1faa88855bf..35345b2b0c44 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -234,8 +234,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
-			inet_sk_state_store((struct sock *)new_msk,
-					    TCP_ESTABLISHED);
+			inet_sk_state_store(new_msk, TCP_ESTABLISHED);
+			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
 			ctx->conn =3D new_msk;
 			new_msk =3D NULL;
 		}
-- =

2.21.1

--===============9003575843217651725==--
