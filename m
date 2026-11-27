Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809731;
	b=OQ1B8z+ADLPZZ82hjRhDl2qwoAwl7HIdfHVydGgcqIB/XQVwX+xLDH6QzeQ7F0U4xpJ9
	 NIe8Pa25gLtsTRAvzCpFSpdJHfCgeQy3VDKluZ+BAY3p8+dFPIJhK/VginASQJnsGmq7w
	 CQYtUeYwaFYPFtpNl6B+Q+alWiGvi48hNlW4/CsWarTh/0VKyL8Fyg//A3yJgRYEOCgcp
	 TGfirLFIL0Z7QUjY/zu5JbHz8+gt612D2l9ee7L/fseG8i9xZeC8O8d4+U5a7v21MbK8U
	 Hon0D4w1Lmm3kZKSNL0BNpIT/QKCJBOMqZ+6DPOkh0XUhe3CInzUS41Kb1+3lls4QYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809731;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jdvNIuFiF7c2WLrU9wdVEPY34Wtk0JKJAPabdIK35ZA=;
	b=MgTDAY8VNZsNp+Fcc5CeoeyivJqd29d+2U7NV1rfWt4+hclOtRo2hBxiji09610SERfk
	 zvI1HCJ+W/JLOb9ouCD7RPR7QPSthKiZDOZPG51sYDR6QEY+EbjJwky2bHIXoUZ1Mzr7y
	 soFnepRrlKpdLB2MB6FDC2O10UmsTH/hiAYehHwvkRrRp+cbd4d68iiQrANisNQpjLsKQ
	 IrHtSnqe7m6XwSRZamkY6uj8koSQEQJCq6QmXBQcJ13I0yjJ5jhK5GrgGxgsOnn8k37o6
	 /y1oEUk2J+n1sLg31aalPzYTN2c4hF6ZPjpGfU0fF0RYlVBYB7oa+8r71Bkf9XOEy4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTnumOGz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE9606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTnumOGz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02601F000C1;
	Fri, 27 Nov 2026 20:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809731;
	bh=jdvNIuFiF7c2WLrU9wdVEPY34Wtk0JKJAPabdIK35ZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XTnumOGztjldcaR/5dIPQzMKkYILKb9Srw8FMAXpmI44UghXgAn8wE9y3qZGQLuyA
	 b5AbEQrQfVcYO4wnwUy8Uch3s8L5r50Iy1/heUcYP2qdHLtmAOpkNzwI0zD6umwAsb
	 OZ0tFVPrYKbg+7u2YLjJUczEUPkQsV7wywuqnQZ8bcya7wyFc/ncEgcPid5zGpSUbH
	 Mr3VpLNy9XgeuBX4PkDC5RLkfVeuwr45tcFgCWpdbvuHS4TSTpkaUdLv5u9StPr5fT
	 c+XQnI8VI9uGXTCzTbX8COKenEQLtImcd2rDfghU0DL8P9RwiAe2/FXznzzxiKXVro
	 fV0koXBSkuACA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:32 +0100
Subject: [PATCH mptcp-net v4 08/20] selftests: mptcp: connect: splice:
 handle MPTFO
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-8-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2866; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LG3Pz7btPobwU6rAagCP+cZn8lv8oGFyx1SgHmm+hVY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H6512t/UkOXRtJjxgEO+woU/VnvEfvkkVuruWs7DI
 33ATHt5RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQWtDH8lfSWeWmbz3VX4HkX
 J1PkVUMVE1YtVTORl1l/Ir1rS8QUGRnuVXw2D9BXssxh4Z6x5/b/ZeZme1u0nb9VTuc/5eK9s54
 fAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With MPTFO, the client reads the beginning of its input file to send it
with the SYN, and keeps the size of what it read in winfo->total_len. In
splice mode, this size is also removed from the length passed to
splice() when reading the reply: with an input file of 8 KB or less,
this length is 0, and the client never reads the reply.

The size of this file is random, and rarely that small. This has been
observed once, with a client file of 4252 bytes, and the test timed out:

  # INFO: with MPTFO start
  # 57 ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP     timeout
  (...)
  # (duration 61192ms) [FAIL] client exit code 0, server 143

It can be reproduced with small files, e.g. with '-f 4000': the file
received by the client is then empty.

Only use winfo when sending, and send what is left in the buffer first,
as the other modes do.

Fixes: 6a059c6bfb55 ("selftests: mptcp: add splice io mode")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 861fa2bd70d0..99e8278a1dd5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -971,13 +971,22 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 	return err;
 }
 
-static int do_splice(const int infd, const int outfd, const size_t len,
+/* winfo: only when sending, with what MPTFO did not send yet */
+static int do_splice(const int infd, const int outfd, size_t len,
 		     struct wstate *winfo)
 {
 	ssize_t in_bytes, out_bytes;
 	int pipefd[2];
 	int err;
 
+	if (winfo) {
+		err = spool_buf(outfd, winfo);
+		if (err)
+			return err;
+
+		len -= winfo->total_len;
+	}
+
 	err = pipe(pipefd);
 	if (err) {
 		perror("pipe");
@@ -985,7 +994,7 @@ static int do_splice(const int infd, const int outfd, const size_t len,
 	}
 
 again:
-	in_bytes = splice(infd, NULL, pipefd[1], NULL, len - winfo->total_len,
+	in_bytes = splice(infd, NULL, pipefd[1], NULL, len,
 			  SPLICE_F_MOVE | SPLICE_F_MORE);
 	if (in_bytes < 0) {
 		perror("splice in");
@@ -1017,7 +1026,7 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 	int err;
 
 	if (listen_mode) {
-		err = do_splice(peerfd, outfd, size, winfo);
+		err = do_splice(peerfd, outfd, size, NULL);
 		if (err)
 			return err;
 
@@ -1029,7 +1038,7 @@ static int copyfd_io_splice(int infd, int peerfd, int outfd, unsigned int size,
 
 		shut_wr(peerfd);
 
-		err = do_splice(peerfd, outfd, size, winfo);
+		err = do_splice(peerfd, outfd, size, NULL);
 		*in_closed_after_out = true;
 	}
 

-- 
2.55.0

