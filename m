Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274730171C
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926081; cv=none; b=XKI0SL9iRxtO5CYYzHQ1DMIUXZlxdNmWyHjn44OY7z3SA9dQRYMgc83NXGlZJ54NKpyzVHgJWnKI7EZETsdEENIYSuKOjAoTB9TZLhlRL/GzjFECchi4g68cFpoHLGt9wIUIWXar9YaU0wgSh8QApC7aZzwvdVHAWUIgJSE2XtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926081; c=relaxed/simple;
	bh=J0NJGf88lWcWV1rrjAAaDmhfdWlaoFxKlanO6HSL9Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEMGP6PJmTlld1vLb+MxkYNO0uvfWf812fSOf7U/IM0LqcaZ3gSDqaWY5iGze77+28Er79kO8L33ETRVPyjWMEf/OqAc88Fpu96AHMWsF6MqlyxZv4/Ck9fgMgfXfQnU9K6qswwFz69MjKyG6IsgrhwMzlfMAfwSfrPBmpyYkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+HO7f3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+HO7f3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE0EC2BCB7;
	Thu, 23 Apr 2026 06:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776926081;
	bh=J0NJGf88lWcWV1rrjAAaDmhfdWlaoFxKlanO6HSL9Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+HO7f3VswJAGRWISIw+voWilsTb1agnIHKXV4Ho7wILRh/YeaAQw+iqjqZCRAr97
	 GAaBjFpyVkW7QZCejumT1DOh5MzKJ6AyzwtYeKmsT4e7IsYuzLAcAyF6VGr4IktZ83
	 mJBY6NayVcPoIQWLgIPaOepNvfIOKbsLQi7djEmGQy1O/96jWa9sS+YZThJiPHYfm2
	 vIUGKbmcvu7uwq7bmIvdSozAK3LkVTTAOUAsFT8be4ogOeaSMEnib2DckAaKv6O2VJ
	 t+gJTXzQGZxLn2tItL66/C3hc3Of+KC3EEQHTe09lWT7CuOAlb3kxXsfEmF2PLxV4O
	 ln8n5lwoTUh0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v16 10/16] selftests: mptcp: connect: use espintcp for ulp test
Date: Thu, 23 Apr 2026 14:33:03 +0800
Message-ID: <2394160f654f1563ba2ef10ef3c93d1483fafb2f.1776924682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..299a7a02d6f5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -285,11 +285,11 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 	if (buflen > 0) {
 		if (strcmp(buf, "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.51.0

