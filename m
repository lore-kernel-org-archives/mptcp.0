Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8536894B
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355828; cv=none; b=FT38Rr6ooLdKUpRM1HyMm6Q7BLdKxxzLSbP2AkvCC5vO3sFUpjvU35XKXRTNhF3Opc5PmSJHK91rdThCI5MszbsLuRonAF354TPEV4nQK/P3vf+c+bz3LPPIoVk7BJUTp9myksoyZupd1THmAgFj5xq0+BGnZ9ZKy43BEPQydOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355828; c=relaxed/simple;
	bh=OCzCFIYgoiaMAiBtegDy0QtVK07qEClmWwfRNS5E42k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gthMO66RVF/XuiOiw/Ol+6+wGH4rxGISdi6m4wGvcigfeRBcLBnwekA1r0o/Sad7DUWG50F1/4PdTjVVd/Oa5GtB1bJBxt06o9fhRXuKFUMPqUTYifjaBf7vpIqS/Xl/i3O5sXpMBaBuJc2C2o0VLFP0nWQ04Vrscfmc87KeYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D118cHDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D118cHDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FAF1F00A3B;
	Thu, 21 May 2026 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355826;
	bh=QNlJojqgfv7GMPK4dZE0g55fgVzitfoZ+67FCVoT7PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D118cHDIyCU/XSKhofzecvEQUR+66lJBxtdUyU1qbfIDrVdN94si/6Ibr1SPuuv0Q
	 M9walc1tWjw8aBzcvlBqTxOa4ueIhtRFeHywwUpwQppv5w+Ycw8aNfEwj5HLCU3z8L
	 sHwTTM5dEGwg+nBoO8Jj9n19NmCUaSBuJr5n64NmpOburmXrqxbDgkeLGZiIcB9G5n
	 +miAhJ/Lc8DmFo8OOcJxTI3rYurZ34UMP0ZsqlApEurdF9I5Z5UhkOgQlL5UTWIgKJ
	 JAhjhhtsei0XiENh1VF2f6zOKR3/l3kZhqb94xBRT4CWam2QVToiyl33rLbNz6sr22
	 1930n7mheTNIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Thu, 21 May 2026 17:29:47 +0800
Message-ID: <54c0535d1cee8bea5a02cf8733c90444efc683df.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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

