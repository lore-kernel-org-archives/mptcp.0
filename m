Content-Type: multipart/mixed; boundary="===============4401211614660643918=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 3/5] mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
Date: Tue, 10 Mar 2020 15:33:30 -0700
Message-ID: <20200310223332.3845-4-peter.krystad@linux.intel.com>
In-Reply-To: 20200310223332.3845-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3909

--===============4401211614660643918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Validate incoming ADD_ADDR options

squash-to: Add path manager interface

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 31 ++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  4 ++--
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8f309f05d673..011570820879 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -439,7 +439,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 static u64 add_addr_generate_hmac(u64 key1, u64 key2, u8 addr_id,
 				  struct in_addr *addr)
 {
-	u8 hmac[MPTCPOPT_HMAC_LEN];
+	u8 hmac[MPTCP_ADDR_HMAC_LEN];
 	u8 msg[7];
 =

 	msg[0] =3D addr_id;
@@ -455,7 +455,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2, u=
8 addr_id,
 static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
 				   struct in6_addr *addr)
 {
-	u8 hmac[MPTCPOPT_HMAC_LEN];
+	u8 hmac[MPTCP_ADDR_HMAC_LEN];
 	u8 msg[19];
 =

 	msg[0] =3D addr_id;
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
@@ -604,7 +628,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	if (!check_fourth_ack(subflow, skb, mp_opt))
 		return;
 =

-	if (msk && mp_opt->add_addr) {
+	if (msk && mp_opt->add_addr &&
+	    !mp_opt->echo && add_addr_hmac_valid(subflow, mp_opt)) {
 		struct mptcp_addr_info addr;
 =

 		addr.port =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4f16a2e04e1b..a5ce50fff412 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -53,8 +53,6 @@
 #define TCPOLEN_MPTCP_PORT_LEN		2
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 =

-#define MPTCPOPT_HMAC_LEN	20
-
 /* MPTCP MP_CAPABLE flags */
 #define MPTCP_VERSION_MASK	(0x0F)
 #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
@@ -72,9 +70,11 @@
 =

 /* MPTCP ADD_ADDR flags */
 #define MPTCP_ADDR_ECHO		BIT(0)
+#define MPTCP_ADDR_HMAC_LEN	20
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
 #define MPTCP_SEND_SPACE	1
-- =

2.17.2

--===============4401211614660643918==--
