Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79A306D3E
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200602; cv=none; b=WnGqpH2Y30id0sfVMJ6uTeAWGw4UTBK4w5FDOY1dCKZg3v0dicJFAG1Jk64+dyyvWOrDd4YwhvW27Ocofv8GVf9shmDxmP7LxJNM3sHT/7MkimWFCgG1YBbAE+QZDDSuCvwcF+3DLdOY3gUQi8vtBZSG59d7sjFZUEtuaN1r92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200602; c=relaxed/simple;
	bh=aucwV16ajChVtuuyf7HN2IIBaCqGS3+1Xk2tmdqvbGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG9nQ1hd1e0AI1a6bNnxRy6MvdrfvOCEwS//+NVcoSeYWGZjCJBBKQuS6YPvfk9hyCXSzs6/xmqOM+wZyacS31bgHv8ItZa36dp4pcF3B6yG79Mod7C8GmtmFGBpIPD3DRSfx4dNb+AyOYFDsZkGzsxlvc7OS7ED2m/0XxIPOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=supiwRaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="supiwRaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B19C116D0;
	Tue, 26 Aug 2025 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200602;
	bh=aucwV16ajChVtuuyf7HN2IIBaCqGS3+1Xk2tmdqvbGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=supiwRaHsBobzZfz0TlVUGt+ruK7WNvnPDfHzPNwoX0y6xBXgbOK2ShRqcvXE1Ans
	 jgB7fxNaRxCQjV/r/Y458ENMF5Aqnao/MDuYcaZo3Ot+Bs1lQBWZIL4p0oGdP0LXVr
	 Mw+nBck6Hfrr1Lv+4TFc3vD/xM5At27znNZwbHuE088L8TNnOkYFdHAAZUp6+jt+Au
	 3c3abLae/cFIdRcKCpSzken2TE88IUUOtnddBbqvdSnvRK0zPKx69JmjrrCYPxUTG+
	 ZdTQBFgGMXXO+TkgG2Wby8woMb2RrRbSHH36ekNZJUR7olFBaM60OOrpwolpwPTcwj
	 50i4uyXRxW/RA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 10/14] selftests: mptcp: sockopt: add wait_for_ack
Date: Tue, 26 Aug 2025 17:29:34 +0800
Message-ID: <7c3b87fbfca4291c5df9a8efb26e57f0c0eba9fb.1756200029.git.tanggeliang@kylinos.cn>
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

Adds wait_for_ack() helper using TIOCOUTQ/SIOCOUTQNSD ioctls to synchronize
tests by waiting for data acknowledgment before proceeding.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index fc65157a41ee..b8e8fec8979f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -21,11 +21,13 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/random.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 
 static int pf = AF_INET;
 static int proto_tx = IPPROTO_MPTCP;
@@ -593,10 +595,43 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
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
 static void connect_one_server(int fd, int unixfd)
 {
 	char buf[4096], buf2[4096];
-	size_t len, i, total;
+	size_t len, i, total, sent;
 	struct so_state s;
 	bool eof = false;
 	ssize_t ret;
@@ -667,10 +702,13 @@ static void connect_one_server(int fd, int unixfd)
 
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
@@ -691,6 +729,8 @@ static void connect_one_server(int fd, int unixfd)
 	assert(ret == 4);
 	assert(strncmp(buf2, "shut", 4) == 0);
 
+	wait_for_ack(fd, 5000, sent);
+
 	ret = write(fd, buf, 1);
 	assert(ret == 1);
 	close(fd);
-- 
2.48.1

