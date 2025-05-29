Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECD1D5CFE
	for <mptcp@lists.linux.dev>; Thu, 29 May 2025 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491756; cv=none; b=lx3eU9E8swBR02KRS59ZRxTdgxche1YWBJMUJ/aOgcSA/Tyr5o6hCRKyUVe9We8IyddcDhj+RzgEfdsq5K9F+PrPrNZ3C5DPGEsYsNzyUAznmvR8ueNGSthcKF3kdKwgV/csTpQOvBqvqRnU6y5rYdf/bWRk/RqJq4DXMP7TZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491756; c=relaxed/simple;
	bh=7o+lpUO/lqaGtBPfi1+vrH/tb1aSUWObzvXggcn31IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv4PxCgBIjCrXJvykFBDmbentEteRUMHossL1MdxcE5+Wz4Pe14gM3AiVXpwwm0euepi4bQHrM1Z3GYeBfz2sAkZ38VtT2TxE/KNkUO7oj2gRO0DTyzz1X1lTQRWzX3LELe7cNb8JSmIu2KtON/dXzpGAxLHL5iH4usrX4CHqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXJmrS0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXJmrS0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD57CC4CEEE;
	Thu, 29 May 2025 04:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491755;
	bh=7o+lpUO/lqaGtBPfi1+vrH/tb1aSUWObzvXggcn31IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXJmrS0/hnxlht1RKLsf1xAohO9sf/KsS0Z/6tw7NGSVva3e1OX0zTMIVrvHeNQWL
	 qyUGshq8/CU+Zyy++u0uM9fMwsatJpqYai0fg9Ln+YjPD23x/iw+3aqjDP3R9bRI1G
	 eS7XU6z4GdYPUZKFhbXSfFqjxFKhGKukbK0ln2Lf5neGkl5UfclnfaGIVuDPDLt12X
	 83IY2yiLCaymHZDVWh2WFyltU8oR2ttkDVdV8CjghXefIGNNruggga2tiuZDz/8wJC
	 sn/CrsJ0ExCn3iHLpewqrZkgVKcjmgwgzPLe1MVwNrXHEbZfOqk2nKWUxizNEwGpKF
	 WHC1/Oq1x/ulg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] selftests/bpf: Add sndbuf for send_recv_data
Date: Thu, 29 May 2025 12:09:04 +0800
Message-ID: <1fce74fea292fe168a723b17fadd733e3d0e74d8.1748484770.git.tanggeliang@kylinos.cn>
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

This helper send_recv_data() is used by MPTCP BPF sched tests, but these
tests require explicit setting of sockopt SO_SNDBUF, so this patch adds
'sndbuf' parameter to this helper to set this sockopt of the accept socket.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 20 ++++++++++++++++++-
 tools/testing/selftests/bpf/network_helpers.h |  2 +-
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  4 ++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 72b5c174ab3b..9cdb80127804 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -92,6 +92,17 @@ int settimeo(int fd, int timeout_ms)
 	return 0;
 }
 
+static int setsndbuf(int fd, uint32_t sndbuf)
+{
+	if (sndbuf > 0 &&
+	    setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf))) {
+		log_err("Failed to set SO_SNDBUF");
+		return -1;
+	}
+
+	return 0;
+}
+
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
 int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
@@ -667,6 +678,7 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
+	uint32_t	sndbuf;
 	int		stop;
 };
 
@@ -690,6 +702,11 @@ static void *send_recv_server(void *arg)
 		goto done;
 	}
 
+	if (setsndbuf(fd, a->sndbuf)) {
+		err = -errno;
+		goto done;
+	}
+
 	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
 		nr_sent = send(fd, &batch,
 			       MIN(a->bytes - bytes, sizeof(batch)), 0);
@@ -718,12 +735,13 @@ static void *send_recv_server(void *arg)
 	return NULL;
 }
 
-int send_recv_data(int lfd, int fd, uint32_t total_bytes)
+int send_recv_data(int lfd, int fd, uint32_t total_bytes, uint32_t sndbuf)
 {
 	ssize_t nr_recv = 0, bytes = 0;
 	struct send_recv_arg arg = {
 		.fd	= lfd,
 		.bytes	= total_bytes,
+		.sndbuf = sndbuf,
 		.stop	= 0,
 	};
 	pthread_t srv_thread;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ef208eefd571..cc0e5f812de2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -98,7 +98,7 @@ struct nstoken;
  */
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
-int send_recv_data(int lfd, int fd, uint32_t total_bytes);
+int send_recv_data(int lfd, int fd, uint32_t total_bytes, uint32_t sndbuf);
 int make_netns(const char *name);
 int remove_netns(const char *name);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..2c35ce21a4a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -35,7 +35,7 @@ static void do_test(char *qdisc)
 	if (!ASSERT_OK_FD(cli_fd, "connect to client"))
 		goto done;
 
-	err = send_recv_data(srv_fd, cli_fd, total_bytes);
+	err = send_recv_data(srv_fd, cli_fd, total_bytes, 0);
 	ASSERT_OK(err, "send_recv_data");
 
 done:
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index b7d1b52309d0..090d876e0da4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -70,7 +70,7 @@ static void do_test(const struct network_helper_opts *opts)
 	if (!start_test(NULL, opts, opts, &lfd, &fd))
 		goto done;
 
-	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
+	ASSERT_OK(send_recv_data(lfd, fd, total_bytes, 0), "send_recv_data");
 
 done:
 	if (lfd != -1)
@@ -169,7 +169,7 @@ static void test_dctcp(void)
 			!ASSERT_EQ(errno, ENOENT, "bpf_map_lookup_elem(sk_stg_map)"))
 		goto done;
 
-	ASSERT_OK(send_recv_data(lfd, fd, total_bytes), "send_recv_data");
+	ASSERT_OK(send_recv_data(lfd, fd, total_bytes, 0), "send_recv_data");
 	ASSERT_EQ(dctcp_skel->bss->stg_result, expected_stg, "stg_result");
 
 done:
-- 
2.43.0

