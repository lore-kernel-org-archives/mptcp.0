Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422007;
	b=aDbnk1pLESnLobo9B+tx/Qo2yieAgbTeQO/Qbhrbg7Gh/NnWgdf5Y28A4HqYrMvz/doA
	 4irfQWLvUobVOTz/OEuXtrb6GYEr/G+Xduo/ojBOXijx8GFeIwca+CPJFGMLjFFHZYjcJ
	 gLTrtHq9Z6c7b4wAluLKAAyZgpB1XOvZk+Jhu7GfEX70sjdpm50Tt8K7rsCKfP1LYZikQ
	 E3gtlYl0uBC2Es3rFpBMKaRVKiYuJGRFSBQxErRH7RKBXh4XJ5RBTH3IipYqCQrYXUQn6
	 DLJjWlIrd6XqNsidIPwkN8ZYOHqabRVAZsX+y2D4TmGpjesDKFKvlT0y1fC+6UJGLQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422007;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AB/CMoaj6flTFgIbh2N+DHP96Aht/jjnr/mmU3FSsmo=;
	b=EtO2vEHX3VniQOf4v8bH28gk78SPBQgTClO+4AVmFNKapukkffbzMw0I9UNjCjXJH2iY
	 zQoNAOHnaKTtmMOhJB94VQCnulUZ0dGeFCZrCqwzlEMCoSD2GpxAT8XJtqUUm+4sL7ZSs
	 i1imfQAuUZDfkj2kzXaKxu2hdaWdZmdcWlJZ/U6GrE9RMZhib7O0Pgck72jNRX3uzdBfA
	 wZ4z3NBUvK6X+yoFGoi9Qoz4Y3K3lvyKl3LSibU0+RYHxgHAW++OhH4ftAyx1CMj3F1vk
	 3DA4Xxb9d+6H7U7sNEcB1iPu6e+bcViE2BqWt7ADP5MSEa84z+5JawdRGetz8acM60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzZL3Gzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F0606A327
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzZL3Gzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42B01F000D4
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422006;
	bh=AB/CMoaj6flTFgIbh2N+DHP96Aht/jjnr/mmU3FSsmo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=AzZL3Gzit58SidsDeowbQ7sctVU5PYC/48fc3t+f5cmKEFFbdNH03oggMGsstso0O
	 q3LrnUE1UXpIGM/1JDacxNdYPniKavzJENpnugTBNpmCCO6d8ejXZRvQtryY9Wzdt5
	 xQuFiAIUhQldEIzRSjmgnpaugXMYZqtBYyXaUfZ21YnIwe4J1xaKAVXvY871J7aZch
	 Dlj0z5zhe1L8js5GTkX9P44Yh9PPDIZFF4cgQ0VlHu/Jy7UQks5J3/+iMGRZ8FPdD2
	 kt7BvPtbSF+lvTf7fWsyi+Ow0WXtrB+xNgSG+TAjcmInPOGCL0MuUspQ8FPI2ECi3V
	 UqhnP2qQy6anA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 6/7] selftests: mptcp: connect: add zerocopy io mode
Date: Mon, 23 Nov 2026 16:19:49 +0800
Message-ID: <9d10433a1bc453357a5994906ff3029f0e1f76a1.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
 .../selftests/net/mptcp/mptcp_connect.c       | 192 +++++++++++++++++-
 1 file changed, 191 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 8c788977e594..08fd50513203 100644
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
@@ -1014,6 +1016,180 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	return err;
 }
 
