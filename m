Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF8314D06
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913150; cv=none; b=alCQmmJ2iXERWLS7U2LP+EQSLvReJz1f7MWaIZCEiC7G+ZrT+G2wuN5dSGFW7JVxq5YngIoqe4NsLt9jFVGiCsBL9F8IeRPJGL/ymfS27/gG6IzXDJ785HWqRYTYu5mQsVnvz7nGNdfPLfHaBGP10pEzoCI+RGYH0+DIUOHbjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913150; c=relaxed/simple;
	bh=r/iZBjr9j4falp+c+F8ZiqsszqQHQ2ZM1C1E1ek5gFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sR5c5qjFu9cmC96cP9fVtWgYVXOgOiQhmlomPHglfQzHNJqSDF9B+7U8xgq4y9I0aw/lz1HFAk+SDyYCInxJY8F+1ou2OY7QK5afxMeyVfu9BDgRVJt8NwSE7hL7VaL+wGVpzkNTtvscCoEla5+dHHxsx+t2aAHYId/qmYnBzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7ZjblRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7ZjblRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6901F00A3A;
	Mon, 13 Jul 2026 03:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913149;
	bh=vN9QUt0K3Ohrp+2UiVzxxGuyjGPwnF946W0GNQhwUY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7ZjblRrNslSE9BMwo8kRj08Wr8Til+kGaKbMXxagYG14CvZTZS4ndYrdIcqRW37h
	 BUROaaGPRST7VdYKL7TsVVRY8T/87lctYn5bVr4x1Z25LvqY8GLyUg95Eg58FS4u3X
	 hOe4N9baAsXc5uLxVSFBlwmei1/vNXUAWEXagFgc3lfgFppZ97esOrOtyVJwR/CpeD
	 7q+MgL0kN1na7/XGfuThwnd9R6XRDwyXwaFJ03P7fIQbTA9q03jcZZw8tnk2ZnB7Ml
	 orfUnZ8kT7GxN/YsJOADu5j26LbZiZJVklC8L3IPWiv5/cibfzatGAm4bZpkLDAl8V
	 +cr4K3VZr9REw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 01/12] selftests: mptcp: sockopt: validate bytes_acked against sent bytes
Date: Mon, 13 Jul 2026 11:25:25 +0800
Message-ID: <cdf38c2157c375bb05436a55d5bc29ff7978a18c.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
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
index b6e58d936ebe..d4ad03ed64ef 100644
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

