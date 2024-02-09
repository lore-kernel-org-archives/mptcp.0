Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259153398
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499750; cv=none; b=n/YTacrT6EX49sCANCyjnGl4ylIBfRcK1FoqxBeVYORwkrNKHpZD5poNWcuwDLPm8MN7CldR2RMhM7mVk4ZSoRmFPTCUYuDJBMh3ieeWnvEiFCQsF1dDAm9S6N0kQxL+AJk+4sFHQtN+VCbhRlDLQrW1WgGkE56KIEOgxOKDufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499750; c=relaxed/simple;
	bh=Q+fM5Jv0a7jv0DaPovnuTii8KGP901zqYpen7P6m3L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnx98ck4HoyP+oOaP/n0RFBaQdV16Np1cAa8Zrm6fXjJDz5B5bHAGbl+Bh5PcKOuVOeLRCL8eHuXH3r2hMCR8DvHLz2r+vbCcB69foezVcTOm786eDvqZdHaLn4oIFPb7uiwm7eCkgbiwfD7SNv0N7fl76+RBzrp3a5nCMMdFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpIk/oCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpIk/oCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B31C43394;
	Fri,  9 Feb 2024 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499749;
	bh=Q+fM5Jv0a7jv0DaPovnuTii8KGP901zqYpen7P6m3L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hpIk/oCtmz9am2UKWwipP3c3mPWEF5AV3tIgRfLuBxOsU0q2hyFBsPNBRWfFvwI5u
	 KihZDpSwOq52+s+lRHhvHmjHgiOKWw12aay7k8km7fgQw6biODTuoN0Pl2rG7CXpBR
	 mfmYnRKjYD9MGG6fL2SgZTw8pS1VWWcIR1JfVHT32HvOSR2u9GI3fg2GCw+RBuKkcL
	 HwWHuF21WeezPwgh/s65tHjnxgOUloSgLMeiIxWXrLwj7yfMsS4dpwYu4z3mejOGnl
	 LDDUzPG1vTT1iXXxGkEH3QVatzWSJiy5VXFvM3f/QQ4ECg/qit0+Qxmm4QOlyksk22
	 oZEff+yVpDLhA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Feb 2024 18:28:39 +0100
Subject: [PATCH mptcp-net 1/5] selftests: mptcp: simult flows: fix some
 subtest names
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-selftests-mptcp-uniq-title-v1-1-e4fb3a3b5f66@kernel.org>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q+fM5Jv0a7jv0DaPovnuTii8KGP901zqYpen7P6m3L0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxmDiEB+vVMHz0kMV4OIWpMvd3DRBbO4zTinmU
 dcAIt316EqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcZg4gAKCRD2t4JPQmmg
 c2yCEACbRj2lYx4qhgVkSTHn72qbYTDAisKKI0W09FIJ3pR8KLvhNtBLea2dY5PNO70dA+n7lbK
 s2F6zczSBx3hiPe791i06teBrEeVfzToJkmSFWvWbjatxiQY5NaZ6yVFgNRjocxcYRmPURI+XFf
 Cydoa9PLIPOTxjHmZPYy0iStvH2llWrDcDMyfvODFbQ7cXMxxtOqulVvc2i+X/FfLIxeuVVzR7e
 6TTaICWaEDwHdny5nK8C2vh7RjvJx0EsDLJ4DX+uRJpPx1RxC916r43j7rBi8ut5dWUcJ3KwHy+
 WeRXQYRkFZsD8UOWBG8ITkw/CZpNe8XbeW+XYdSO7h2Gu8X9N0GtgqVJapMkGxP6cOWH/3jmBfL
 UrzM9Dl2CkXUV7VRrwug0eTCFeFlYS7lZOsDn8O3RxKJIAtioTJt7SG0q9B+1CvEKR+wAQOiZjE
 yInzTmjHGjUkn0cmdBawmLI+m0xY3bPT8NsO6MFahjBBpNdMpu45j5fWNSZLU1H+e0YoXKPlgI3
 t3mJ0Ujham2eu+Pj0yfAob+lj9jrn62FnyCwDQwaUHgVat/Ysu2OY4iC9eKYvZG4p7GZ8hZX5YM
 0iARTG7SoJSwFrcKp90dEWWUQuB359wsN0ID/K4iuaqvtoX4156PXGeDOeS+gHsPiS1g8bAZlPd
 bHOKizXpS+qA6qA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The selftest was correctly recording all the results, but the 'reverse
direction' part was missing in the name when needed.

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

Fixes: 675d99338e7a ("selftests: mptcp: simult flows: format subtests results in TAP")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 619be0e1acf5..f377ef01970b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -250,7 +250,8 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-60s" "$msg - reverse direction"
+	msg="${msg} - reverse direction"
+	printf "%-60s" "${msg}"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"

-- 
2.43.0

