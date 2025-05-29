Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2C1D5CFE
	for <mptcp@lists.linux.dev>; Thu, 29 May 2025 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491759; cv=none; b=RPniypHANhMRcQ+UlI0O38U3Lyyff4he4hSC9E+BCgahAJJbWm0TEGbFi+H8wI/j0M1uYY0wuimaC3P8btjuEl917IiPr/IieMg5OjNoOjvmQCEWIYTwhvpmBYtISACyRphgDu8VQK4/YzSh6dcI2qYmjOoqQZmBQlBF+wQ9SoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491759; c=relaxed/simple;
	bh=S9DWn45rd1Gl5UFviND2SaCaiqBYSJ6aCu6pz2elKiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDW7YH0dUPd39sSIatGv9W6qfrnHOsZ3/SY1q4ITdLCINGZTgjzl4VQPAbh0AZIKamYAlvw8WeXi5nbbQ9NRGzqYzwwpP0k0M7dy9CcQ42+uiG8zdo3LC9nhutCgug+n0xXw/OWQLzRODbTXoYB6dgatvBPKHhlLIl6NeXK07B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my4Rn8/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my4Rn8/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F91AC4CEEA;
	Thu, 29 May 2025 04:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491756;
	bh=S9DWn45rd1Gl5UFviND2SaCaiqBYSJ6aCu6pz2elKiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=my4Rn8/wvAeGqbHhdrOIWMrSO593vdlA2XftQ27v80bllSHrwUPA5ETgLNWvQe2CM
	 24v7BZcD5PNGhBhVIPabL16VkaR/xqaeWvvuh+Okxg60zNO7DtnIvJiJk/jbPufRRz
	 ur3BflEhaYlj+v2pnvUUzj6M9/chfX73yefe0CxB5RG8A/JO3piqQ4AyvlYfgEdqYx
	 dnlH8rz3vV119nhd7vutzQObHqtojJl3Ox87s/Thpv1AwJOdA6c8TiNwxCr6lQ17CB
	 BpNPgoZBpP1SH9m2PdEwJxC+Pdy3c57RGW3QETMoL0wbOaHju6eLMkdXflN8wzPlzq
	 jb2QCrL0EZ0IA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/3] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu, 29 May 2025 12:09:05 +0800
Message-ID: <2904b1a5d923ca8de14475a833da6edab3fa1582.1748484770.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748484770.git.tanggeliang@kylinos.cn>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

BPF tests fail sometimes (a probability of approximately 1%) with
"bytes != total_bytes" errors:

 test_burst:PASS:open_and_load:burst 0 nsec
 test_bpf_sched:PASS:Scheduler name too long 0 nsec
 test_bpf_sched:PASS:burst 0 nsec
 create_netns:PASS:ip netns add mptcp_ns 0 nsec
 create_netns:PASS:ip -net mptcp_ns link set dev lo up 0 nsec
 sched_init:PASS:create_netns 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns link add veth1 type veth peer name
 endpoint_init:PASS:ip -net mptcp_ns addr add 10.0.1.1/24 dev veth1 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns link set dev veth1 up 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns addr add 10.0.1.2/24 dev veth2 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns link set dev veth2 up 0 nsec
 endpoint_init:PASS:ip -net mptcp_ns mptcp endpoint add 10.0.1.2 subflow
 sched_init:PASS:endpoint_init 0 nsec
 test_bpf_sched:PASS:burst 0 nsec
 send_data_and_verify:PASS:burst 0 nsec
 send_data_and_verify:PASS:burst 0 nsec
 (network_helpers.c:613: errno: Resource temporarily unavailable) \
                                        send 5608500 expected 10485760
 (network_helpers.c:661: errno: None) recv 2755984 expected 10485760
 (network_helpers.c:669: errno: None) Failed in thread_ret -11
 send_data_and_verify:FAIL:send_recv_data unexpected error: -4 (errno 0)
 multipath-tcp#162/9   mptcp/burst:FAIL
 multipath-tcp#162     mptcp:FAIL

This patch fixes this issue by setting SO_SNDBUF, while deliberately not
setting SO_RCVBUF.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 7c51250e7161..5402d42335c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -590,6 +590,8 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 	struct timespec start, end;
 	int server_fd, client_fd;
 	unsigned int delta_ms;
+	unsigned int rcvbuf;
+	socklen_t optlen;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
@@ -602,7 +604,14 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
 		goto fail;
 
-	if (!ASSERT_OK(send_recv_data(server_fd, client_fd, total_bytes),
+	optlen = sizeof(rcvbuf);
+	if (getsockopt(server_fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, &optlen) < 0)
+		goto fail;
+
+	if (setsockopt(server_fd, SOL_SOCKET, SO_SNDBUF, &rcvbuf, sizeof(rcvbuf)) < 0)
+		goto fail;
+
+	if (!ASSERT_OK(send_recv_data(server_fd, client_fd, total_bytes, rcvbuf),
 		       "send_recv_data"))
 		goto fail;
 
-- 
2.43.0

