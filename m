Content-Type: multipart/mixed; boundary="===============2730720853592509075=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 10/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:53 +0200
Message-ID: <20190615105259.15151-11-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1395

--===============2730720853592509075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - Comparison to NULL could be written "ssk"
 - line over 80 characters

What has not been fixed:

 - /

Fixes: 972098f3f6a8 (mptcp: Make connection_list a real list of subflows)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 245b8fb785e0..b6ee9cfc2e16 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -519,7 +519,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 		msk->subflow =3D NULL;
 	}
 	spin_unlock_bh(&msk->conn_list_lock);
-	if (ssk !=3D NULL) {
+	if (ssk) {
 		pr_debug("subflow=3D%p", ssk->sk);
 		sock_release(ssk);
 	}
@@ -884,7 +884,8 @@ static int mptcp_shutdown(struct socket *sock, int how)
 	list_for_each_entry_rcu(subflow, &msk->conn_list, node) {
 		pr_debug("conn_list->subflow=3D%p", subflow);
 		rcu_read_unlock();
-		ret =3D kernel_sock_shutdown(mptcp_subflow_tcp_socket(subflow), how);
+		ret =3D kernel_sock_shutdown(mptcp_subflow_tcp_socket(subflow),
+					   how);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-- =

2.20.1


--===============2730720853592509075==--
