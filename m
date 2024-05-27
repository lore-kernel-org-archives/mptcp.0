Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE013B7A3
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807534; cv=none; b=aBHsclmq31Ks/UdU9WcG8+Ga9BA0HkvM6Nyfe8G6IkpThCpBTfMptQIi2cDcX9EcLrEz3X+gBI7xHVShsTwxiK9N62YAbrKpnCeNIUu4Ya/7lzX1FgKmV+p1viRUNTwwjsTF6Yapnx9cPKsL2t/3h2IprKkoElxwXaonoodSsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807534; c=relaxed/simple;
	bh=ClSxmwWO2U9SG4cXkYEmj9cxaLnaOSwzWkJRxKT9oWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzDPdikcdgzprvZhEgToAeoG9EVesCV6WQcfFTvNeoGtW8lKxeh5by1NV0tW8uNlYuCp6oBT2AYZqK41DHac9eEkIz0WOHoYSRa5Sgj0P4BfvAopJKrFxWEgomdBXp5RgstjQlUaH+1atp7Iofs0leQD6KcsUQwvAp2RXWz+2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAAzbTph; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAAzbTph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97C1C32789;
	Mon, 27 May 2024 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807533;
	bh=ClSxmwWO2U9SG4cXkYEmj9cxaLnaOSwzWkJRxKT9oWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HAAzbTphpepuvvwjMMlz9baAicf6R2y1xv5MHrJzbT7E/dIVo1Kl7CAqc/TmCrcxC
	 +TdbhzpJF2NzeGCJUd0d9uQRXXV3t6LJ0NA9fpm5GLo0u0YMULUySh03aPThC/UFSw
	 PDOkXr9bWOcwRRTrK+jhsFXfkkh2jZPwl26UpsKXZz79LmDgdgW9YZdWI+2t9zTjTm
	 Uu7wT6AUgjuqZbZyoVdmoFQt/i2JOLvyHfamEU4Vms0vwvMdBZ8SbXfmvX3kZ5+1PI
	 OiWaGWxNpnDFsmWPL+5caE9oj50jqNclfjWQZKshy4g8BgB+L4Gja1K9xkz5TG39Jr
	 Ia3pzfz4i2k3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:35 +0200
Subject: [PATCH mptcp-next v6 8/9] selftests: mptcp: lib: use
 setup/cleanup_ns helpers
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-8-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aGrjt/RDOMUUSXTZAa9PaA4YVy1Qtna2bT4y7qjVvdA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdipIjGF8byWUHSPYuKwBQhFTgdJeIHmEHVh
 X4dRPyfMd2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 c9w3D/9rqUD1EaMMvoLIVTORoycb0zBnZNZHWRp/8mLlVXmAglZyc+A5WpvN2zKbyyfuUcl2UW4
 TTDu69B9HNp70FdGw3vB0XMhyt6YGXRfY1GTxxk89Khp856xRjp2R+f2n21p3B9Z/QKlk3fx+h1
 VZISFm96RUqrDoQpdO5IVJoO9CdibiYyyd3bmY+1rqxr5xEXOYjpF/wdG6ZoVZ4b/z8aDPxEjM6
 W8aGy8IC22AjQ/Zv8wVYlQWTiFBaNYct++rZaYQANWGfeIbw4FXa2LFs7NxBrurNady3lUnli2Q
 f3SR6lIEuV7jBQMUBGATkk446Tvkl7RpwGNk0P7KUDR89Csv22DSqPQS9laPtLYKZ4z3Rq3rSi+
 2lFKQ5vQCSJq7C2ZGl/iVfS9YSI5Lal+4eMLCy/Vs4L5GrjU6rUv2inpYwdajQXmwguLA2SsdK8
 zB7J6DGhkGLvByVRO71YrrzyMVeLbfIW+qC89trAhBsNIXcfIoKSF3lFyRBAfdGzKegxLCYxihD
 plTBf0dDfYAIgDFEONtJjnk1I9vkypbqoDLWj7GOEBozF/sbfnbRxhOxGP6no9ctwAdjKpor5uD
 14nbvf/q+1in3x/tXUM5vXVZUyEiOAEtcsZexF8XF7BjsthsGaUMlrj2+S1SizOEHjHLtGuJJKA
 /bpst8czihiwKrQ==
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

