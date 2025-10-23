Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C418239E97
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199035; cv=none; b=A5JHlvLVdBsBnFHvU9ZOENZD3rjDmRCd5B4oaIUfYcfn2cPCGdZy6ZZ9oUy+nURQNY4C6KjLTv7j/u8NcdWBA6rLm1AMwJNidNWzGptnvw8RE7HnZLI0cy8Iry4zvGvRUgJUUur4712FxZsIEvhZ0cXwZwfHnpE1xwIrK7ppD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199035; c=relaxed/simple;
	bh=u1OZJ9In7hfd07kTJbkYzYi2oSaHFfRsA0/bm+9E7ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muLSc8Vc8OqkKe/vPxgc3uz64j8Kc79cCkBBH88xzUgs0Ex8oWnrcG3JuSIsOf4uqtFg95FnShAN3ZYD54MHP0YfbKugtni6hAyr8wvPrA8N/AxmkWUo3qiqDjFgn1bXu+AZ482vgLUlk18lvdGFgxt7TVsMe7iFhAT/JBcOp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff+P7ds4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff+P7ds4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE1C4CEFB;
	Thu, 23 Oct 2025 05:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199034;
	bh=u1OZJ9In7hfd07kTJbkYzYi2oSaHFfRsA0/bm+9E7ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ff+P7ds4vc4gyg59nn0BZoyYk8ROLJx+4GYOXnB19Gn/bI3LxsNdiqHfkZEsn38Y3
	 nj1ZU9Ub818T4LyneSyODUmP26cy4zM6BKnQyLzMQx3gHwONH+aNenXJCbIKANzE5y
	 zIMTLoENUKTzbE2ZgpCA2/IyByKZt7zBiWctwIPnuRU/k0YE30LN23zLTd1wrH+0SB
	 urOsr+h7p6Di8/tCLbOSP1cnaq19LtRmMGKAb2m3SVT1s7gbqk1bGNw3V3FE88L/Jf
	 MikuNuD2bn2ALmNbetsGawywMzVxhha4/tIhdrAz78ZbD7Qt8ZgkEPr3vt0RXym86S
	 yVZyWMdOKnDLQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 7/8] selftests: mptcp: add splice io mode
Date: Thu, 23 Oct 2025 13:56:50 +0800
Message-ID: <427c47a3dbdcf1d42b1be8134fb7e5331ffc0dbb.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new 'splice' io mode for mptcp_connect to test
the newly added read_sock() and splice_read() functions of MPTCP.

do_splice() efficiently transfers data directly between two file
descriptors (infd and outfd) without copying to userspace, using
Linux's splice() system call.

Usage:
	./mptcp_connect.sh -m splice

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c030b08a7195..3834304f2b89 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -51,6 +51,7 @@ enum cfg_mode {
 	CFG_MODE_POLL,
 	CFG_MODE_MMAP,
 	CFG_MODE_SENDFILE,
+	CFG_MODE_SPLICE,
 };
 
 enum cfg_peek {
@@ -123,7 +124,7 @@ static void die_usage(void)
 	fprintf(stderr, "\t-j     -- add additional sleep at connection start and tear down "
 		"-- for MPJ tests\n");
 	fprintf(stderr, "\t-l     -- listens mode, accepts incoming connection\n");
-	fprintf(stderr, "\t-m [poll|mmap|sendfile] -- use poll(default)/mmap+write/sendfile\n");
+	fprintf(stderr, "\t-m [poll|mmap|sendfile|splice] -- use poll(default)/mmap+write/sendfile/splice\n");
 	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
 	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
 	fprintf(stderr, "\t-p num -- use port num\n");
@@ -926,6 +927,55 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 	return err;
 }
 
+static int do_splice(const int infd, const int outfd, const size_t len,
+		     struct wstate *winfo)
+{
+	int pipefd[2];
+	ssize_t bytes;
+	int err;
+
+	err = pipe(pipefd);
+	if (err)
+		return err;
+
+	while ((bytes = splice(infd, NULL, pipefd[1], NULL,
+			       len - winfo->total_len,
+			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0) {
+		splice(pipefd[0], NULL, outfd, NULL, bytes,
+		       SPLICE_F_MOVE | SPLICE_F_MORE);
+	}
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+
+	return 0;
+}
+
+static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
+			    bool *in_closed_after_out, struct wstate *winfo)
+{
+	int err;
+
+	if (listen_mode) {
+		err = do_splice(peerfd, outfd, size, winfo);
+		if (err)
+			return err;
+
+		err = do_splice(infd, peerfd, size, winfo);
+	} else {
+		err = do_splice(infd, peerfd, size, winfo);
+		if (err)
+			return err;
+
+		shut_wr(peerfd);
+
+		err = do_splice(peerfd, outfd, size, winfo);
+		*in_closed_after_out = true;
+	}
+
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -958,6 +1008,14 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 					 &in_closed_after_out, winfo);
 		break;
 
+	case CFG_MODE_SPLICE:
+		file_size = get_infd_size(infd);
+		if (file_size < 0)
+			return file_size;
+		ret = copyfd_io_splice(infd, peerfd, outfd, file_size,
+				       &in_closed_after_out, winfo);
+		break;
+
 	default:
 		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
 
@@ -1371,12 +1429,15 @@ int parse_mode(const char *mode)
 		return CFG_MODE_MMAP;
 	if (!strcasecmp(mode, "sendfile"))
 		return CFG_MODE_SENDFILE;
+	if (!strcasecmp(mode, "splice"))
+		return CFG_MODE_SPLICE;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
 	fprintf(stderr, "\t\t\"poll\" - interleaved read/write using poll()\n");
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.43.0

