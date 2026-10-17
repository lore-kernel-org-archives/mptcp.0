Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BC2C08BB
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792227219; cv=none; b=L/w3lYUGZEk2KqdqQYHDFjZs64YvyFvMeklzUBfJ8a17rFCyX2yLOhDGjSufO9qrPf4kTtItB90YFRuUh1gJsjwO/7x/+n3flGWdnbkW8jIlRAKoS1INxnqC+NuZZMlgTEGYGFgQPytBWgGucFBOhqp/bk7M4kRX0UKQDvpqoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792227219; c=relaxed/simple;
	bh=sKEs7E2FcSaNFN2gRH6TrCTNNM5eyBpEF/9U1lXOC9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X/Iv8VdBy9zU5hWowfbgdBLMtzCJrt54kNtAe5mshwKWqFejGHvbx58fuhfT/0xzd+5zoBk45IcHDJcqdthQMytOOxRxU9NGHA+O4+FBkZTyw3rKa/znylEWDecnGTZt29nLzmOM4jgGWw1tcp+I9jgqLEdT14vbBmkv4I0jQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVYKxKYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVYKxKYx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D003C2BCF5
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792227219;
	bh=sKEs7E2FcSaNFN2gRH6TrCTNNM5eyBpEF/9U1lXOC9c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DVYKxKYxbv9MB7eCMWQ8ajaQUJFUJCAek8zxAvAQ9gXXzhRZpjA6Lo8bbDZ9UOjcH
	 a6TG3q5YLX1O8HX6OHTFW5SCu35rMygxKKcIUIwAx/baA3smDloaPXkKIlGJ+qGEEn
	 FwYCIPlPOC13Bm8Pe8O3bOPx0GDhAvgm76XA/F7Lqb/xdtD9Eopn09COe3ahcqtc0I
	 lE6+m0QA+3LeRhMjFdrGVcQESlViXrGnvhuDZrvJwmYdr8vVTTK6l4e0Mnwm0dTap0
	 FyCRiuBg7Xp5Fzr7wrWujFH5s4liZMauygkSsQyDhvRQQcI4s9UVCOvF92tkZE1tRE
	 4rmqWg/QiwZjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A75BCCF2C9
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 08:53:39 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 17 Oct 2026 01:53:38 -0700
Subject: [PATCH mptcp-net] selftests: mptcp: sockopt: drop unreachable FIN
 accounting
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-fix-mptcp-issue-637-v1-1-cda9bf1c79de@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kBGrSm9SnFh4lSn0DRkohTEu
 zfV5eO//zZQTsIK92qDxKuofEIBulTg5yFMjDIWhtrUHRmy+JQvvmP2EUV1Yewai8ZRa6kd3PX
 moDxj4qId1QeccuAM/Tnp4l7s878K+/4D6FUn3IIAAAA=
X-Change-ID: 20261017-fix-mptcp-issue-637-0b14714ab58b
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792227218; l=2417;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=ZpuiPIB1QPb3VfM2ymJIY8rzST/1xBmMmukn2oZWteo=;
 b=BeOP1DqZ/SubdQM53wLwhMHTnd1mlQTstUn+9MPvSbF0jX+bNF7zd/uVgzLYP4ZvDB/rl49Nj
 dwcljeOQjNLCLEkztvsAZ+YC69voT55zw1APHdJCscUHDKCwl949tv8
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

connect_one_server() sets eof when read() returns 0, then immediately
checks total != len. The receive loop only observes EOF while total is
still below len, so that check always fires and xerror() terminates the
process. The later if (eof) block that increments total for DATA_FIN is
therefore unreachable.

The client also does not wait for the peer to close: process_one_client()
blocks on hangup first, so a peer DATA_FIN cannot arrive before this
assertion. DATA_FIN sequence advancement is already checked on the server
after EOF. Treat an early EOF as a hard error and drop the dead
adjustment.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/637
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..20e0050e7cd7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -572,7 +572,6 @@ static void connect_one_server(int fd, int pipefd)
 	char buf[4096], buf2[4096];
 	size_t len, i, total;
 	struct so_state s;
-	bool eof = false;
 	ssize_t ret;
 
 	memset(&s, 0, sizeof(s));
@@ -610,16 +609,15 @@ static void connect_one_server(int fd, int pipefd)
 		ret = read(fd, buf2 + total, sizeof(buf2) - total);
 		if (ret < 0)
 			die_perror("read");
-		if (ret == 0) {
-			eof = true;
-			break;
-		}
+		if (ret == 0)
+			xerror("unexpected EOF, total %lu, len %lu\n",
+			       total, len);
 
 		total += ret;
 	} while (total < len);
 
 	if (total != len)
-		xerror("total %lu, len %lu eof %d\n", total, len, eof);
+		xerror("total %lu, len %lu\n", total, len);
 
 	if (memcmp(buf, buf2, len))
 		xerror("data corruption");
@@ -629,9 +627,6 @@ static void connect_one_server(int fd, int pipefd)
 
 	do_getsockopts(&s, fd, ret, ret);
 
-	if (eof)
-		total += 1; /* sequence advances due to FIN */
-
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261017-fix-mptcp-issue-637-0b14714ab58b

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


