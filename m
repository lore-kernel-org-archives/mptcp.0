Content-Type: multipart/mixed; boundary="===============3001557114909540595=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:48 +0200
Message-ID: <20190615105259.15151-6-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1390

--===============3001557114909540595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - line over 80 characters (2)
 - Unnecessary parentheses around '...' (3)

What has not been fixed:

 - /

Fixes: e1686072b85a (mptcp: Create SUBFLOW socket for incoming connections)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 6 ++++--
 net/mptcp/subflow.c  | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e333f4390645..93e1d3303add 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -70,7 +70,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 =

 	if (msk->connection_list) {
-		pr_debug("conn_list->subflow=3D%p", subflow_ctx(msk->connection_list->sk=
));
+		pr_debug("conn_list->subflow=3D%p",
+			 subflow_ctx(msk->connection_list->sk));
 		sock_release(msk->connection_list);
 	}
 =

@@ -95,7 +96,8 @@ static struct sock *mptcp_accept(struct sock *sk, int fla=
gs, int *err,
 	subflow =3D subflow_ctx(new_sock->sk);
 	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
 =

-	*err =3D sock_create(PF_INET, SOCK_STREAM, IPPROTO_MPTCP, &new_mptcp_sock=
);
+	*err =3D sock_create(PF_INET, SOCK_STREAM, IPPROTO_MPTCP,
+			   &new_mptcp_sock);
 	if (*err < 0) {
 		kernel_sock_shutdown(new_sock, SHUT_RDWR);
 		sock_release(new_sock);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 81b3d161fd81..613eb0bbda0d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -99,9 +99,9 @@ static struct sock *subflow_syn_recv_sock(const struct so=
ck *sk,
 	if (subflow_req->mp_capable) {
 		opt_rx.mptcp.mp_capable =3D 0;
 		mptcp_get_options(skb, &opt_rx);
-		if ((!opt_rx.mptcp.mp_capable) ||
-		    (subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key) ||
-		    (subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key))
+		if (!opt_rx.mptcp.mp_capable ||
+		    subflow_req->local_key !=3D opt_rx.mptcp.rcvr_key ||
+		    subflow_req->remote_key !=3D opt_rx.mptcp.sndr_key)
 			return NULL;
 	}
 =

-- =

2.20.1


--===============3001557114909540595==--
