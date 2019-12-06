Content-Type: multipart/mixed; boundary="===============6138234468868995205=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN
 if one one subflow has closed
Date: Fri, 06 Dec 2019 17:37:32 +0100
Message-ID: <20191206163732.GA795@breakpoint.cc>
In-Reply-To: a0204fbd-6678-c9ce-1273-9f6183892615@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2826

--===============6138234468868995205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> 00:07:58.688 [   14.025780] #PF: supervisor read access in kernel mode
> 00:07:58.689 [   14.026588] #PF: error_code(0x0000) - not-present page
> 00:07:58.690 [   14.027394] PGD 0 P4D 0
> 00:07:58.690 [   14.027801] Oops: 0000 [#1] SMP PTI
> 00:07:58.691 [   14.028355] CPU: 0 PID: 731 Comm: mptcp_connect Not taint=
ed
> 5.4.0+ #5
> 00:07:58.692 [   14.029365] Hardware name: QEMU Standard PC (i440FX + PII=
X,
> 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> 00:07:58.693 [   14.030752] RIP: 0010:mptcp_stream_accept+0x8d/0x160
> 00:07:58.694 [   14.031533] Code: 8b 9c 24 b0 05 00 00 49 81 c4 b0 05 00 =
00
> 4c 39 e3 74 71 49 8d 76 40 48 89 74 24 08 eb 08 48 8b 1b 4c 39 e3 74 5e 48
> 8b 6b 78 <48> 83 bd 78 02 00 00 00 75 ea 4c 8d bd 28 02 00 00 89 44 24 04=
 4c
> 00:07:58.697 [   14.034405] RSP: 0018:ffffad8d8044bdf0 EFLAGS: 00010283
> 00:07:58.698 [   14.035218] RAX: 0000000000000000 RBX: ffff96f35d0d9928 R=
CX:
> 0000000000000001

The faulty commit is

    make accept not allocate kernel socket struct


When doing the last version I broke tcp-ipv6 fallback.  This fixes
things:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1512,6 +1512,15 @@ static int mptcp_listen(struct socket *sock, int bac=
klog)
 	return err;
 }
 =

+static bool is_tcp_proto(const struct proto *p)
+{
+#ifdef CONFIG_MPTCP_IPV6
+	return p =3D=3D &tcp_prot || p =3D=3D &tcpv6_prot;
+#else
+	return p =3D=3D &tcp_prot;
+#endif
+}
+
 static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			       int flags, bool kern)
 {
@@ -1526,7 +1535,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		return -EINVAL;
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
-	if (err =3D=3D 0 && newsock->sk->sk_prot !=3D &tcp_prot) {
+	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
 		struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
 		struct mptcp_subflow_context *subflow;
=20
--===============6138234468868995205==--
