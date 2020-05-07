Content-Type: multipart/mixed; boundary="===============7096553099939506708=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: set correct vfs info for subflows
Date: Thu, 07 May 2020 18:53:24 +0200
Message-ID: <a2fde8fb93863b0ffdeea94b5f44ba64b7601c5d.1588865446.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4345

--===============7096553099939506708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a subflow is created via mptcp_subflow_create_socket(),
a new 'struct socket' is allocated, with a new i_ino value.

When inspecting TCP sockets via the procfs and or the diag
interface, the above ones are not related to the process owning
the MPTCP master socket, even if they are a logical part of it
('ss -p' shows an empty process field)

Additionally, subflows created by the path manager get
the uid/gid from the running workqueue.

Subflows are part of the owning MPTCP master socket, let's
adjust the vfs info to reflect this.

After this patch, 'ss' correctly displays subflows as belonging
to the msk socket creator.

Fixes: 2303f994b3e1 ("mptcp: Associate MPTCP context with TCP socket")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 67a4e35d4838..4931a29a6f08 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1012,6 +1012,16 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 	if (err)
 		return err;
 =

+	/* the newly created socket really belongs to the owning MPTCP master
+	 * socket, even if for additional subflows the allocation is performed
+	 * by a kernel workqueue. Adjust inode references, so that the
+	 * procfs/diag interaces really show this one belonging to the correct
+	 * user.
+	 */
+	SOCK_INODE(sf)->i_ino =3D SOCK_INODE(sk->sk_socket)->i_ino;
+	SOCK_INODE(sf)->i_uid =3D SOCK_INODE(sk->sk_socket)->i_uid;
+	SOCK_INODE(sf)->i_gid =3D SOCK_INODE(sk->sk_socket)->i_gid;
+
 	subflow =3D mptcp_subflow_ctx(sf->sk);
 	pr_debug("subflow=3D%p", subflow);
 =

-- =

2.21.1

--===============7096553099939506708==--
