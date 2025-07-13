Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC05223DFA
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399847; cv=none; b=Xy5AG/R5bACVxKDDiswdqCr9IkAMgEezRLYuH4FQIbmACxNAAD4Jgl61my3Kr5Fv4LQN8PZgzxnQRfWu402G28HctunNRbeZeyEOaImZr3S4XB+Oflo1qv5pjZMc99wfcDtuJARitjU/4GVRl9B2lYnxJ+GS71pPdU60bjQ17Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399847; c=relaxed/simple;
	bh=qmn/hzWixyaXkO58tn8KmxTlHtv0NRCl4mPohlgGytE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+A356nnqurBYGgi/0Daf8fE+ZP2p0w7u/fjD96Pl5aQXvWhvgqtxQyLh//1dzBAoeO1VhVEMwMEPaM+sdOpF4uJa1ena80nrL1aA+sehfpO7irqysW51EyukFHWsr4B2Cj4DZmtoSvYo7Pvh3GcOCl5wpWRoImz9OJeIwcnpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4WfeEvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4WfeEvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D283BC4CEF1;
	Sun, 13 Jul 2025 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399846;
	bh=qmn/hzWixyaXkO58tn8KmxTlHtv0NRCl4mPohlgGytE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4WfeEvIZKX1sQ0jeSfJGrxAFrbwLPg7C1u9TGsZOooi4u9mxr9v42griOl3zeGvv
	 QL0n0v/ZfHRYISb3U9HamD2fr9o64Kqs1eSWwAhmMDQ+DmbfKm5MbbtBiV9t+VyiVQ
	 Drf2+RF9TLwUB9mdzjX8YJS0xEIt2oLAscEZl8RbZGtxqR9ZRMEInX3Np4/x+O9wKQ
	 ZxmJUaFxtfSQb/WTEOkG3dzAlchyC56+ef36sxihZx1+Mes7/YAVxFI140L/VM1JyB
	 x1hny5Wjpsa04i20fTA6m/EHqNrWAt+agpTM+taiGmGWjgG7u/98CK9tZVJY9zfepo
	 31ijk6i6FVTXQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 8/9] selftests: mptcp: add splice io mode
Date: Sun, 13 Jul 2025 17:43:48 +0800
Message-ID: <e3472d0ba6587846637227993a2a6df83fdf76fb.1752399661.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
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
index ac1349c4b9e5..4c219d620398 100644
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
@@ -925,6 +926,55 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
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
@@ -957,6 +1007,14 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
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
 
@@ -1361,12 +1419,15 @@ int parse_mode(const char *mode)
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
2.48.1

