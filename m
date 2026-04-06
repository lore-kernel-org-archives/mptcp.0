Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5001883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478015; cv=none; b=FHomzcR2x7jiA0BlwHDTcrj81fPI7bXABQ6pHX/nW7ivzekkhK/zuHlGI0Wtq61dffU4pikyCc/573+g/Ollfbc/fna0nQsYU8v/WU2uXWN5HKDMyTeo9dsM8VJTIMle2b40TgLsXyQ7sdwpV/eCIa0oM+dqZ4cWP+3z9OMbSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478015; c=relaxed/simple;
	bh=J0NJGf88lWcWV1rrjAAaDmhfdWlaoFxKlanO6HSL9Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK1s0Y6pekKL5Kq8TgtbLgz1hjO8QHZCQCtFngqDuPkWfMxl7RJxySBMGJgYpQw04KMt5wBRscnPQ014wT0vm93webFpwyK1Ku7WfnnUB4j0m3/SKrB6DNk7xvaG8kHT4ngZ4zT52xGkvulrHxENYHNZJms5WIZ1M5IVK53Fl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNmsvLx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNmsvLx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE4EC4CEF7;
	Mon,  6 Apr 2026 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478015;
	bh=J0NJGf88lWcWV1rrjAAaDmhfdWlaoFxKlanO6HSL9Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNmsvLx9iUNgmf/hU7RVin5vWAr2oMtU/L+9++8Q93W6OgaD0hS0OX9vZ70csIKaA
	 dNe+Zd9Rec5xlU/9rGNrCyFDFiO66VK0evHD7aM453LwDGoFMiEKTGkG4teGtanB9w
	 KZL+aDoJFmPHNebsaUaxbyvfz+MrOa4pk/FRh84mPoN8jwFKISvZaqHvicqCCgej5V
	 K6jmLaIIT3PkahMOHnw1SMiFuaEBVTHKFKRKnh4mYI19ODIZsiTXEdtduXcy6yr2Ly
	 F5U2FHeWi8g9ZMEGbh5NREGEHhZ7ia2+yrW9I9HXOAFlowEt14s7zFPqQkzBvaJelo
	 wR0j6uoQhoQfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Mon,  6 Apr 2026 20:18:49 +0800
Message-ID: <d5bcddad1bca80486cbcd64d76ba3e9907767ccd.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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

