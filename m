Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3E2BEC5A
	for <mptcp@lists.linux.dev>; Sat,  1 Nov 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988505; cv=none; b=f8x9OX8F/BGj61SEmMlocKqaM+rdtS5aN43osdU3SJS3NXwX0ut/aPhrksUMK1pLM527u6HhXYI8dntTa2HpG7kh05IZjfTBxb8BSgVtJo7ZnXm5L/7y5bjVfscP0x1CXUemPAgmrPVBLjkUsXpdMfylVLP8htVFP4lUNsiwuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988505; c=relaxed/simple;
	bh=ocLbHxZ9wo2QXyV1i8WpgqWZ27rONG/afCrvvjhF7M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCBmS5cXNWoTD7taAFEJN8KsDlxLDC7EY6OslUtJAHXu+Pp24SQW0I7rZEkJF10zGUIVj3DDu9qpdwRDGcY4fH0UqcPPWayfZ0meOtOIM/SD3jK4cRUMTjljVnlrTXjG7ZRWPesjqn5OL2w0v8m9fcAoWHgvwfa7NokPKvIL8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfA0nRtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfA0nRtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58292C4CEF8;
	Sat,  1 Nov 2025 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761988502;
	bh=ocLbHxZ9wo2QXyV1i8WpgqWZ27rONG/afCrvvjhF7M4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dfA0nRtIkekixjLDyGB/ah6n/F6U2FdbK0nW4VOebyCZrD/RL/7lmfTZR/4+sBczx
	 Fs5y7Ctb8aJzJ8PBl02PM2aLicQXwYHhj2abchAff7u0Q3z1lIujxQ59EhTd8nCCmR
	 ymBFHcZe09pTNkahB/fJSwBJiSjMeOKRQ1mdesnAQgAbqAMMUNyjG8/98YOvCymuFi
	 23vSQ0ZLIHXJImMP9zJDg1HRnQcazJnSea3DlKqE5fG8OqiPLMrPyr+UeyOCUSuRAf
	 BVMssHS07vq2OS+XKRyU0MZNI4eqf1TaqNKTIgNjujguKcYI3niCP7yvC99SlDh12x
	 dVK3Q0Nf+a1JQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 01 Nov 2025 10:14:44 +0100
Subject: [PATCH mptcp-net 3/6] selftests: mptcp: join: endpoints: longer
 transfer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-slft-join-inst-v1-3-10572512a0b2@kernel.org>
References: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
In-Reply-To: <20251101-slft-join-inst-v1-0-10572512a0b2@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ocLbHxZ9wo2QXyV1i8WpgqWZ27rONG/afCrvvjhF7M4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJZz/dFMGkq3rqZJ7nm2tZfwfL1L7+8262cKHxT8VKhh
 W8Fv59bRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESiLjD8YjbU47qzq2T9XaXQ
 mDeXNHK0Qq0MF0zen2X3MalZdhFTEcMfnsthk54s2iL7wbX1n5Tjig2LKxvvyt4PY82vlOpn45z
 ABwA=
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