+static bool process_cmsg_zc(struct msghdr *errmsg)
+{
+	struct sock_extended_err *serr;
+	struct cmsghdr *cm;
+
+	for (cm = CMSG_FIRSTHDR(errmsg); cm; cm = CMSG_NXTHDR(errmsg, cm)) {
+		if (cm->cmsg_level != SOL_IP && cm->cmsg_level != SOL_IPV6)
+			continue;
+		if (cm->cmsg_type != IP_RECVERR &&
+		    cm->cmsg_type != IPV6_RECVERR)
+			continue;
+
+		serr = (struct sock_extended_err *)CMSG_DATA(cm);
+		if (serr->ee_origin == SO_EE_ORIGIN_ZEROCOPY)
+			return true;
+	}
+
+	return false;
+}
+
+static bool drain_errqueue_zc(int peerfd)
+{
+	size_t ctl_len = CMSG_SPACE(sizeof(struct sock_extended_err));
+	struct msghdr errmsg = {};
+	bool found = false;
+	char *ctl;
+
+	ctl = malloc(ctl_len);
+	if (!ctl) {
+		perror("malloc ctl");
+		return false;
+	}
+
+	errmsg.msg_control = ctl;
+
+	while (!found) {
+		errmsg.msg_controllen = ctl_len;
+		if (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE) < 0)
+			break;
+
+		found = process_cmsg_zc(&errmsg);
+	}
+
+	free(ctl);
+	return found;
+}
+
+static void wait_for_completions_zc(int peerfd)
+{
+	struct pollfd pfd = { .fd = peerfd, .events = POLLERR };
+	struct timespec start, now;
+	int timeout_ms = 5000;
+
+	if (cfg_time > 0)
+		timeout_ms = cfg_time;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (;;) {
+		long elapsed_ms, remaining_ms;
+
+		if (drain_errqueue_zc(peerfd))
+			break;
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed_ms = (now.tv_sec - start.tv_sec) * 1000L +
+			     (now.tv_nsec - start.tv_nsec) / 1000000L;
+		if (elapsed_ms >= timeout_ms)
+			break;
+
+		remaining_ms = timeout_ms - elapsed_ms;
+		if (remaining_ms > 200)
+			remaining_ms = 200;
+		if (poll(&pfd, 1, remaining_ms) < 0)
+			break;
+	}
+}
+
+static int do_sendmsg_zc(int infd, int peerfd, size_t size,
+			 struct wstate *winfo)
+{
+	struct iovec iov = {};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	size_t sent = 0;
+	ssize_t ret;
+	void *buf;
+	int err;
+
+	err = spool_buf(peerfd, winfo);
+	if (err)
+		return err;
+
+	buf = malloc(size);
+	if (!buf) {
+		perror("malloc");
+		return 1;
+	}
+
+	if (read(infd, buf, size) != (ssize_t)size) {
+		perror("read input");
+		err = 1;
+		goto out;
+	}
+
+	while (sent < size) {
+		iov.iov_base = buf + sent;
+		iov.iov_len = size - sent;
+
+		ret = sendmsg(peerfd, &msg, MSG_ZEROCOPY);
+		if (ret <= 0) {
+			if (ret < 0) {
+				perror("sendmsg MSG_ZEROCOPY");
+				err = 1;
+			}
+			break;
+		}
+		sent += ret;
+	}
+	if (sent != size)
+		fprintf(stderr, "sendmsg short: %zu/%zu bytes queued\n",
+			sent, size);
+
+	if (size > 0)
+		wait_for_completions_zc(peerfd);
+
+out:
+	free(buf);
+	return err;
+}
+
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	socklen_t len;
+	int on = 1;
+	int err;
+
+	set_sndbuf(peerfd, size * 2);
+
+	len = sizeof(on);
+	if (setsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, len)) {
+		perror("setsockopt SO_ZEROCOPY");
+		return 1;
+	}
+
+	on = -1;
+	if (getsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, &len) ||
+	    on != 1) {
+		perror("getsockopt SO_ZEROCOPY");
+		return 1;
+	}
+
+	if (listen_mode) {
+		err = do_recvfile(peerfd, outfd);
+		if (err)
+			return err;
+
+		err = do_sendmsg_zc(infd, peerfd, size, winfo);
+	} else {
+		err = do_sendmsg_zc(infd, peerfd, size, winfo);
+		if (err)
+			return err;
+
+		shut_wr(peerfd);
+
+		err = do_recvfile(peerfd, outfd);
+		*in_closed_after_out = true;
+	}
+
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -1054,6 +1230,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
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
 
@@ -1470,6 +1657,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1477,6 +1666,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.55.0

