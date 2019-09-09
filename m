Content-Type: multipart/mixed; boundary="===============2906381358474156402=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] protocol: avoid sparse endian warning
Date: Tue, 10 Sep 2019 01:17:22 +0200
Message-ID: <20190909231725.4952-2-fw@strlen.de>
In-Reply-To: 20190909231725.4952-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1808

--===============2906381358474156402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

protocol.h:82:16: warning: incorrect type in return expression (different b=
ase types)
protocol.h:82:16:    expected unsigned int
protocol.h:82:16:    got restricted __be32 [usertype]

squashto: mptcp: Add ADD_ADDR handling

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd7b3b107fe0..49ac7c842a3c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -77,7 +77,7 @@
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
 =

-static inline u32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
 	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
 		     ((nib & 0xF) << 8) | field);
-- =

2.21.0


--===============2906381358474156402==--
