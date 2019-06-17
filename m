Content-Type: multipart/mixed; boundary="===============7724709850853462861=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] squash to: mptcp: Add path manager interface
Date: Mon, 17 Jun 2019 16:11:40 +0200
Message-ID: <20190617141142.6782-2-matthieu.baerts@tessares.net>
In-Reply-To: 20190617141142.6782-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1416

--===============7724709850853462861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

This is extracted from MP_JOIN handling WIP v3 by Peter.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1f94c99ac897..1358f3231fca 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -64,7 +64,9 @@ struct pm_data {
 	sa_family_t family;
 	union {
 		struct in_addr addr;
+#if IS_ENABLED(CONFIG_IPV6)
 		struct in6_addr addr6;
+#endif
 	};
 };
 =

-- =

2.20.1


--===============7724709850853462861==--
