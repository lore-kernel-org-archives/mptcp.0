Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16231A054
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594030; cv=none; b=f3NpdZMu1D8tFOHyePraLrdrrPADg2kVbSlJKpa4Dr2t+u4ETZSK4YzH+VJrmO1nY9JkZgCoD7L9loFzCvu6vdCjHYJjqOTfJ5QwM/5ng6gdOYu4/OrQlBT95gWgxWz752fjInatFZkjlgS3C5TXI4KlBjOjjyxZS8JiuOUpRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594030; c=relaxed/simple;
	bh=Z1qk1/ZDPKobj+mm3LAy/LCsv+6hoaK8lxJFYM87v4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mugNHPpZFviRiQWlF4fYemIMKXzaBWZS8XG7xzeyd4AWY0E/Iwv6/pDj+3O67H66zFcgG5hbMoTG4U/z2u7vFKXswLfUvj3OiERuTT0eEwHNNZnuQwkrTyZqNSKQChbvn+C70YM7CYb2uHeY0I6PtRTrFtDYgkl13f7d8/AqInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXxfBCKG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXxfBCKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90152C113D0;
	Tue, 19 Aug 2025 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594029;
	bh=Z1qk1/ZDPKobj+mm3LAy/LCsv+6hoaK8lxJFYM87v4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXxfBCKGxVl+X3bf8CAL13GS0Q8fjWG/AMNUeRQgI75Z7ml6qLPaANjGvjO3ygPMp
	 TckCWTm/lvQmS8Ic3PARJeD5jTGZAX+4PIuIS+AQpIANJeHW8J9BIVobDulyCCrskk
	 A0aG2msxpAdCQITO0PFCj+e+xSjfeK1wGwwXqtD/XfRRpZXIHc4wgbqh9tnlo/xSH9
	 VC7eI39Au1UB8AXUtak4n4pef5Bsj1d0t7t3YpuQBVBKxa3ZcWxCU3WJJJRzmRyP5/
	 5P6RFIQpNNuMsdIekY1cdZW12DKy+1/Odaynl9bFBuYG3mGVpf9mwXpfyDUy76BjtB
	 jDGrNMQ9cNcQg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 04/11] selftests: mptcp: sockopt: add SO_BINDTODEVICE test
Date: Tue, 19 Aug 2025 17:00:10 +0800
Message-ID: <95adea00b5a39d25ffa2f02fa050ea0928c402c6.1755592822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755592822.git.tanggeliang@kylinos.cn>
References: <cover.1755592822.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++++++
 2 files changed, 33 insertions(+)

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
index 271d9777da54..948e54b50c43 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -281,6 +281,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_REUSEPORT sockopt v4"
 
+	print_title "SO_BINDTODEVICE sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_BINDTODEVICE sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -303,6 +307,10 @@ do_mptcp_sockopt_tests()
 	print_title "SO_REUSEPORT sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_REUSEPORT sockopt v6"
+
+	print_title "SO_BINDTODEVICE sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_BINDTODEVICE sockopt v6"
 }
 
 run_tests()
-- 
2.48.1

