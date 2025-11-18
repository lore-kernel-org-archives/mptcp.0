Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6339212D7C
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438522; cv=none; b=mUj9n6t8SrUVwebCdiVLQCkvdQhcrqFvGz5zkBPnGu9MUxbL0RHSlAi9pYjnp82nkn0G4sFUm7r+LYW/m95JCb0oy3EtK6c88pJqaxFSKFpoldU+bRZqcYCBxTWvgAWP2WfOyDZBj1axiSw41LjPKgMsfNRigrxMDCFBxnANKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438522; c=relaxed/simple;
	bh=IkjJuAcYOdnHA8vEx/WZzPFOXoiX7pDk8Ed2WKaf6to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVVrYlyaXmg/OKd0xfxd3DChX2KzcJdp3inot0gcHl0os8kRlnBSgDgYXlw9kmyXesg2/AysH4BpWXnXGEOmJwiiqAT72xC2HJCXkngno1MVeVd5T48HUpOc5aQd7MYbu5Lxe1l+nKifwH/r2OwHA4+xdSDxkymkAUIF93p0yX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H75Uq9my; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H75Uq9my"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A69DC19421;
	Tue, 18 Nov 2025 04:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438522;
	bh=IkjJuAcYOdnHA8vEx/WZzPFOXoiX7pDk8Ed2WKaf6to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H75Uq9myJDNxIzQAn9fctFf+XA7CpYIY5DWdnvP9TD52e+nG21bXMeRwyRpc6qX3X
	 5phU/DQMb0EeMSRR7OyyzsAJiRIdQte7DqtCoKuto9eKtYaoU2TpO15R5wv47GqvOr
	 Rg/IIl2Vm70jCi3SjbdJYe+DDIMVDWQdsKoEAM6P5PBm+R1z1OQEFY1PKoGVvS6QR1
	 RVeDh2k0neAzL4mikE3h6uKjfDb0eOpv8y6GcOBP6bPGGGFTh+yOgBS+vutF3qKnb/
	 Ob6g9EN355qqz/XGUi1PxFDY+PmSOok68rnDTAoGQ0NXU0cBa0zRI7kdbeGl1FSyYL
	 4plLqY8BHClhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 07/10] selftests: mptcp: connect: enhance TCP ULP testing
Date: Tue, 18 Nov 2025 12:01:28 +0800
Message-ID: <173a27421099de5c9f79a2e8f2ac55c5bbab073a.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Improve sock_test_tcpulp() function to properly validate TLS ULP
setup on MPTCP sockets. The updated logic verifies that TLS can be
correctly configured based on the socket protocol type and state.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b82df82e0594..deafcff7a2c8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -33,6 +33,7 @@
 #include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
+#include <linux/mptcp.h>
 
 extern int optind;
 
@@ -272,7 +273,7 @@ static int do_ulp_so(int sock, const char *name)
 }
 
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
-static void sock_test_tcpulp(int sock, int proto, unsigned int line)
+static void sock_test_tcpulp(int sock, int proto, int r, unsigned int line)
 {
 	socklen_t buflen = 8;
 	char buf[8] = "";
@@ -285,11 +286,11 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (strcmp(buf, "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
 		ret = do_ulp_so(sock, "tls");
-		if (ret == 0)
+		if (ret != r)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
 		ret = do_ulp_so(sock, "tls");
-		if (ret != -1)
+		if (ret != r)
 			X("setsockopt");
 	}
 
@@ -300,7 +301,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 #undef X
 }
 
-#define SOCK_TEST_TCPULP(s, p) sock_test_tcpulp((s), (p), __LINE__)
+#define SOCK_TEST_TCPULP(s, p, r) sock_test_tcpulp((s), (p), (r), __LINE__)
 
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
@@ -325,7 +326,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		if (sock < 0)
 			continue;
 
-		SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+		SOCK_TEST_TCPULP(sock, cfg_sock_proto, -1);
 
 		if (-1 == setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one,
 				     sizeof(one)))
@@ -352,7 +353,7 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		return sock;
 	}
 
-	SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+	SOCK_TEST_TCPULP(sock, cfg_sock_proto, -1);
 
 	if (listen(sock, 20)) {
 		perror("listen");
@@ -360,11 +361,20 @@ static int sock_listen_mptcp(const char * const listenaddr,
 		return -1;
 	}
 
-	SOCK_TEST_TCPULP(sock, cfg_sock_proto);
+	SOCK_TEST_TCPULP(sock, cfg_sock_proto, -1);
 
 	return sock;
 }
 
+static int is_mptcp(int fd)
+{
+	struct mptcp_info info;
+	socklen_t optlen;
+
+	optlen = sizeof(info);
+	return getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &optlen);
+}
+
 static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto,
 			      struct addrinfo **peer,
@@ -388,7 +398,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			continue;
 		}
 
-		SOCK_TEST_TCPULP(sock, proto);
+		SOCK_TEST_TCPULP(sock, proto, -1);
 
 		if (cfg_mark)
 			set_mark(sock, cfg_mark);
@@ -425,7 +435,7 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 
 	freeaddrinfo(addr);
 	if (sock != -1)
-		SOCK_TEST_TCPULP(sock, proto);
+		SOCK_TEST_TCPULP(sock, proto, is_mptcp(sock));
 	return sock;
 }
 
@@ -1197,7 +1207,7 @@ int main_loop_s(int listensock)
 				xerror("can't open %s: %d", cfg_input, errno);
 		}
 
-		SOCK_TEST_TCPULP(remotesock, 0);
+		SOCK_TEST_TCPULP(remotesock, 0, 0);
 
 		memset(&winfo, 0, sizeof(winfo));
 		err = copyfd_io(fd, remotesock, 1, true, &winfo);
@@ -1371,7 +1381,7 @@ int main_loop(void)
 again:
 	check_getpeername_connect(fd);
 
-	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+	SOCK_TEST_TCPULP(fd, cfg_sock_proto, -1);
 
 	if (cfg_rcvbuf)
 		set_rcvbuf(fd, cfg_rcvbuf);
-- 
2.51.0

