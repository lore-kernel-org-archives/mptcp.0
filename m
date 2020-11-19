Content-Type: multipart/mixed; boundary="===============6946360568940602355=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 06/10] mptcp: add port number
 listened in kernel check
Date: Thu, 19 Nov 2020 18:19:46 +0800
Message-ID: <d3d9dea1baa419a5fcdbdf1a01770d982c211f2c.1605780306.git.geliangtang@gmail.com>
In-Reply-To: fffe5a2aa8ec491955857eb4698764fc2e4a03a7.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6817

--===============6946360568940602355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new flag listen_in_kernel, to mark the new port has
been listened in the kernel side. If the new port has been listened from
the userspace, kernel_bind() in mptcp_subflow_listen_in_kernel will fail,
the listen_in_kernel flag will be not set, then the connection will be
aborted in subflow_init_req.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ba0c5f628637..d926deae8610 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -371,7 +371,8 @@ struct mptcp_subflow_context {
 		backup : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
-		disposable : 1;	    /* ctx can be free at ulp release time */
+		disposable : 1,	    /* ctx can be free at ulp release time */
+		listen_in_kernel : 1;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 76fdaa57eb1d..4939b396847a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -192,7 +192,8 @@ static void subflow_init_req(struct request_sock *req,
 			pr_debug("syn inet_sport=3D%d %d",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener) ||
+			    !listener->listen_in_kernel) {
 				subflow_req->mp_join =3D 0;
 				return;
 			}
@@ -1171,6 +1172,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 =

 void mptcp_bind_and_listen_new_port(struct mptcp_sock *msk, __be16 port)
 {
+	struct mptcp_subflow_context *subflow;
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_addr_info local;
 	struct sockaddr_storage addr;
@@ -1206,6 +1208,8 @@ void mptcp_bind_and_listen_new_port(struct mptcp_sock=
 *msk, __be16 port)
 		goto err;
 	}
 =

+	subflow =3D mptcp_subflow_ctx(listener->sk);
+	subflow->listen_in_kernel =3D 1;
 	pr_debug("bind_and_listen_new_port done");
 	return;
 =

-- =

2.26.2

--===============6946360568940602355==--
