Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454452D5938
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083027; cv=none; b=MEaXoAHOkOHiJgPYsdLCe/STxqu5IZWoQ2aqwK/orFK5FVgF5UQsjhinXRdCjIHm9eNpND4SZPruscycaTXkEMupvuWm4fY0o/I9uRpPl3HtFHwgrv03hSALvfH5kdTyLVlqoZLB3b2KfZboJvcuZHpebSRYTjHc3ql+IDae1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083027; c=relaxed/simple;
	bh=qIBsqFVvBorBqc84mVDtrWVlmPySnuF9WwgXa52rhZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VwVdS/sOZUfa9rvy7ExRshiyeNtPujYquxc1WWi4ruZrCGJDW+Y77CMM3HqifHbF3M3hTESDnTYXqIYpxQyXqUi6KRqe9423XwuzNirjnbw17b9yxaSQ0xI75bXTWh1Fn9DnbgKeMmLbNyodoEYTfUIGtQV6dJHwnbyD2oWrFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2Eah65L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2Eah65L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E1C4CEFD;
	Sun,  2 Nov 2025 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083026;
	bh=qIBsqFVvBorBqc84mVDtrWVlmPySnuF9WwgXa52rhZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W2Eah65LJ2dS4T1flGSZBKHkf8VJu6ZHfGQjZkfRRCTMUmbY5qaeb+2R3ZyzMLtLM
	 G3+gAh+E9XDst9to5eZY9jBFVRXpYloyZVnad0UJfOZoQ+ydt8UIpX9GpnCimRRLh1
	 zWQHqNjVdQjxJUBlBuUacTpBFSm6rTv4IAG6XDzs8EOcEOJlIFO2M8W9l5G38MyODN
	 nFOpMwwPuyECdN7XBajGLfMzzGnikVUeHjo/dCNDYkB5WoEcwJL23JNO/i6vXExyB1
	 EMrTJos7ad7VBf5OBhaI/GhbA3cZHia5/1QtX7KhaSAGKJEJ7k2K+ingkxjaVK5wfi
	 VANhNYSnnlj2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Nov 2025 12:30:08 +0100
Subject: [PATCH mptcp-net v2 6/6] selftests: mptcp: connect: trunc: read
 all recv data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-slft-join-inst-v2-6-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qIBsqFVvBorBqc84mVDtrWVlmPySnuF9WwgXa52rhZg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHc68bYrat+dcde7Nv7ONjq2LX/SpSiiKLVY459EKo
 5PH/fL+dJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEsJCR4f0sL/4K8RCL3zsW
 nH3Bor6v5P2evc+2puR8X+rH2y+y8jYjw0vV0GMMW8V+zNx7csFCLa2P31a+vvd/UpLL5TSnJRx
 Wk3kB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

MPTCP Join "fastclose server" selftest is sometimes failing because the
client output file doesn't have the expected size, e.g. 296B instead of
1024B.

When looking at a packet trace when this happens, the server sent the
expected 1024B in two parts -- 100B, then 924B -- then the MP_FASTCLOSE.
It is then strange to see the client only receiving 296B, which would
mean it only got a part of the second packet. The problem is then not on
the networking side, but rather on the data reception side.

When mptcp_connect is launched with '-f -1', it means the connection
might stop before having sent everything, because a reset has been
received. When this happens, the program was directly stopped. But it is
also possible there are still some data to read, simply because the
previous 'read' step was done with a buffer smaller than the pending
data, see do_rnd_read(). In this case, it is important to read what's
left in the kernel buffers before stopping without error like before.

SIGPIPE is now ignored, not to quit the app before having read
everything.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - Also catch EPIPE, and ignore SIGPIPE
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c030b08a7195..404a77bf366a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -710,8 +710,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
-					if (cfg_rcv_trunc)
-						return 0;
+					/* expected reset, continue to read */
+					if (cfg_rcv_trunc &&
+					    (errno == ECONNRESET ||
+					     errno == EPIPE)) {
+						fds.events &= ~POLLOUT;
+						continue;
+					}
+
 					perror("write");
 					return 111;
 				}
@@ -737,8 +743,10 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		}
 
 		if (fds.revents & (POLLERR | POLLNVAL)) {
-			if (cfg_rcv_trunc)
-				return 0;
+			if (cfg_rcv_trunc) {
+				fds.events &= ~(POLLERR | POLLNVAL);
+				continue;
+			}
 			fprintf(stderr, "Unexpected revents: "
 				"POLLERR/POLLNVAL(%x)\n", fds.revents);
 			return 5;
@@ -1441,7 +1449,7 @@ static void parse_opts(int argc, char **argv)
 			 */
 			if (cfg_truncate < 0) {
 				cfg_rcv_trunc = true;
-				signal(SIGPIPE, handle_signal);
+				signal(SIGPIPE, SIG_IGN);
 			}
 			break;
 		case 'j':

-- 
2.51.0

