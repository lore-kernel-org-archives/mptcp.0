Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488583CC7
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621130; cv=none; b=TgQBP2v83TVJipCaHiY27vWpjrNQgVBpltGFEE0evkZHfoKHNrDdRND5fuwgRXh8MYS/5DxvcfL7UGQkxSfGNueVbd9SjMP2wnDnfUXJHWYoth5ROP3ZZ9ZS4UgnoZwOAvzDaZ+IOd5N5tyh4PTZFq4rLzWDjgC9ljYXX0wWr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621130; c=relaxed/simple;
	bh=bzmZGZMFMHzVLnybsX1umsqQILIwhLnzq64QMuLnak0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc1zZegYMDc3p6CyovbEbVv7fpP2ZsgxmCdCqaKtz2J4fPhM6IMrUKaH6y1wHniGlKIzWC9tmP30+6NJrCQSErJYtMZAleD8glP9XoANfavk4OWfHEkSX1mO5iIIDwT22FcdgnZ3kg3rKpB9ZYHuSf1IAoXxZAe7jwfICP/Vy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ6RFvBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ6RFvBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6CDC4CEF1;
	Fri,  8 Aug 2025 02:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754621130;
	bh=bzmZGZMFMHzVLnybsX1umsqQILIwhLnzq64QMuLnak0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZ6RFvBIm5oJg1iikNeXFJ2w2WXO6I33PtvwqigA4wH8jrsjFxXJtM+dBj+uZ1Ulp
	 MIEoxXs6PCaHi3pu/wv/4Xsv5ezBBzXlaA0SKyROjf/Hnilo2gbAIbehvrC4O4H0gZ
	 Bjy/dHxBLXiKZYpDulD9WgokIckmdL4nCboZht0K3ia2HZTMGlB9vcTQwQwxCXFcGj
	 D5gInZQXd27LUCRzds8ytdxoRCcvALam+fRBt3VGlG/JdIN3BrWb2/uJCJRNk1MbJi
	 odcPVA1+ZbkK49wUrrLYwkDO0QGwNHBBnQwEGk4D2PtuK0KJrA9i65C2CDsOu7RzMv
	 ME41FOSkzuvXQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/8] selftests: mptcp: sockopt: add TCP_INQ server connection
Date: Fri,  8 Aug 2025 10:45:07 +0800
Message-ID: <6eacbf444287ddd95f7171bfb782e4f3a4c82424.1754620968.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
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
index d68db3f0d5f5..e2fcc6656058 100644
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
@@ -961,7 +1072,10 @@ static int client(int ipcfd)
 
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

