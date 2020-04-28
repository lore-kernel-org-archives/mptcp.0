Content-Type: multipart/mixed; boundary="===============5331467690775549771=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 6/6] mptcp: cleanup option parsing
Date: Tue, 28 Apr 2020 16:20:11 +0200
Message-ID: <c47fb0968f49f3493d9ea08b8b7689f149436d53.1588082498.git.pabeni@redhat.com>
In-Reply-To: cover.1588082498.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4263

--===============5331467690775549771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp option status is always initialized by
mptcp_get_options(), we can clean-up a couple of
call sites open codying such task.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
this could be squashed into
"mptcp: move option parsing into mptcp_incoming_options()",
kept here to since the latter is already pretty big, but
no strong opinion against squashing
---
 net/mptcp/subflow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c43fe9958287..f412e886aa9b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -128,7 +128,6 @@ static void subflow_init_req(struct request_sock *req,
 =

 	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
 =

-	memset(&mp_opt, 0, sizeof(mp_opt));
 	mptcp_get_options(skb, &mp_opt);
 =

 	subflow_req->mp_capable =3D 0;
@@ -425,6 +424,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

+	/* we need later a valid 'mp_capable' value even when options are not
+	 * parsed
+	 */
 	mp_opt.mp_capable =3D 0;
 	if (tcp_rsk(req)->is_mptcp =3D=3D 0)
 		goto create_child;
@@ -452,7 +454,6 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			fallback =3D true;
 	} else if (subflow_req->mp_join) {
 		fallback_is_fatal =3D true;
-		mp_opt.mp_join =3D 0;
 		mptcp_get_options(skb, &mp_opt);
 		if (!mp_opt.mp_join ||
 		    !subflow_hmac_valid(req, &mp_opt)) {
-- =

2.21.1

--===============5331467690775549771==--
