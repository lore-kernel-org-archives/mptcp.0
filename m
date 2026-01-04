Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B39248F47
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519333; cv=none; b=am+8uD3ROxiwFNQRzrzJNbBah0CXU79gzcKWevgOaAN/HEvLtFDTo4/v6qQGPWH1nPtRb0S7rmm5B5YaEfd7CD3UmPNW7kBVLsEKTqgApD4lCbgDAm9Dqv2LryOqAh1Yu3lqtnY6Y9z2qpl/a3UStOTNrPnYmyKCHpl1Fs6PF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519333; c=relaxed/simple;
	bh=Szr/lToEsIj3M3xclaxfxA1Ft51MKqPAHn8KZoDp0PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMxcITTwjZHm222P5RpEO3vJdU4jUFxY/vYJios6GueMwoKQubfuIdOckvINo4ZazwPY7uroKr1Moi9oHbcnKKLgeGOdhnx4oOwSYx9pBLjHqgfVNOTtBSaSlai0K3oZJyjds+jl6dcBCKa4Of4RDny1s2KSqTVTtvt3zKA7+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOw6Arpx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOw6Arpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E646C4CEF7;
	Sun,  4 Jan 2026 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519332;
	bh=Szr/lToEsIj3M3xclaxfxA1Ft51MKqPAHn8KZoDp0PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOw6ArpxRdxM3glQAG9hIngraqHqbFD+RqyXuC+RGrl2B2PNV44W6zhwT/D0ed5gN
	 qpnqf7X2/lzDnHk6pjnXAxjq4U6+4g72CCh8nDRTvCJHpI5qfdlo/oEdLXA4Ozvgbs
	 bGfXORy+vSnm0RCPsVPBmUJ+zGJt+I7V1T+/PeYLEJGk0j6SU41nZlVii65QurzTeR
	 oy1Tba23n6x5w+09Fim11/UCgu5YRca4QW2MRSr5I/p7NWtJt5uESA0fgrXE/98Kjk
	 bH1mW9WjTwAp2bLsjcVSEjLk/XJSQ7/Ce8xGGUXEELFFIwNZ1wrrSzPvetlsRMtu10
	 7yGhEpyQnbHJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 08/10] selftests: mptcp: connect: update sock_test_tcpulp
Date: Sun,  4 Jan 2026 17:35:09 +0800
Message-ID: <60062870d6cf5189817dca821a9f5f46402597d4.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update sock_test_tcpulp() to ensure the mptcp_connect.c tests are not
broken when CONFIG_TLS is enabled.

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), another ULP name, "smc", is set instead in this
patch.

is_mptcp() has been added to determine whether the current test mode is
MPTCP or fallback. In MPTCP mode, the getsockopt TCP_ULP value should be
"tls", while in fallback mode, it should be "mptcp".

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c        | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b82df82e0594..9da32701d2d0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -271,6 +271,18 @@ static int do_ulp_so(int sock, const char *name)
 	return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
 }
 
+static int is_mptcp(int fd)
+{
+	socklen_t optlen;
+	int mptcp = 0;
+
+	optlen = sizeof(mptcp);
+	if (getsockopt(fd, IPPROTO_TCP, TCP_IS_MPTCP, &mptcp, &optlen) == -1)
+		perror("TCP_IS_MPTCP");
+
+	return mptcp;
+}
+
 #define X(m)	xerror("%s:%u: %s: failed for proto %d at line %u", __FILE__, __LINE__, (m), proto, line)
 static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 {
@@ -282,13 +294,13 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		X("getsockopt");
 
 	if (buflen > 0) {
-		if (strcmp(buf, "mptcp") != 0)
+		if (strcmp(buf, is_mptcp(sock) ? "tls" : "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "smc");
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "smc");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.51.0

