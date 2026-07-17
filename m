Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832F304BDF
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263837; cv=none; b=MeCIukyBLYLSTFmdKKElnVc14p/kTb+vRt8UGTJ1PUrEM6Sy+iwD+6aOwnEFEgDGbmN+GJ7OL9B6633P/Tp0CBOChzXYARdmwXA3ZCQ4wJkxU7jqia7ZHBGCCh7n5wiUv0O/SO7czTpCe1lyu3GJmCAdRc2NHuHMYUNWgD+Mujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263837; c=relaxed/simple;
	bh=mB4ElubyuYVkTuLy6Ay8PCPnsTSm04VFaKyuPOovojo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld8oCoK8rAq1zA4UOZS4zN0HY8Ux01erROGtCjttMDiaba10funBu4nIkNHa03bRqatVoNr0kLLgUdVJ7IGkLgvS5KYHDpNSp5kQrZ692i5Bk7lnwMo/zVgzjSesjrEYERciJiJrL0uFe3kICvd8fvN7YgHNXb6PJuOtAvWbK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na42CF7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na42CF7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376211F00A3A;
	Fri, 17 Jul 2026 04:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263836;
	bh=NoHE9yCFCmcosyIGNKg3hVbsyiSvt+JXJynBvANWavU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=na42CF7pS98lQyH3H3OEbMct1VeAyiflA9vq2UNXp1AlwR/foxziGBLZtBIkQH6fi
	 7JcAtCuWJGmCpSek0Uwcci7Tr7+EQ2WsH4E6UJy0WR8T5mVp1CE1Tn578HQTH/RDBj
	 1wyGOZwMWsE3TVO1UDhxj1BvvjDwn5/bbMepAlzD+yP/CwHk0/wAYQUFpTgLCK+ySC
	 jFQt4+v+9mlue3vdFyUxkXb/bmXlQawF/NOTUK8Ub+DhqiKi1Jc6k1eN1Ix7gJ11LH
	 BPvYKQ3ESrC4Vw+eLBuw8ORkUERS2oi50XX0SCGN8ozwD92Ux10jrAa+vXtFAj4Yli
	 AkMlz6nHMxtbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 7/9] selftests: mptcp: connect: add zerocopy io mode
Date: Fri, 17 Jul 2026 12:50:16 +0800
Message-ID: <2e6b8d84bf48a8d7a9a5b4897786d0dc181ebe3f.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_connect.c       | 162 +++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..f6ebdc5bf745 100644
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
@@ -998,6 +1000,150 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
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
+	int i, timeout_ms = 5000;
+
+	if (cfg_time > 0)
+		timeout_ms = cfg_time;
+
+	for (i = 0; i < timeout_ms; i += 200) {
+		if (poll(&pfd, 1, 200) < 0)
+			break;
+
+		if (drain_errqueue_zc(peerfd))
+			break;
+	}
+}
+
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	struct msghdr msg = {};
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
+	if (listen_mode) {
+		if (do_recvfile(peerfd, outfd) < 0) {
+			err = 1;
+			goto free_bufs;
+		}
+	}
+
+	err = sendmsg(peerfd, &msg, MSG_ZEROCOPY);
+	if (err < 0) {
+		perror("sendmsg MSG_ZEROCOPY");
+		err = 1;
+		goto free_bufs;
+	}
+	if ((unsigned int)err != size) {
+		fprintf(stderr, "sendmsg short: %d/%u bytes queued\n",
+			err, size);
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
+	wait_for_completions_zc(peerfd);
+
+free_bufs:
+	free(buf);
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -1038,6 +1184,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
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
 
@@ -1453,6 +1610,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1460,6 +1619,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.53.0

