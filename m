Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B4372EE9
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775307; cv=none; b=fuq66Lo7Pa1I0w95xOqP2eFTc3NzvuzCyoW1Bs52O3gF2XBnL1DU8BpZ6JgZvEid3SSOFztxpjUKkRwoSI0vyNxP2YCBUwVQ9LMJLUiM8N3eSoOVrXL1ukH38Sw0TeTgSDVQz+zPbgWpk/XRyqJeGpP6TaYaRWaN1RWVwvOl01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775307; c=relaxed/simple;
	bh=wGGj4mfCekdUcK3drDu8dMrZN9KG53Vze9S7YhqWi/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFyw8Bp2l5xYOiYFNhPczTbYnX4b2aXsX4HRyqzBxJIq2AEPOHls5JEmbeGlDmG4uCDKnu5EjZXAlFeKaCxFNrWNvwLanP4Lup37YimqwstyFl4JljPpCTYsx7Ef7CB8bV/U+b921bqsScO/hP12DKnhC6YbZmfbVypFydgUmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N94QaTKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N94QaTKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B721F00A3A;
	Sat, 11 Jul 2026 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783775305;
	bh=ynSNWd+QM95V3Q6eGhh4RYN57Qzluk1RKKihArqL+LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N94QaTKmT3gEnzteDrbGqg7F31ZW3GXnB6+vwD1A08ru4GV4Fqq8p+bRFVUZ3kYTC
	 Ax+/Zntx/WyBxO35O1vvOiMrYsYBTZ7jYXgQJa/0t7VrB3jZ16np3gX+BpqR2naThG
	 avUYz/E8T1xECcenjFfmjD7Q72ZyFDS8fgEE0aBjlPX8ulOhtq52YIn1UDoWR4C3HR
	 GBu32X1ea93NtLnJjAb1fjtmekjAyWJdZs9wuGO+pV9TvN4IzvD1Fu2rMZKhPCvmir
	 /iqdfIotgFZ4SMlmJlxz8UzhExiPW7SrZ3HgqO000QksnZv1ACmg/CtaPrHMzoQX0t
	 U71sjgwc+FAug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/4] selftests: mptcp: connect: add zerocopy io mode
Date: Sat, 11 Jul 2026 21:07:51 +0800
Message-ID: <40bcb0d6fc245cc063cd1ff3360eafbe4facdd79.1783774784.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783774784.git.tanggeliang@kylinos.cn>
References: <cover.1783774784.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_connect.c       | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..11012dadfa70 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -53,6 +53,7 @@ enum cfg_mode {
 	CFG_MODE_MMAP,
 	CFG_MODE_SENDFILE,
 	CFG_MODE_SPLICE,
+	CFG_MODE_ZEROCOPY,
 };
 
 enum cfg_peek {
@@ -125,7 +126,7 @@ static void die_usage(void)
 	fprintf(stderr, "\t-j     -- add additional sleep at connection start and tear down "
 		"-- for MPJ tests\n");
 	fprintf(stderr, "\t-l     -- listens mode, accepts incoming connection\n");
-	fprintf(stderr, "\t-m [poll|mmap|sendfile|splice] -- use poll(default)/mmap+write/sendfile/splice\n");
+	fprintf(stderr, "\t-m [poll|mmap|sendfile|splice|zerocopy] -- use poll(default)/mmap+write/sendfile/splice/zerocopy\n");
 	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
 	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
 	fprintf(stderr, "\t-p num -- use port num\n");
@@ -998,6 +999,52 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	return err;
 }
 
+static int copyfd_io_zc(int infd, int peerfd, int outfd, unsigned int size,
+			bool *in_closed_after_out, struct wstate *winfo)
+{
+	struct msghdr msg = {};
+	int sndbuf = size * 2;
+	struct iovec iov;
+	char *buf;
+	int err;
+
+	buf = malloc(size);
+	if (!buf) {
+		perror("malloc");
+		return 1;
+	}
+
+	if (read(infd, buf, size) != size) {
+		perror("read input");
+		free(buf);
+		return 1;
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
+	err = sendmsg(peerfd, &msg, MSG_ZEROCOPY);
+	if (err < 0 || err != size) {
+		perror("sendmsg MSG_ZEROCOPY");
+		free(buf);
+		return 1;
+	}
+
+	err = 0;
+	shut_wr(peerfd);
+	if (do_recvfile(peerfd, outfd) < 0)
+		err = 1;
+	*in_closed_after_out = true;
+
+	free(buf);
+	return err;
+}
+
 static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
@@ -1038,6 +1085,17 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
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
 
@@ -1453,6 +1511,8 @@ int parse_mode(const char *mode)
 		return CFG_MODE_SENDFILE;
 	if (!strcasecmp(mode, "splice"))
 		return CFG_MODE_SPLICE;
+	if (!strcasecmp(mode, "zerocopy"))
+		return CFG_MODE_ZEROCOPY;
 
 	fprintf(stderr, "Unknown test mode: %s\n", mode);
 	fprintf(stderr, "Supported modes are:\n");
@@ -1460,6 +1520,7 @@ int parse_mode(const char *mode)
 	fprintf(stderr, "\t\t\"mmap\" - send entire input file (mmap+write), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"sendfile\" - send entire input file (sendfile), then read response (-l will read input first)\n");
 	fprintf(stderr, "\t\t\"splice\" - send entire input file (splice), then read response (-l will read input first)\n");
+	fprintf(stderr, "\t\t\"zerocopy\" - send entire input file (zerocopy), then read response (-l will read input first)\n");
 
 	die_usage();
 
-- 
2.53.0

