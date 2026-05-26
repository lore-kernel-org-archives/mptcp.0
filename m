Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB53A0B3F
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788823; cv=none; b=WKH+RZP+nEmVS0tnN7oz3qGpcj8zA3fN9O8BIEEdhqi+IOSFnWBM02Vuxw6P62DsiHplVoWuNww2WhtnBLlXp2X+xh/FAzhPRyHkGxXc8xpT+MkTbU7B7BwU5c3pPN95GIr6GZ9Ch+6tjkAkGmApbS5ZDJaz6l0lb2wawVq6GBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788823; c=relaxed/simple;
	bh=OCzCFIYgoiaMAiBtegDy0QtVK07qEClmWwfRNS5E42k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE8fS2KhcfLCKormpGSVe+chhPYsPEhwimEi1ROvXnRdIVDYc3gM8hgOQCWnDqkvDi4+67k3PyeBs/ScAW4ueTqfPrKPZ43O9vGRAVEN9zyStVL4W+1ToMwqRavLblQlGL8OijJygu6bw5iVcGB4A9c5nFqhCUVf+qBpuyfYYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CORJCnv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CORJCnv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A161F00A3A;
	Tue, 26 May 2026 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788822;
	bh=QNlJojqgfv7GMPK4dZE0g55fgVzitfoZ+67FCVoT7PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CORJCnv2wYjaRWP1IWRChRgp59ezYBKnTPTZHr2zHrut3nMqMCacWMKO7oXmoxBdi
	 qO5xKOnu7Viq+xGEJJ6DHBlnHqdMd0ZVgjH1gek5rWEr+vLjsoFaA/biOTRCnwuGi4
	 7yLAnrRjwaLuHugPOuNpBm8im9TcbNCOrh9shoDsuI2r/eUJuNjbiiTa+Bztrxm/d/
	 WZU0xNR25UvUPlcZG9WtlT8h5B9b9rC1d7/h0cDMEYkz1lzsjFVcGm5MNhSHFT0xLs
	 6GjB/Yi9A9UOF04RRPInlL+ZYBn7TArnACdo82thwYagyVMreG+tLNB2JMGINSps4g
	 R2+NHAWQgtRnw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Tue, 26 May 2026 17:46:27 +0800
Message-ID: <def37b621d1a82c2f257c25beb451b3ca3a92da8.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/config          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..b9960f227796 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_XFRM_ESPINTCP=m
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

