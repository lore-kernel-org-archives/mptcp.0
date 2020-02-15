Content-Type: multipart/mixed; boundary="===============7597547828321383443=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: select CRYPTO
Date: Sat, 15 Feb 2020 15:45:56 +0100
Message-ID: <20200215144556.956173-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3664

--===============7597547828321383443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this modification and if CRYPTO is not selected, we have this
warning:

  WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
    Depends on [n]: CRYPTO [=3Dn]
    Selected by [y]:
    - MPTCP [=3Dy] && NET [=3Dy] && INET [=3Dy]

MPTCP selects CRYPTO_LIB_SHA256 which seems to depend on CRYPTO. CRYPTO
is now selected to avoid this issue.

Even though the config system prints that warning, it looks like
sha256.c is compiled and linked even without CONFIG_CRYPTO. Since MPTCP
will end up needing CONFIG_CRYPTO anyway in future commits -- currently
in preparation for net-next -- we propose to add it now to fix the
warning.

The dependency in the config system comes from the fact that
CRYPTO_LIB_SHA256 is defined in "lib/crypto/Kconfig" which is sourced
from "crypto/Kconfig" only if CRYPTO is selected.

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

--===============7597547828321383443==--
