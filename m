Content-Type: multipart/mixed; boundary="===============0017178010159548281=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] subflow: held a ref to the current net
Date: Mon, 13 Jan 2020 19:56:18 +0100
Message-ID: <9c759abdef0ec82c2648c423578256f0f71611ea.1578941741.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3348

--===============0017178010159548281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP subflows are created via sock_create_kern(), so they
do not held any references to the current network namespace.

The TCP timer infrastructure assumes the current net is always
alive/goes away after the relevant sock.

Due to the above packetdrill is able to trigger UAF with some
simple scenario (and fast netns tear-down).

Acquire a reference to the current net at creation time.

Note: using __sock_create(/*...*/, 0) will break lockdep (kernel
socket get a different lockdep key).
---
 net/mptcp/subflow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2c0f2ed7a428..750fe14db4bc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -585,6 +585,11 @@ int mptcp_subflow_create_socket(struct sock *sk, struc=
t socket **new_sock)
 		return err;
 =

 	lock_sock(sf->sk);
+	/* kern socket do not acquire by default net ref, but TCP timer need it
+	 */
+	sf->sk->sk_net_refcnt =3D 1;
+	get_net(net);
+	this_cpu_add(*net->core.sock_inuse, 1);
 	err =3D tcp_set_ulp(sf->sk, "mptcp");
 	release_sock(sf->sk);
 =

-- =

2.21.0

--===============0017178010159548281==--
