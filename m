Content-Type: multipart/mixed; boundary="===============5510914125602489292=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] subflow: get a ref to the current net
Date: Tue, 14 Jan 2020 22:46:13 +0100
Message-ID: <43354232f69ebf85d4e54e822f8019930b1ccb57.1579038306.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3354

--===============5510914125602489292==
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

Squash-to: "mptcp: Associate MPTCP context with TCP socket"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
RFC -> v1:
 - no changes, just added squash-to tag
---
 net/mptcp/subflow.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9e2ff5b40d13..96e156027f85 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -27,6 +27,11 @@ int mptcp_subflow_create_socket(struct sock *sk, struct =
socket **new_sock)
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

--===============5510914125602489292==--
