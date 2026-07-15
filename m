Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9632931D7
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113452; cv=none; b=Ig1kysh6dBtr0GmydgnExuvF9a8gR2PIJfjCA70FJrTi5F6PCL5gEBKhsA0kNIg6VXiA/Z/5OkO84FB2xak9ttzSbwGfqlf4N+H3PKaCiTDnZmTTAQEIxUMNsoL+b3gIZgcFeuRWriwZsiGFGpkMvC7htZApbJsfozhlIBj0330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113452; c=relaxed/simple;
	bh=h025n3Wk0LwTydM3OCfHMUkLdzBmNNCOsfttMCMbrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPxY4bFGnBiQzPdFrTo7ZRJ3V0ml4yUyUE1lY/v5hl4vkwxzN8DuIQcCPswXvaF1urBvJ1CIyukyxZ/xeoXcEPZ8R7Yqx7QuOtzwCFxD+94NtWIFBdZTr/Tml6EB7NXc795QSO2vlFcQ0e4c0TwD/xwDmoyTdI0q9djAzkTgwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHF13Uoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHF13Uoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409C91F000E9;
	Wed, 15 Jul 2026 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113450;
	bh=tiDZpWkvrhgwsDO/miQ045VyimJeEcIeLwgrT2qidqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHF13UooKLb/kYYOgNAvPP2elx6ZLAdYI0VF2Sf/1CqZWI9GbVgBDu1WK9q/6OQDw
	 HCQhht50PtBeSXNK8e+5BXAGRu3PKJsK+KEt1P6e4l3xSx6NwxMydL85sk+8CLx7uu
	 uPXWP9quWzCOx9vWpGhrsu6rvQymNVOpYPRNZmvyFxROFm5hyibwgJe8XRT6NSvA+K
	 tMaY/whbtqh1Z5AmtwxNQBQ+WFHA7NEo0nxN8ZO9RX9TH2FzU5D+0t9lK4mVghDxCE
	 bq/sJus4el1/AjjToDNyoRKo4fofAlpuu/ud+nxQulCxgHTOv/xe9jLajqUDmtke7i
	 CBY5XtM/6mUbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 6/8] selftests: mptcp: connect: add zerocopy io mode
Date: Wed, 15 Jul 2026 19:03:51 +0800
Message-ID: <d1f4a4ec636e58d21a82919731fc7cf91205ebb0.1784113088.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784113088.git.tanggeliang@kylinos.cn>
References: <cover.1784113088.git.tanggeliang@kylinos.cn>
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

The completion notification draining uses batched polling to handle large
transfers that may generate multiple completion events across different
TCP segments.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 122 +++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..4670c194672d 100644
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
@@ -998,6 +1000,110 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	return err;
 }
 
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	size_t ctl_len = CMSG_SPACE(sizeof(struct sock_extended_err));
+	struct pollfd pfd = { .fd = peerfd, .events = POLLERR };
+	struct msghdr errmsg = {}, msg = {};
+	int sndbuf = size * 2;
+	int total_ms = 5000;
+	int batch_ms = 200;
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
+	while (total_ms > 0) {
+		int n = poll(&pfd, 1, batch_ms);
+
+		if (n <= 0)
+			break;
+		do {
+			errmsg.msg_controllen = ctl_len;
+		} while (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) >= 0);
+		total_ms -= batch_ms;
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
@@ -1038,6 +1144,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 				       &in_closed_after_out, winfo);
 		break;
 
+	case CFG_MODE_ZEROCOPY:
+		file_size = get_infd_size(infd);
+		if (file_size < 0)
+			return file_size;
+		if (cfg_sockopt_types.mptfo && winfo->total_len &&
+		    file_size >= winfo->total_len)
+			file_size -= winfo->total_len;
+		ret = copyfd_io_zc(infd, peerfd, outfd, file_size,
+				   &in_closed_after_out, winfo);
+		break;
+
 	default:
 		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
 
@@ -1453,6 +1570,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1460,6 +1579,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.53.0

