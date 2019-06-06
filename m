Content-Type: multipart/mixed; boundary="===============7914339690240789905=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/7] mptcp: reduce number of pr_debug() calls.
Date: Wed, 05 Jun 2019 17:36:27 -0700
Message-ID: <20190606003632.2863-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1297

--===============7914339690240789905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squash to: Handle MP_CAPABLE options for outgoing connections

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c  | 5 ++---
 net/mptcp/protocol.c | 2 --
 net/mptcp/subflow.c  | 5 ++---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 964e73b6b48b..7475c1d5c15f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -250,15 +250,14 @@ bool mptcp_established_options(struct sock *sk, unsig=
ned int *size,
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

-	pr_debug("subflow=3D%p", subflow);
 	if (subflow->mp_capable && !subflow->fourth_ack) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
 		*size =3D TCPOLEN_MPTCP_MPC_ACK;
 		subflow->fourth_ack =3D 1;
-		pr_debug("local_key=3D%llu", subflow->local_key);
-		pr_debug("remote_key=3D%llu", subflow->remote_key);
+		pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu",
+			 subflow, subflow->local_key, subflow->remote_key);
 		return true;
 	}
 	return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e809719dcfd..902b6c994f00 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -721,8 +721,6 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct subflow_context *subflow =3D subflow_ctx(msk->subflow->sk);
 =

-	pr_debug("msk=3D%p", msk);
-
 	if (mp_capable) {
 		u64 ack_seq;
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1b8ec517c687..829c97c57745 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -80,10 +80,9 @@ static void subflow_finish_connect(struct sock *sk, cons=
t struct sk_buff *skb)
 =

 	inet_sk_rx_dst_set(sk, skb);
 =

-	pr_debug("subflow=3D%p", subflow_ctx(sk));
-
 	if (subflow->conn && !subflow->conn_finished) {
-		pr_debug("remote_key=3D%llu", subflow->remote_key);
+		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow_ctx(sk),
+			 subflow->remote_key);
 		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
 		subflow->conn_finished =3D 1;
 =

-- =

2.17.2


--===============7914339690240789905==--
