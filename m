Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D62D4B40
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083025; cv=none; b=hOwWog2MW7oKq46lwV626RyWJarAGnZHaEAodnMhJf7feb1i834eV44kYwYTgWxGJLN6yWo/gKbATtMG8yVKraJCpuxEqHPcBZARl0wnUCOvft7mGtdg1eQxvINOrCdJPiVnfgPNciaI/Kt6kFnLJHyPTvrXVZD6lT9Gh3EJwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083025; c=relaxed/simple;
	bh=uQvWJWqihZkGpKPZrKlmGpWWzLcBWMn4qN10M0TfeC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzFc6nURf6QTpLR+xZVMWX7up+FPbwssSM9LaQ5b6Eq5/jNEfP3ovLiu96zsmKeQkJOlrS97u9avQKF5b0FExWS48/mu257yMxDupC893tJksoCOfAiSGxJyYoC5dPjDMR6mIlwr2WPpLAcsjmdi5jLqE79C1oiRB15ZCvLlvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKAOb0vL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKAOb0vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F68C4CEF7;
	Sun,  2 Nov 2025 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083025;
	bh=uQvWJWqihZkGpKPZrKlmGpWWzLcBWMn4qN10M0TfeC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AKAOb0vLoXrU5mjVk5hCPZvDJ/OzDzooLNVFJ/tG/9L68TG7XJkfMPqBxEAQpotYE
	 amo2WT5uCrLq5/CGVA0WiQfF2BUkDHYQmm4yyNe+SJqTCcApwuF8Ez7N/KtaRwRHMR
	 XspGre73+YNEaK/jIWlotgprfQ+Ir2LDbdynVH6OQfGs5u2NRd6fishMKMepudwl63
	 TYrqGJfRi9ocic8SjqCl8iyrBmGm9Q7QQIZSdxdQTAw+9MTb3OGICpM+p3j4sVppBQ
	 u54AY5h7RbcRDGSXBlCJj8WsWd9Aoxt/ZfPtebr8NmcBuEMJ8ko/S3rRIptz+GnUmp
	 cQTEn9i9R+2Lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Nov 2025 12:30:06 +0100
Subject: [PATCH mptcp-net v2 4/6] selftests: mptcp: join: userspace: longer
 transfer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-slft-join-inst-v2-4-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uQvWJWqihZkGpKPZrKlmGpWWzLcBWMn4qN10M0TfeC8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHU51FAdmZbV/YdNhe2u4O6bd7e9O7y1+5Td/3ku++
 u//7y93OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayIIzhf9gUB0GWzrZ3J8vO
 N/td/55xdFVd8t9mA2bbp/Gz+Q5xMzD84b9q8f0me7eh7wEOY4a0F0E2BwtTF/KufvePt/BBe9Y
 6XgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to make the
connection longer. This connection will be killed at the end, after the
verifications, so making it longer doesn't change anything, apart from
avoid it to end before the end of the verifications

To play it safe, all userspace tests not waiting for the end of the
transfer are now sharing a longer file (128KB) at slow speed.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Fixes: e3b47e460b4b ("selftests: mptcp: userspace pm remove initial subflow")
Fixes: b9fb176081fb ("selftests: mptcp: userspace pm send RM_ADDR for ID 0")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b5a7045c1392..1af96a63516c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3957,7 +3957,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
@@ -3990,7 +3990,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -4018,7 +4018,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -4039,7 +4039,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
@@ -4063,7 +4063,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		{ speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1

-- 
2.51.0

