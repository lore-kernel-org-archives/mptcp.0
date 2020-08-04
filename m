Content-Type: multipart/mixed; boundary="===============2649795869521686408=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: be careful on subflow creation
Date: Tue, 04 Aug 2020 18:31:06 +0200
Message-ID: <61e82de664dffde9ff445ed6f776d6809b198693.1596558566.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5472

--===============2649795869521686408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nicolas reported the following oops:

[ 1521.392541] BUG: kernel NULL pointer dereference, address: 0000000000000=
0c0
[ 1521.394189] #PF: supervisor read access in kernel mode
[ 1521.395376] #PF: error_code(0x0000) - not-present page
[ 1521.396607] PGD 0 P4D 0
[ 1521.397156] Oops: 0000 [#1] SMP PTI
[ 1521.398020] CPU: 0 PID: 22986 Comm: kworker/0:2 Not tainted 5.8.0-rc4+ #=
109
[ 1521.399618] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1ubuntu1 04/01/2014
[ 1521.401728] Workqueue: events mptcp_worker
[ 1521.402651] RIP: 0010:mptcp_subflow_create_socket+0xf1/0x1c0
[ 1521.403954] Code: 24 08 89 44 24 04 48 8b 7a 18 e8 2a 48 d4 ff 8b 44 24 =
04 85 c0 75 7a 48 8b 8b 78 02 00 00 48 8b 54 24 08 48 8d bb 80 00 00 00 <48=
> 8b 89 c0 00 00 00 48 89 8a c0 00 00 00 48 8b 8b 78 02 00 00 8b
[ 1521.408201] RSP: 0000:ffffabc4002d3c60 EFLAGS: 00010246
[ 1521.409433] RAX: 0000000000000000 RBX: ffffa0b9ad8c9a00 RCX: 00000000000=
00000
[ 1521.411096] RDX: ffffa0b9ae78a300 RSI: 00000000fffffe01 RDI: ffffa0b9ad8=
c9a80
[ 1521.412734] RBP: ffffa0b9adff2e80 R08: ffffa0b9af02d640 R09: ffffa0b9ad9=
23a00
[ 1521.414333] R10: ffffabc4007139f8 R11: fefefefefefefeff R12: ffffabc4002=
d3cb0
[ 1521.415918] R13: ffffa0b9ad91fa58 R14: ffffa0b9ad8c9f9c R15: 00000000000=
00000
[ 1521.417592] FS:  0000000000000000(0000) GS:ffffa0b9af000000(0000) knlGS:=
0000000000000000
[ 1521.419490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1521.420839] CR2: 00000000000000c0 CR3: 000000002951e006 CR4: 00000000001=
60ef0
[ 1521.422511] Call Trace:
[ 1521.423103]  __mptcp_subflow_connect+0x94/0x1f0
[ 1521.425376]  mptcp_pm_create_subflow_or_signal_addr+0x200/0x2a0
[ 1521.426736]  mptcp_worker+0x31b/0x390
[ 1521.431324]  process_one_work+0x1fc/0x3f0
[ 1521.432268]  worker_thread+0x2d/0x3b0
[ 1521.434197]  kthread+0x117/0x130
[ 1521.435783]  ret_from_fork+0x22/0x30

on some unconventional configuration.

The MPTCP protocol is trying to create a subflow for an
unaccepted server socket. That is allowed by the RFC, even
if subflow creation will likely fail.
Unaccepted sockets have still a NULL sk_socket field,
avoid the issue by failing earlier.

Reported-and-tested-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
Fixes: 7d14b0d2b9b3 ("mptcp: set correct vfs info for subflows")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3838a0b3a21f..3c31a8160f19 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1032,6 +1032,12 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
 	struct socket *sf;
 	int err;
 =

+	/* un-accepted server sockets can reach here - on bad configuration
+	 * bail early to avoid greater trouble later
+	 */
+	if (unlikely(!sk->sk_socket))
+		return -EINVAL;
+
 	err =3D sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
 			       &sf);
 	if (err)
-- =

2.26.2

--===============2649795869521686408==--
