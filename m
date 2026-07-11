Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B1282F0C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741485; cv=none; b=Dx2S+lCEhkuyMYX9x25hdpyGPinfCJ+XdqQsD7MdT5Sek2jCOWN2ur17XQNTN9+wEy+t0gbmuplkmu8SycFJfqkBe7FdKjPccCHeM39iU3wwCKZ1mOdtyuMuSkKR9tTH4YZlIzoNLCzJj6ESp7/PORbsVVUcozF+XkKyp5sr7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741485; c=relaxed/simple;
	bh=ZtB4giW2IGgh60tSsWal8WZQH61EAYlXKmRthf/Tacg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRR9B1jCJU+BjknokNRjkznUxHiAeAREFogo/+f7IT0XdSiqXM2uhIUx8Alrc1i/2nVr9kt8D/FbVF31z7QmeHQKT9V6Ea1+mbE9gk1EY0L4T3UnxTiwEKRBeivS3Pu4lBlw9TZZ3jzJKPqZfy8SXTQ9OWHjildZSfh4CfJzD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsa+sQpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsa+sQpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA5C1F00A3A;
	Sat, 11 Jul 2026 03:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741483;
	bh=C4pJeJbo/xKslRek0LQHi3bi9Wa2TGdyyam5Q9wSCpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsa+sQpwjC8dzLELYee1rNfAyZJoZ2dUTSBTixOsUBjo2TGRm8ay68o9u1Yu0bhyW
	 F5qHOC/O+ENVWF1TGb0XjvMJWElvGzGQigvUPPCStV4A+qLEVXHeWBEGTGJeZ6qlqb
	 Wb1EsFB8HGimi1bKJras8RyJRAo7mzG2H42CjsVjMdoZzHFluZ0W0MKRyYlsk1GANe
	 9+HdP9cfq4JITZUniwPlbIavO7grMM4/8dkahtGy+7ESTzT0Amh8W8t7BBwg9GIIlH
	 GiF86HBgnbd9OoUMPNAx6sZ3E6Bs+1eZ0JlK6+CNuRsgAWwbOOlb8lixBI/y/H5Oqu
	 L1ZpLOJVzL/Ew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 11/14] selftests: mptcp: sockopt: wait ack for huge transfer
Date: Sat, 11 Jul 2026 11:43:39 +0800
Message-ID: <d2c3f6a810173d3e4faf761fbf309e2ee4f0c70a.1783740443.git.tanggeliang@kylinos.cn>
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

Add wait_for_ack() helper to synchronize test steps by waiting until the
send queue is drained (all data ACKed). Used in server_huge_transfer()
to ensure reliable TCP_INQ validation.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index aebf22337b8c..1a5a7f25ae8b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -26,6 +26,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
@@ -598,10 +599,45 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
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
 	size_t i, total;
+	size_t sent;
 	ssize_t ret;
 
 	for (i = 0; i < sizeof(buf) - 1; i++) {
@@ -617,10 +653,13 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 
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
@@ -641,6 +680,8 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 	assert(ret == 4);
 	assert(strncmp(buf2, "shut", 4) == 0);
 
+	wait_for_ack(fd, 5000, sent);
+
 	ret = write(fd, buf, 1);
 	assert(ret == 1);
 	ret = write(unixfd, "closed", 6);
-- 
2.53.0

