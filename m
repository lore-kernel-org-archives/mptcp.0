Content-Type: multipart/mixed; boundary="===============4979789387206213952=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/4] mptcp: fix compilation warning without IPV6
Date: Thu, 17 Oct 2019 16:50:44 +0200
Message-ID: <20191017145047.8900-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191017145047.8900-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2219

--===============4979789387206213952==
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

--===============4979789387206213952==--
