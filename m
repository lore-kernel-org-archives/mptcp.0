Content-Type: multipart/mixed; boundary="===============4356208221071027969=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-net-next 02/12] mptcp: Remove some left-over
 cruft
Date: Tue, 18 Dec 2018 11:43:41 -0800
Message-ID: <20181218194351.14716-3-cpaasch@apple.com>
In-Reply-To: 20181218194351.14716-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 938

--===============4356208221071027969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP-congestion controls have been removed. This here is a
left-over.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/Kconfig | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 3620a29db1ef..32cae39cdff6 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -717,21 +717,6 @@ choice
 	config DEFAULT_BBR
 		bool "BBR" if TCP_CONG_BBR=3Dy
 =

-	config DEFAULT_LIA
-		bool "Lia" if TCP_CONG_LIA=3Dy
-
-	config DEFAULT_OLIA
-		bool "Olia" if TCP_CONG_OLIA=3Dy
-
-	config DEFAULT_WVEGAS
-		bool "Wvegas" if TCP_CONG_WVEGAS=3Dy
-
-	config DEFAULT_BALIA
-		bool "Balia" if TCP_CONG_BALIA=3Dy
-
-	config DEFAULT_MCTCPDESYNC
-		bool "Mctcpdesync (EXPERIMENTAL)" if TCP_CONG_MCTCPDESYNC=3Dy
-
 	config DEFAULT_RENO
 		bool "Reno"
 endchoice
@@ -752,10 +737,6 @@ config DEFAULT_TCP_CONG
 	default "vegas" if DEFAULT_VEGAS
 	default "westwood" if DEFAULT_WESTWOOD
 	default "veno" if DEFAULT_VENO
-	default "lia" if DEFAULT_LIA
-	default "olia" if DEFAULT_OLIA
-	default "wvegas" if DEFAULT_WVEGAS
-	default "balia" if DEFAULT_BALIA
 	default "reno" if DEFAULT_RENO
 	default "dctcp" if DEFAULT_DCTCP
 	default "cdg" if DEFAULT_CDG
-- =

2.16.2


--===============4356208221071027969==--
