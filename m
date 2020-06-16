Content-Type: multipart/mixed; boundary="===============3134375754056069895=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: default KUNIT_* fragments to
 KUNIT_ALL_TESTS
Date: Tue, 16 Jun 2020 18:51:05 +0200
Message-ID: <20200616165105.3015572-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4707

--===============3134375754056069895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_ALL_TESTS so individual tests can not be turned off.
Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
menuconfig.

Similar to beaed42c427d ("kunit: default KUNIT_* fragments to KUNIT_ALL_TES=
TS")
and following ones.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: move crypto test to KUNIT"

 net/mptcp/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index c701f27300ce..d7d5f9349366 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -21,9 +21,10 @@ config MPTCP_IPV6
 endif
 =

 config MPTCP_KUNIT_TESTS
-	tristate "This builds the MPTCP KUnit tests"
+	tristate "This builds the MPTCP KUnit tests" if !KUNIT_ALL_TESTS
 	select MPTCP
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Currently covers the MPTCP crypto helpers.
 	  Only useful for kernel devs running KUnit test harness and are not
-- =

2.27.0.rc0

--===============3134375754056069895==--
