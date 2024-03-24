Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EE18638
	for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296128; cv=none; b=dT1ox9GK+Ffr31CJ7XGit7hgo62vn7v7s6Lj3lqloLhYyYYrSsWN/j0L2SxU3OYUejuqrh/s6g/G24Nq1V2pNgDwffm1RWyRXVEhvE7+Ype8pRELEMh972JJfl4DQg51W6W1ETNyqC6t75PeBqxhxTp18/jhnp/sWQ3oSQAIY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296128; c=relaxed/simple;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bqsh+i8Vfgrxgx4qTm3NNFw54NDtlF/6dBHUKJ0aJcliBP53V6Je2+UsPwoeOUaFiRqqletlTl97wq4MnIJcE7ZiprspD8lmFOeqgNwiNkBtqWzX+tJ81pzzsmaGbE72gt9gUNGAwCec7L/y2K1NRttfCdncZSC/EKhAtmlichw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTeOm+Aw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTeOm+Aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633EAC43390;
	Sun, 24 Mar 2024 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711296127;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTeOm+Aws61sPh8zivc2imA1dVzOQA8PuE+0UplPBsizMpK0YOOZkvv+eemTdQIiP
	 NeZdNKLrJl9QWxUwT95f9GZINabCCkfhq2awXkBG/nIn+lLna2/p16toKLob5Tm3sW
	 YFF4K98XZ5c/PMrQQjYsM2BxeElwSg9fBS4mCJGTTC4ROpPXZK4KnG+EgXdUuB69eW
	 oy+y8dFO9RdRU0h08F/h6e/aJL9PXb63VEClPGvtIwsKK/EzF2LvDBpy9v9kGHQQdM
	 H2PEWT3TCDs6QUzC4+zXBOo8qbGiJAj7Du+Umz7iRi6WPAYGoGUWs3b2rBhu11am+4
	 oxv9O3RmnHA8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/4] Squash to "selftests/bpf: Add bpf scheduler test" fix
Date: Mon, 25 Mar 2024 00:01:14 +0800
Message-Id: <311e074a3ca0465bdc5e4c2283e334bae5ccd306.1711296000.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711296000.git.tanggeliang@kylinos.cn>
References: <cover.1711296000.git.tanggeliang@kylinos.cn>
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

Here errno 11 is EAGAIN, sending should continue in this case, not break.
This patch makes BPF tests stable.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6e28215d7404..7fec91ab19cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -353,7 +353,7 @@ static void *server(void *arg)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_sent = send(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_sent == -1 && errno == EINTR)
+		if (nr_sent == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_sent == -1) {
 			err = -errno;
@@ -397,7 +397,7 @@ static void send_data(int lfd, int fd, char *msg)
 	while (bytes < total_bytes && !READ_ONCE(stop)) {
 		nr_recv = recv(fd, &batch,
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
-		if (nr_recv == -1 && errno == EINTR)
+		if (nr_recv == -1 && (errno == EINTR || errno == EAGAIN))
 			continue;
 		if (nr_recv == -1)
 			break;
-- 
2.40.1

