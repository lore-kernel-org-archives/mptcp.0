Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEEE84FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563647; cv=none; b=udZ1w98z1HhJxEAh7Js/ZSBbBdNXxUuQhFgT732OMtAOu3avHX+ujZySq9dHRt1Q3RPKxOhMhAQcQzpEulO0VrLH3CumgwAXn6pFpTeSSAXAJBiOAl2ppUGe5EvTtgz3j8oWraq3314xRj44GIaZ/x29gjvIfrtFSldLaMGYqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563647; c=relaxed/simple;
	bh=ClSxmwWO2U9SG4cXkYEmj9cxaLnaOSwzWkJRxKT9oWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mL3zGppKBuTW2i323tSvvxCTgKFzXNc0wo4L6xrMj28Du2YrCD4tKb58+fF6FVcSC73a6fRkWP6LqQNLNZ3I6IX8CkoPAg6aWRqND3VXqF2QT5tMNYG5RRacIhlDMlO5EXBf05EFfxp/jMJhOukz/H+iFPscmP7bF85xabtHN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StloDT7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StloDT7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AC6C32782;
	Fri, 24 May 2024 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563647;
	bh=ClSxmwWO2U9SG4cXkYEmj9cxaLnaOSwzWkJRxKT9oWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=StloDT7hxDqBSew7YDIdx02eTzWdstq6EZwlFJe2WnGhj7GMmb8cDqmhtwpiPwFOE
	 5GCUsxnqJqaaD31LN/1puoWboy3UJt2o2wFwHzhQs7NxISZk/r+mSk8nTXhE5JRFsF
	 Gyahzt150a44ndgaSikof/JSVmvZCcpaLTjHCIrWMm76lMh9DQA6AzWj45rU3tUqJt
	 NSNjnmH3S+04TOuNVr8b/xVgf7W14GxSBlDvLvN+K8udxL7Euz+JJTvuksw1Pc3X0j
	 9LGhwxnYmVWRpQqjsKYNY2HDinmMFZE+laurm/1Pl3NCvXwbUKg76GBL9cSvUifUGL
	 VvR/AiMRbwWrw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:31 +0200
Subject: [PATCH mptcp-next v5 8/9] selftests: mptcp: lib: use
 setup/cleanup_ns helpers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-8-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aGrjt/RDOMUUSXTZAa9PaA4YVy1Qtna2bT4y7qjVvdA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zX9SIJDHqpd5ja6uc5OAyVvbCuvHB/TPIM
 YW4MNx57jmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 c6TkEAC8rcocds7EkLNhSzk8gnd5H9kAmO+8ENOdZ/b2Wgyycb4hHr/r11tUWgGSx8v5KOb/t5v
 U4v0vj9CzLdNJkEaDyctKF42XFAqsmIg1fqWw9u/pUUxqPcVgoWFHdPLQENYy4WSMHnpyhhoaMx
 IdxvRralsC025i6XkiBM2gWLehNlHYX1lacLIyqVDaCuREGk5HNC0me1awBRNTub2IOCOw2vE+9
 VSZWnH1CEbpzhs6WpRV0Hc5TikSZRk0bLgm0iJ2HoLAvaeWWfph+gWW5hTlthdTwzKRRIaWhxTK
 ufl4PaAOoKWAArn8pkJvwEmcXN6msMooQPelSZ+Tgujsg+i3qNXr5Ua6Ppf2tRG0O1K8BOodA86
 sv/GhC34AsuGTnDvkIHVq+T0aXvVLfzvjvnqNMQrplI0g63Y8pLYRI4j3Y6m0qUIzD4LzD9/8fX
 2NspfOML5/py2cztNRq2ThoA9eS2Z/Rcy/++6aI/slWfGGw2oCxVi4xI4bMhVh8U7JCL/LMbJxV
 Pnf//ZP+P5NlSzcKfGu2iZSZ8iP09p5w942A0PDlfsvvBtB2W7KpbHnWqKV53S1UTswd6VcZdb8
 aYnyvetH1xb5OVhP5+lVvqJj9ZClpjOeG8ObQ+/p5wLJlSRHFdaDDffLCiSamiXjUelbuiJi9uW
 mqwPLV7uZYLYjQA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes lib.sh into mptcp_lib.sh, uses setup_ns helper
defined in lib.sh to set up namespaces in mptcp_lib_ns_init(), and
uses cleanup_ns to delete namespaces in mptcp_lib_ns_exit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 6ffa9b7a3260..d9e30516dc72 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,6 +1,8 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/../lib.sh"
+
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
@@ -438,17 +440,13 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	local sec rndh
-
-	sec=$(date +%s)
-	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
+	if ! setup_ns ${@}; then
+		mptcp_lib_pr_fail "Failed to setup namespace ${@}"
+		exit ${KSFT_FAIL}
+	fi
 
 	local netns
 	for netns in "${@}"; do
-		eval "${netns}=${netns}-${rndh}"
-
-		ip netns add "${!netns}" || exit ${KSFT_SKIP}
-		ip -net "${!netns}" link set lo up
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -456,9 +454,10 @@ mptcp_lib_ns_init() {
 }
 
 mptcp_lib_ns_exit() {
+	cleanup_ns "${@}"
+
 	local netns
 	for netns in "${@}"; do
-		ip netns del "${netns}"
 		rm -f /tmp/"${netns}".{nstat,out}
 	done
 }

-- 
2.43.0

