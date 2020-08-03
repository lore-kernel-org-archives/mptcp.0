Content-Type: multipart/mixed; boundary="===============1286259272035242699=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: use mptcp_for_each_subflow in
 mptcp_stream_accept
Date: Mon, 03 Aug 2020 21:00:44 +0800
Message-ID: <fe531e58a52eae5aa46dd93d30d623f8862c3d09.1596459430.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5441

--===============1286259272035242699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use mptcp_for_each_subflow in mptcp_stream_accept instead of
open-coding.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d3fe7296e1c9..400824eabf73 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2249,7 +2249,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
 		__mptcp_flush_join_list(msk);
-		list_for_each_entry(subflow, &msk->conn_list, node) {
+		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 			if (!ssk->sk_socket)
-- =

2.17.1

--===============1286259272035242699==--
