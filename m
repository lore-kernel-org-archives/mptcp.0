Content-Type: multipart/mixed; boundary="===============7301930994595555477=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/4] mptcp: attach subflow socket to parent
 cgroup
Date: Tue, 04 Aug 2020 18:13:29 +0200
Message-ID: <20200804161331.1219161-3-nicolas.rybowski@tessares.net>
In-Reply-To: 20200804161331.1219161-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5468

--===============7301930994595555477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It has been observed that the kernel sockets created for the subflows
(except the first one) are not in the same cgroup as their parents.
That's because the additional subflows are created by kernel workers.
This is a problem since the eBPF programs attached to the parent's
cgroup won't be executed for the children.

This patch fixes this behaviour.

About the new helper 'mptcp_mem_cgroup_sk_clone', as the subflow sockets
are created by the kernel, we can't use 'mem_cgroup_sk_alloc' because of
the current context being the one of the kworker.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---
 net/mptcp/subflow.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a4cc4591bd4e..4c4e4bd0526a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1130,8 +1130,19 @@ int __mptcp_subflow_connect(struct sock *sk, int ifi=
ndex,
 	return err;
 }
 =

+static void mptcp_mem_cgroup_sk_clone(struct sock *parent, struct sock *ch=
ild)
+{
+#ifdef CONFIG_MEMCG
+	struct mem_cgroup *memcg =3D parent->sk_memcg;
+
+	if (memcg && css_tryget(&memcg->css))
+		child->sk_memcg =3D memcg;
+#endif
+}
+
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
+	struct sock_cgroup_data *parent_skcd =3D &sk->sk_cgrp_data, *child_skcd;
 	struct mptcp_subflow_context *subflow;
 	struct net *net =3D sock_net(sk);
 	struct socket *sf;
@@ -1144,6 +1155,20 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 =

 	lock_sock(sf->sk);
 =

+	/* the newly created socket has to be in the same cgroup than its parent,
+	 * only the additional subflows created by kworkers have to be modified
+	 */
+	child_skcd =3D &sf->sk->sk_cgrp_data;
+	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=3D
+	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
+		mem_cgroup_sk_free(sf->sk);
+		mptcp_mem_cgroup_sk_clone(sk, sf->sk);
+
+		cgroup_sk_free(child_skcd);
+		*child_skcd =3D *parent_skcd;
+		cgroup_sk_clone(child_skcd);
+	}
+
 	/* kernel sockets do not by default acquire net ref, but TCP timer
 	 * needs it.
 	 */
-- =

2.28.0

--===============7301930994595555477==--
