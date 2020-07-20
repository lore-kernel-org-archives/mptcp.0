Content-Type: multipart/mixed; boundary="===============0293157162733940193=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 05/24] net: switch sock_setbindtodevice to sockptr_t
Date: Mon, 20 Jul 2020 14:47:18 +0200
Message-ID: <20200720124737.118617-6-hch@lst.de>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5103

--===============0293157162733940193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a sockptr_t to prepare for set_fs-less handling of the kernel
pointer from bpf-cgroup.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 net/core/sock.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 91224709869389..bd20fc5cce0850 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -608,8 +608,7 @@ int sock_bindtoindex(struct sock *sk, int ifindex, bool=
 lock_sk)
 }
 EXPORT_SYMBOL(sock_bindtoindex);
 =

-static int sock_setbindtodevice(struct sock *sk, char __user *optval,
-				int optlen)
+static int sock_setbindtodevice(struct sock *sk, sockptr_t optval, int opt=
len)
 {
 	int ret =3D -ENOPROTOOPT;
 #ifdef CONFIG_NETDEVICES
@@ -631,7 +630,7 @@ static int sock_setbindtodevice(struct sock *sk, char _=
_user *optval,
 	memset(devname, 0, sizeof(devname));
 =

 	ret =3D -EFAULT;
-	if (copy_from_user(devname, optval, optlen))
+	if (copy_from_sockptr(devname, optval, optlen))
 		goto out;
 =

 	index =3D 0;
@@ -839,7 +838,7 @@ int sock_setsockopt(struct socket *sock, int level, int=
 optname,
 	 */
 =

 	if (optname =3D=3D SO_BINDTODEVICE)
-		return sock_setbindtodevice(sk, optval, optlen);
+		return sock_setbindtodevice(sk, USER_SOCKPTR(optval), optlen);
 =

 	if (optlen < sizeof(int))
 		return -EINVAL;
-- =

2.27.0

--===============0293157162733940193==--
