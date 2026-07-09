Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051273DCDAB
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580831; cv=none; b=NA57nr3l3V8ALjGnrUQEDMlGMwX1scE43a+HDOuKkU2ucXJyDFaXh38kRyhSY/L7+Y1FLkXI+JL5sMdrp4hQ75PZzfvWPLyQDU1SwwTY4DTkbTlSZ+sSVa9RBLBfEBKslNsLPDmtdDneEkFxAiYoV7L58g0JZYRkzor3slJ4JoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580831; c=relaxed/simple;
	bh=CfzGSmkj9yOu8ulI2KgIZbhEJpX1k2fMqyrxZpM7N+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0znhPrL1Iz3+XfETMI3PxK+FKx8v/pyGk6pa1RkZNDUS4AXgE+RCYl5lR+XgEh0RZ4OPRdeHcw2spAVvDsjsrM18fmEsEQAUmswQbZfqb+7yQA/f27fE1LeRGejy++8aJu7PTQsyx+KeO6ZJS77sNGv34BXmQ8+HrkQCH/s9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apuBd4kK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apuBd4kK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8BC1F000E9;
	Thu,  9 Jul 2026 07:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580827;
	bh=YUO9o5zbQvgy5LE9w7vJtkymziVd45Xt3ZiXB7fgL6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=apuBd4kKgcj/m9uecSiKfDZi8Cti6tK53LMfh9+zuWrkI/5VvGwEfKv+eYcQb7r2x
	 sg3SMDTtwAUxlvI6645TszmosSDti2Yz5VhKu1MzJcUrSH3fYGGoP8QcQpulmuOW0R
	 VSrAJf7o/0snPJj5ezQ9cbZCbQYNmcArDv/6mhLlaa2WOV4WnJb8+m98y/dHLnPviR
	 Wq6wOh4GfWotSCqaSAvJzLs1XKDWADSsnZjl1UJUwJEwzTxwY5JvjeQi/8v2TBSvwA
	 zwv8ZGrwnOocVJH5YVCSVfNTmLewHNMAnSsaJAUryZNSGShPqwfxQ4qsPj8F0k+sbz
	 uor4ywHmqPpHA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 06/12] selftests: mptcp: sockopt: set FIONREAD ioctl
Date: Thu,  9 Jul 2026 15:06:15 +0800
Message-ID: <4ddab6eb6a25ffc6c956277709a870e474c0103e.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement FIONREAD ioctl checks to validate available data size, ensuring
synchronization between write and read operations with non-blocking waits.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 15c9f8dbae47..1b4d94abb1c6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -683,6 +684,24 @@ static void process_one_client(int fd, int unixfd)
 	if (expect_len > sizeof(buf))
 		xerror("expect len %zu exceeds buffer size", expect_len);
 
+	for (;;) {
+		struct timespec req;
+		unsigned int queued;
+
+		ret = ioctl(fd, FIONREAD, &queued);
+		if (ret < 0)
+			die_perror("FIONREAD");
+		if (queued > expect_len)
+			xerror("FIONREAD returned %u, but only %zu expected\n",
+			       queued, expect_len);
+		if (queued == expect_len)
+			break;
+
+		req.tv_sec = 0;
+		req.tv_nsec = 1000 * 1000ul;
+		nanosleep(&req, NULL);
+	}
+
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
-- 
2.53.0

