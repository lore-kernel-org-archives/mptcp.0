Content-Type: multipart/mixed; boundary="===============4398089398784517399=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 14/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:57 +0200
Message-ID: <20190615105259.15151-15-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1399

--===============4398089398784517399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - Prefer 'unsigned int *' to bare use of 'unsigned *' (2)

What has not been fixed:

 - added, moved or deleted file(s), does MAINTAINERS need updating?
   > TBD later

Fixes: 63989ae59543 (mptcp: Add path manager interface)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/pm.c       | 2 +-
 net/mptcp/protocol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 954360a3af2f..512dc110098a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -48,7 +48,7 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
 	pr_debug("msk=3D%p", msk);
 }
 =

-bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
+bool pm_addr_signal(struct mptcp_sock *msk, unsigned int *size,
 		    unsigned int remaining, struct mptcp_out_options *opts)
 {
 	pr_debug("msk=3D%p", msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 257fdfec705e..3b15e56dc9e0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -174,7 +174,7 @@ void pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void pm_add_addr(struct mptcp_sock *msk, const struct in_addr *addr, u8 id=
);
 void pm_add_addr6(struct mptcp_sock *msk, const struct in6_addr *addr, u8 =
id);
 void pm_rm_addr(struct mptcp_sock *msk, u8 id);
-bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
+bool pm_addr_signal(struct mptcp_sock *msk, unsigned int *size,
 		    unsigned int remaining, struct mptcp_out_options *opts);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-- =

2.20.1


--===============4398089398784517399==--
