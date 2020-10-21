Content-Type: multipart/mixed; boundary="===============1024831125504376157=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] selftests: mptcp: depends on built-in IPv6
Date: Wed, 21 Oct 2020 17:55:49 +0200
Message-ID: <20201021155549.933731-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6395

--===============1024831125504376157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Recently, CONFIG_MPTCP_IPV6 no longer selects CONFIG_IPV6. As a
consequence, if CONFIG_MPTCP_IPV6=3Dy is added to the kconfig, it will no
longer ensure CONFIG_IPV6=3Dy. If it is not enabled, CONFIG_MPTCP_IPV6
will stay disabled and selftests will fail.

We also need CONFIG_IPV6 to be built-in. For more details, please see
commit 0ed37ac586c0 ("mptcp: depends on IPV6 but not as a module").

Note that 'make kselftest-merge' will take all 'config' files found in
'tools/testsing/selftests'. Because some of them already set
CONFIG_IPV6=3Dy, MPTCP selftests were still passing. But they will fail if
MPTCP selftests are launched manually after having executed this command
to prepare the kernel config:

  ./scripts/kconfig/merge_config.sh -m .config \
      ./tools/testing/selftests/net/mptcp/config

Fixes: 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 instead of se=
lecting it")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 8df5cb8f71ff..741a1c4f4ae8 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,4 +1,5 @@
 CONFIG_MPTCP=3Dy
+CONFIG_IPV6=3Dy
 CONFIG_MPTCP_IPV6=3Dy
 CONFIG_INET_DIAG=3Dm
 CONFIG_INET_MPTCP_DIAG=3Dm
-- =

2.27.0

--===============1024831125504376157==--
