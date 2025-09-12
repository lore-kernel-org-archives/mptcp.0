Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBE7494
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648415; cv=none; b=hk+ebu2HyT5FwgknJczY5ARen8rMnQ1JN3mlY7NblJKsieGj8AO7SUTxGxpYSHnW5G+NmyvAoNZdC7CrW7Ii+4Smzdxd6Wt6poByyR1GLQXMIesNvAv47+cPd9ujT4IgTx21xVS0qcShreLZIk7A6ydkwMbSwl5iXbhk6FFYo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648415; c=relaxed/simple;
	bh=FzaI3OlxGvwaDioGWLmO5qY7kCDTpj0+XvxM+WzGfY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSGsbxv7zqEzkS8bGa9eOYugugX+yZOL9UduOthG8gZJV+OzgZsisp30KgOO5XfH7ZlSV6nLX7g84XKEDDcjyn+n/CWKpQgMcJs9JOSyQLhZhEWr3iTTIX46nS77B98fXNf2/3RYSaqINOnC4d7NDR8YB6MNNXXZr+Md7/CoWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSuRvi2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSuRvi2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EFDC4CEF4;
	Fri, 12 Sep 2025 03:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757648414;
	bh=FzaI3OlxGvwaDioGWLmO5qY7kCDTpj0+XvxM+WzGfY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSuRvi2zKboXWgNDfobkEiPR3FyQ/CrqVWBbQJVn34HcUjQaIVi5yhnaFxuDQi1sE
	 bNP3satQ6vBfCQnOfGRs+NH7Wilsncp/hjgIT5Cq5wGIuevUbhOY7aZJ3lgUku4cD7
	 syBaPv42hvaeVYZIGgmkHGRwQr2TZ9yTsOSN63G1lx6+BFm6j31tT2NnUZ7YCavLgk
	 wOswVcH5YOsgOgVLMW6OHuBAA9uL0dUpc9myAS+mR7w4e3S1aOZ1zzJzpV58Cl0M5A
	 M7sEOYK7SI7Dl8qQe7rV2JpolIaE8GXtN4FC97HD/e8ZtSHQC2DJqlyYp7DQm1rT2W
	 Ve3mKfG6oAYoQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v3 1/3] selftests: mptcp: sockopt: fix error messages
Date: Fri, 12 Sep 2025 11:40:03 +0800
Message-ID: <46a76424b742faf97df213882d1048cfec2348be.1757647967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757647967.git.tanggeliang@kylinos.cn>
References: <cover.1757647967.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch fixes several issues in the error reporting of the MPTCP sockopt
selftest:

1. Fix diff not printed: The error messages for counter mismatches had
   the actual difference ('diff') as argument, but it was missing in the
   format string. Displaying it makes the debugging easier.

2. Fix variable usage: The error check for 'mptcpi_bytes_acked' incorrectly
   used 'ret2' (sent bytes) for both the expected value and the difference
   calculation. It now correctly uses 'ret' (received bytes), which is the
   expected value for bytes_acked.

3. Fix off-by-one in diff: The calculation for the 'mptcpi_rcv_delta' diff
   was 's.mptcpi_rcv_delta - ret', which is off-by-one. It has been
   corrected to 's.mptcpi_rcv_delta - (ret + 1)' to match the expected
   value in the condition above it.

Fixes: 5dcff89e1455 ("selftests: mptcp: explicitly tests aggregate counters")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e934dd26a59d..112c07c4c37a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -667,22 +667,26 @@ static void process_one_client(int fd, int pipefd)
 
 	do_getsockopts(&s, fd, ret, ret2);
 	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
-		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64, s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - ret);
+		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
+		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
 
 	/* be nice when running on top of older kernel */
 	if (s.pkt_stats_avail) {
 		if (s.last_sample.mptcpi_bytes_sent != ret2)
-			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64,
+			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
+			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_sent, ret2,
 			       s.last_sample.mptcpi_bytes_sent - ret2);
 		if (s.last_sample.mptcpi_bytes_received != ret)
-			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64,
+			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
+			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_received, ret,
 			       s.last_sample.mptcpi_bytes_received - ret);
 		if (s.last_sample.mptcpi_bytes_acked != ret)
-			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64,
-			       s.last_sample.mptcpi_bytes_acked, ret2,
-			       s.last_sample.mptcpi_bytes_acked - ret2);
+			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
+			       ", diff %" PRId64,
+			       s.last_sample.mptcpi_bytes_acked, ret,
+			       s.last_sample.mptcpi_bytes_acked - ret);
 	}
 
 	close(fd);
-- 
2.48.1

