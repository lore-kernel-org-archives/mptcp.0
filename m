Content-Type: multipart/mixed; boundary="===============3252494281853043628=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:pm: limit changes for basic in pm.c
Date: Tue, 15 Oct 2019 16:06:55 +0200
Message-ID: <20191015140655.16427-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2144

--===============3252494281853043628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Seems better to use mptcp_pm_init() and remove specifc changes for
'basic' PM in protocol.c.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Implement basic path manager"

 net/mptcp/pm.c       | 1 +
 net/mptcp/protocol.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9c1e3e631ade..d2b56fb8b47f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -198,4 +198,5 @@ int mptcp_pm_get_local_id(struct request_sock *req, str=
uct sock *sk,
 =

 void mptcp_pm_init(void)
 {
+	mptcp_basic_init();
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9f89095ac438..df5455c3719a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1447,7 +1447,6 @@ void mptcp_proto_init(void)
 =

 	mptcp_subflow_init();
 	mptcp_pm_init();
-	mptcp_basic_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
-- =

2.20.1

--===============3252494281853043628==--
