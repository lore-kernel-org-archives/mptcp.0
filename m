Content-Type: multipart/mixed; boundary="===============2541855710720931850=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH net] mptcp: select CRYPTO
Date: Wed, 12 Feb 2020 18:03:05 +0100
Message-ID: <20200212170305.2683209-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3633

--===============2541855710720931850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this modification and if CRYPTO is not selected, we have this
warning:

  WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
    Depends on [n]: CRYPTO [=3Dn]
    Selected by [y]:
    - MPTCP [=3Dy] && NET [=3Dy] && INET [=3Dy]

MPTCP selects CRYPTO_LIB_SHA256 which depends on CRYPTO. CRYPTO is now
selected to avoid this issue.

Fixes: 65492c5a6ab5 (mptcp: move from sha1 (v0) to sha256 (v1))
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 49f6054e7f4e..a9ed3bf1d93f 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -4,6 +4,7 @@ config MPTCP
 	depends on INET
 	select SKB_EXTENSIONS
 	select CRYPTO_LIB_SHA256
+	select CRYPTO
 	help
 	  Multipath TCP (MPTCP) connections send and receive data over multiple
 	  subflows in order to utilize multiple network paths. Each subflow
-- =

2.25.0

--===============2541855710720931850==--
