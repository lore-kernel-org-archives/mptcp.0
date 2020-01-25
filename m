Content-Type: multipart/mixed; boundary="===============6897276079718974048=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/2] mptcp: Fix code formatting
Date: Fri, 24 Jan 2020 16:04:03 -0800
Message-ID: <20200125000403.251894-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200125000403.251894-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3509

--===============6897276079718974048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch.pl had a few complaints in the last set of MPTCP patches:

ERROR: code indent should use tabs where possible
+^I         subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);$

CHECK: Comparison to NULL could be written "!new_ctx"
+	if (new_ctx =3D=3D NULL) {

ERROR: "foo * bar" should be "foo *bar"
+static const struct proto_ops * tcp_proto_ops(struct sock *sk)

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/subflow.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 41d49126d29a..39fdca79ce90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -26,7 +26,7 @@
 =

 static void __mptcp_close(struct sock *sk, long timeout);
 =

-static const struct proto_ops * tcp_proto_ops(struct sock *sk)
+static const struct proto_ops *tcp_proto_ops(struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family =3D=3D AF_INET6)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8cfa1d29d59c..1662e1178949 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -592,7 +592,7 @@ void mptcp_handle_ipv6_mapped(struct sock *sk, bool map=
ped)
 	target =3D mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 =

 	pr_debug("subflow=3D%p family=3D%d ops=3D%p target=3D%p mapped=3D%d",
-	         subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
+		 subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
 =

 	if (likely(icsk->icsk_af_ops =3D=3D target))
 		return;
@@ -773,7 +773,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	}
 =

 	new_ctx =3D subflow_create_ctx(newsk, priority);
-	if (new_ctx =3D=3D NULL) {
+	if (!new_ctx) {
 		subflow_ulp_fallback(newsk, old_ctx);
 		return;
 	}
-- =

2.25.0

--===============6897276079718974048==--
