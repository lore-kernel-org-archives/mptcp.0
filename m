Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739D2EA732
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940779; cv=none; b=W+sQTNm/5MSaNTL52PR+ROIMqtypNi39xO1p+5MP+HLUItfWW+Wt/TCkYdRP3OQPu8vOyu08UWcH0UtYvPn76lm7gwNz9xpSDS2WIRulsaQm/BHcTU89cESn4uiRZrWN+3gXpWY1mRGLulE8/LuJQ1iFxmhRZYhshCXsc1IIf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940779; c=relaxed/simple;
	bh=OZomXwYZ0TJNG2JLPnIzzQ4pHtRjZ2Qa4LR69Pgm7z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4GuTauCVJ42Ot8A+hfIwqwZTVKb+iqf+RGSHSyFySseeoW4HXPB3w1ZXf7a01e61DMAMDsuvgPSgITJcvSR1NAUs4KxSUAdwwB0Cp7K9W32AraBxQ3luVWKLyfyqnGoXX+8gTyOyfUQIjZXy2i6PySno7+p1LFb560FOA5GHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnpJSJ0Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnpJSJ0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF134C19425;
	Wed, 12 Nov 2025 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940779;
	bh=OZomXwYZ0TJNG2JLPnIzzQ4pHtRjZ2Qa4LR69Pgm7z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BnpJSJ0QjkgAaKDb8XQp1rLrB04qyPLKRnVE+3X/qaSE++F/kEB8Coa0vA020zDiK
	 urryqZQK0/2CN1A5sOy2nAh0gkXOU/9TNKm5GjKpzrc0swlSWs4OqH6anKnjPepN8p
	 EOFM6r6tdmBePNuqboiKrvVi2mZQNqjpTO7FQ2DM3F7p87T+k73JVXspXGp6quZqph
	 b/A2dKRI7sgdtnpYVL2AY54UgRCtR0GbmGQT1e+dF7K8X3H41B4xI3vrfPnNEFw7Cp
	 17h20skJbpa3oAnnNZwIasd1nHzRVxBs1YJxrNC+6BpOdpujgVDVm5i/NG8JrdSia8
	 Pq68sxAktsD6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 10:45:49 +0100
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: join: userspace: longer
 timeout
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-slft-longer-timeout-v1-2-97aab145a062@kernel.org>
References: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
In-Reply-To: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OZomXwYZ0TJNG2JLPnIzzQ4pHtRjZ2Qa4LR69Pgm7z0=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGkUV2iggPLVkzocu57xP4xk1u3PJtO2varsG/32vv+5cqA1R
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmkUV2gACgkQfCLwwvNHCpc+ygEAg4Db
 C62CaEjmPUfmxtFVXjCVG2af/8bxiVIUZ8Z6da4BAI7eWEpyOBwxrz5gHDSh4HSKkWNYTk4u9rp
 7z1QLzE8H
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to have a longer
timeout, and even go over the default one. This connection will be
killed at the end, after the verifications: increasing the timeout
doesn't change anything, apart from avoiding it to end before the end of
the verifications.

To play it safe, all userspace tests not waiting for the end of the
transfer are now having a longer timeout: 2 minutes.

The Fixes commit was making the connection longer, but still, the
default timeout would have stopped it after 1 minute, which might not be
enough in very slow environments.

Fixes: 290493078b96 ("selftests: mptcp: join: userspace: longer transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b058f78ea0bd..541c2676c79e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3953,7 +3953,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
@@ -3986,7 +3986,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -4014,7 +4014,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -4035,7 +4035,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -4059,7 +4059,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1

-- 
2.51.0

