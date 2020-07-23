Content-Type: multipart/mixed; boundary="===============0794008460927452930=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 06/26] net: switch sock_setbindtodevice to sockptr_t
Date: Thu, 23 Jul 2020 08:08:48 +0200
Message-ID: <20200723060908.50081-7-hch@lst.de>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5203

--===============0794008460927452930==
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
index 71fc7e4ddd0648..5b55bc9397f282 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -609,8 +609,7 @@ int sock_bindtoindex(struct sock *sk, int ifindex, bool=
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
@@ -632,7 +631,7 @@ static int sock_setbindtodevice(struct sock *sk, char _=
_user *optval,
 	memset(devname, 0, sizeof(devname));
 =

 	ret =3D -EFAULT;
-	if (copy_from_user(devname, optval, optlen))
+	if (copy_from_sockptr(devname, optval, optlen))
 		goto out;
 =

 	index =3D 0;
@@ -840,7 +839,7 @@ int sock_setsockopt(struct socket *sock, int level, int=
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

--===============0794008460927452930==--
