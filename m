Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7002BEFF1
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988508; cv=none; b=Tm/W8XFLN1HbrTadKGDjpd4haQD5d3HczoJmLW5+fZiUIjBpi307ZejbU25z+rYLBMRYeli70ZIITzI8BUuceuYgzGsgm3ZfHzWA7wPP2fJWi/dPSxgZIYFd/3qnL3pFNSbGr9vX+Yn7O/yDp7PAC6Zh7jNvT7MIOqPsS7AZf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988508; c=relaxed/simple;
	bh=mmxZqX7Mj5b4ZP2T2+tx6rK6JsYV9Adi9IOdoGMvEUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POXXci902IR82u1orbMztHLPVL7Nq4QaojXh/AMZ9Ef7SEv/zw+BB9IHLD7ABYFFoWJk33oJfawEN/51toExKwPzm2IAEXTp5oY/fFI4Ql5OtfbeP4cUr6lAyPj/TF+nvk5Zz9GUXcm70shfm1x1k4+wH1cAvwmVLGp7S7/+lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GopGl/73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GopGl/73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1596C116B1;
	Sat,  1 Nov 2025 09:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761988505;
	bh=mmxZqX7Mj5b4ZP2T2+tx6rK6JsYV9Adi9IOdoGMvEUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GopGl/73Fl2VdQe8vkgMcnIhI7lzqddXPeU+7s3E/cjTGkV1DCUMy/EhOOaeG7Jne
	 fER1m0BAwBbDn92MimRat4ss7j9ig/Pp87tAuf2jJfd28fhx+oqKJ8L0KRCgRnpX+P
	 maUG/AREWSOzLIpVOrUYHdYE86aoz+Vza+CBRpUQOXSANH5LHKVnday//wINHeRZmc
	 LORhsAenXikj13ytJnNH9D2quhI8M6+kkICckF1AjdRZ2i1lXggxdLsrsWDodde4B7
	 /YJD+tnwRGoZSI7zdZjCu11QXliTgq27k2E2MfaObwCgbAd5ATI9RUqxxHJcJbd1c5
	 J1S3v8oZBDXVQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 10:14:47 +0100
Subject: [PATCH mptcp-net 6/6] selftests: mptcp: connect: trunc: read all
 recv data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-slft-join-inst-v1-6-10572512a0b2@kernel.org>
References: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
In-Reply-To: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mmxZqX7Mj5b4ZP2T2+tx6rK6JsYV9Adi9IOdoGMvEUE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJZz09idGpLuu2X4SzqcojN9U6I/LlEUcHqL75H/BI+z
 hGpnrako5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJFXxkZ/m0IKf6RuLc7fs2W
 g7VRvincrMaqxbf/++dyyf5ji+iJZWSY+2BV6QrR93NWVFSrzJ4df8rjYCqv2Lbm3p1+Wnd6g6Y
 xAQA=
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

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c030b08a7195..6ad2126b08a7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -710,8 +710,12 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 
 				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
-					if (cfg_rcv_trunc)
-						return 0;
+					/* expected reset, continue to read */
+					if (cfg_rcv_trunc && errno == ECONNRESET) {
+						fds.events &= ~POLLOUT;
+						continue;
+					}
+
 					perror("write");
 					return 111;
 				}
@@ -737,8 +741,10 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
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

-- 
2.51.0

