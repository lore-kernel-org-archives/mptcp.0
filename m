Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06075199FB4
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239716; cv=none; b=kgjlVfCTTzscTK3l+oR6KcI6LettVNhoYl+kEilHlPdo/YsylNPd+DuXFM70PHOL312cKQDm9hU4Nk8DSTrT4oWMexUK1+CNxGAWnIy/Mu3XGGda0H+v3MPBuDKI/vuG4Ha2NFDnGAiMHkG1vJD2UaflflD7QD1xt/9EEda7ChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239716; c=relaxed/simple;
	bh=C3OYK8VXgoKD8yVc6YatwuAiK2CNR43lCLbdquUX3VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oA9ZErycQTg+qoqzBIofq4ML+j1HVfCvdRlSp3I0zMyxb2fUp9A6g+DUfsT2KH1OxBvZaEQEysf24MPWfXfdJWbawm9DmA7ZkzQl8PTaasIegMP9tUQ3kW6/5RxxSUPL+SoOJdt7K9Wced+Dg7BfapCSNxavVIAB1XyLTJtIBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNLo9pGd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNLo9pGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDAC4AF09;
	Wed, 21 Aug 2024 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724239715;
	bh=C3OYK8VXgoKD8yVc6YatwuAiK2CNR43lCLbdquUX3VI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UNLo9pGddDqLERAwhtjlxIFolXF2Xri9zQ4jjW7MEcjzkrrgjS2BfEjdF/rCpTRFU
	 DNcmKPJpRyMwser8NQvjXNWRABfVtDjJd5WX+0i/Q7OiCW932eFFZ1PnVhgw8hl4I4
	 Y0o6GrZzcNRZNIjcirEUM5OJqy81vpgiKcWmCL6Xi4b5qspGi9VCcJO0quqgVK8l/y
	 GcZpfLSMPAyy208B20JpbFGx/2mG+Ad0bChKGc0ZA86tge09YQXb3Jgf83S6pqlted
	 p0QfX/6eRDt0fHmoIsU5hr8d4ymwn0jI9RD+HExf3z50anStoqwflverXNDmLWYlOK
	 /wjsoaxz4shDg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 21 Aug 2024 13:28:30 +0200
Subject: [PATCH mptcp-next 1/3] selftests: mptcp: lib: add time per
 subtests in TAP output
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-mptcp-ksft-time-v1-1-c4ea94f41244@kernel.org>
References: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
In-Reply-To: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C3OYK8VXgoKD8yVc6YatwuAiK2CNR43lCLbdquUX3VI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmxc9hC9rmC79Ag4I3RsvlFMuTri2MkmDV542SU
 OAubVQn8iGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsXPYQAKCRD2t4JPQmmg
 cwdzEACcC2bs/BZPspyjk6uQLj/aY9fkZArZvvNbuEzaU4J+D0MTWEci9MzTKFOqP5/5eOibhEj
 udviqFffvuotJ/2GJ1hFpvgxtMuHQas/ox/MKKRbMyJzaeKAAd2xWtbfdb2/YUzvWAm/lmy54cT
 drdozzS3DHUBCmOAU9mrsw7bNIRefaIj1B9CPLfwinXR3mvwzDnJiug/a6TCShvOo+sMeDNa/HY
 qlaWroHus5jWg2W2PG6fiStfz8+MVdKJVFjuVvjgU2bchbO2Cezt8GH8hN70Mj2wyWnpQPgQoXq
 69L2O0sTBHax9N3qundMLfgZkWcBx6fsr+RXs55mYdRgvHbX430yftNYEJWZRvdzG18NqNq7Zb8
 rQdGKSWXNHtLGQmPu0RJuj6blpbbUQEJfHREZkBy+I8Gis65SxLCP6Qt2Mkb9QKFFV+wTb8B91D
 KI324htz2T3Pk84cypuSrVWJxC3MGZb/g4yu3/WETt/Ew+ledVXTltUXnEPiUfpxa2g8DxaB0eY
 n8xbQniThYht5+/g55TwtJF9y21NHv072yRc4Z2o//aCdFl41B9R2NLd390iLgwgPshXHmcmgJT
 Kv55R0C+DuZWqhJCRjZD5ejOm3umlFPfE2hL03d9+JqeWwUd3MlzwIRR34DAnTBfo5fcI6Q69bG
 vG+NyDT4XNDcx+A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It adds 'time=<N>ms' in the diagnostic data of the TAP output, e.g.

  ok 1 - pm_netlink: defaults addr list # time=9ms

This addition is useful to quickly identify which subtests are taking a
longer time than the others, or more than expected.

Note that there are no specific formats to follow to show this time
according to the TAP 13 [1], TAP 14 [2] and KTAP [3] specifications.
Let's then define this one here.

Link: https://testanything.org/tap-version-13-specification.html [1]
Link: https://testanything.org/tap-version-14-specification.html [2]
Link: https://docs.kernel.org/dev-tools/ktap.html [3]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 438280e68434..871720da04c4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -25,6 +25,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_SUBTEST_FLAKY=0
+MPTCP_LIB_SUBTESTS_LAST_TS_MS=
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
@@ -201,6 +202,11 @@ mptcp_lib_kversion_ge() {
 	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
 }
 
+mptcp_lib_subtests_last_ts_reset() {
+	MPTCP_LIB_SUBTESTS_LAST_TS_MS="$(date +%s%3N)"
+}
+mptcp_lib_subtests_last_ts_reset
+
 __mptcp_lib_result_check_duplicated() {
 	local subtest
 
@@ -215,13 +221,22 @@ __mptcp_lib_result_check_duplicated() {
 
 __mptcp_lib_result_add() {
 	local result="${1}"
+	local time="time="
+	local ts_prev_ms
 	shift
 
 	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
 
 	__mptcp_lib_result_check_duplicated "${*}"
 
-	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*}")
+	# not to add two '#'
+	[[ "${*}" != *"#"* ]] && time="# ${time}"
+
+	ts_prev_ms="${MPTCP_LIB_SUBTESTS_LAST_TS_MS}"
+	mptcp_lib_subtests_last_ts_reset
+	time+="$((MPTCP_LIB_SUBTESTS_LAST_TS_MS - ts_prev_ms))ms"
+
+	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*} ${time}")
 }
 
 # $1: test name

-- 
2.45.2

