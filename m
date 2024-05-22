Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03979B9D
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374875; cv=none; b=cSfedJGzku8TP8QfD0E2kMmsJvLIDnPh3Xx2op2NOVROmt5Pk3dssUrPCcdJ9bX9hzsfcDOt/1SZB40rzfrV0tXjrk7pRiWbuskPeqPcE3nKiIt8g5c0dvpWHyBO8tc7pTf0gWzDi9mvczuIG8ysBeSJhwmAC4cZi0EIZYg3Dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374875; c=relaxed/simple;
	bh=Ggy7iYS0IsFK7puQFPQ7OdbUwg1pe5OIKJkUZqeKNe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=It27eQWOUkTb8q2hHYyNc7OSdy3WvOlcCUneLWzjij20FNoPeL6yWDyP57IqUDoO2H/5+0hQrGckFTOjjULXGewCqZvz3vpzc/eHYwhtmNJv4jmcpoRoCvrL0vP3+K8dw0ZX3Y4C+Z9woOpgTEc5WZ442cY9AJMwdb34Hgs78Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja2jj8ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja2jj8ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33770C4AF07;
	Wed, 22 May 2024 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374874;
	bh=Ggy7iYS0IsFK7puQFPQ7OdbUwg1pe5OIKJkUZqeKNe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ja2jj8ok1x+6n6mM8mLiXhBGi8ULKN/9/ZgIyBcwW8ceGPt62/SHbO+1LjybKea9q
	 wEWOp4B+rBVJNwEKlcWAPr5F2zkqbI5W+bt90hewxHGodwgC4fKfexYCJ0LagdrXg4
	 paYn8L2/Q7OS4WUZb46HyJtAPREYsQjgYfM/mR9whb/1pddieNMGGOFyfdPr9eVkEQ
	 w6qEM3TG+CFt22Tw2w5RjQ02Pb7ZEZRYhLYHRQ+14/FyAz+BqyBjYzkCEWN1cbLIIp
	 3+LwsA5JX1+Crrn28gvbzp3rjtl3cE77ybwNTMV3eYyNu9YYxm0zP6Y9RX4r/oM8XS
	 XaJbfE6x2449w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 May 2024 12:47:44 +0200
Subject: [PATCH mptcp-net v3 2/4] selftests: mptcp: simult flows: mark
 'unbalanced' tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-selftests-mptcp-disable-flaky-v3-2-a10c68bf2680@kernel.org>
References: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
In-Reply-To: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ggy7iYS0IsFK7puQFPQ7OdbUwg1pe5OIKJkUZqeKNe0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTc1XSSc2IYMIDUMnD3v8VBf0L265DIAzdxcU6
 /6iRvIgNhmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZk3NVwAKCRD2t4JPQmmg
 c3e6D/0ZJtGq2hzY/NZIsXlhD6q6VrJCOmAdHR23dil+pG45dsvwAxfqWkFqxFjOSnyOIfRjMv8
 Vux1INXAHdT3duFLNADebTyZCtIMQAg0LFqLioM4ODFw/bC/o6f5VbALg7QIrx/tXj3FzwYMKf9
 Z7WiP9IwQ7grFbVySVJuS9j3WKkI2kZrtr9ToEdnVmdvS4QgKNZj8A0AWJsEFUycBdez9rQYXyt
 gCOENqzya8Ajm5yN2DMeZdstLvRYIAQoNBuuDMdBSr99nOkAnZUCv1LDM5n9b2x8Q7IX60SnVmS
 BbI5p25WXJHty5YaaHYR4CL9NHK1S0Dnw9iK6d/cgJla2vQQ/7sdzEnmlJxRxOUEfN+VQdMN91w
 rYlQ5qzAVZWs/+o6YQXygE7/ncKEGMZIigKbfSww9uz2X68UVvptAgkBXYjviCShtOjCp+abwa2
 8/jBgz8uuELLRZ53EgjbWdRbL3DZMqgNkC6yMCiEsa0ueHbMhLHS1xvOB4fHzVmvN2rkg7MUFhi
 clMy2F6G3XUwzlh6NWRMFkX+tt+xHqbnH7AkjWqJCjmQIoZ7kYbWIdfdc6+rHGnf6+TkqqBpVZl
 odQbXGfQGXi5oj+biwxRP96noBhzKX6x5hXt9xJjgzrEetN98u5D41LgLqdz7TCCRZNbgBjLM8U
 Bj89iImCOqB6W6Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are flaky since their introduction. This might be less or
not visible depending on the CI running the tests, especially if it is
also busy doing other tasks in parallel.

A first analysis shown that the transfer can be slowed down when there
are some re-injections at the MPTCP level. Such re-injections can of
course happen, and disturb the transfer, but it looks strange to have
them in this lab. That could be caused by the kernel having access to
less CPU cycles -- e.g. when other activities are executed in parallel
-- or by a misinterpretation on the MPTCP packet scheduler side.

While this is being investigated, the tests are marked as flaky not to
create noises in other CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/475
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d0b39c2e38a3..b42d767246cc 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -244,7 +244,7 @@ run_test()
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -254,7 +254,7 @@ run_test()
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -290,7 +290,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 15 5 0 0 "unbalanced bwidth"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 15 5 0 0 "unbalanced bwidth"
 run_test 15 5 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 15 5 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 

-- 
2.43.0

