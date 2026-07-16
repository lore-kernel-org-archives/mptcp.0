Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B8372EF7
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188300; cv=none; b=uHiXsZjZEa+QNgoQXFFUfr/EkpEqvkYnQUlz4ubO5tOAnWdhNBOAiikgt7BiXBTmZc0WaQRxP84ksMhZ+pPOXnhiH894cvfkImrrUrO4xD4ICY8260i/QSvxIhfXcwLxo+Nc+6bV8nhU6907DBkdWfng4RZZqmtM23FHjYoHMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188300; c=relaxed/simple;
	bh=HOTdH8eDacRqdEhZeGM23y42Ik5dXxC+sdAjGuwFoWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4RJi5PbKvWwxuqhkQQdN03gKjCj1P0TaHc3oBHVAhRB6C1zUTuRFgq/3MMvnelHJdhaXucs993wVd7ke3LAlXBiYRWJnb8FE7f4XyDt6BU56TrbIZE0rl7arWiiDAsbaefuo36b3SN/PtVHR+QtBnh0fMKXCDEuBu2pdKZgUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXHf5h1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXHf5h1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E221F00A3D;
	Thu, 16 Jul 2026 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188296;
	bh=z6NW5f2phGegZI7fpAJVzxrInrAxJqY9VH6SPTM/vto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXHf5h1nambMEaCXylLVaJd708sygqmvb+byyYV1VS9B5omBJNU8HECkyPfefT9cG
	 PRZZzLp7zq6C/z7PpmvSFoyy7O0JvXxwODPt7nEQFMZGKg3okGoIhjQSbPgURFw8FG
	 ld8uCe5xnAPOAExZiIV7hHhDL54e0FpWU/tEZpbqj/cGETVExKiw/SG2Dbw7dsWqA0
	 ksw5HBASZ1EuPHewwWc9bLl1copuy+Vlu8f6erIb0TO2cvNnUErhxBPVsBtk3vvnH/
	 D6NKGXZ79B7La5LImVpVefmjSiMc2mH/gZFnumaZficE5S1NUuyK+G0Cadb0EMurhr
	 K4++0zB8zyHNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 08/10] selftests: mptcp: connect: add zerocopy io mode
Date: Thu, 16 Jul 2026 15:50:47 +0800
Message-ID: <30b29493ed5bdb1862c3a8d227149ecc25ce63fd.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_connect.c       | 179 +++++++++++++++++-
 1 file changed, 178 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..63eb6e4dd4a7 100644
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
@@ -998,6 +1000,167 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	return err;
 }
 
+static bool process_zc_cmsg(struct msghdr *errmsg, unsigned int size)
+{
+	struct sock_extended_err *err;
+	uint32_t bytes_completed = 0;
+	struct cmsghdr *cm;
+
+	for (cm = CMSG_FIRSTHDR(errmsg); cm; cm = CMSG_NXTHDR(errmsg, cm)) {
+		if (cm->cmsg_level != SOL_IP && cm->cmsg_level != SOL_IPV6)
+			continue;
+		if (cm->cmsg_type != IP_RECVERR &&
+		    cm->cmsg_type != IPV6_RECVERR)
+			continue;
+
+		err = (struct sock_extended_err *)CMSG_DATA(cm);
+		if (err->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
+			continue;
+
+		bytes_completed += err->ee_data - err->ee_info + 1;
+		if (bytes_completed >= size)
+			return true;
+	}
+
+	return false;
+}
+
+static bool drain_errqueue(int peerfd, unsigned int size)
+{
+	size_t ctl_len = CMSG_SPACE(sizeof(struct sock_extended_err));
+	struct msghdr errmsg = {};
+	bool done = false;
+	char *ctl;
+
+	ctl = malloc(ctl_len);
+	if (!ctl) {
+		perror("malloc ctl");
+		return false;
+	}
+
+	errmsg.msg_control = ctl;
+	errmsg.msg_controllen = ctl_len;
+
+	while (1) {
+		errmsg.msg_controllen = ctl_len;
+		if (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) < 0)
+			break;
+
+		if (process_zc_cmsg(&errmsg, size)) {
+			done = true;
+			break;
+		}
+	}
+
+	free(ctl);
+	return done;
+}
+
+static void wait_for_zc_completions(int peerfd, unsigned int size)
+{
+	struct pollfd pfd = { .fd = peerfd, .events = POLLERR };
+	int total_ms = 5000;
+	int batch_ms = 200;
+	int max, i = 0;
+
+	if (cfg_time > 0)
+		total_ms = cfg_time;
+
+	max = total_ms / batch_ms;
+	if (max < 1)
+		max = 1;
+
+	while (i < max) {
+		if (poll(&pfd, 1, batch_ms) <= 0)
+			break;
+
+		i++;
+
+		if (drain_errqueue(peerfd, size))
+			break;
+	}
+}
+
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	struct msghdr msg = {};
+	int sndbuf = size * 2;
+	struct iovec iov;
+	socklen_t len;
+	int on = 1;
+	char *buf;
+	int err;
+
+	if (spool_buf(peerfd, winfo) < 0) {
+		perror("spool_buf");
+		return 1;
+	}
+
+	buf = malloc(size);
+	if (!buf) {
+		perror("malloc");
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
+	wait_for_zc_completions(peerfd, size);
+
+free_bufs:
+	free(buf);
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -1038,6 +1201,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
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
 
@@ -1453,6 +1627,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1460,6 +1636,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.53.0

