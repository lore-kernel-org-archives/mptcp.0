Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826679;
	b=ghY+9utXjJFGq1vPOucX3wnO8PU7QIdGUNpoaUWpAAMPj/6LspA9AyvSnp+fXulIZAd3
	 oY7tjTRXn2fagE2NMPrp0jVpWhWbT5Fs5j0/UpjzaUQ9LDkqQ/YTdaBbJHK9ofgOtWb5K
	 p1aHx/fMeNavR5DXbeuin6Cas9udJb3RqBz44eNDqMQULt2ZojYHSfBIoyd9/gscqXynX
	 M6NO1bs8ygBm7X+b1VBBoxH2euP5foG+qMUNmF7wCG8/lwKoe56R8kSUuPTf1bxQLhCT7
	 7/vY4zqxFhM8dizeqe+f9D1gtco+DSaQpsuD0i6Re/MI65lGNjRGw4W0nhB9sEpYWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826679;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KY/eHjpuJC9gkRrMN0LzUWCt09sRj8c+0f80CRXtIyE=;
	b=yYbAVn0UdkFt7Bo0dJQost88Si1wzAaLkOBvQVx3kttT9W86M9dZ3DgUsMzZ4wUTYb7C
	 Hya+jQ/5GhFB8avAD2xpHG+6+HbhXsxO3dfOI3oJEUxlKdUlDeSAdVvyhm5KJMnzQB+Q0
	 yiPii5KJWC90p316DVHwTblzm81DP1GPfkvhULxnP+dELx+6+Ewx+rP7Ku39fmWptOh0K
	 hAkwoARyd0zJCwnGZb9WJa4rlF0ZX379itgyhapSQMrxFd36bxqaAO0pQqO5QlKlYQpRi
	 +8EB00dyoofxLEv4L/xgptZ7fdc9U7+hfBrFe5CWjKMcheKxOuofi23uJrX1omGuncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5VTQUe2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303C606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K5VTQUe2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F151F000C6
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826678;
	bh=KY/eHjpuJC9gkRrMN0LzUWCt09sRj8c+0f80CRXtIyE=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=K5VTQUe20t0M16V9rEX2G/ALTxf3Rv2Sab8FVFnbiCHeUxEqZD743vadL4dXu6jwc
	 vBMXOIxoBBvZaeDQWKgJh1gkUwK52GdohWNdjfnbUzTXZvfTuOlrXgARoBIRsOLdH8
	 DDBuNBJMkCBlEi3eZU/8VCkPl/zfZQuVMI5iSx6GfVS1sYERxdQmVBM92/sv7xTBKs
	 6lujq2uonc3EI3+stcNgkfme3zi+lsYBwR52QxaKeiEr8ToddNxvJTB/b7JKmcsNmi
	 L9OlWyFFf5uhC+jBS+24kJ9yyPYy59kwAn4u7StARb9BJ9Ni9qDMY+nkyKQL4ADqhd
	 bfvdjH9RsSnDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 6/7] selftests: mptcp: sockopt: check app_limited
Date: Mon, 16 Nov 2026 18:57:44 +0800
Message-ID: <655e40ce580c2cdb8126397d03498d225dbea6da.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After a small data exchange, assert tcpi_delivery_rate_app_limited == 1
when expect_all_features() is enabled.

rate_app_limited starts at 1 (tcp_init_sock) and is cleared only by
non-app-limited rate samples. The preceding commit makes
mptcp_rate_check_app_limited() set tp->app_limited on subflows when
MPTCP has no pending data, marking outgoing skbs as app-limited so rate
samples don't clear rate_app_limited.

This guards against regressions where subflows are never marked
app-limited. The test covers the empty-queue path only; the early return
in mptcp_rate_check_app_limited() (when MPTCP has pending data or
retransmissions) is not exercised by this test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..9517c530ba21 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting only checked under EXPECT_ALL_FEATURES */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

