Content-Type: multipart/mixed; boundary="===============1875734186460033228=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: Handle MP_CAPABLE options for
 outgoing connections"
Date: Mon, 16 Dec 2019 22:26:53 +0100
Message-ID: <5bc1ab81d4c3eed1a2ad8b5b83069bacc980a8ee.1576531578.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3091

--===============1875734186460033228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_established_options() definition will be changed in a couple of patch=
es,
let's introduce early it's final form

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/mptcp.h   | 5 ++++-
 net/ipv4/tcp_output.c | 9 ++++-----
 net/mptcp/options.c   | 3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d7af03848f5a..588abcb76da3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -55,7 +55,8 @@ bool mptcp_syn_options(struct sock *sk, unsigned int *siz=
e,
 void mptcp_rcv_synsent(struct sock *sk);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
 			  struct mptcp_out_options *opts);
-bool mptcp_established_options(struct sock *sk, unsigned int *size,
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts);
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
@@ -104,7 +105,9 @@ static inline bool mptcp_synack_options(const struct re=
quest_sock *req,
 }
 =

 static inline bool mptcp_established_options(struct sock *sk,
+					     struct sk_buff *skb,
 					     unsigned int *size,
+					     unsigned int remaining,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a4bf1197f577..d123d67026d5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -798,11 +798,10 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
 		unsigned int opt_size =3D 0;
 =

-		if (mptcp_established_options(sk, &opt_size, &opts->mptcp)) {
-			if (remaining >=3D opt_size) {
-				opts->options |=3D OPTION_MPTCP;
-				size +=3D opt_size;
-			}
+		if (mptcp_established_options(sk, skb, &opt_size, remaining,
+					      &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			size +=3D opt_size;
 		}
 	}
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 26203dfb6be6..89aef0d0beb1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -196,7 +196,8 @@ void mptcp_rcv_synsent(struct sock *sk)
 	}
 }
 =

-bool mptcp_established_options(struct sock *sk, unsigned int *size,
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-- =

2.21.0

--===============1875734186460033228==--
