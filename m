Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270649C4A2
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063244; cv=none; b=njITR5igJyX3hpouj70zChY4C7G7qzyCk6GRQ4vyQ5zXZYON6h9nsJl7puoe+wTVDiUNbEVDYbc7fcaFoJVTxuJTYSWk1eaUNcbmf2lK1Seazb7nqZbWsVG9HUaxmTrnQkIDcUgin2PsgpdULGELZFi4Zf6/hQrg0jeyPSsA7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063244; c=relaxed/simple;
	bh=dEDdI2b9/Qz6iJQh5uyMTd7SYYoijk7LcgUhZNiSI14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kCgdMXiIOyeP09+0shS/xhOj+ioXrW0EjbF8/DlhkQTIqoa6ETrFpj0TqgcbqMW1d0QbwbE1or0MCGQYr19DlBgs+HtltOYUXx5DC4eDQfZcSccL/wJi6c7O7+7NsFatYglDQMrqpYrtpS30Y7ibvIyUMFpu1W4Vs2s35v6tR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRZJTb/i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRZJTb/i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4B36C2BCC7
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792063243;
	bh=dEDdI2b9/Qz6iJQh5uyMTd7SYYoijk7LcgUhZNiSI14=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZRZJTb/irciFDJgLShftmzgEDJwUHKUFaboeBemHoVm0U7dF5FHEnc6nebJkUSPJ+
	 QYaVsv6B+7VaaWpz+Pot9RZntMMXcpsqzEtukFFCeqK36f+pKYlEtYceIH8IHXVOtu
	 BBbrMgUkbtdMbL+kM8a+O+rYPcsdjc0AQFMot7nGq+UiG4UkQaDAy9kZTuQMhBCdnt
	 nutUp9vFCn0vv+LpCFuz8o/ZLhNUZx29mN6Ww0mH9zfCeaptzsd+YbKJlYTrS53ysj
	 7nZUK6Boe2ngL/YSIwpmogzlSDrtnRcXku7a83iue/ek9r9OJYi7QYp8nu9RiKzpJI
	 IrvXJnyf5OIAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B0CC6B34
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 11:20:43 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Thu, 15 Oct 2026 04:20:32 -0700
Subject: [PATCH mptcp-net] selftests: mptcp: sockopt: pass total bytes to
 do_getsockopts
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-fix-mptcp-issue-638-v1-1-5de999ad601c@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oEkpfXxK9KFJrc6gjFkUhFK/
 72pXR7uuWcmRRYoXZqZMr6i8okV7KEh/7zFB1hCZXLG9dbYjkf58TsVn1hUJ3DfnhjehtCa8ej
 OHdVnyqjav3qlXY4oNOyTTvcXfNmqtCwr1Je2XIIAAAA=
X-Change-ID: 20261015-fix-mptcp-issue-638-ec1dd30f7295
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792063242; l=1443;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=U42LN1KsOOub+KeywRtAdFlCeTRcN444mHVbdXwEBv0=;
 b=PJj+rySFGPhUTnT2w+LcBKumlAoHM9Lr//AJsj5yZw69ADoN4oa0sRWIk9UBCHkfOskqapHve
 ebEszr34pX1ASP1wlpLYvPfgXhzab1U2U0JqV2fJESIkg8LgcT8VOSU
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

connect_one_server() reads the echoed payload in a loop because
read() on a stream socket can return a partial chunk. After the
loop, it still passed the last read() return value to
do_getsockopts() instead of the accumulated byte count.

do_getsockopt_tcp_info() then compared the subflow TCP counters
against that partial size, polled until timeout, and failed the
test. Use the total instead.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/638
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..7b4ccbe10ae1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -627,7 +627,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, total, total);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261015-fix-mptcp-issue-638-ec1dd30f7295

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


