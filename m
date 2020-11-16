Content-Type: multipart/mixed; boundary="===============4754489448376837911=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/3] mptcp: add new flag
 listen_new_port
Date: Mon, 16 Nov 2020 12:31:00 +0800
Message-ID: <e6d99c38352b1494235eb577805a21939b7f9281.1605500515.git.geliangtang@gmail.com>
In-Reply-To: e25c8761f3dcd0a262e0578bf97001c875ca59d2.1605500515.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6736

--===============4754489448376837911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new flag listen_new_port, to mark the new port has
been listened in the kernel side. If the new port has been listened from
the userspace, kernel_bind() in mptcp_subflow_listen_new_port will fail,
the listen_new_port flag will be not set, then the connection will be
aborted in subflow_init_req.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0ee63f6b54b4..6508ca895f02 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -372,7 +372,8 @@ struct mptcp_subflow_context {
 		backup : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
-		disposable : 1;	    /* ctx can be free at ulp release time */
+		disposable : 1,	    /* ctx can be free at ulp release time */
+		listen_new_port : 1;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 38a77cc98d2b..47826e4c9534 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -192,7 +192,8 @@ static void subflow_init_req(struct request_sock *req,
 			pr_debug("syn inet_sport=3D%d %d",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener) ||
+			    !listener->listen_new_port) {
 				subflow_req->mp_join =3D 0;
 				return;
 			}
@@ -1209,6 +1210,7 @@ void mptcp_subflow_listen_new_port(struct mptcp_sock =
*msk, __be16 port)
 	if (err)
 		return;
 =

+	subflow->listen_new_port =3D 1;
 	pr_debug("listen_new_port done");
 }
 =

-- =

2.26.2

--===============4754489448376837911==--
