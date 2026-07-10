Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B03C8182
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673976; cv=none; b=UhzoPAjAgBlo7M1C4s5AQfQiuR+e24Mt6nPKCg7yeFCQRMjbAs8GIgnPmVxdv80HwbHYiodFfZv+hxkUf3kKHlAFv6dlB8wOrIoRJxcx6IlcqyrJyxNa5yDVO3Dt1xZvO2KEDoRY6q036ga/+npyIKCTJ7IBl7vDomO9y3gYSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673976; c=relaxed/simple;
	bh=M029lbGzAkMEP+nQtfI1E9GVZ5Yxlk81bMtYkjJ99os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmFL7pUSiQQ46eUBMacrh9B1WOXUo2l/IBpOc4NPiLfHCj+4HRaqOVW+/MWRVGI+J6nQgunnocivorHgfItQ1zZltWgRZryH3lfPY8g2R0zXIZxosFtUCBPgh2RiDBKZxNx9KG5HoBxHV57o27nFtNZvWk+FsPcUt0ex18Qdbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhrqn0xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhrqn0xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA31F00A3A;
	Fri, 10 Jul 2026 08:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673974;
	bh=hup+mlI7ipn8n1l4qPCTi18I+4c0oU5a9VFd++yfVCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhrqn0xo9f80Fzon7OwHzFU3kYJLqaGJ9Er96sG8KI44a1eylbkb9iN+MWNM8IXTq
	 vltMJ+cqcI3g+YY2EjwLfUxEm/BsPT3Rpbr34+e/dJAEjplPxi0hd/jgfnZIzjCbJz
	 3MheIlriVrF32n7MErtBhF12pECtqYy8au7aeoWMi7D6yVVF1IWgaDwcn89F9lI7Gs
	 HomUR1KaWS+sUPvbTfJAROjn3uEcFptisWb2jA70erkgnFOhS6jeYIxb+HB6eIM3au
	 xB6OwYWE70SZhqZqdMrq+rKp5rJI1qd3SVzRhukklbn+Wszbp1qkU0mu3MGazUiKPV
	 pRJOmU2UVePyw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 07/10] selftests: mptcp: sockopt: add wait_for_ack helper
Date: Fri, 10 Jul 2026 16:59:10 +0800
Message-ID: <1cf028e5469b5e041d05b18fcf8271300c983d3a.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
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
index 16b58f6ac7b7..bc2cb3db3264 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -26,6 +26,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
@@ -596,10 +597,44 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
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
-	size_t i, total;
+	size_t i, total, sent;
 	ssize_t ret;
 
 	for (i = 0; i < len ; i++) {
@@ -615,10 +650,13 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 
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
@@ -639,6 +677,8 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 	assert(ret == 4);
 	assert(strncmp(buf2, "shut", 4) == 0);
 
+	wait_for_ack(fd, 5000, sent);
+
 	ret = write(fd, buf, 1);
 	assert(ret == 1);
 	ret = write(unixfd, "closed", 6);
-- 
2.53.0

