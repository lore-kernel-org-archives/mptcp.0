Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A632C18D;
	Tue,  2 Apr 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039929; cv=none; b=QeeLQPF0cBBvQHNxXeJJLstcn1BuTpIQlaJmXRGcVtw/nzEJKveg/kTyJ73Q+XzRExjFR6AJw/ElJAPk9UFADoXTWeal7/hBFPTR3Iqv/niiP16ZZ13wYrruEcrB4D0aur/rhqA//qHmpVDVVaTXHXR/jLQtosfdSClk0zP1uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039929; c=relaxed/simple;
	bh=07FqalDjY1f8ndnRBogLUbwQJZBS1p4FrrU/ZXVSbH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOuR4zr/W60YVVe3u7TeHqLWcE7jhEIp9Dn1c78BTPdB8HCOxYxg1y/aOMvVtGAi4U3+xtRQ55sjblBMEaZttUrhdxqOPc0nmAdc9liFfF1xIqo5FFY1+0urU4Cg+0OIQlGNQpT9Bp4YR2WxJmGJo9uoeMmXHf8xpaggQNsE/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUMVw03A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUMVw03A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BBEC433F1;
	Tue,  2 Apr 2024 06:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712039928;
	bh=07FqalDjY1f8ndnRBogLUbwQJZBS1p4FrrU/ZXVSbH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUMVw03AH4opNHDI5JCOELrs0SDEdJJoO/HspKh6/ZtAyKpd2KcrcKeud3OmumcZm
	 04ybroCvLoClh6SVIJPMRTwd+J/RrD7tqFAymOy6vMiZnS8aJKS2PO9KIQdIZp/qMv
	 Q2gDJGzsZFBlVbaGR+P7ZmGvovBX/0YFHWIaPw4ucDcGG6VJv1Gkr6l6o9HXvKj2e8
	 RDUkZcmy0IcCPIMNnpvQaF+ALpvJ6x2gKfg4IyJ8K5qZg+TrMYF0lLMTDaJ8Wb8k+z
	 gVnyNhz5SeXcm6hrzvI3tAmURlkY3TiegBEO4+YSWf8PnXdSX5b02fOqt+Skf2Pqt0
	 zpD8vZSU31YMQ==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next 1/3] selftests/bpf: Export send_byte helper
Date: Tue,  2 Apr 2024 14:38:27 +0800
Message-Id: <4daa40f84a7b9e506bb21c4dcbccdcf1db8fc750.1712039441.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712039441.git.tanggeliang@kylinos.cn>
References: <cover.1712039441.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper send_byte is defined in mptcp.c, sk_lookup.c and tcp_rtt.c.
It makes sense to export it into network_helpers.h to let it can be
used for all BPF selftests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c      |  9 +++++++++
 tools/testing/selftests/bpf/network_helpers.h      |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |  7 -------
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 13 -------------
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   |  7 -------
 5 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db27a9088e9..f2f8f7388d7c 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -497,3 +497,12 @@ int get_socket_local_port(int sock_fd)
 
 	return -1;
 }
+
+int send_byte(int fd)
+{
+	char b = 0x55;
+
+	if (!ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte"))
+		return -1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 94b9be24e39b..d7ee2857093c 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -71,6 +71,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
+int send_byte(int fd);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8f8d792307c1..bff13ecec64c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -225,13 +225,6 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
-static void send_byte(int fd)
-{
-	char b = 0x55;
-
-	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
-}
-
 static int verify_mptcpify(int server_fd, int client_fd)
 {
 	struct __mptcp_info info;
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..b4310a5ec1a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -282,19 +282,6 @@ static int fill_sk_lookup_ctx(struct bpf_sk_lookup *ctx, const char *local_ip, _
 	return 0;
 }
 
-static int send_byte(int fd)
-{
-	ssize_t n;
-
-	errno = 0;
-	n = send(fd, "a", 1, 0);
-	if (CHECK(n <= 0, "send_byte", "send")) {
-		log_err("failed/partial send");
-		return -1;
-	}
-	return 0;
-}
-
 static int recv_byte(int fd)
 {
 	char buf[1];
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index 8fe84da1b9b4..dcb2d5e9c8db 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -12,13 +12,6 @@ struct tcp_rtt_storage {
 	__u32 icsk_retransmits;
 };
 
-static void send_byte(int fd)
-{
-	char b = 0x55;
-
-	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
-}
-
 static int wait_for_ack(int fd, int retries)
 {
 	struct tcp_info info;
-- 
2.40.1

