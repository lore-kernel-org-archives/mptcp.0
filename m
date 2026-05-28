Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EC364043
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960464; cv=none; b=CUPGFIfXEYMPoJoeVHY6CQRrbB190U17iJL4Ole+ORvYPTILv8RuBLw9jIdAv7+jEKHax0uXRwl02CRlRTkQ42zkJszZWoCfGtTQzL+q0CPHv8XecQ0x17Dzr1ndoYuEErRUcgGBLiZ8JHfdRPiWXfoO4cT+FfCJ5twnWuxisMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960464; c=relaxed/simple;
	bh=3gl0K9I5PyXXoykIdu26iq4G+91su8cvRW6scifbKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj1dLAnExyUv/SIMGhSC8aYGdg+MLsogMt2yEqH45Rss9J96LrVVm60PjXQ0mmZdW5xEFsTra93CUEFvLDFQ8VXLssRPe7C5ipccvcH+CTlZUWSRbc6ZBi5BvYc+6loq5IID0b8nNs4DiX+NxxKPBE2t57WHS1u5iz0Q0EekiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/Ne4sK0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/Ne4sK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30AD1F00A3E;
	Thu, 28 May 2026 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960461;
	bh=i1r228t++8Jx2HzWD9Lh3NCKCbWjqFm66UQqWx4jVMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/Ne4sK0Wfj2rPpP8W8NN86bv8Z43fs+hBzKVEaGiTfce6ZXdjn88dVJt5QkbZdNH
	 /yix1F4pCxIpUpGmWRO5D6UIwBjD9oK5Grlk1Cby7gxhojFryos/LG9Wyit9mTP807
	 b9LKjvHZuGaa2PpKwVsrobPsMnPn+MvdvSuAlqXVt9ZGOjEYdTU0xstbJXX13zB9Y1
	 R6Qb7Xkb6wT175ntrtrgF0VgcTVo4m5CuYTdrm9q5MEfE97XjP+B0B6wFPnrsN3Myo
	 NUFZvYvN8vRw7D8fksKf6yPSKVulHvbbzoOY8AFhlyXqEI8YVFHH408DBu2k4H11Bt
	 6P3DBY5ZgZPRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 11/18] selftests: mptcp: connect: use espintcp for ulp test
Date: Thu, 28 May 2026 17:27:02 +0800
Message-ID: <027eee165419222950d9eedc8168cd2c7a04b9b2.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

