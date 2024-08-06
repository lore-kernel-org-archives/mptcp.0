Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6F1BE873
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943153; cv=none; b=tpRGnmijMkLcoXTJjB9m51RtyDaqzdvzS20pr8veeeBYi4l2YRgJD0eIY/87d1+ckIs83BjqBCeF1SQ0tFvANNJPZkSbNs5S6sJVNJPAaBCeu6ICJlniQxz90SgG/8lqfKMih4kPeWMBDBhy9mJn1EFnQ3Wdhxbsm9p4lVrOPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943153; c=relaxed/simple;
	bh=6RQNdbJkEwyjjByHCRGnwG7R7TBjuVOtTr/ai7jVFeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N40G1W8W2ttdj2VH9ZM0BF4qPjyAtZx9jRdf8im04ZRaM9wDCKQiA/fUWQ0Dq1YNqZeEuXwuzgS9sMWT14VnZmTMipNgNcUS9TjVPdjHDPXnZL1R86Ay2mamPyCXYOj28Znr4YLCUqxHWICMB/FNjEKrZcuMFnElPbHH9CoqSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DORDj6ly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DORDj6ly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8D4C4AF0C;
	Tue,  6 Aug 2024 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943153;
	bh=6RQNdbJkEwyjjByHCRGnwG7R7TBjuVOtTr/ai7jVFeU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DORDj6lyBt3uBLUlkNAacI19TfMpxyPQP3qR79jFthlTfs2Dyb0wDDgcgVIujqATW
	 B9wQxZF0DrAqULFLZXaImFhSletVfK3C3oSmh/Lp4i7zI3WDgVNITsWQxAnhUyOtZw
	 l+SQEi0CKKDA3xmBP0DZi7yTumV5fneGaNuepShp1WEv+m7uvwVz2hTapGrV4aTuSI
	 PvoMQ/1obgZ/XwDLaqIhwB7V/nLL2PfLS9B4VqIdMqzFZHyxAnTT4wwoVhRaZ15xVN
	 cxEx5solIFqaR76bJwDwVsni7qCtzIhNOWcju+R0Oi+vugF85arY2NSLRXkehjE2oz
	 WDx+y8uTH1H0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 06 Aug 2024 13:18:56 +0200
Subject: [PATCH mptcp-next v3 8/8] selftests: mptcp: join: mute errors when
 ran in the background
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-mptcp-join-tx-mib-v3-8-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6RQNdbJkEwyjjByHCRGnwG7R7TBjuVOtTr/ai7jVFeU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaovcd0hAsxo8sEjRR2afLAMn8CXslHCMxnt
 7Qgl7C8y3OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 c4tqEACMs5/DPP1IHXi/LlmXX9WMjvVfz2Z0mkKI8XLjTjF07bK3wIFGkTRhXSXglWCLTuII9OH
 0soD/ZIy9QPP+rs6h1bFWDPaHpbj/IK9b1Gfgz+dEmf2QXP171iOp/gJnuvtf5aj1yIXqI3aOs5
 wGyOfq2FYdW9W26dEwly6Sj1UD8Raq4KUO5XwsphZefOEgDO1grlUwPy5uJRz8HkvrJ0mJg//Xt
 r1VA/GZrmpkGGe1ITqqBwwVmv4y81HzwjOf/Rf174wl9jky2EHdBhwtdyPvvVL/McSLl3p32EpK
 7ERREQ8XKP5TU01sPeKjeuu7qp0wnv/oUBNYdn8jV+ZHkKw8PBSkM7AbLH8yZKaEqzPJ0zqpoIE
 UBVSUd+qHUztN+rE+V/tgjj+LySbIimxANp8jZc/EOtafNvSji6gPEw3w7LLhbOy9nOQioTRuQD
 szQzegzwrtdEuriJg/ay4Dve39nKKrJhorq/VTQWtZSvkFMgfbw+qjmuZN5RsX8muqxL6SLSKBK
 VyYDiijMRaUA5b3wP8eY+RTZmKKCS+vIbNLzKXKnqoCIuiKaA5klSq5ns0yM9aEitVjNZze6zyZ
 28k7re1X7AnqWgXCKNq92UQSZLiw9O8OFBHVQc36OvDkZlvAAdNdYDPNFPl8oqZlqWWzxEUbD3B
 yIZwvz64e2V0kiA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The test is supposed to be killed before the end, which will likely
cause "Connection reset by peer" errors. It is confusing, especially
because in case of real transfer errors, the test will not be marked as
failed. But that's OK, there are many other tests checking that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a8c4d6c04823..6d9fe305c281 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3481,8 +3481,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
@@ -3516,8 +3516,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
@@ -3545,8 +3545,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		chk_mptcp_info subflows 0 subflows 0
@@ -3566,8 +3566,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
@@ -3590,8 +3590,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
@@ -3621,8 +3621,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns1
@@ -3646,8 +3646,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3693,8 +3693,8 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3730,8 +3730,8 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_attempt_fail $ns2

-- 
2.45.2

