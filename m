Content-Type: multipart/mixed; boundary="===============7746113350273530128=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: select CRYPTO
Date: Wed, 12 Feb 2020 17:39:28 +0100
Message-ID: <20200212163928.2644113-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3632

--===============7746113350273530128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is now needed when using crypto_memneq() in subflow.c:

  ld: net/mptcp/subflow.o: in function `subflow_syn_recv_sock':
  subflow.c:(.text+0xa0b): undefined reference to `__crypto_memneq'

Note that without this modification and if CRYPTO is not selected, we
have this warning:

  WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
    Depends on [n]: CRYPTO [=3Dn]
    Selected by [y]:
    - MPTCP [=3Dy] && NET [=3Dy] && INET [=3Dy]

MPTCP selects CRYPTO_LIB_SHA256 (for MPTCPv1) but even if there is a
dependence to CRYPTO, the latter is not enabled. Does that mean we also
need to backport this 'net'?

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Add handling of incoming MP_JOIN requests"

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

--===============7746113350273530128==--
