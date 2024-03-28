Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A55FBA7
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619415; cv=none; b=neCBQbFz3UIhXLRKnz7Peg99pz0s3yZgJ0VJxWwq9hXFNO0LvSIRdzWkFW3qHiEdd3oJbVusCmgfnSCrlxuDgv479AR5CbfFqU/pmQV6+9xMfdIxd0J+t10WjaBnk2othsbSQhcplaSglqhp1fHGXEdUNydO+DFrFNbT6GmtCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619415; c=relaxed/simple;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmvIC8t66/A92PFvknBBm5Qrx81Uc0TepX/OS1PprENZa5KiMLka+GvMrKwUnySgJsxV7X6s6D69DqCZZzGccmK23+7OkOjKFCy/hGAuFVCN2LPfFrumMowypesNERX0MLit9eAyQ3z1nKA/pnu2Fh2bdEhLLXauq0KvSpllkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9wHa5PP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9wHa5PP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843FDC433C7;
	Thu, 28 Mar 2024 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619415;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9wHa5PPmnKSRlvLm1N6kssz6qvNT0Qu/V/7w+LK0C0rZFwKgya7qHAx1B9J7gFwY
	 K6kdSa/1EjInQkACSdQ8b2aX+0zSP7LJ+cZJV9cktJqFeQ1WViDu9f1T4KWySDxkFL
	 umSsYXrKqE+SltwBV+FZyTD5QSNUUEErcO2FTBjbI8rG+rERvZrV+JY0OgnklnMvYM
	 GAmoy159o/8Ogk7lWsI4JHGtbX+U6f5oEdMwWofsuEsOJXrtrpFXFDm1mqGf8BeSQy
	 u2M0anP66ub5VQhR3Ta4nCTMoE5Z1wwFxpBYCodvBY3KhEwDNXyvWu5ygXWWlMLXpk
	 LJGmXSOn4wfrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 01/11] Squash to "selftests/bpf: Add bpf scheduler test" - fix
Date: Thu, 28 Mar 2024 17:49:58 +0800
Message-Id: <0e49cdf987fe33ca8e6f1531da34874c3a750851.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
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

