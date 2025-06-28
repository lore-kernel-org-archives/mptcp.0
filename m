Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B554A08
	for <mptcp@lists.linux.dev>; Sat, 28 Jun 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093887; cv=none; b=cZvwiWea+wixHZfZdldgWGBjgoolPKLgiyizXt3rdqxLGF3i6+weyxd11mPwm7aMQDEvtqVAntg0g3M/fkIo+7ENFnSAwYVW6jVpUnQ8zKnre5olPN6H6+Cgl8QN0QTflvOl43emeIDXkpRw9bwNtcNPuLYUm4tsWgwSIfpsEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093887; c=relaxed/simple;
	bh=bhuC2TqYyeTrDbPGob8gPdZZn5KwfuDrY1y5UaLO+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBUWlwU7XLh0a2YUvJTYq+veBQWijv4sidLTFSxmUYiFY1wT/UJdavfUhWVyyWI8k5rSioP9nDP4qIZCkxYXeSBFE11VNOaEYakwnwMpztpCjsexliRs65J1cfoD5E1+2zy+nDYnLor38mMWX8VUm/0zNmcOI+8HoYw8j4pst+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzSxO/GP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzSxO/GP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9873BC4CEEA;
	Sat, 28 Jun 2025 06:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751093886;
	bh=bhuC2TqYyeTrDbPGob8gPdZZn5KwfuDrY1y5UaLO+bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzSxO/GPQqvs1eK9gAGr7LZh3v0RA6ZoCvctxpDKxfbupBlc4Y4zs2KKRPLcDGjNS
	 VrFil+PnWKbbMmxo8u9kIQjucvxNGZ6ZWtIakoqDFOpwQVTj5MhviJkcQkEwy3l4AI
	 fqzCYgAjUzRx7FXQiUlI+nOqVksCcLInCgPSPQrZ6uwCdIzNhYqHTAWlysV+3Ycgav
	 an9qMHJXytoe540DhZdeNGqp1FUc8yqYuV7Ll5e+rZtvb/UOI9oe8oJwExFrTfEH43
	 j7WzODqnNB+xmDqQpUkvVIpoW6HwBCOGDk+8dpR0HyZJexCVO6NH34XxCRHz9Zhe7C
	 +p3VpgWICB/vA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/5] selftests: mptcp: add splice io mode
Date: Sat, 28 Jun 2025 14:57:13 +0800
Message-ID: <9d593d11dbe5aa772957a7f0ab7c27c8eac73eea.1751093346.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751093346.git.tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new 'splice' io mode for mptcp_connect to test
the newly added read_sock() and splice() functions of MPTCP.

	./mptcp_connect.sh -m splice

v2:
 - only use 'splice' mode for MPTCP fallback tests too.

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

