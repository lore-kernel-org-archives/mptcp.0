Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535E2C1594
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822562; cv=none; b=KOBfFEIALY5NvD6Y4ySJQB8GrBvFEvlpH8n32bkcfeVBS4VfGTFWJ1xztXVAVp1OU39KXl4N3nDrEBlY5UQ694qvVdlKrynLbsPuQd8f2WbzqNDIER86TfCzdLkrSZJyytqkltE6YlAzN6A2adJCijKvz0w83iS2G8Oai8fhmJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822562; c=relaxed/simple;
	bh=owLH+gb7OvY00mvj5JQkSym7AEf/tCeiQchTf6ZWAy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn421zZy/MhM3RIaLB40rjD7CGWlIHhVkKJPDjxuqLT/todEWGf2nEXNMOzLpiDTYkB701awQW+BeteBU6eykPjajhs3SdQUAH4opXT2ZY0JraRDFF8hlxQFbm96C19SugVtDctlznEmXQrEDcsDMQWvpOdfdCaWIwJV/dxhorw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4d+o8h2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4d+o8h2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9891F00A3D;
	Sun, 12 Jul 2026 02:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822560;
	bh=axjLnQ+S8CQ93he7gZ11b1dSyULFKMxC9Czno+GfL4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4d+o8h2jqul/vD77rfJEN36nc5vSpvMom4WBP4nmHS3wg9zQLRtUI53oZPXalpFQ
	 nRDmPgQTtuzoQ3OszirGdcTbaRRuSd9apapV8s/4uO+JkYEo+wLV6OcuL88BRB2OJc
	 nbTznySZNwozRhGLUYVQc/T4k6Aq5SX3TqN1+12Uxr7iXE8GVhNw7pjU78LTu1rVTq
	 RJ0h48r0TVxNs7xmnwUM3h117w795Ph2F6gxEH4vXvi13CJ/PYhjYD7XcfollA47a3
	 GQU8Qcwabq41jELhZgNP28tPD8b/A4LdnMj6LAG+ogFA2bA2ih8ZlMCiCCofRUgaqx
	 XU/fb1jWWiIeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/5] selftests: mptcp: connect: add zerocopy io mode
Date: Sun, 12 Jul 2026 10:15:23 +0800
Message-ID: <77cfd82ece03d7ad82cc9b2c824cf8cf878df7db.1783821830.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783821830.git.tanggeliang@kylinos.cn>
References: <cover.1783821830.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_connect.c       | 96 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..770b94e3a2ca 100644
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
@@ -998,6 +1000,84 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	return err;
 }
 
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	size_t ctl_len = CMSG_SPACE(sizeof(struct sock_extended_err));
+	struct msghdr errmsg = {}, msg = {};
+	int sndbuf = size * 2;
+	struct iovec iov;
+	char *buf, *ctl;
+	int on = 1;
+	int err;
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
+	if (setsockopt(peerfd, SOL_SOCKET, SO_ZEROCOPY, &on, sizeof(on))) {
+		perror("setsockopt SO_ZEROCOPY");
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
+	while (recvmsg(peerfd, &errmsg, MSG_ERRQUEUE | MSG_DONTWAIT) > 0)
+		;
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
@@ -1038,6 +1118,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
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
 
@@ -1453,6 +1544,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1460,6 +1553,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.53.0

