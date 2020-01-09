Content-Type: multipart/mixed; boundary="===============2831534664560852355=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/7] Squash-to: "mptcp: Add key generation and
 token tree"
Date: Thu, 09 Jan 2020 17:41:34 +0100
Message-ID: <7b8764391f36f09822abc2fe7374854e718fde25.1578586484.git.pabeni@redhat.com>
In-Reply-To: cover.1578586484.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3328

--===============2831534664560852355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 net/mptcp/subflow.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2dad612b48be..b8651367f6fe 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -160,8 +160,11 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(child);
 =

+		/* we have null ctx on TCP fallback, not fatal on MPC
+		 * handshake
+		 */
 		if (!ctx)
-			goto close_child;
+			return child;
 =

 		if (ctx->mp_capable) {
 			if (mptcp_token_new_accept(ctx->token))
-- =

2.21.0

--===============2831534664560852355==--
