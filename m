Content-Type: multipart/mixed; boundary="===============0489323883167784779=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp v3 1/3] mptcp: release mptcp socket in
 mptcp_close
Date: Thu, 16 May 2019 11:23:49 +0200
Message-ID: <20190516092351.9741-2-fw@strlen.de>
In-Reply-To: 20190516092351.9741-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1187

--===============0489323883167784779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kmemleak reports several stray objects.
This fixes following splats:

  unreferenced object 0xffff88810e27f240 (size 2016):
    comm "mptcp_connect", pid 2187, jiffies 4295218907 (age 1371.080s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      02 00 01 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
    backtrace:
      [<00000000298ae054>] sk_alloc+0x4c/0x600
      [<000000001cd7d411>] inet_create+0x1f4/0x6a0
      [<00000000ac4d1289>] __sock_create+0x1b4/0x3c0
      [<00000000cf2663ed>] __sys_socket+0xb6/0x170
      [<00000000b8efb3a9>] __x64_sys_socket+0x3d/0x50
      [<000000006e83b432>] do_syscall_64+0x72/0x270
      [<0000000007655965>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
      [<0000000073c2278e>] 0xffffffffffffffff

This is because mptcp_close forgot to put the last reference.

We also need to set the state to CLOSED and orphan the socket, else the
put will trigger warning about 'alive' inet socket being torn down.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e80b4a50a208..ad8b1dcd525e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -592,6 +592,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 	struct socket *ssk =3D NULL;
 	struct list_head list;
 =

+	inet_sk_state_store(sk, TCP_CLOSE);
+
 	spin_lock_bh(&msk->conn_list_lock);
 	if (msk->subflow) {
 		ssk =3D msk->subflow;
@@ -615,6 +617,9 @@ static void mptcp_close(struct sock *sk, long timeout)
 		pr_debug("conn_list->subflow=3D%p", subflow);
 		sock_release(sock_sk(subflow)->sk_socket);
 	};
+
+	sock_orphan(sk);
+	sock_put(sk);
 }
 =

 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
-- =

2.21.0


--===============0489323883167784779==--
