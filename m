Content-Type: multipart/mixed; boundary="===============0466105607495935582=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] DO-NOT-MERGE: mptcp: enabled by default
Date: Fri, 05 Mar 2021 18:20:42 +0100
Message-ID: <4dc9bac4227796db1c5046500a4d3253f2c23840.1614964581.git.pabeni@redhat.com>
In-Reply-To: cover.1614964581.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8044

--===============0466105607495935582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

This commit is useful for automated builds, e.g. from Intel's kbuild.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index a014149aa3233..739dc22f27b34 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -5,6 +5,7 @@ config MPTCP
 	select SKB_EXTENSIONS
 	select CRYPTO_LIB_SHA256
 	select CRYPTO
+	default y
 	help
 	  Multipath TCP (MPTCP) connections send and receive data over multiple
 	  subflows in order to utilize multiple network paths. Each subflow
-- =

2.26.2

--===============0466105607495935582==--
