Content-Type: multipart/mixed; boundary="===============5849361625825316663=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADDR_MAX
Date: Fri, 12 Jun 2020 13:27:28 +0800
Message-ID: <463f48a4f92aa403453d30a801259c68fda15387.1591939496.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4657

--===============5849361625825316663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unify these two duplicate macros into 8.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 2 --
 net/mptcp/protocol.h   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b78edf237ba0..b694f13caba8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -41,8 +41,6 @@ struct pm_nl_pernet {
 	unsigned int		next_id;
 };
 =

-#define MPTCP_PM_ADDR_MAX	8
-
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 809687d3f410..86d265500cf6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -135,7 +135,7 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, u8=
 nib, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 =

-#define MPTCP_PM_MAX_ADDR	4
+#define MPTCP_PM_ADDR_MAX	8
 =

 struct mptcp_addr_info {
 	sa_family_t		family;
-- =

2.17.1

--===============5849361625825316663==--
