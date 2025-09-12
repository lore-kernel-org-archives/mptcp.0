Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5930EF86
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686853; cv=none; b=rWa7OOpiS5mzVmF4nHBbAJmbJ45uxQ+ilNZpiMarkwZyz3Lh4rUCf+LFU13pe6DaOG47m+3XFrMSnULZEMYgwwbkN8AONVM1aPiQ/4ufjAvQ8Ev0WWxNz7vCZOTdMV71IXqkyXsF3af8+CvO+nW4XJLPWIffxUqif/7cUvUZSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686853; c=relaxed/simple;
	bh=6Kif0ZlP8Z81dmo3UrqSBwhK5c7Q3HgfRP+XWW2LCzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzCzVMhhOEcjMwPzg/XghA1OPnDfz+9wEeFN1ESzz3wWwoMWdBQu/utLokgMEXIDXbNyVPXX0fFoN3d/jYB63dqs28u0fHI4bjY2Y9iR1m+xl54dW5HJtkI5IAguxxjl6/qI5bdYjRmjUH9QjzshdG8LOSpoRH25NFWA2OEH2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffWIRgH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffWIRgH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA4C4CEF4;
	Fri, 12 Sep 2025 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686853;
	bh=6Kif0ZlP8Z81dmo3UrqSBwhK5c7Q3HgfRP+XWW2LCzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffWIRgH9ZUaSYVG3c7y1kwwScaVy2OwOQqnWrRjmpJ/Tpw0xApcwoUgMOxOjb4mHm
	 +buIoFwfNbfbIqPZsX/ElRyuhLm3TIXN057WrfSbXEInT6Hyum9IY5N1Nabt00/OYi
	 7SXI2hAcKor9E39TzdDJKpyHJdQWFnQ7+XfAP7JLNuPANRra7gGRGc5W6nkDCi1OV4
	 1QYIQeZtrbwiYRazAaj4obvvpVojb5DRdHwb58F+jFp/t96GbQZbU+U9EjtUEdHxeK
	 Cc82LPF0dugAWJopjtUuqGRHbF9o+CXelFEk2uaVxSIDFtUa9zUC9m1fmx+ZUi+dCJ
	 v10shjwxWfrtQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/9] selftests: mptcp: sockopt: handle INQ on client side
Date: Fri, 12 Sep 2025 22:19:54 +0800
Message-ID: <89286c8c40905c94c50021ebcedc636efe3d6709.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Integrate connect_one_server() and wait_for_ack() from mptcp_inq.c into
mptcp_sockopt.c, and rename connect_one_server() to connect_inq_server()
to handle TCP_INQ-specific operations on client side.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 116 +++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index f5342903a80a..ef7a445b626a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
@@ -660,6 +661,116 @@ static void connect_one_server(int fd, int ipcfd)
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
+static void connect_inq_server(int fd, int ipcfd)
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
+	ret = read(ipcfd, buf2, 4);
+	assert(ret == 4);
+
+	assert(strncmp(buf2, "xmit", 4) == 0);
+
+	ret = write(ipcfd, &len, sizeof(len));
+	assert(ret == (ssize_t)sizeof(len));
+
+	ret = write(fd, buf, len);
+	if (ret < 0)
+		die_perror("write");
+
+	if (ret != (ssize_t)len)
+		xerror("short write");
+
+	ret = read(ipcfd, buf2, 4);
+	assert(strncmp(buf2, "huge", 4) == 0);
+
+	total = rand() % (16 * 1024 * 1024);
+	total += (1 * 1024 * 1024);
+	sent = total;
+
+	ret = write(ipcfd, &total, sizeof(total));
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
+	ret = read(ipcfd, buf2, 4);
+	assert(ret == 4);
+	assert(strncmp(buf2, "shut", 4) == 0);
+
+	wait_for_ack(fd, 5000, sent);
+
+	ret = write(fd, buf, 1);
+	assert(ret == 1);
+	close(fd);
+	ret = write(ipcfd, "closed", 6);
+	assert(ret == 6);
+
+	close(ipcfd);
+}
+
 static void process_one_client(int fd, int ipcfd)
 {
 	ssize_t ret, ret2, ret3;
@@ -973,7 +1084,10 @@ static int client(int ipcfd)
 
 	test_ip_tos_sockopt(fd);
 
-	connect_one_server(fd, ipcfd);
+	if (inq)
+		connect_inq_server(fd, ipcfd);
+	else
+		connect_one_server(fd, ipcfd);
 
 	return 0;
 }
-- 
2.48.1

