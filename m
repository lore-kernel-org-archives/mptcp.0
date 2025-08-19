Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFF22424E
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594031; cv=none; b=s5wq+MfYIYCXBxgqGPgqraQBPEzaW8ThbL7Fx5bI+Et8W93N6bV8IOyTZCyhh+pkIeVRPESAOJHD1iyhFxjOHbDuRQ/+uwkjmuPWCfuDOitCOcZ4A/VGgQqLnzW1pg2tV1F+RAVACSS92bD6ER2mag7FBoOsiRAvbH+aQtr8qf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594031; c=relaxed/simple;
	bh=J87gRu+lhUbmNeEj0rm9Cx+3jrK/nERyWETPs/7IZWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLqQIg8kIfNSjoc1WJKXQdk7YbRv+c2UsRw6MIsHjTJqkMoh+WSfrqj7BfqMnkInW6kWW6qi9lQ1+RcL5PsdiCyFlzRs2OEL/lTqG9AOD1Btha0veN3N7u53cYcSblBdrivWZJgPdk8I8P0OdR37CHAkoksNPSwq3KPqU71ZnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fha2bkCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fha2bkCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DCFC116B1;
	Tue, 19 Aug 2025 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594031;
	bh=J87gRu+lhUbmNeEj0rm9Cx+3jrK/nERyWETPs/7IZWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fha2bkCP2BzfX+2tup/KBV76RLmaa9z3GFi+GY6oe/z6cPg4CCt8Lo5Np4HpURgD0
	 kwkbXb45AlvsLVecBLIugfq6lWnDIAZxRWO7IgEJpS+sG+HAZNmzMDZ1BB6bGhKnLN
	 nYVO/cDk4rvGbN9nZKNA1qhjxsvwAIvms08dMNoaPeuUuDMyZwUN5qFXnv7uQjysJJ
	 2R0S0DV9OE/p3jTbnKKfBbaZWFXMtTh0xBVHfko3H9tDHtb1sRZzNAaR68UF9TZouH
	 qRoFG53EZSi8Q0F6QV2tWyTj7hGr3vC7XuoI4LvRWvFgeWmoZMIKNQI1rQI2TMLW3w
	 AMHeCNcImqnEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 05/11] selftests: mptcp: sockopt: add SO_BINDTOIFINDEX test
Date: Tue, 19 Aug 2025 17:00:11 +0800
Message-ID: <0888dbece9afe24eab9e838fec4d3809d2afc3e5.1755592822.git.tanggeliang@kylinos.cn>
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

Implement tests for the SO_BINDTOIFINDEX socket option:
- Uses ioctl to get the loopback interface index
- Sets the option to bind to "lo"
- Validates the bound index via getsockopt
- Supports both IPv4 and IPv6

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 41 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 ++++
 2 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index df4f85f129f7..25456e540cad 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -208,11 +209,36 @@ static void do_setsockopt_bindtodevice(int fd)
 		perror("setsockopt(SO_BINDTODEVICE)");
 }
 
+static int get_ifindex(int fd, const char *ifname)
+{
+	struct ifreq ifr;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
+
+	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0) {
+		perror("ioctl");
+		return -1;
+	}
+
+	return ifr.ifr_ifindex;
+}
+
+static void do_setsockopt_bindtoifindex(int fd)
+{
+	int ifindex = get_ifindex(fd, "lo");
+
+	if (setsockopt(fd, SOL_SOCKET, SO_BINDTOIFINDEX,
+		       &ifindex, sizeof(ifindex)))
+		perror("setsockopt(SO_BINDTOIFINDEX)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
 	do_setsockopt_reuseport(fd);
 	do_setsockopt_bindtodevice(fd);
+	do_setsockopt_bindtoifindex(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -622,6 +648,19 @@ static void do_getsockopt_bindtodevice(int fd)
 	assert(!memcmp(ifname, "lo", len));
 }
 
+static void do_getsockopt_bindtoifindex(int fd)
+{
+	socklen_t len;
+	int ifindex;
+
+	len = sizeof(ifindex);
+	if (getsockopt(fd, SOL_SOCKET, SO_BINDTOIFINDEX,
+		       &ifindex, &len))
+		die_perror("getsockopt(SO_BINDTOIFINDEX)");
+
+	assert(ifindex == get_ifindex(fd, "lo"));
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -638,6 +677,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_reuseport(fd);
 
 	do_getsockopt_bindtodevice(fd);
+
+	do_getsockopt_bindtoifindex(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 948e54b50c43..8eae13f4da38 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -285,6 +285,10 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_BINDTODEVICE sockopt v4"
 
+	print_title "SO_BINDTOIFINDEX sockopt v4"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_BINDTOIFINDEX sockopt v4"
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
@@ -311,6 +315,10 @@ do_mptcp_sockopt_tests()
 	print_title "SO_BINDTODEVICE sockopt v6"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "SO_BINDTODEVICE sockopt v6"
+
+	print_title "SO_BINDTOIFINDEX sockopt v6"
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "SO_BINDTOIFINDEX sockopt v6"
 }
 
 run_tests()
-- 
2.48.1

