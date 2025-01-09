Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BB222596
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429923; cv=none; b=V+t3Zn7nMDD+nl77q5QjaBS5jd18V9VTsp4ajWCernL1p2l5AA7eEgSBXF1afhcs4CBCV669JOZqd67A59P6IPMMIpxqNVdvay2zYtrHyXtw3vkqWKGaZaCy+HQcfRv8tQudFflX5IeW8CHe9wnjDTpMpnLlGeJYNc/37mWQscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429923; c=relaxed/simple;
	bh=M1oCPZnYDfadQ1DpPz19zC+8N/iGu7KKQN+SVBZX+Cs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=I7Yu0sPStSd9+fWKsMfQi8Sh3stb42cPD4FvtDItfOSseM7dSDmaZLBui8aflZd1YCYoPNr4Jq0rZjtKo2aklzHsFzIevox1KkrgJ72rVIG5winZQ77LPrHPoobN2QxTX1KPRwVTtbLWDE9djJdRcyn2v9AP1lvoYkzq9vHtdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qfvL/cIo; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qfvL/cIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736429915;
	bh=/MerUg8xywAmRPkK8nk2mJUtUqZmRpp7reApPSscNwI=;
	h=From:To:Cc:Subject:Date;
	b=qfvL/cIoNHLQr3UbDZbOnvbEMiRcE28OxJM9NunCmYCq+R5rzsI7OvIHox+Xw43l1
	 h1qY5ZVFhEgY1rajXZmbT/q8oREGBA7WmB99QCzmjd5rtmjpE9JfREXCemuSaz17Zp
	 i1TTeumvEGKrGrYAVYJiuIOrf+3fKU8qLD0HTmyI=
Received: from localhost.localdomain ([39.156.73.13])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 8169B0D6; Thu, 09 Jan 2025 21:32:22 +0800
X-QQ-mid: xmsmtpt1736429542t6p6ngco6
Message-ID: <tencent_501B9947760682D23ADE286C65020C801307@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTgmXL69ZLkAEkskchdEYgyyOufdZhTw5i9Wm/9JWQYV3K/JJnnL
	 OJ7nUFewrQ/UzQ0KHuym9Nh+jWEGDTfpdFtV0XtTIEt5fh9eEwX636ikXxVeNK1OvgJSONun5R13
	 Y6pNbwbqc/Hqjh71aVHZLUROJh1KYNXjyZmEePyfPlXnO1jBhaUUjWAfiw2ZT6qq+tKm/tDH9Ueo
	 vWS0UpHw/RVM+BB83j9Xps/1zD/NbvkBR87JS8/43op/pxjetZYIzGjvqxclyfTztT6Ob75vHWRk
	 3TsQaa1znrdRuA5LHRGTaX274gAqWb7e2oMT4rwZAVmSYYFZcNYGEuKi9Kw3LSjsABSux0+innNz
	 TCwFUQJRoFBWBnvdGubchPSjfdpY6za+JmMiware7cPA/sjEatxjRPEtbXk+xkP35pyf/mvsJ2vd
	 K+Pb4E7Jj98iQhjd6cSyeZ8hP46+fFBI1gv6JyES0TUZC2X7ffh0SCx8h2e6Z7HKAj3i0SEXM/rT
	 q6Ili6t2c6tLX7O2DxI5uAwL5ZpIBqwZPBHyoX7SHiyQjXsUJbIqx/PoSoB37JqGqXX01mWwtdCn
	 gGVRcP3Xjy1gZgFGwPadhgR7z4wbRhSznL/3jFwmjskqcbhrg+dx2fHA9t6mBwnm4Ho2XSCBcomq
	 ytD+6c5v4dhw+yWhOd0u+cW7iv5crJbbhRCgg5xCZBGnPgo262PRpHd+rDvhS4qhaFHKX6yIMRcr
	 mRxjwFMAKJQ4zIlWfVF8d21CZ1LPQrpIow3Ma8Yk0yXMH2+t0UmZlmWGgFqLS3OHdHDpfmxWlY08
	 G50ZmvZKvhTJytjpNmHYujZnzN5KUiNvLOFKO+GkqmNwj1t+vqmmNz77b1rOlM2laRTDJWRT1uJi
	 vbrb3i44diD4ecfzf6/otk9SdDjK5AHKsJcQRr2T9MO4OV1cUJGAiIpC7OtfuLems0eAeYAtjM9R
	 WBqVjvI75Qr+oN+AUkWXF+xJp30+xm
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Gang Yan <gang_yan@foxmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	mptcp@lists.linux.dev
Subject: [PATCH 2/3] selftests: mptcp: relax conditions in SYN_TX validation
Date: Thu,  9 Jan 2025 21:32:21 +0800
X-OQ-MSGID: <20250109133221.220550-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

In ADD_ADDR timeout test cases, the syn_tx MIB counter is not an
accurate number. This patch introduces '+n' to 'join_syn_tx'
to relax the strict condition.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07e2bd3a315..6b0705d10840 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1361,13 +1361,20 @@ chk_join_tx_nr()
 	local create=${join_create_err:-0}
 	local bind=${join_bind_err:-0}
 	local connect=${join_connect_err:-0}
+	local allow_multi_syn_tx=0
 	local rc=${KSFT_PASS}
 	local count
 
+	if [[ "${join_syn_tx}" = "+"* ]]; then
+                allow_multi_syn_tx=1
+                syn_tx=${join_syn_tx:1}
+        fi
+
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
 	if [ -z "$count" ]; then
 		rc=${KSFT_SKIP}
-	elif [ "$count" != "$syn_tx" ]; then
+	elif { [ "$count" != $syn_tx ] && [ $allow_multi_syn_tx -eq 0 ]; } ||
+             { [ "$count" -lt $syn_tx ] && [ $allow_multi_syn_tx -eq 1 ]; }; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx"
 		fail_test "got $count JOIN[s] syn tx expected $syn_tx"
-- 
2.25.1

