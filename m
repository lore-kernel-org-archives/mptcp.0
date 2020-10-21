Content-Type: multipart/mixed; boundary="===============7070763344622768352=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: depends on IPV6 but not as a module
Date: Wed, 21 Oct 2020 12:51:53 +0200
Message-ID: <20201021105154.628257-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6389

--===============7070763344622768352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Like TCP, MPTCP cannot be compiled as a module. Obviously, MPTCP IPv6'
support also depends on CONFIG_IPV6. But not all functions from IPv6
code are exported.

To simplify the code and reduce modifications outside MPTCP, it was
decided from the beginning to support MPTCP with IPv6 only if
CONFIG_IPV6 was built inlined. That's also why CONFIG_MPTCP_IPV6 was
created. More modifications are needed to support CONFIG_IPV6=3Dm.

Even if it was not explicit, until recently, we were forcing CONFIG_IPV6
to be built-in because we had "select IPV6" in Kconfig. Now that we have
"depends on IPV6", we have to explicitly set "IPV6=3Dy" to force
CONFIG_IPV6 not to be built as a module.

In other words, we can now only have CONFIG_MPTCP_IPV6=3Dy if
CONFIG_IPV6=3Dy.

Note that the new dependency might hide the fact IPv6 is not supported
in MPTCP even if we have CONFIG_IPV6=3Dm. But selecting IPV6 like we did
before was forcing it to be built-in while it was maybe not what the
user wants.

Reported-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
Fixes: 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 instead of se=
lecting it")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    For more details about the issue we have when we try to compile
    CONFIG_IPV6=3Dm and CONFIG_MPTCP_IPV6=3Dy, please refer to:
    =

    https://lore.kernel.org/netdev/CAMuHMdW=3D1LfE8UoGRVBvrvrintQMNKUdTe5PP=
Qz=3DPN3=3DgJmw=3DQ(a)mail.gmail.com/

 net/mptcp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index 8936604b3bf9..a014149aa323 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -19,7 +19,7 @@ config INET_MPTCP_DIAG
 =

 config MPTCP_IPV6
 	bool "MPTCP: IPv6 support for Multipath TCP"
-	depends on IPV6
+	depends on IPV6=3Dy
 	default y
 =

 config MPTCP_KUNIT_TESTS
-- =

2.27.0

--===============7070763344622768352==--
