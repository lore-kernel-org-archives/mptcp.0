Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55D54BC4
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613118; cv=none; b=VTpJLj90GNg1kYkPaEsyh6iRtiUkUeJFw7elqV2LsW0V8dmBeUPT6dOrPxVTadmPkAskBNZgg+o6GAYC3Xcag8uTHh7RQMMUZINSK+sksDyp96p6ebokcPP5HyaIDfBaUt9CkEi/ssB8D6u8TZvVn6Wi7HC5q4zNX/IXKLzz0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613118; c=relaxed/simple;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pe1lKXTNCvNb43hhGzVBEYUs5IGL+ieQSZyhvYIRyAa3FPw3DQeADXRoHIEJgeYg/NT/cNHPSuUUqb1BgemSy73GOjWcIfd+gGQMZJWCH+eOvcIJ6vOO8B93ZWpYFGDtfQ72Rjyay0GSx7eOXZ24350CjlqfjKFnqcFEN0394Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFvXz9Ce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFvXz9Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83043C43394;
	Thu, 28 Mar 2024 08:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613118;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFvXz9CegqZ3aZn9tJho+8VwHv2NMiDnVFn7YtI6DMSO3HFNIkxK6M+NwGDxYyjlu
	 pqXUlFKCK4t9zaM0UjyPpREbjGgJCxua546UEeNqb3Vf4kFxvWx01CKxl4xiNoVgz+
	 Rqb/hc++h0Js8vZf7ALslEPCwgu/8bhs+2TPyEW9iEUaPOLSAgsLFZ8moXAWDaV3bM
	 0LjkGEImhcXX3cm80InKLTdYGno7JuDRTjsxCVFZywMthnBBlpF6nyc3K8ukAegW//
	 yvrVtyzEIFK6JclLceuSZ+32U2R2VKEvlVHGqBLPK5PwCYZXklG7NbNlD7Blni2kW8
	 RWCr2DVdhP1pA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 01/14] Squash to "selftests/bpf: Add bpf scheduler test" - fix
Date: Thu, 28 Mar 2024 16:04:48 +0800
Message-Id: <0e49cdf987fe33ca8e6f1531da34874c3a750851.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
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

