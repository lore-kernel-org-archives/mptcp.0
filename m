Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADFA336EF8
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913549; cv=none; b=NDu7Pay/Rm3cMf+Ok5Q5DrOVdz+dSb3uMqwh8zkIaFYivBDELiRPoxiqlndU3OCk2prSpyNPIoFdVniIJdX+yz7lVMT/N1PgBZqdXzFqt57N1UMAi2gx0GRTs72D6QfdTb4PoIewAyVUzPE9Et0ABmsPc70Ok3Zcpklzt1JrXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913549; c=relaxed/simple;
	bh=4Duva9Yr7m3YD4xANgbhMjll3Y3NVXM8exAKoKCT1LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGN2S/1eUHrezqSLog63319L1u/L54RQjeEfWTWiOQtJynSOlHHOH8N4rGzXXWs/a3vUbw6UNaZ5pLHmXUcQVVg/TZyKrq3Z5EEFZ6NSu1RDqOFM0eVTKWnOLdTnA/fTmtwEtp72tr2UOyasluyhQUkwONuKVxcLvimTJhGNyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imkTZv7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imkTZv7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96151F000E9;
	Mon, 13 Jul 2026 03:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913547;
	bh=2s1KB6ti+ihgUmNauc/eKmN72UCpwvDtY4nIsjO0D2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=imkTZv7hrC0Gx4sGlaiHBOx6DbeFSd/jxOi2X8H5Ht0Xtgaw+wUJopg5w2ADz3bLp
	 UgqnE6DJ/gokINCqW0nGEIvTS9MHNkyI4MfzGQ9MLXUaWGhSx//DRc4OsJeTUhaA9k
	 Y1DjXx6ibVDRFgG8JdCBhqSpoan237XTKlWf4mvzTNzoekIL5n+CZkjDg5FAymx35d
	 cOwAOzszxJJL0UxpifVk4KwkO4eZKBowDtIb7kpQfxXIfp6LlADZqf7jZ/Rat+i3Ab
	 LuKphxSUdRwfJHOTFLj2rbbEmx38JTziu70KLng2266OxmNmQlM+2kwWJxtl06YQMH
	 8fHOhu/hGSLWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/5] selftests: mptcp: connect: add zerocopy io mode
Date: Mon, 13 Jul 2026 11:32:12 +0800
Message-ID: <bfd6822b343e5bd394f0339268fe7bbf1461b1bc.1783913332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913332.git.tanggeliang@kylinos.cn>
References: <cover.1783913332.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new I/O mode 'zerocopy' to the mptcp_connect selftest, which uses
sendmsg() with the MSG_ZEROCOPY flag to transmit data. This enables
testing and performance validation of the zero-copy send path for both
TCP and MPTCP connections.

This mode is useful for benchmarking and for verifying correctness of
MSG_ZEROCOPY handling in the MPTCP stack.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 120 +++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..715ccd98ff7d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -33,6 +33,7 @@
 #include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
+#include <linux/errqueue.h>
 #include <linux/compiler.h>
 
 extern int optind;
@@ -53,6 +54,7 @@ enum cfg_mode {
 	CFG_MODE_MMAP,
 	CFG_MODE_SENDFILE,
 	CFG_MODE_SPLICE,
+	CFG_MODE_ZEROCOPY,
 };
 
 enum cfg_peek {
@@ -125,7 +127,7 @@ static void die_usage(void)
 	fprintf(stderr, "\t-j     -- add additional sleep at connection start and tear down "
 		"-- for MPJ tests\n");
 	fprintf(stderr, "\t-l     -- listens mode, accepts incoming connection\n");
-	fprintf(stderr, "\t-m [poll|mmap|sendfile|splice] -- use poll(default)/mmap+write/sendfile/splice\n");
+	fprintf(stderr, "\t-m [poll|mmap|sendfile|splice|zerocopy] -- use poll(default)/mmap+write/sendfile/splice/zerocopy\n");
 	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
 	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
 	fprintf(stderr, "\t-p num -- use port num\n");
@@ -998,6 +1000,108 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	return err;
 }
 
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	size_t ctl_len = CMSG_SPACE(sizeof(struct sock_extended_err));
+	struct pollfd pfd = { .fd = peerfd, .events = POLLERR };
+	struct msghdr errmsg = {}, msg = {};
+	int sndbuf = size * 2;
+	int timeout_ms = 200;
+	struct iovec iov;
+	char *buf, *ctl;
+	socklen_t len;
+	int on = 1;
+	int err;
+
+	if (spool_buf(peerfd, winfo) < 0) {
+		perror("spool_buf");
+		return 1;
+	}
+
+	ctl = malloc(ctl_len);
+	if (!ctl) {
+		perror("malloc ctl");
+		return 1;
+	}
+
+	errmsg.msg_control = ctl;
+	errmsg.msg_controllen = ctl_len;
+
+	buf = malloc(size);
+	if (!buf) {
+		perror("malloc");
+		free(ctl);
+		return 1;
+	}
+
+	if (read(infd, buf, size) != size) {
+		perror("read input");
+		err = 1;
+		goto free_bufs;
+	}
+
+	iov.iov_base = buf;
+	iov.iov_len = size;
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	if (setsockopt(peerfd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf)))
+		perror("setsockopt SO_SNDBUF");
+
+	len = sizeof(on);
+	if (setsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, len)) {
+		perror("setsockopt SO_ZEROCOPY");
+		err = 1;
+		goto free_bufs;
+	}
+
+	on = -1;
+	if (getsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, &len) ||
+	    on != 1) {
+		perror("getsockopt SO_ZEROCOPY");
+		err = 1;
+		goto free_bufs;
+	}
+
+	if (listen_mode) {
+		if (do_recvfile(peerfd, outfd) < 0) {
+			err = 1;
+			goto free_bufs;
+		}
+	}
+
+	err = sendmsg(peerfd, &msg, MSG_ZEROCOPY);
+	if (err < 0 || (unsigned int)err != size) {
+		perror("sendmsg MSG_ZEROCOPY");
+		err = 1;
+		goto free_bufs;
+	}
+	err = 0;
+
+	if (!listen_mode) {
+		shut_wr(peerfd);
+		if (do_recvfile(peerfd, outfd) < 0)
+			err = 1;
+		*in_closed_after_out = true;
+	}
+
+	while (timeout_ms > 0) {
+		int n = poll(&pfd, 1, timeout_ms);
+
+		if (n <= 0)
+			break;
+		while (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) >= 0)
+			;
+		timeout_ms = 0;
+	}
+
+free_bufs:
+	free(buf);
+	free(ctl);
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -1038,6 +1142,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 				       &in_closed_after_out, winfo);
 		break;
 
+	case CFG_MODE_ZEROCOPY:
+		file_size = get_infd_size(infd);
+		if (file_size < 0)
+			return file_size;
+		if (cfg_sockopt_types.mptfo && winfo->total_len &&
+		    file_size > winfo->total_len)
+			file_size -= winfo->total_len;
+		ret = copyfd_io_zc(infd, peerfd, outfd, file_size,
+				   &in_closed_after_out, winfo);
+		break;
+
 	default:
 		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
 
@@ -1453,6 +1568,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1460,6 +1577,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.53.0

