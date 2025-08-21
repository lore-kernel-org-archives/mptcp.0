Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DF2E8B76
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766546; cv=none; b=UOqo63CcnBZA780mNEp9YBIuXXSODVQ2ryiv+t7HIJnP0DQ/nUfkrxXmDkx/VxqxS7aIe6khfplaJQikZj5c/f6SjDy6N+8DP/XCMLRwBflbY7bxoB+dj4zcq6NH02FujAU0gDwzJB4zgQxePP8VgmfHtzj0SR7J11PctiY0vM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766546; c=relaxed/simple;
	bh=vSKyIEbQYvUT9+M/dK7eMKPXnScz8yekPL97TpMiNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKN2iHSGEIeYPvUHbC3XzRk9nCucRDBGEes6dtTRc76BEo0+vhrm7tb9tqlDQ3OPSBXNz1zq0Z3/C6++d4PuwwoIHM+/dhbMsPUaHsj/gCz5uOQs4su8CrhzAD+bRrfX0M031ymGHJ/QQQqGrtkSV817I3tkJ4EgtKwVVsBjEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvucpXSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvucpXSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496DEC4CEED;
	Thu, 21 Aug 2025 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766545;
	bh=vSKyIEbQYvUT9+M/dK7eMKPXnScz8yekPL97TpMiNUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvucpXSPvs51VcJ29RZDOM5U+JG+r4eM8rXCEkHmdF0A0fECxQpI/9iafpMPv+x1p
	 3ij1I0JuIpyWEFdgtYHa5IIgN+4O19N8TtUTZUxINxUqPaZ7X0+O2wuoKAVcTGRurC
	 PpmbvweKgYidSRIAN4pkvkPNHWz4QaKvQv3G9pAvWSM/x9JJSozJfs1+IMJCL5UPqY
	 23I+4NUon8a9Ufd6FoOG+XB8BOs/23WuaMhivK8ZpLCt6/UDPhoIXfzraInLarhJkP
	 7HpEJNVinGhUpReKXJThU8HBbzdt9kp3Z3cYnwAd1X6U+XWcrUUe7oKaFWi0wJiQbM
	 JQaPanWt5JMwQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 09/10] selftests: mptcp: sockopt: add IP_LOCAL_PORT_RANGE test
Date: Thu, 21 Aug 2025 16:54:57 +0800
Message-ID: <ccc5f059b0548d68c4c4333467c25b60e791b94b.1755680616.git.tanggeliang@kylinos.cn>
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

Add tests for IP_LOCAL_PORT_RANGE:
- Sets port range to 30000-31000
- Verifies the range via getsockopt
- Covers both IPv4 and IPv6
- Reports results in test script

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 25 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 +++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ca1a40492aa4..25074e5b4eaa 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -262,6 +262,15 @@ static void do_setsockopt_bind_address_no_port(int fd)
 		perror("setsockopt(IP_BIND_ADDRESS_NO_PORT)");
 }
 
+static void do_setsockopt_local_port_range(int fd)
+{
+	uint32_t port_range = (31000 << 16 | 30000); // [30000 - 31000]
+
+	if (setsockopt(fd, SOL_IP, IP_LOCAL_PORT_RANGE, &port_range,
+		       sizeof(port_range)))
+		perror("setsockopt(IP_LOCAL_PORT_RANGE)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
@@ -271,6 +280,7 @@ static void do_setsockopts(int fd)
 	do_setsockopt_freebind(fd);
 	do_setsockopt_transparent(fd);
 	do_setsockopt_bind_address_no_port(fd);
+	do_setsockopt_local_port_range(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -734,6 +744,19 @@ static void do_getsockopt_bind_address_no_port(int fd)
 	assert(enable == 1);
 }
 
+static void do_getsockopt_local_port_range(int fd)
+{
+	uint32_t port_range;
+	socklen_t len;
+
+	len = sizeof(port_range);
+	if (getsockopt(fd, SOL_IP, IP_LOCAL_PORT_RANGE,
+		       &port_range, &len))
+		die_perror("getsockopt(IP_LOCAL_PORT_RANGE)");
+
+	assert(port_range == (31000 << 16 | 30000));
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -758,6 +781,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 	do_getsockopt_transparent(fd);
 
 	do_getsockopt_bind_address_no_port(fd);
+
+	do_getsockopt_local_port_range(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 3756b537e2a6..2016adde1553 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -273,7 +273,8 @@ do_mptcp_sockopt_tests()
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
 		   "IP_FREEBIND" "IP_TRANSPARENT" \
-		   "IP_BIND_ADDRESS_NO_PORT"; do
+		   "IP_BIND_ADDRESS_NO_PORT" \
+		   "IP_LOCAL_PORT_RANGE"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -294,7 +295,8 @@ do_mptcp_sockopt_tests()
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
 		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX" \
 		   "IPV6_FREEBIND" "IPV6_TRANSPARENT" \
-		   "IP_BIND_ADDRESS_NO_PORT"; do
+		   "IP_BIND_ADDRESS_NO_PORT" \
+		   "IP_LOCAL_PORT_RANGE"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1

