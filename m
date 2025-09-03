Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361482D0C73
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872504; cv=none; b=uawWfhsav7E2hQyVkrDZ/b29qxiNxaCE+DheQtG4o5rXNQhRoQ8AkoVpxGMpCzs2NLWl1wO/A3e2vzZj1cP12oXR8D6aA67ROveZFGjIaLQ2rS5xIeQ0OVoCixvEoXMkNSjU1s851q2cvR9IDdBw9QMNx9g6vgA0KpFOAz+IQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872504; c=relaxed/simple;
	bh=+LfHFjHJwNi0aG5LdIJTJQwDWkDAMV2Rq2FSJe64h3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEWUPRn+QKhxECN0fliET4LiBHLKcjNqKSOx4AFDY/W82UlCSwnBUpIFRR6PlJ0tij0na0xzQcKP43S3jzBvrrqeRo2v87n8oMbVoo3c/X/mBRroJtuUTsH8VW6uL1+NYuXXPx93ARUVZKBx2jh6eCYobtzwRSnUZ42AAH4c20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkdnFxhS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkdnFxhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8856DC4CEF0;
	Wed,  3 Sep 2025 04:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756872503;
	bh=+LfHFjHJwNi0aG5LdIJTJQwDWkDAMV2Rq2FSJe64h3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkdnFxhSj3bS1JQLdAEc3D1Q8G0rrmDXfvj0h5RyUBbPECJoYXWL/gFwnOxPz95IJ
	 Ik+5O5uHplYIQc727XBL4xhijjs6To0O6nbRu//zY2dTIW802H2VT081QvilI10LqS
	 Lx47mJs+3hja87vHxIj56Vg1nOesp+w9iHyDbGb7OcRQDx/DneeloiPipLxc2Od6+J
	 taT8hlZFxd33ZArJA1Cs+2Dz6Aq3mJd/0gmNI0c06IBAYDr2EcY6sDxbzvdqWFm455
	 8YROCRSZN7FrbZksDImJvMauD2fDgkPhMEev1I9zjDvDz5dcTGVPpMk6XQ2+trnPYM
	 cdVcs8bCoqdSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 3/3] selftests: mptcp: sockopt: fix error messages
Date: Wed,  3 Sep 2025 12:08:07 +0800
Message-ID: <fff9e4c04b934f0fe311cd5b83b68e468f443e45.1756872050.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756872050.git.geliang@kernel.org>
References: <cover.1756872050.git.geliang@kernel.org>
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

1. Add diff calculation: The error messages for counter mismatches now
   include the actual difference ('diff') between the expected and received
   values, making debugging significantly easier.

2. Fix variable usage: The error check for 'mptcpi_bytes_acked' incorrectly
   used 'ret2' (sent bytes) for both the expected value and the difference
   calculation. It now correctly uses 'ret' (received bytes), which is the
   expected value for bytes_acked.

3. Fix off-by-one in diff: The calculation for the 'mptcpi_rcv_delta' diff
   was 's.mptcpi_rcv_delta - ret', which is off-by-one. It has been corrected
   to 's.mptcpi_rcv_delta - (ret + 1)' to match the expected value in the
   condition above it.

Fixes: 5dcff89e1455 ("selftests: mptcp: explicitly tests aggregate counters")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b616af36c16f..56dfd02c5d01 100644
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
 
 	close(pipefd);
-- 
2.48.1

