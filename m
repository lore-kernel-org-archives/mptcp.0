Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEC2D4B40
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083024; cv=none; b=j2Gp1syWTQeIDBupxcjBkEOaGaAIAeWxxuKKHHO2YgSJUlCLGhh+iMyPxkkaH96/STHPuc6sxVgO0yRQL+nox8XnINI6i5XrRBpBs7qr5T35eQN7mHlLA6NivhxWIs3FQVV09SdnIRj4hl0z9gD4z3SA2zn2rLxeM+joyEhuHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083024; c=relaxed/simple;
	bh=ocLbHxZ9wo2QXyV1i8WpgqWZ27rONG/afCrvvjhF7M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIvJZbl//fzwzXqflOLhOw1UhGi1ZOCzqFdEBzX1JuU68M9Yw0Tmk1uABT0TPlm7y1k+HjM+KuUQeZDELQxyZfGOPiHUzptaMDGRAqNCB8a2KDMxOnjErEubP+id//skiVcqrErqGwejNuGnENJxVFKT6XQbYeutP8JUgCZEwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW5AbLnn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW5AbLnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFC9C116C6;
	Sun,  2 Nov 2025 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083024;
	bh=ocLbHxZ9wo2QXyV1i8WpgqWZ27rONG/afCrvvjhF7M4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VW5AbLnn7QA9zM6lcnWHxo661NWyJN3E5KZd4ISpmZt+gc8ql8m4djfxOJVhekzW9
	 4yJ/LNzUaSXIUNG5fMK8EXKtPMyXgeKI5/HRS9eR00ME29JczQn2GAFnchoGr8V3Sb
	 bHLBh+Jh7p3sTVq8Q0w/8jI1vss0ws4mH8aT0L3Ao9Sx4Uh71FjgAgK/R706C3n2O0
	 TwfPCLRmwp2oKgsCqlnm3tlVUrzKjgpcOn6OCEwISoLghQSuJsJ6yCMtD/iY+ilNYI
	 8MCH32vmpYuI4c1hO+7FnhfBDSa0AXNizlzNrTS+zZOo9GnvQhc+6uBMaPijHkc2Nb
	 STTcsfH+VcXSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 02 Nov 2025 12:30:05 +0100
Subject: [PATCH mptcp-net v2 3/6] selftests: mptcp: join: endpoints: longer
 transfer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-slft-join-inst-v2-3-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ocLbHxZ9wo2QXyV1i8WpgqWZ27rONG/afCrvvjhF7M4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLZHU5MP+8zid1b1ct5iZ1l/R3pSrtVClJha1mUS+9Xn
 Tt0dx1rRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESachgZHn2YUsIuekv9m6n/
 jtbues43K6cc4zgRc2/fhlfKeleybzL8L7M/e+np7OLDwhenHtCM5v56fsHLtCkajb/kRFOsuJL
 suAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some userspace
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to make the
connection longer. This connection will be killed at the end, after the
verifications, so making it longer doesn't change anything, apart from
avoid it to end before the end of the verifications

To play it safe, all endpoints tests not waiting for the end of the
transfer are now sharing a longer file (128KB) at slow speed.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 399805812197..b5a7045c1392 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4094,7 +4094,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		{ speed=slow \
+		{ test_linkfail=128 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4121,7 +4121,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		{ test_linkfail=4 speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4199,7 +4199,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		{ test_linkfail=4 speed=5 \
+		{ test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4272,7 +4272,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		{ test_linkfail=4 speed=20 \
+		{ test_linkfail=128 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 

-- 
2.51.0

