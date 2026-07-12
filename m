Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7102F39B5
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850096; cv=none; b=j09nT4guQxCl4uZgWU+30l5OWzHRnuJBPZbO0FF4a4kGfjz98u+6J8G+jObTEi44bUOx2dn91F6vli/6QTgSeAJAcH1NVMs0qK/okat2gKFaTKmlsLgHYcxJA7Iw06N5gLgO10MIiFgUyj7KdZymMnvkV3jCw+lb+hqdom9K6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850096; c=relaxed/simple;
	bh=9lfwrFuLNblC7KI/9rXve3uu1ZE3kVaXnmRxYwHgRks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyrbCcKfv2acqrD1dCTB2vJegfwZefOY7h+1UbTjp3aC5UudZWycpR1wQfHSL97tvHxEj2xEcWKd+3Xskzce3SJOVdiJiOpk9rPNe8kEITQdoUoyq9tYdJE0dOlE/wQxvOxNq7x2Ewol1stMTRJKv7UHd2Jg7afoyjRwP94suJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrMqER3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrMqER3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5B01F000E9;
	Sun, 12 Jul 2026 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850095;
	bh=r9L7lHw8DH9GW9XTF6xmbJ/Kplnl3oZMxtIjEPkVU6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MrMqER3POD4KvEt5GuKnMippy2xX91lGIVOxM/Gnka9Ro5R2lxMk8qiVztTuMUGWr
	 KlPJ9bEme6QQBLiT0yM98CkbAK+tA486Gx6jXzsISsYPJ91Ya8wTtCGqSYnMnQQ2f8
	 wQtOhxAqGHCk1TttuJLoycVgdtxRsQkXbAHhqJskyuej63gqD/fdFWORQJQtvceRRs
	 9eH4v/xfNXLDX12wBTJDNFHxPNwlhi+A9QGWvaHyldtjG5Q/QB8VgzcJHfLMrPTTom
	 wazsh/j6JYJUmvXCOKtGcChcFiVwpU7oIGtFz3JDE1TfYQAKTWN++dYWrllunHlhm8
	 yX59qOa1e5u7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 03/15] selftests: mptcp: sockopt: reseed RNG after fork
Date: Sun, 12 Jul 2026 17:54:09 +0800
Message-ID: <3ac32a0cfeef2ea8c0b97f498ef19e286ee77a7f.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

xfork() does not reseed the RNG in the child, so server and client
processes use the same rand() sequence. Restore the per-fork reseed
from mptcp_inq.c by calling init_rng() in the child, ensuring
independent random values for buffer contents and transfer sizes.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 1f719885cd47..d4bc5d879abd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -129,6 +129,8 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void init_rng(void);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -800,6 +802,8 @@ static pid_t xfork(void)
 
 	if (p < 0)
 		die_perror("fork");
+	else if (p == 0)
+		init_rng();
 
 	return p;
 }
-- 
2.53.0

