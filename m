Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C4371878
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994952; cv=none; b=X/I5R+50h8rqMYzd8xP+JZGVkRBLw4x9tRw24QMrMTz/UUKhb368mToMstVINt9ZXYfA5H+KSca/1zaJOK98NSjvnliHTO8AjlFYTsvEskG3W+hQpE3niLBdCKJXGPTAdQT4poWJFL+sx6bBrlR0gcy8BbuOOQ5UkYNmPnIuZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994952; c=relaxed/simple;
	bh=su3byV5CQRgP/hVAJAxGXtFNOhd7bwk3bqqSMy8GUak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2cZ8nlI8rUsaejvpoVZTeTGMKesYjG+X6r42E4mK3Rpf1kEJObgLEIfP7/7vPjCTADQqddPML9Q10y78vZblVDnL8cutys353SrO3yrfpqWPbzhAEWOxvKyzfzTM5GmISsKrhlqtuNEFar/hRpmXaDyJgwz43cla0X2LHMNwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc+g1i6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc+g1i6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6782C1F000E9;
	Tue, 14 Jul 2026 02:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994950;
	bh=FQ+liz7xroJkaMduO7Qio+7oB+puSGrcDRagRxjeiwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nc+g1i6VsuwlBBrfug9au/KVlbMqcXx2wth+9QcwI9kJ6CPDuGZRoXrFDxaUbsPhg
	 ZW3wYAJhBaE59PGqdRw0Tda13ljnaU/zg2J0JIek9WYIaRw8b7aX2zUnwrXUm2IMW/
	 LMhbP5KHoyGuhElFMVURiReuPchhOea+BhDhMAlBeGPN+JaJu/mm/eoXqwmX5UB8XO
	 i3BpkC6vyURJ1Oei/3xRkn9boXi8okScu8zkPilVkhdFb8GuFQToYQpCqAN+q1rl5V
	 NiiK68LI2Q8iWGOuYqygROxre/BpBJ7gT+QE2ZBbq1aigafENQ95lBmBHl4qx6Xzyb
	 1xgOn9F4EZ1hA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v10 02/13] selftests: mptcp: sockopt: validate bytes_acked against sent bytes
Date: Tue, 14 Jul 2026 10:08:47 +0800
Message-ID: <12f1842569af336508444be4d03160a7a0af1399.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcpi_bytes_acked tracks the number of bytes sent and acknowledged,
so it should be compared with the amount of data written (ret2), not
the amount read (ret). This corrects a logical error in the test
validation.

Fixes: b86418beade1 ("selftests: mptcp: sockopt: fix error messages")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 56f2109699aa..2eef0912a932 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -683,11 +683,11 @@ static void process_one_client(int fd, int pipefd)
 			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_received, ret,
 			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret)
+		if (s.last_sample.mptcpi_bytes_acked != ret2)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret,
-			       s.last_sample.mptcpi_bytes_acked - ret);
+			       s.last_sample.mptcpi_bytes_acked, ret2,
+			       s.last_sample.mptcpi_bytes_acked - ret2);
 	}
 
 	close(fd);
-- 
2.53.0

