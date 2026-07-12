Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90560373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850106; cv=none; b=Kx6QSqPbycxD+oqcxSvcjJ8eywmOwwBsEHvgYxW0xyEwJz0BY+VuNjg6sAfQiBqdgdd7JtIr7lmFDJfIghSmfDWU2LgJJU0oVjbppMtLrBp9pxuEBOVHjAQy0CKQxoFSdFot/Gy0oWerIEM6daZBLNySdIbP8FHa/wn9o/rp4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850106; c=relaxed/simple;
	bh=3qCFmuVaFBMqCZounj08gh296xFMpZi7ef621Sch1iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMwEhCnbmxpzmj/1WiWReUqSKTPJ4hSEvoBE2zCwr0qCUr0qonQh+jhIDNUMvlkccQOyriLvAiIdi+8DRUZZU+jWHiPT9uAwMge5+pzm125r2tmWU2thgTmVfNEJVDHK/yhn1yxAAOoNGIo9XUD7tjkVPdTMUiS/nxAQ3cG8al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEjqnbCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEjqnbCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8229B1F000E9;
	Sun, 12 Jul 2026 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850105;
	bh=CTPfuOlRA6FSdS5gT9+iSiNHBvw1nFhY1/Z7GPUxjK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FEjqnbCVhQj/naIRBRCdqGPPUnikOaoETLdG/MmJ3VgZ8s7aPzGMSQogAsYLOPnHS
	 c8FUgdjvTr97bKlQ+uLAkB0uSqqLLzUDkFlck4KDd9iJYo16xzcqMSquTtN7C2Jrf+
	 8nB/xBSXc1cs34Soo6Jw8LUKU/bH06Ikw7PuaNAEE/aBMEReTprk8DlRBZD5huxaqk
	 kXYiu7HyRgXmj7EvgnD9aHtVtUlyeMdeQyM4u3pzmK/c4jIFg+gxTVpk31taMXNmIm
	 MffCCCFFrD5cPmDzGSLaTQPllOhB1dEGeVWax3cZVAGKTFOfCseOfCqDQ6x7rPGV0d
	 DxTeViBLx5ixg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 12/15] selftests: mptcp: sockopt: wait ack for huge transfer
Date: Sun, 12 Jul 2026 17:54:18 +0800
Message-ID: <00effe48c3f943dbf3d04688287d4515d89e22ce.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
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
index 4503ec87f374..dbf13ef02298 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -27,6 +27,7 @@
 #include <netinet/in.h>
 
 #include <linux/tcp.h>
+#include <linux/sockios.h>
 #include <linux/compiler.h>
 
 static int pf = AF_INET;
@@ -599,10 +600,45 @@ static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
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
@@ -618,10 +654,13 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 
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
@@ -642,6 +681,8 @@ static void server_huge_transfer(int fd, int unixfd, size_t len)
 	assert(ret == 4);
 	assert(strncmp(buf2, "shut", 4) == 0);
 
+	wait_for_ack(fd, 5000, sent);
+
 	ret = write(fd, buf, 1);
 	assert(ret == 1);
 	ret = write(unixfd, "closed", 6);
-- 
2.53.0

