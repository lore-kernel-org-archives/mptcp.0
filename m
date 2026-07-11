Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63841255F2C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741482; cv=none; b=hNF5anUvyUuD7NYzYY2+ZxJSDxDLxusUL2fwCY212ZPnOCibyCcF3ji9n13MRzHh8sitCKz5Zx9+A5Hwy/SwFpovdcsubRiDDl8aVi3Rp66YP6pqBQ2A3HN+CRJ9o3mXVQI8rg/ArUcQntPf0QSLI7f6sdHsTirdlosvBNswICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741482; c=relaxed/simple;
	bh=mMjtAVY1DG5T0dWMgCVyTzfYfmysDjsN5NOgF7x0htI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx4hRkJZK3tq3DpvpbCEY197HlpjHm44sjjA7I+grstzcjJ4Nf/E1xOOgXicLVBhveM3ojQHFfkDLLlk80cbgGInHhPKCRc2litfxKk5Yp+2jbe2jrgEnl3UhXhWSUsclCGtlC0/04L/Yp+Yz9Dpzu+ugWQJbJY6SuaJgigwUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsnZ0A6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsnZ0A6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EBD1F00A3A;
	Sat, 11 Jul 2026 03:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741481;
	bh=b2HtoZ8/+FnjSkbP3XlT2UgINU6F5GlFGXvirozYi8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QsnZ0A6wC0GR2zqWGsmtCcknVO9OdID3LSO5i+IviiaWVqIf6/taLOw0WEjWqsc8S
	 BDDv7mk3A9mRgYcf0V/TcUzX5Ps2elpiffiDNy41dW32lLORUpJqUwDvHqVtYy15wW
	 ckcHcox4uZE9k3wSRZu4FFDiKsqeIwuoP1T72O3Oj8xBOLP2/GKnX9zug4qcueIxYW
	 ZSRf1Iya19TqGSF16qoUrfSxOxBQmJcQyOs3eOgl3fwl+XsIAPok9VG1SmLPDccBXe
	 YNlXhGYN9awfKyn/lnQgEgnb1oxPpoRpdm0ikWvYYyNjTzjT3dDVfzdB1frSeZ0xaQ
	 B3crPGExY5NHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 09/14] selftests: mptcp: sockopt: set FIONREAD ioctl
Date: Sat, 11 Jul 2026 11:43:37 +0800
Message-ID: <552a0289eb6dd58e95a7a4fc4dfabff8e5d17e44.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
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
index 181eae9de136..6bccb206181f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -689,6 +690,24 @@ static void process_one_client(int fd, int unixfd)
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

