Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828E3DD877
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580834; cv=none; b=qZJJUGl5hgkWhW1t3F832nzgsG7ww1X3L9ZDSV3iYlgjBxP3RSeS13ojGRyLhzq9Vsf5EE0Q7wqFyA6+P1Ks6t+RtGob1+QlU1w/RlfbBPUzZQTJCCi3CFq+JMAHkBhZmzhEpjrYrQ6hkCTWzxAo7zF6k1/3FOo8pjP4bSzsev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580834; c=relaxed/simple;
	bh=KUAXdMF3I9CUBID25zCxTb9wxzhWV0A6zbYTQVhM2lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOYt+6tdn1/DcxcWJbRKXcVI367d8SlSBEgeXG/5XKMQN7wOKRTyVC7+jozmy91nCSueTDtj3OSY8K+MdMQsnYIBD5V1ZlWSDxPpddUWkw+EqhTpr4UI4d3XpZqzHtvFkwBfyubhokuLXYrhcbMlQQEDFrp5W7Cn2EbuWHB9GsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS6xdS3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS6xdS3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097FD1F00A3D;
	Thu,  9 Jul 2026 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580831;
	bh=JPJfCfvQuca4Y2g365WtslHky8kUIgI3IJJJk9Ql6MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WS6xdS3BNDkTRN0u9X7LdW4QjNaWsyby5Re3koJRqAr/UjrgZDlqJXYkntbjaD/K0
	 M1KSpMjfiilX9SSCovl7QUaUMX1RSS48XnnhLwk4SCCqTaAzy0ODT9Y5cXeRE2FvC7
	 zCd6zcMctvYip7CeA176e4qXjk4i9//Nqpq8+ALf5DvB5FGkAZB/kYC+d9+1O66eYO
	 TMbOvGoq79OxdBfAdSGnOr1QapaxHKu4WlvtZUfURf06L4x4ulg45/Vp4jF6fmqSsv
	 SacrNAcjIQJy25LZA7zOPMs/BOBoxth50dgjr0cCdV5lTYZ7S/0SGVOHp/qgmX/y2w
	 y/VuFBq7bdk2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 08/12] selftests: mptcp: sockopt: add wait_for_ack helper
Date: Thu,  9 Jul 2026 15:06:17 +0800
Message-ID: <a9d541168a557055e20a4a8bad1dfd90b49f0753.1783579976.git.tanggeliang@kylinos.cn>
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

Add wait_for_ack() helper using TIOCOUTQ/SIOCOUTQNSD ioctls to synchronize
tests by waiting for data acknowledgment before proceeding.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b4da3aa9713b..393c863f3762 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -26,6 +26,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
@@ -593,10 +594,44 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 		do_getsockopt_mptcp_full_info(s, fd);
 }
 
+/* wait up to timeout milliseconds */
+static void wait_for_ack(int fd, int timeout, size_t total)
+{
+	int i;
+
+	for (i = 0; i < timeout; i++) {
+		int nsd, ret, queued = -1;
+		struct timespec req;
+
+		ret = ioctl(fd, TIOCOUTQ, &queued);
+		if (ret < 0)
+			die_perror("TIOCOUTQ");
+
+		ret = ioctl(fd, SIOCOUTQNSD, &nsd);
+		if (ret < 0)
+			die_perror("SIOCOUTQNSD");
+
+		if ((size_t)queued > total)
+			xerror("TIOCOUTQ %u, but only %zu expected\n",
+			       queued, total);
+		assert(nsd <= queued);
+
+		if (queued == 0)
+			return;
+
+		/* wait for peer to ack rx of all data */
+		req.tv_sec = 0;
+		req.tv_nsec = 1 * 1000 * 1000ul; /* 1ms */
+		nanosleep(&req, NULL);
+	}
+
+	xerror("still tx data queued after %u ms\n", timeout);
+}
+
 static void server_huge_transfer(int fd, int unixfd, size_t len)
 {
 	char buf[4096], buf2[4];
-	size_t total;
+	size_t total, sent;
 	ssize_t ret;
 
 	ret = read(unixfd, buf2, 4);
@@ -604,10 +639,13 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 
 	total = rand() % (16 * 1024 * 1024);
 	total += (1 * 1024 * 1024);
+	sent = total;
 
 	ret = write(unixfd, &total, sizeof(total));
 	assert(ret == (ssize_t)sizeof(total));
 
+	wait_for_ack(fd, 5000, len);
+
 	while (total > 0) {
 		if (total > sizeof(buf))
 			len = sizeof(buf);
@@ -628,6 +666,8 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 	assert(ret == 4);
 	assert(strncmp(buf2, "shut", 4) == 0);
 
+	wait_for_ack(fd, 5000, sent);
+
 	ret = write(fd, buf, 1);
 	assert(ret == 1);
 	ret = write(unixfd, "closed", 6);
-- 
2.53.0

