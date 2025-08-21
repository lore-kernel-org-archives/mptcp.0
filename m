Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21C2E8B76
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766538; cv=none; b=kgcBfiGVjhJi6E0Iy6TmD9JAo38whOdE29GSDQCkX5XlGHvbMBAejiNLCGvCpSbUbgATwzHo8hQED46JfdyMDz5bu0h8+xeB+JeMVDmJDcJV4/+5ymgMF1Hr3N/jk1XxrjYISEXObjnKlzMFcKoBAPLhxEJnv0Zd4ADS+TRrzo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766538; c=relaxed/simple;
	bh=0j56qtVM1KDCgWYeMP865w/A8yzjyoXgwi+eP5xbJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNKY9UYSiN0j40abCPUwcw8+2xTBYOxE/Kaknbe0d0mp7WgP/sJwZdoPDslUO5wmGGrWcOtK5vFjt1axJsEu4n/6dNyOt/urSMISZALEv1ctxMardbLvR/Sw3KaKLf+rV2w6JkuV19xLjx4Nrn1VDnHlssNtFvKUYR7f/gpCV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaOG4kx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaOG4kx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D807C4CEED;
	Thu, 21 Aug 2025 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766535;
	bh=0j56qtVM1KDCgWYeMP865w/A8yzjyoXgwi+eP5xbJyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaOG4kx/q1LDqct4Tpz27yqsXHszPZdWGb5qKUKMgQoWSzUaBMAFbx3MIRe3bpHWS
	 bcAk0ut2yghYCHstQ6HSGISP9I4+Www0t5UOZN6W9eSrAkqQHiilDLWvGWJao7LSl9
	 h/I7pIufkrD1juHVlSiIZHXakd7aGSMDzzoiiTX/L6BGVJU1tP1rJyBJPXwt5AYKJa
	 XtRk3dVY6Lu4ZxDWTsbqGf2vN5y4t0XZNee0DAJ17OTOGuuT1vmo4OD4P25vmJP7GI
	 CTFkpZofBdZraRrI1u8A3tis5al1p81GaKx1JBwswT6v3kckkU4IC4TuiPyEDksC33
	 HoGWh1HSsrFlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 05/10] selftests: mptcp: sockopt: add SO_BINDTOIFINDEX test
Date: Thu, 21 Aug 2025 16:54:53 +0800
Message-ID: <91ec59691a0dae607baa6f6260643b1617483c6c.1755680616.git.tanggeliang@kylinos.cn>
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

Implement tests for the SO_BINDTOIFINDEX socket option:
- Uses ioctl to get the loopback interface index
- Sets the option to bind to "lo"
- Validates the bound index via getsockopt
- Supports both IPv4 and IPv6

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 41 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  4 +-
 2 files changed, 43 insertions(+), 2 deletions(-)

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
index 44342ce6fd16..7f2effd82af8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -271,7 +271,7 @@ do_mptcp_sockopt_tests()
 
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
-		   "SO_BINDTODEVICE"; do
+		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -290,7 +290,7 @@ do_mptcp_sockopt_tests()
 
 	for opt in "SOL_MPTCP" \
 		   "SO_REUSEADDR" "SO_REUSEPORT" \
-		   "SO_BINDTODEVICE"; do
+		   "SO_BINDTODEVICE" "SO_BINDTOIFINDEX"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1

