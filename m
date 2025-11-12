Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFF27A12B
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940778; cv=none; b=fAhrhkRSkSOqwwb1ndSLh9smzJ9ByfRlOr4PwSX0r1V5k7Y1ewSUPCPBO0hbQJhJ+RuY9CwZDgaLLdeCAD7DgPGXELnX8eBCuSSW0BfqzNK9R3bB6DcI6CXXKlFF2ZQYIAyHmCfpzjTyPucR7pqbDjCP0nWXTo3Cr6mXoIUj0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940778; c=relaxed/simple;
	bh=5uYGF+p+7f7C5WLiJI5V/08vyRN0caCQQK8JI77oJrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBJjEYV4iWvCYhcSKq43q3P7snM3dUT663Y2JPCv2ZWphL8j/02xUjy2oXd439Pk/D3snE/UxZeqidGHCAtoLLJc+ClXfUpcW9YDMHY7NDg/SSfTbu16UfvctyM6EiIWUIvXYs1A/x3quw32An5ct5i7EyIby7IWE1Sm49kb/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+9IE2Bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+9IE2Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BE7C116B1;
	Wed, 12 Nov 2025 09:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940778;
	bh=5uYGF+p+7f7C5WLiJI5V/08vyRN0caCQQK8JI77oJrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u+9IE2BbZKNWdJMDIos/GsTv3nF8NXmrOapm1cG/mtbe/1hlFtoWP/S+TRIWluwno
	 /Ud3BFfMPV6paUL4tBI+jdxIfSfW6Gz5zYGLc3YUngvNm7f2kAxCPgRevp6W5uXlJq
	 8S+t2n11WIXglkQ2khwQlecKloTQnwx/6KmaphOffem8jqsN/nSaCyt/k8bQUPi0DS
	 Cp+UlyuwO7bcvVn2Ff+yZsSPmsAzOomM+mmmyO3pNS86WVUy+zTOVxZZkr5rTW5LBt
	 tiJiWtj6cdBdkbVnIl57N8db9X24PT1Sxp9/Q/zv1yjmJQKeSTyS4AV5IxUZcg6eRg
	 cM5NJMmJ6C5hg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 10:45:48 +0100
Subject: [PATCH mptcp-net 1/2] selftests: mptcp: join: endpoints: longer
 timeout
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-slft-longer-timeout-v1-1-97aab145a062@kernel.org>
References: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
In-Reply-To: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5uYGF+p+7f7C5WLiJI5V/08vyRN0caCQQK8JI77oJrs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFwtM/7W8/vLtOK2+vcVXc3JclTod2/g9gn8X0U8fSf
 oKgyVPZjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl8jGZk2DM9wtDeYb2u1Of6
 ozGTYrNLstLWWaznf737VUbP7dd2KQz/3Wb1BmVpZuw4ZvjGWsVYQsZq4y+Gjz+vff+6QOGuWug
 UDgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In rare cases, when the test environment is very slow, some endpoints
tests can fail because some expected events have not been seen.

Because the tests are expecting a long on-going connection, and they are
not waiting for the end of the transfer, it is fine to have a longer
timeout, and even go over the default one. This connection will be
killed at the end, after the verifications: increasing the timeout
doesn't change anything, apart from avoiding it to end before the end of
the verifications.

To play it safe, all endpoints tests not waiting for the end of the
transfer are now having a longer timeout: 2 minutes.

The Fixes commit was making the connection longer, but still, the
default timeout would have stopped it after 1 minute, which might not be
enough in very slow environments.

Fixes: 6457595db987 ("selftests: mptcp: join: endpoints: longer transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 41ce0eeed72c..b058f78ea0bd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4090,7 +4090,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		{ test_linkfail=128 speed=slow \
+		{ timeout_test=120 test_linkfail=128 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4117,7 +4117,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4195,7 +4195,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		{ test_linkfail=128 speed=5 \
+		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
@@ -4275,7 +4275,7 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		{ test_linkfail=128 speed=20 \
+		{ timeout_test=120 test_linkfail=128 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 

-- 
2.51.0

