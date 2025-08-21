Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736212ED17C
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766532; cv=none; b=QdP718WJyqomIdPSsAMlIQtdp6qhAn6rJ6E2vhKGY0FCYTMsrRoAvPlxezn/8UHMNY3A1COzsnspjA0A6xzbnK9WSaKXu7GQUxBpDtzyDcAfr0WnwkGqDimgZhaNWOkMojPW8GN2BES2Lrib5ddU+Y8/cnGm7Bxr8hqd25s7exs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766532; c=relaxed/simple;
	bh=S7Wm5LTpWey4533Hju75/uKS8sfaxxKDlRnQkeNo/OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6DnLi4g14m09YaFFijr8ArKUWUiCIYAe6MskwD2Y7w+Pjj11nmvPnogP1xVPBbhPb/oYNcwZxdfRIx3aFSKBpxt7LE65/YF2chb9oNGE3z6bEb7TKiinMOhwjufhJrXgRk66Us64WuhG8Q8+36me5Yq1j1rRijcxopylvKLey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7AqbKfP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7AqbKfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EBBC4CEEB;
	Thu, 21 Aug 2025 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766532;
	bh=S7Wm5LTpWey4533Hju75/uKS8sfaxxKDlRnQkeNo/OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7AqbKfPID6YZZzxW5DdejrUx77C2ZK2ijeOWZ2Fd+B9vuJuHyTWPlA+P8ZbANRRW
	 QEhR8Z5J4PwlCvC6EZm/j41/Mx0etNdfe0wrrB7/hqfd0GjrB4tgpzL+cwxYu2arXB
	 S88j6PN0X9SY4EU+mMPFn4zptizvoL9TpLr7szq0qfNNRLdWYdbo6PshjnYOg2KBD0
	 8bYeBFVWeooTpoGtl7aVZa6FIGL7CYP0LVAQ8HTtH1R/zlZ06/XAfCnqv7QpLQIOKa
	 f1nKK42u03vrck5g1dDnMLWeyGHjAnM4J6gcOXzoRdKj+6z33U1B+kbI5kg8HK0wAQ
	 2cbNHcFeoyxKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 03/10] selftests: mptcp: sockopt: add SO_REUSEPORT test
Date: Thu, 21 Aug 2025 16:54:51 +0800
Message-ID: <21b4afc199156967b6d35ff4ff97cd038a35b800.1755680616.git.tanggeliang@kylinos.cn>
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

Implement comprehensive testing for the SO_REUSEPORT socket option:
- Setsockopt and getsockopt helpers for SO_REUSEPORT
- Verification of the set value
- Integration into both client/server workflows
- IPv4 and IPv6 test coverage

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 23 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  4 ++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index a91709aeca06..816d71706f7d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -190,9 +190,18 @@ static void do_setsockopt_reuseaddr(int fd)
 		perror("setsockopt(SO_REUSEADDR)");
 }
 
+static void do_setsockopt_reuseport(int fd)
+{
+	int one = 1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)))
+		perror("setsockopt(SO_REUSEPORT)");
+}
+
 static void do_setsockopts(int fd)
 {
 	do_setsockopt_reuseaddr(fd);
+	do_setsockopt_reuseport(fd);
 }
 
 static int sock_listen_mptcp(const char * const listenaddr,
@@ -578,6 +587,18 @@ static void do_getsockopt_reuseaddr(int fd)
 	assert(reuse == 1);
 }
 
+static void do_getsockopt_reuseport(int fd)
+{
+	socklen_t len;
+	int reuse;
+
+	len = sizeof(reuse);
+	if (getsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &reuse, &len))
+		perror("getsockopt(SO_REUSEPORT)");
+
+	assert(reuse == 1);
+}
+
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
 	do_getsockopt_mptcp_info(s, fd, w);
@@ -590,6 +611,8 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 
 	do_getsockopt_reuseaddr(fd);
+
+	do_getsockopt_reuseport(fd);
 }
 
 static void connect_one_server(int fd, int pipefd)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index da6c261275ec..1c357ed757d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -270,7 +270,7 @@ do_mptcp_sockopt_tests()
 	fi
 
 	for opt in "SOL_MPTCP" \
-		   "SO_REUSEADDR"; do
+		   "SO_REUSEADDR" "SO_REUSEPORT"; do
 		print_title "$opt sockopt v4"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v4"
@@ -288,7 +288,7 @@ do_mptcp_sockopt_tests()
 	fi
 
 	for opt in "SOL_MPTCP" \
-		   "SO_REUSEADDR"; do
+		   "SO_REUSEADDR" "SO_REUSEPORT"; do
 		print_title "$opt sockopt v6"
 		mptcp_lib_pr_ok
 		mptcp_lib_result_pass "$opt sockopt v6"
-- 
2.48.1

