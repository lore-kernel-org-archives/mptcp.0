Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E63016E7
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053281; cv=none; b=A1irYNoJwq96KPIBYQwl0w7GUnXO56C4n8yplfPfBNtju0t/tA+UiaOzJ+8ImbLa/bZId4dpwgqdHB9cDhLA3V1kuPnZhJOhhQLEmTo1yfKZ09fNfUWE4mh4iXGY0Nv5UxFA2TtIWCdH1tM6IIndmJfN5Cpa7/SLtpmdqQE4WOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053281; c=relaxed/simple;
	bh=3gl0K9I5PyXXoykIdu26iq4G+91su8cvRW6scifbKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFbn+ahR+J+aROD4/d+fkb/10Cllr36jIEiMPPcG5NCY6jcgDDJS7jz1+neH8Ju4FoziKJJZ5v7KJt3Oq1N2m/331CNqfDxgqIDaibf6nFTzc390pMdaKv85g7CAce7gtuhYPYF5rUsVNRz246pAH8vLyk9Xq9PiAIB+rYPJic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+wcn3wS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+wcn3wS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B3B1F00893;
	Fri, 29 May 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053280;
	bh=i1r228t++8Jx2HzWD9Lh3NCKCbWjqFm66UQqWx4jVMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+wcn3wSU1Q5nLdZaWtJv7LPSdFFHsxJDg33YnLhHn449u6lZmIf9MJtkuKwmfjWr
	 DNNwqqYgLKPtES0gM3zQTy6XPbdnOfJtGu0COU5NgBUAyd8XqoGzvt+dCVY4MSIODY
	 MaPVn/x+Ty/04iQxnuBLH6Vn5EahAbvvAvMB633cVGSRLwXyFPAwxP4WAEp2xlI8OL
	 ZXrdsqkx5ZigxMVBRnAGxRQIODN/+R+OtSCJ6XWVm2waPYTHMJj5FzuU9htkMezCtV
	 NIYmMaZG8CR1vBzkCbrbuI/vVlR/nXaLOwlRD1ACoLBWrBKrB474uUxunAWVpKSWvR
	 QRKubG41P4yIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 13/20] selftests: mptcp: connect: use espintcp for ulp test
Date: Fri, 29 May 2026 19:13:55 +0800
Message-ID: <246842e2c9737d307f95f94b8dbf86c047b7ccea.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/config          | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..f48bd5183fb3 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,7 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESPINTCP=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESPINTCP=y
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
2.53.0

