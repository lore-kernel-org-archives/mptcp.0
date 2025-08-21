Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D782ED16B
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766534; cv=none; b=RC9+kL3hmAsOa+zWoN88ACBXeWDHrRDDUYPEHIT/igMeUEK+osIR1ejdjWlsONswWQBNfWxOjRvl3d0z2Y19P/0csjhS8K8ysiZUZYUOHmrJYQ0CTGVMFpN02yYw6B7Y6KEeGY42DHDCPCBXk7KxIsnYkXr8iVRgqyOefIALpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766534; c=relaxed/simple;
	bh=8Oa2j0c9SE1226y5Dsdgh9OiCdu8wEI23v3te89Oh1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9epD97IVt/DLE3VsE501F9jL3FVkfucryzzcssq7mtpbsICv+XsMpjPJkaIVP/yAmS5FmWD4VzvPoxJidw3jrxLPCkAX5Yey7IiVKZNGT2j/dWET0LX39mugvPI80IVV1o1ZL0Bob/+3oMljlK8CSWXZRwAEIhw6alHjJHyHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt0LpSPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt0LpSPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A57C4CEEB;
	Thu, 21 Aug 2025 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766533;
	bh=8Oa2j0c9SE1226y5Dsdgh9OiCdu8wEI23v3te89Oh1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qt0LpSPOUaWtU62sjiav9LB96z3b5w4dA35X1lYazurA6G4XBzk8sON2fQT33/IXj
	 MYOBya7V9OkDkM3Pvf/C+y55i2eNO2ngEZSKoMFz6NuMj3cNPoxD35oEAaT3Vh0aVU
	 QqPhto/HTMcaPkjjtHGJ+2pIJtmxXtiHDdeEItdA++Dh7f7n9pnaogIan719PY6z5P
	 u+D4CBRVHOKAYxKoJ1lzG0QCHYbJW5wxceJFZL0Nj4cktBjYR8E1CN6cw4UoqIPk4Q
	 kUR9jK745P3/0/CnmPijoVTV5njiRyfBaXWSc/OLftZfK0jQ8WRYJWKB/KdY6paKRY
	 Al7CXR/zXHqYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 04/10] selftests: mptcp: sockopt: add SO_BINDTODEVICE test
Date: Thu, 21 Aug 2025 16:54:52 +0800
Message-ID: <cae15fa4d115782c7c98429b3f7ea3c9bcf73679.1755680616.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755680616.git.tanggeliang@kylinos.cn>
References: <cover.1755680616.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add tests for the SO_BINDTODEVICE socket option:
- Binds sockets to the loopback device ("lo")
- Verifies the binding via getsockopt
- Includes IPv4 and IPv6 test cases
- Reports results explicitly in the test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 +++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 816d71706f7d..df4f85f129f7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -23,6 +23,7 @@
 
 #include <netdb.h>
 #include <netinet/in.h>
+#include <net/if.h>
 
 #include <linux/tcp.h>
 
@@ -198,10 +199,20 @@ static void do_setsockopt_reuseport(int fd)
 		perror("setsockopt(SO_REUSEPORT)");
 }
 
+static void do_setsockopt_bindtodevice(int fd)
+{
+	const char *interface = "lo";
+
+	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE,
+		       interface, strlen(interface)))
+		perror("setsockopt(SO_BINDTODEVICE)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
 	do_setsockopt_reuseport(fd);
+	do_setsockopt_bindtodevice(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -599,6 +610,18 @@ static void do_getsockopt_reuseport(int fd)
 	assert(reuse == 1);
 }
 
+static void do_getsockopt_bindtodevice(int fd)
+{
+	char ifname[IFNAMSIZ] = { 0 };
+	socklen_t len;
+
+	len = sizeof(ifname);
+	if (getsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, ifname, &len))
+		die_perror("getsockopt(SO_BINDTODEVICE)");
+
+	assert(!memcmp(ifname, "lo", len));
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -613,6 +636,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_reuseaddr(fd);
 
 	do_getsockopt_reuseport(fd);
+
+	do_getsockopt_bindtodevice(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1c357ed757d6..44342ce6fd16 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -270,7 +270,8 @@ do_mptcp_sockopt_tests()
 	fi
 
 	for opt in "SOL_MPTCP" \
-		   "SO_REUSEADDR" "SO_REUSEPORT"; do
+		   "SO_REUSEADDR" "SO_REUSEPORT" \
+		   "SO_BINDTODEVICE"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -288,7 +289,8 @@ do_mptcp_sockopt_tests()
 	fi
 
 	for opt in "SOL_MPTCP" \
-		   "SO_REUSEADDR" "SO_REUSEPORT"; do
+		   "SO_REUSEADDR" "SO_REUSEPORT" \
+		   "SO_BINDTODEVICE"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1

