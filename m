Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A427FD51
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664232; cv=none; b=cunB/I/ZsTZTZIRIHTf7Nt4vCJRgvBktGhgArak3wGikwq+7YMxCLCpV72PJhNlSTNYPZck7HKZ6uNzkN8jEihWWFDWHmXuNnX82zc46OnUtFP0QeskpljIImvJ5Gme4UF+UdQoJKgTwL2YAJzOuOs4t3giSwNDqOL7bYXHipCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664232; c=relaxed/simple;
	bh=7TFjjCCWW+R3t6INXdt1mhu9lsCXt5/N7WCdi+Q0fYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZMBWwnHo4eZXAelwP9omJjEH+x3Z3XTcJwV8AWfOgnrZogoge3Zud1ioZUv65yxZCf7V3UPPf/xUJ0jEeQXpn11ZjXdDFur+QZL+aWgXUOlMQrMrImIAtfBss6XHWqn6Tk1PNsEfupI/wMh6RN1e3xUr8h4upfdFLUNOgfodO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GedM3uTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GedM3uTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A557C4CEF6;
	Fri,  8 Aug 2025 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664231;
	bh=7TFjjCCWW+R3t6INXdt1mhu9lsCXt5/N7WCdi+Q0fYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GedM3uTV8S/ekVGOvR3tbOwhP35RosM2fvZ/0Xj1GLJMtFE6ZfL1IbI2PiA1VkXbX
	 oacjuqcRsgRlXS3SJbvwHTrqYqgn/5voJ1hgDUMrW5UB96Ms3lLIfZ5MjfNWrqi22h
	 kabqHXfAbgarj0POChLQiO/0JcAWgetg7UVqJ2agVrJF4nNVK5n28oqhq0/EqWNgDb
	 F8JQG6QR1tZJZjxH2iD8iE0bywWdkpD3r4dINxVwKOpUJ78kVwugrLv/lyjVvsxZy9
	 OnsqADAT4YahsiEzYevwmuJk7OmMHiSX1U2zrm73vJ2mOB4P/foCwqg4G5C883QTDn
	 TECvRHQ3EjeAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/9] selftests: mptcp: sockopt: add TCP_INQ server connection
Date: Fri,  8 Aug 2025 22:42:52 +0800
Message-ID: <198003e3766655b965a316826a98073108190258.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement connect_one_server_inq() featuring:
- Wait mechanisms for ACK verification
- Large data transmission with flow control
- Proper shutdown sequence handling
- Integration with IPC signaling

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 116 +++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 0a85d7b3efe8..c12c5e0e6766 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
@@ -660,6 +661,116 @@ static void connect_one_server(int fd, int pipefd)
 	close(fd);
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
+			xerror("TIOCOUTQ %u, but only %zu expected\n", queued, total);
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
+static void connect_one_server_inq(int fd, int unixfd)
+{
+	size_t len, i, total, sent;
+	char buf[4096], buf2[4096];
+	ssize_t ret;
+
+	len = rand() % (sizeof(buf) - 1);
+
+	if (len < 128)
+		len = 128;
+
+	for (i = 0; i < len ; i++) {
+		buf[i] = rand() % 26;
+		buf[i] += 'A';
+	}
+
+	buf[i] = '\n';
+
+	/* un-block server */
+	ret = read(unixfd, buf2, 4);
+	assert(ret == 4);
+
+	assert(strncmp(buf2, "xmit", 4) == 0);
+
+	ret = write(unixfd, &len, sizeof(len));
+	assert(ret == (ssize_t)sizeof(len));
+
+	ret = write(fd, buf, len);
+	if (ret < 0)
+		die_perror("write");
+
+	if (ret != (ssize_t)len)
+		xerror("short write");
+
+	ret = read(unixfd, buf2, 4);
+	assert(strncmp(buf2, "huge", 4) == 0);
+
+	total = rand() % (16 * 1024 * 1024);
+	total += (1 * 1024 * 1024);
+	sent = total;
+
+	ret = write(unixfd, &total, sizeof(total));
+	assert(ret == (ssize_t)sizeof(total));
+
+	wait_for_ack(fd, 5000, len);
+
+	while (total > 0) {
+		if (total > sizeof(buf))
+			len = sizeof(buf);
+		else
+			len = total;
+
+		ret = write(fd, buf, len);
+		if (ret < 0)
+			die_perror("write");
+		total -= ret;
+
+		/* we don't have to care about buf content, only
+		 * number of total bytes sent
+		 */
+	}
+
+	ret = read(unixfd, buf2, 4);
+	assert(ret == 4);
+	assert(strncmp(buf2, "shut", 4) == 0);
+
+	wait_for_ack(fd, 5000, sent);
+
+	ret = write(fd, buf, 1);
+	assert(ret == 1);
+	close(fd);
+	ret = write(unixfd, "closed", 6);
+	assert(ret == 6);
+
+	close(unixfd);
+}
+
 static void process_one_client(int fd, int pipefd)
 {
 	ssize_t ret, ret2, ret3;
@@ -973,7 +1084,10 @@ static int client(int ipcfd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, ipcfd);
+	if (inq)
+		connect_one_server_inq(fd, ipcfd);
+	else
+		connect_one_server(fd, ipcfd);
 
 	return 0;
 }
-- 
2.48.1

