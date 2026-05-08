Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E01A683A
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262910; cv=none; b=hDdd2zxBLsWAhLr6djf2yZnB6DQcWxMGgXRwRNOFjGI7kGBAr9/daQPT1BBOmr0dlH4jW0L7/zrgNxrKzzg0U7bWKk1Nx4lYuxh1Oliu1nggVgI9a1IWL4jS7iInrsP0x5g0zUvxPFOVivlGvPR2FnVa2445XqpXXhgoHvWRR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262910; c=relaxed/simple;
	bh=f5pbmqMatZ0CdAtvxnZWCrL786LEAfYmSEsfqv72ryA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3dO4fc0uZl3yaJH0WZrir5XB4iXiWnS3LHGtu5xI9xLjZI7hteVBamlEGLI3Agus/UbWJ4CSEI7fZv0tgbp3Bf7XmdnMnyl5tUYLEasW1SAXXt4jumwva8xG5KfnB1PYdN1HYPZMWZyrgqFUiwRgtTjBxmkkX/NnUr+mbVjFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkdcn5uR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkdcn5uR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21CFC2BCC7;
	Fri,  8 May 2026 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262910;
	bh=f5pbmqMatZ0CdAtvxnZWCrL786LEAfYmSEsfqv72ryA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gkdcn5uRPSt5Q4YKA++6bl6yXAc9mRuzdoGTFbObnPQEUr0Sf57Oq275KY86G7XI0
	 UW8MzOne80e2Cj9t0v1LGTw/TEWVqCLEye5CQ4tqJb/xiY9xM3khuDJB8v9KaOdQrB
	 AfXHrqoDUDpwm4tq8/8pbomuzhS6IESSYYTphwgQO+KTxVi13D4LrzxZP9kFDQLjlV
	 Fp7OQP8Z1bwV3ziB9hJCG5LHhoZKmGUi9qLzYoVnBR2Q+rcPFQ4a5OlrEMluGA3VNM
	 lLJ5AOiahxX1r/zgbxT0ES25cbV5qXuNiqlzzCerSg8wvIMN6SFABm3aJXzIi8gsmE
	 oL9LFcNk8IH9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 19:54:56 +0200
Subject: [PATCH mptcp-net 2/3] selftests: mptcp: simult_flows: adapt limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mptcp-sft-sflows-bufferbloat-v1-2-e9b0d25d9789@kernel.org>
References: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
In-Reply-To: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=f5pbmqMatZ0CdAtvxnZWCrL786LEAfYmSEsfqv72ryA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KVefeWcbPEn2bZWYoGyf0MqYp0/Wtvw6dWvikWmdH
 bPyzY+EdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk709Ghj3MHNn7T0kxPsyd
 nf3AXDjR73hs4+oEp41SS15+F4qUn8vwP71Du0udq23TTPPjV1c9nWEna7O4dlv66ZXXJdf6HYz
 OYgAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Avoid using a fixed limit, no matter the setup. This was causing too
high bufferbloat in some situations, e.g. with a low bandwidth and very
low delay because the default limit was too high for this case.

Instead, use more appropriated limits. Note that unbalanced bandwidth
modes seem to require slightly higher limits to cope with the different
bursts.

Fixes: 8c09412e584d ("selftests: mptcp: more stable simult_flows tests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 345cf200c653..7b9aabe10170 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -223,9 +223,11 @@ run_test()
 	local rate2=$2
 	local delay1=$3
 	local delay2=$4
+	local limit1=$5
+	local limit2=$6
 	local lret
 	local dev
-	shift 4
+	shift 6
 	local msg=$*
 
 	[ $delay1 -gt 0 ] && delay1="delay ${delay1}ms" || delay1=""
@@ -240,10 +242,10 @@ run_test()
 
 	# keep the queued pkts number low, or the RTT estimator will see
 	# increasing latency over time.
-	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit 50
-	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit 50
-	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit 50
-	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit 50
+	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit ${limit1}
+	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit ${limit2}
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit ${limit1}
+	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit ${limit2}
 
 	# time is measured in ms, account for transfer size, aggregated link speed
 	# and header overhead (10%)
@@ -301,13 +303,13 @@ done
 
 setup
 mptcp_lib_subtests_last_ts_reset
-run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
+run_test 10 10 0 0  20 20 "balanced bwidth"
+run_test 10 10 1 25 20 50 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
-run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
-run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0  30 20 "unbalanced bwidth"
+run_test 10 3 1 25 40 30 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 50 30 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.53.0

