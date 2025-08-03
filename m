Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCF13C8FF
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223237; cv=none; b=oiExFuqf2AzCGCmesoauzpmlI8YVxgRjvLcP31L+APA5rl8HZtQ7IrrnFDa8SluGNuktOp97D0kvMl6pLA0tG/rW0pClHmgH0qeGUKHP/wOqy1EwFTrl2y/9X2gfO64iBdsVBsFiM6cCwyNNrxkaDm1IxQng8YCfXV8Y8Q84uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223237; c=relaxed/simple;
	bh=gcr+hho1F2tBRCWOCyDqqJLUxZzzdu5X1T6lb/bLX3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Km0akIJgTX3DFqlSNVBoR+aFezu1pQw7emMP9p3+wqZ6sw76d7Km2aeqgYUD/0pIs2bPAOyrmTQQHPkcUty8xCOZ1Pea8TqIvRu3l7gLJsLiy1avnN+P2qVeXFhqBByKh/TPlhqJ1l6OCi+4dYZcTQMxj8QU+2XJSYZlJwpPHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbHffuC9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbHffuC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793D2C4CEF8;
	Sun,  3 Aug 2025 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754223236;
	bh=gcr+hho1F2tBRCWOCyDqqJLUxZzzdu5X1T6lb/bLX3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jbHffuC9ApHfvz0KPmKKq0dztPQBgoKIbSRNmepJsRnmLxDam97f4G+c2tH5EdK49
	 H/LV/7AVLyPDFnS2WMef6Jx8J7RrfISQ8pFBGQ8o1FR9TF934VcjQjKBwPIdAKCxvA
	 NBksYpAHRkdksRGoTKDVeTf5tpN4UwT4hNXH8P4O/2a47uqrZdI53PRMt+77vsa3Ps
	 JI77eIvmMTCvAAsilr2p+2v1IM9QGaKPOFYUL/ZVebQ0RRl9tf9uQtc3t93+AOhvgo
	 EscfB2sWuS758S/xhc09yz7cdkkIMZk7fc5p9JTGpgRNDoO6FxPrIu7PClGMVrm3Rk
	 P+isY8zfkm1SA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 03 Aug 2025 14:13:44 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: sockopt: fix C23 extension
 warning
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250803-sft-mptcp-warn-gcc-v1-2-6d87808721ea@kernel.org>
References: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
In-Reply-To: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gcr+hho1F2tBRCWOCyDqqJLUxZzzdu5X1T6lb/bLX3U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL6g5qCbuq/5JT4faKponZn6dSYNYfeOr9PlP48wVnp1
 OttORvEOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiJ8XwV2xrv3xuhOLERNl1
 cmuXMLsJbvXIUWppaY36l5a56BrvO0aGE1LLXspXbexdd+3zlgif3Qni/GFsNT4aq/Sbn/UVsc9
 iAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

GCC was complaining about the new label:

  mptcp_inq.c:79:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     79 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

  mptcp_sockopt.c:166:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    166 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

Simply declare 'err' before the label to avoid this warning.

Fixes: dd367e81b79a ("selftests: mptcp: sockopt: use IPPROTO_MPTCP for getaddrinfo")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 5 +++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 3cf1e2a612cef911028f46569563d16dd5d32129..f3bcaa48df8f22e8f4833fcc3b919d21764bf7fb 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -75,9 +75,10 @@ static void xgetaddrinfo(const char *node, const char *service,
 			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
-again:
-	int err = getaddrinfo(node, service, hints, res);
+	int err;
 
+again:
+	err = getaddrinfo(node, service, hints, res);
 	if (err) {
 		const char *errstr;
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 9934a68df23708ecb413c4ab26523989e3b9f158..e934dd26a59d9b50445d61e8b8013ce3c8d2a8a0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -162,9 +162,10 @@ static void xgetaddrinfo(const char *node, const char *service,
 			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
-again:
-	int err = getaddrinfo(node, service, hints, res);
+	int err;
 
+again:
+	err = getaddrinfo(node, service, hints, res);
 	if (err) {
 		const char *errstr;
 

-- 
2.50.0

