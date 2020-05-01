Content-Type: multipart/mixed; boundary="===============3921384429707317735=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Fri, 01 May 2020 11:09:12 -0700
Message-ID: <20200501180912.GU14696@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 4294

--===============3921384429707317735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

while testing forked MPTCP as client and upstream MPTCP as server and one
forgets to set the max_subflow limit with iproute, I end up having a
scenario where SYN+MP_JOIN is followed by SYN/ACK+MP_JOIN followed by the
ACK+MP_JOIN, which then gets RST by the server.

This makes for a weird packet-trace:
16:48:01.626118 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [S], seq 326770196=
8, win 42340, options [mss 1460,sackOK,TS val 1457348237 ecr 0,nop,wscale 7=
,mptcp join id 4 token 0x8e133996 nonce 0xee4ce80a], length 0
16:48:01.626163 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 26031035=
0, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 3916703437 ec=
r 1457348237,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce 0x3=
238ac63], length 0
16:48:01.626411 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [.], ack 1, win 99=
1, options [nop,nop,TS val 1457348238 ecr 3916703437,mptcp join hmac 0x5c9f=
67595a7c0f15e72b8d45d2abe73de3a86bf8], length 0
16:48:01.626427 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [R.], seq 1, ack 1=
, win 340, options [nop,nop,TS val 3916703438 ecr 1457348238,mptcp dss ack =
7475064947213107918], length 0
^^^
Server kills the connection -> this is because subflow_syn_recv_sock does
the goto close_child and will return NULL to tcp_check_req

16:48:02.653269 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 26031035=
0, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 3916704464 ec=
r 1457348238,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce 0x3=
238ac63], length 0
^^^
But, server keeps on retransmitting the SYN/ACK, which happens because
tcp_check_req did not remove the request-socket after subflow_syn_recv_sock
returned NULL

16:48:02.653692 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [R], seq 326770196=
9, win 0, length 0
^^^
This time, the client will send the RST because of the previous RST from the
server


16:48:04.701270 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 26031035=
0, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 3916706512 ec=
r 1457348238,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce 0x3=
238ac63], length 0
16:48:04.701707 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [R], seq 326770196=
9, win 0, length 0
^^^
And server keeps on retransmitting the SYN/ACK until things time out.


I think we should move the subflow-count check to the SYN+MP_JOIN reception
=C3=A0 la:

-------
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f23016ed3f..adddf2da5dcc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1611,7 +1611,6 @@ bool mptcp_finish_join(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct sock *parent =3D (void *)msk;
 	struct socket *parent_sock;
-	bool ret;

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);

@@ -1627,15 +1626,12 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);

-	ret =3D mptcp_pm_allow_new_subflow(msk);
-	if (ret) {
-		/* active connections are already on conn_list */
-		spin_lock_bh(&msk->join_list_lock);
-		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
-			list_add_tail(&subflow->node, &msk->join_list);
-		spin_unlock_bh(&msk->join_list_lock);
-	}
-	return ret;
+	/* active connections are already on conn_list */
+	spin_lock_bh(&msk->join_list_lock);
+	if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
+		list_add_tail(&subflow->node, &msk->join_list);
+	spin_unlock_bh(&msk->join_list_lock);
+	return true;
 }

 bool mptcp_sk_is_subflow(const struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 009d5c478062..0684bfc42f88 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -99,6 +99,10 @@ static bool subflow_token_join_request(struct request_so=
ck *req,
 		return false;
 	}

+	if (!mptcp_pm_allow_new_subflow(msk)) {
+		return false;
+	}
+
 	local_id =3D mptcp_pm_get_local_id(msk, (struct sock_common *)req);
 	if (local_id < 0) {
 		sock_put((struct sock *)msk);



Thoughts?

This is not going to trigger a RST from the server (see comment in
subflow_init_req, because we are not passing up a return-value from init_req
to tcp_conn_request - but that should be easy to change).

But, even without the RST, the pcap looks much nicer now:
18:06:46.186260 IP 10.1.4.1.52083 > 10.2.1.1.5001: Flags [S], seq 269929216=
5, win 42340, options [mss 1460,sackOK,TS val 3290516720 ecr 0,nop,wscale 7=
,mptcp join id 5 token 0xd17535a3 nonce 0x785acfed], length 0
18:06:46.186276 IP 10.2.1.1.5001 > 10.1.4.1.52083: Flags [S.], seq 17927547=
39, ack 2699292166, win 43440, options [mss 1460,sackOK,TS val 1090612422 e=
cr 3290516720,nop,wscale 7], length 0
18:06:46.186469 IP 10.1.4.1.52083 > 10.2.1.1.5001: Flags [R], seq 269929216=
6, win 0, length 0

Server replies with a SYN/ACK without MP_JOIN, which makes the client
trigger the RST.



Christoph





--===============3921384429707317735==--
