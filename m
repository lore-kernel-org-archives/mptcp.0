Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F63093A7
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200604; cv=none; b=aVc6MDPtO4e2nIiefP9MkmLo+7RFidq/qxhO8XJCqQm4t0+8TA/l7Qqe8EqHvyBR+LhHXGN+CDQY5GGZ3cMrSbTs3DG/fhnsUNS4QD/dEfSSVFmon/lltBnItHnE3TxXQFpyf4xGvDtHuRMdq8/cGkJJal7xXt2Ej0s07KwNeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200604; c=relaxed/simple;
	bh=8QagbiO/zoUMg9axgJJOInRd3KfFKq+khADlc59tUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nb9kVmQLA/AvH7Rx8jJxB8AeqNE5OeiudERv915UKn+GPrUzH4vU+++tOsLBMmnBr3tI+rXqXzf5DzgTznUbplMp9ZO92AS2L/XL1DIJR4E+mDT1QOQnicEEkVe3jbN8HEhRA4gEXMZRuFXcQqtLy1Z8fIJmKcs0Y+nKqN+kMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntbY4Fiz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntbY4Fiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A53C116C6;
	Tue, 26 Aug 2025 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200603;
	bh=8QagbiO/zoUMg9axgJJOInRd3KfFKq+khADlc59tUtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntbY4FizVL0boqrJT8H+GX7VsyXTDMes8eue9tksd8/I4hIg0EvqMiqzJ/IVyVSDz
	 bbjImYx2pfETto5pq2RN4U5IodJE1qRu2TOE1BvVTos2G/7uVNi2DNpNj12XR3IJu8
	 Xs79cCACVDnvcC5U5Lt/RvmG7lFIMrN4PYgWhI2sarjSrt8w0JnAToqP7Tp2XUo/9Q
	 20SzJXHYBpLizFm55niKU/bG5ia/P4/qlNDHsa7tjnWAR8hIu4RdwB1NplmDq0gy5S
	 ePMvY3UydV3xAnZf40K4zaLBdiSnc2ioUWdA06GTpu8tUcLmmuvy4FJOv+Ewb31nkG
	 d6/zEkT+8SFKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 11/14] selftests: mptcp: sockopt: set FIONREAD ioctl
Date: Tue, 26 Aug 2025 17:29:35 +0800
Message-ID: <af08bc3c27e1ac01f214e3ded74d05c48a9936d5.1756200029.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implements FIONREAD ioctl checks to validate available data size, ensuring
synchronization between write and read operations with non-blocking waits.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8e8fec8979f..7cc4626b7bf3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -771,6 +771,24 @@ static void process_one_client(int fd, int unixfd)
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
 	/* read one byte, expect cmsg to return expected - 1 */
 	ret = recvmsg(fd, &msg, 0);
 	if (ret < 0)
-- 
2.48.1

