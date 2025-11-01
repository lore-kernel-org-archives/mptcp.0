Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952628DB49
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988503; cv=none; b=kXKb/1o3JM8FXPGYWUw2SiIlBffRXr5xRQRz89NbCDOb55v+VU2eyaAyM9tNOQUB6zLA4wGio9OpvA+AtEK5b3sj2IRREHRnZG/HoGF/tnx9LZfibBcUhonHJPTX5whxrkqfr9uwdTWSzOGpDK9d0BJX0j5ilGUH417KpoTlPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988503; c=relaxed/simple;
	bh=uQvWJWqihZkGpKPZrKlmGpWWzLcBWMn4qN10M0TfeC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlGSXqCzzVo0DeoufhiTWfhjl+UTwyYKefvxiHQn4MrDvUdr2Q/1+QqJO0PPK1YKm1H2PYCYmRTCPY6HcpowkpgpR6JAzO6d7lE9EpD3oRl8Ew7O/TxcsG4mSTtUnk4MDO9FXvjR2tACqCXtZkAVNjZGAhPT7VBnT+hCbocJDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDsjWrl+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDsjWrl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA93C113D0;
	Sat,  1 Nov 2025 09:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761988503;
	bh=uQvWJWqihZkGpKPZrKlmGpWWzLcBWMn4qN10M0TfeC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dDsjWrl+oQhhxGEqEuecj6ry4Y51Wd7OoqWV2TuWpeC6GBl4+tVAUjT38ih/iVKJl
	 IO2tmg/tSnsmB0TeRv7kBCYJDQQkua4eBE6lQ94qkFWwky/1wvcoh7s16rnCwO2lcQ
	 EfhHCFyCtHfM2l5fbt1SxwK7TT6j8qh1hurtA/7E6hWZyf1sGwxsdGnOc2yidfaEck
	 3EkTo0/k5uDJYgWETS8ZTGP0GSbXV55tM4IDYXDD1+YA9EzEmFzky2PM6wqE6Hl71v
	 24PslSjoAZvMdt/roUwijavs+LoGhgQIYBI9iMOOCNKlw4nqxhpme4Tg77vm9czVQz
	 zrtfqmTnsOPVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 10:14:45 +0100
Subject: [PATCH mptcp-net 4/6] selftests: mptcp: join: userspace: longer
 transfer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-slft-join-inst-v1-4-10572512a0b2@kernel.org>
References: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
In-Reply-To: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uQvWJWqihZkGpKPZrKlmGpWWzLcBWMn4qN10M0TfeC8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJZz0+Qm3qj/3YP78+FrGbtnq/OLJ9vHNUUGWrukXhg4
 jSh/uWxHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZLMrIcES4J/2NRuGSd0Yz
 l3WxHZkb1xnAHNc9r7LTOCiUe+uzFEaGXZ9u6n8p84pb9eOWfLXWltlnxaYLunsuldusYfQ+tWk
 +CwA=
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

