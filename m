Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592F3839A
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042164; cv=none; b=hdVOIcQpap9LuYeeh4bTG2thZ4K+/O4pVa1LLyEz0lBVwGpgF/gnl8mDxJ6xFTQjTqVkG8sC3sRLG/0+37NyRDUgd6yUeRy0EHv2ZRHNnpY8CPycMjANRDmt6nIM90H/xRjifBEOC+LAfNKy50ZPJU3U0szgRNxNlv13B2FxNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042164; c=relaxed/simple;
	bh=2AX+Is4y3Wk3xT/v83nqHaYe/s/mHl2JO8mleHGsQ7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyLvb2hum0df5dv9BF93M9Xj+auh6HxSTEXqHsG+IZJ7fwtf7bFNtKwcFk3bzvh/qnfO4q1qBdejuuehfb3eeIqEP1HUihLteGpi7scjdkkGgkN+blP8C/2SS5xJiPKeBdx1Hpx+Sx9apuj6zWGTyPiNfjORTQ6cVWe03O8wRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW3NxLwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW3NxLwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925EEC433C7;
	Tue,  2 Apr 2024 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042164;
	bh=2AX+Is4y3Wk3xT/v83nqHaYe/s/mHl2JO8mleHGsQ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LW3NxLwojjJdAn0DwSPMZDH79oI9M/o3C5iofRG9uq82h1NfjFasCSVnWXoGT28se
	 weYMG+LOqJzGjvyUrOBgeyddgRd7a5GMaJT+uGLnDcri7xqHy9vGRQouU3QfoxSafJ
	 Fo2WWKLbHdOo9MoPZ3oUhwG0R6OaNpbq7/gT/wmBHjp+UNQvARhCc+yafMJpJFUC0+
	 pGDKvJhbh1UVdFaPzC/2GrOeDRqeYBzBvINM9kTZ9C32dmn8oGoKRwUM2nn5QFmZ/U
	 3U9z2fh0pk/dZFOzRnspdwPStkkgQvTi36ULej0TeIPKvS3L4Jf6xwuwylQTbDqO8X
	 KcClIwaSNDRPA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 01/10] Squash to "selftests/bpf: Add bpf scheduler test" 1 nonblock
Date: Tue,  2 Apr 2024 15:15:49 +0800
Message-Id: <f0b66813ae8274e5653988d80d16171508f05796.1712042049.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712042049.git.tanggeliang@kylinos.cn>
References: <cover.1712042049.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

BPF tests fail sometimes with "bytes != total_bytes" errors:

 # test_default:PASS:sched_init:default 0 nsec
 # send_data:PASS:pthread_create 0 nsec
 # send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
 # default: 3041 ms
 # server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
 # send_data:FAIL:pthread_join thread_ret:-11 \
		test_default:PASS:has_bytes_sent addr_1 0 nsec
 # test_default:PASS:has_bytes_sent addr_2 0 nsec
 # close_netns:PASS:setns 0 nsec

Here errno 11 is EAGAIN. This patch sets server socket to nonblock
to fix this. It makes BPF tests stable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6e28215d7404..d3d51aee440d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -88,6 +88,16 @@ static void cleanup_netns(struct nstoken *nstoken)
 	SYS_NOFAIL("ip netns del %s", NS_TEST);
 }
 
+static int set_nonblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL);
+
+	if (flags == -1)
+		return -1;
+
+	return fcntl(fd, flags | O_NONBLOCK);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -466,6 +476,7 @@ static void test_default(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
+	set_nonblock(server_fd);
 	send_data(server_fd, client_fd, "default");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
@@ -639,6 +650,7 @@ static void test_burst(void)
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
+	set_nonblock(server_fd);
 	send_data(server_fd, client_fd, "bpf_burst");
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
 	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
-- 
2.40.1

