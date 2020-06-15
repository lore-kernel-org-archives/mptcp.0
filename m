Content-Type: multipart/mixed; boundary="===============1862822274938780987=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2] mptcp: drop MPTCP_PM_MAX_ADDR
Date: Mon, 15 Jun 2020 16:28:03 +0800
Message-ID: <8d8984e8f73e37c87e69459fdef12fe9bab80949.1592209282.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4672

--===============1862822274938780987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have defined MPTCP_PM_ADDR_MAX in pm_netlink.c, so drop this duplicate m=
acro.

Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 Changes in v2:
  - change Subject from "mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADDR_M=
AX"
---
 net/mptcp/protocol.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 809687d3f410..70ed698bd206 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -135,8 +135,6 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, u8=
 nib, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 =

-#define MPTCP_PM_MAX_ADDR	4
-
 struct mptcp_addr_info {
 	sa_family_t		family;
 	__be16			port;
-- =

2.17.1

--===============1862822274938780987==--
