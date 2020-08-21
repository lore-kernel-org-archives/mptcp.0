Content-Type: multipart/mixed; boundary="===============3483748923864390661=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH bpf-next 2/3] mptcp: attach subflow socket to parent
 cgroup
Date: Fri, 21 Aug 2020 17:15:40 +0200
Message-ID: <20200821151544.1211989-3-nicolas.rybowski@tessares.net>
In-Reply-To: 20200821151544.1211989-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5593

--===============3483748923864390661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It has been observed that the kernel sockets created for the subflows
(except the first one) are not in the same cgroup as their parents.
That's because the additional subflows are created by kernel workers.

This is a problem with eBPF programs attached to the parent's
cgroup won't be executed for the children. But also with any other features
of CGroup linked to a sk.

This patch fixes this behaviour.

As the subflow sockets are created by the kernel, we can't use
'mem_cgroup_sk_alloc' because of the current context being the one of the
kworker. This is why we have to do low level memcg manipulation, if
required.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---
 net/mptcp/subflow.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8cac2655c82..535a3f9f8cfc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1130,6 +1130,30 @@ int __mptcp_subflow_connect(struct sock *sk, int ifi=
ndex,
 	return err;
 }
 =

+static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+{
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	struct sock_cgroup_data *parent_skcd =3D &parent->sk_cgrp_data,
+				*child_skcd =3D &child->sk_cgrp_data;
+
+	/* only the additional subflows created by kworkers have to be modified */
+	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=3D
+	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
+#ifdef CONFIG_MEMCG
+		struct mem_cgroup *memcg =3D parent->sk_memcg;
+
+		mem_cgroup_sk_free(child);
+		if (memcg && css_tryget(&memcg->css))
+			child->sk_memcg =3D memcg;
+#endif /* CONFIG_MEMCG */
+
+		cgroup_sk_free(child_skcd);
+		*child_skcd =3D *parent_skcd;
+		cgroup_sk_clone(child_skcd);
+	}
+#endif /* CONFIG_SOCK_CGROUP_DATA */
+}
+
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
@@ -1150,6 +1174,9 @@ int mptcp_subflow_create_socket(struct sock *sk, stru=
ct socket **new_sock)
 =

 	lock_sock(sf->sk);
 =

+	/* the newly created socket has to be in the same cgroup as its parent */
+	mptcp_attach_cgroup(sk, sf->sk);
+
 	/* kernel sockets do not by default acquire net ref, but TCP timer
 	 * needs it.
 	 */
-- =

2.28.0

--===============3483748923864390661==--
