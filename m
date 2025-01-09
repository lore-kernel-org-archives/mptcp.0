Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59C2594AE
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429563; cv=none; b=DLziToa5lMqZPT+phDLRPLuAq2/HxXPFYIxEn6iiuaGzqK7ZGtBGAq/tTfGfMvS8+OAY3HI5/Yp7Y+/A60ncXufzGoxunh8HsghGMCmmLwn4AjebVd+IRqIbNUTtSccKyRwSQMLecznSQquE5VC8FTrRslw8GYMn3UIYZr9JXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429563; c=relaxed/simple;
	bh=/z1vJKZ2zeFkzeQm05OuTmvXerZc4WWyz+9S+q3RmT8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XNiTUpKAP99r+RxbpVx+7QF6scpQb8O39NcZ29gZc/E1iZn32jrkZNpqK7Gx2A40C9ZRJBg2poNKs/TL3ryHtqPaRpO8/N9bIlA2VEuv6TUmfLEnyVvE+PYyfNZOPPbem9GPSA/FunPEm0yMcDEn1JWalpHcAOlc+F8ozrCWjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=J+B8uAQi; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="J+B8uAQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736429555;
	bh=J4M2tFViBo/FKvMikDdG3L/Jr6X7bkpqn2z9wY+J730=;
	h=From:To:Cc:Subject:Date;
	b=J+B8uAQi0C8aUz59vstd5+ljhtTiKE54lO92NNm6DsAEErn22bum8YpXnxMXFUfEs
	 P3WdoaGLeWs87z3+u8lAOs124NKkhd61IC5YG7B0i+981gUVyN7IYJvsfxKgWkoJxC
	 NIifv/tftQbVqWNdNtNNvBrA76Sns408o51sYBXs=
Received: from localhost.localdomain ([39.156.73.13])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 820B6C63; Thu, 09 Jan 2025 21:32:32 +0800
X-QQ-mid: xmsmtpt1736429552t7ynj0ljs
Message-ID: <tencent_FF589D3CCA6CB1BB13DCD53D469928F3610A@qq.com>
X-QQ-XMAILINFO: NStMSlBeip5yF8ljdblUDlWNkIRlVMr026AqNFxkixjwSEiqHC4FgRLk52cloT
	 0BfLwfbJoMvy/9WCVu5cLdUh7CDcRbxsdlVHYFJ8rj2qDqGCMmF7vOuuk0WQ95a3lEztWc5vxFMk
	 6K9vTm5hRW3C+zxP8aRg+eTsqmlN+uJ+aW/H2JACAE+c5hdegdUY+tV7ViexCjblf/qo/fJ1lr6u
	 xrYO5jnkZK8e+xzQSdL4QJ8T56GNnQXRMiYMgFoSiLAb8H8dQsGO4xpB84Si71xpIKCFa31iJSFf
	 fQikrxWamhdLxEUxIlCQwfnoxM9ciJeRBnE77i72latxITr28sxZXdEZBq+BZ2RAAHX/fxFT3GVI
	 Dd7rmaUIwnAGUciISjCP6i5JPCMr1+ftQ8n3BYK0CU9EPse2GqATAO1c4Wl494iLcNEuL3rKXBiU
	 Uf21ur1mSI97noaKVcDPREd1KgkwfwYAM7LZSHWlqMJDj3Ylm11g+QhQntiaTgeMQ/gn0TfV9Oo4
	 c/ws1T0AQfTBFwSPW2yInYD/Tci3rUv3kzxttLQQs6hzCfT2GgHP7D6whlMq0BAeTur4407E5PYd
	 ZMs9e0vAnNekqrzxJn9cVuOyEMF+FdYrmEHKXvEsMUSxMeFX/y9DXnM33mhKT0DpWuDpt6oKxuV6
	 zyJafHBRT4T4ORNFh2J9DwA0AQUg5pregO2Vbu0GDtnwSLRyuurUxSM6XUTc7/da/CH7vxQg4z4H
	 DLbSef6yK1jBGss/jhXZCQOFQ3OMY4lL95ehyRZRNsUnbMq2m3fKZMdKzVgmczq+5Zj87eoBARFk
	 HFOoAo4jh3M/pr+Cg2IAZUeEv8IW0Y+B8BsUqmT1awOnDCtrRfaWKSVst0kgyWtZN4Nr5BrUWyoJ
	 t5do0oPciPhAfaPH3XyV535nlyfKoOE4ap9mjQbyZgBV2iJRdlZ/46VDJYom0CbkdEvCdM/zPrXj
	 5MAsJnceZRBP3xzZbadg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	mptcp@lists.linux.dev
Subject: [PATCH 3/3] selftests: mptcp: add a testcase for invalid addr timeout
Date: Thu,  9 Jan 2025 21:32:32 +0800
X-OQ-MSGID: <20250109133232.220644-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This patch adds a timeout testcase, which includes a invalid address
within the same LAN, along with another valid address. The invalid
address in the LAN triggers a TCP error, leading to an incorrect
increment of 'add_addr_accepted'. This test ensures the valid address
can still join in this situation.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6b0705d10840..80ce8daac2a8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2318,6 +2318,20 @@ add_addr_timeout_tests()
 			chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
+
+	# signal invalid LAN addresses, which will cause an error at TCP level
+	if reset_with_add_addr_timeout "invalid LAN address, ADD_ADDR timeout"; then
+		pm_nl_set_limits $ns1 2 2
+		pm_nl_add_endpoint $ns1 10.0.1.3 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_set_limits $ns2 2 2
+
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
+		join_syn_tx=+2 \
+			chk_join_nr 1 1 1
+		chk_add_nr 8 0
+	fi
 }
 
 remove_tests()
-- 
2.25.1

