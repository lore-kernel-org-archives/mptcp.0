Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E4364BF
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530121; cv=none; b=ld2IgXjVxgmPBvFWUHC1yaA1RFKGdR1/uDm/X0U6KQ1gQwBXBk6SUX+jYNMiI4rPRK+9I3LciG3c+uTZzpQJWwTU/fLnrsvKTenC1XnS1hQKJ3iZgPSWP0xNGsicKn7isGZiglBmtxKjUAfpzYL4QSM/soyW4aB9LQA108eVv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530121; c=relaxed/simple;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaKodIWLrQ8qA1xiYnpjzcGJRH2WyeT2o/ZUQNUe9MEchm/l+cuISgRP8srJPVB2Ax1A2S7icPVYTlHcYLxv0SdjynTggG/W+NFZxA8N49BUE/EZIGhj46mABBetgF/6pZdcStLi7l9cAF53nZbrKtDjaA+Y3LxtmwmdPG3Dd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1TDSH8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1TDSH8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995DCC43399;
	Wed, 27 Mar 2024 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530121;
	bh=nYOWAU7sfzIVHuhCPmcHon1XQI6uRYZDP32k3/YsPdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1TDSH8eIANEAttX0O0YQcmV6a/k1LkOOFG6zObm14A/wSrjRvoYiGPaXbK9Z9Ag4
	 s7kSQ6oz2vayCwWHRLpE5dnILTh/UjACtw+NLzdYTLnYuCHbhWVD9WIoxsSlA0lSxI
	 I4HdCuO3JRC2h/rSoWTuYgfY/tApBxroLwkVmtIoPiVVCUswzsbahHsb/WRdXzL/fK
	 /WJztV40QRmW0rEHmXtk3dys9GMCfo0fMcZd1Sw0PhS+Y9PXYwp5Bjv9uaJbSN6g7b
	 lzGKD8ghjEPpK/NJUHcSLAwSXDgFye6/JUmSzSGh7hfZo2xz3ebSB5/3dQSXCQFCiK
	 Jy0JmV59H0oGQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 01/11] Squash to "selftests/bpf: Add bpf scheduler test" fix
Date: Wed, 27 Mar 2024 17:01:39 +0800
Message-Id: <93b646ade5fec9bf710a722bcf3ff29b3579b429.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
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

