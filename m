Content-Type: multipart/mixed; boundary="===============5747399030436600038=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: fix compilation warning without IPV6
Date: Wed, 16 Oct 2019 18:15:26 +0200
Message-ID: <20191016161528.4336-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191016161528.4336-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2182

--===============5747399030436600038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  net/mptcp/pm.c:228:23: warning: unused variable =E2=80=98addr6=E2=80=99 [=
-Wunused-variable]
    228 |  struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
        |                       ^~~~~

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: Add path manager interface"

 net/mptcp/pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b14308ad11a3..f521bf0c5f69 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -224,8 +224,10 @@ void mptcp_pm_add_addr6(struct mptcp_sock *msk, const =
struct in6_addr *addr,
 int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
 			 struct sockaddr_storage *saddr)
 {
-	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
+#if IS_ENABLED(CONFIG_IPV6)
 	struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
+#endif
+	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
 =

 	if (!msk->pm.local_valid)
 		return -1;
-- =

2.20.1

--===============5747399030436600038==--
