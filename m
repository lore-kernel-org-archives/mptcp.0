Content-Type: multipart/mixed; boundary="===============0543713649069569298=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:pm: remove duplicated RM addr
Date: Tue, 15 Oct 2019 16:07:53 +0200
Message-ID: <20191015140753.18058-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2145

--===============0543713649069569298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We already have mptcp_pm_remove_addr() and this one is implemented.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Implement basic path manager"

 net/mptcp/pm.c       | 5 -----
 net/mptcp/protocol.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d2b56fb8b47f..f20377c869ad 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -154,11 +154,6 @@ void mptcp_pm_add_addr6(struct mptcp_sock *msk, const =
struct in6_addr *addr,
 	pr_debug("msk=3D%p", msk);
 }
 =

-void mptcp_pm_rm_addr(struct mptcp_sock *msk, u8 id)
-{
-	pr_debug("msk=3D%p", msk);
-}
-
 /* path manager helpers */
 =

 int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 245833f438ee..d81d6bf18a65 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -297,7 +297,6 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk, const st=
ruct in_addr *addr,
 		       u8 id);
 void mptcp_pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *add=
r,
 			u8 id);
-void mptcp_pm_rm_addr(struct mptcp_sock *msk, u8 id);
 int mptcp_pm_announce_addr(u32 token, u8 local_id, sa_family_t family,
 			   struct in_addr *addr);
 int mptcp_pm_create_subflow(u32 token, u8 remote_id, sa_family_t family,
-- =

2.20.1

--===============0543713649069569298==--
