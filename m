Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9361509B5
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619295; cv=none; b=ZWTTL4Cwf/MMIT8D9ArXX1U1qMX8K+V01X3AxuTlh16QLELz0TdXLsbE9qOQlI7afImYC4OTSj4Z0kQ4fD0xMirLijDbQV+P+EEKbHSB8Kk4SsxWqlal5gH3Utg1eX34f4dFj4Tg7595EPMzAd7cMP3x9EQiN7LjeWHeCJ0vHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619295; c=relaxed/simple;
	bh=o+jSbvlYzxeuCb/O3UexE+kxh+qFTT5+46ZgSo6Gq38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHXwAw0XfMSzDGG85SwoAmJ2PU57ZlUxr8dqeoiUk+Qnu0joA2qDFsnDS209mZ9ceofr8gdezMAeZOMNOXT7V5L+zLwRvJu/W7D1cdQDlVBt5GZSCvhAiRDbs3/yvl3bW3/zMIgizBio4IxOtHeJch2jnUPyPXCstWpivIttZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5Zdb8V/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5Zdb8V/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC9C43390;
	Thu, 22 Feb 2024 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619294;
	bh=o+jSbvlYzxeuCb/O3UexE+kxh+qFTT5+46ZgSo6Gq38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W5Zdb8V/uPWZKlpC0AIIN0f262lazuSYYxxRSj+jpabe6WN+4zNuBwIQodv24tCyH
	 6whhI423HOjXbGDWtVdxxYnPczKeP+nPQR8Ct6O6nC81wpntRbtoD8uZHSR6+8ucaL
	 mis8o+p4Ex1jYrTyfShIyPQZddZMt7nzIxwAE4uWteAMc17qs8lVrumwZjKcNY+BZ4
	 Z/5XNTBHAfrlqTbGYqL9iYCr3VoZfnduJWHwIwCDvQ31niDsSJ4kK4E38tkuoPzlyq
	 bjgfUjp4IU0ExOsbXaHONnGt0PG8W8cIajbAcQKMPceQdv5/zVywhzTCAyWxnp57bi
	 cCQOGJ5ByJf0A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Feb 2024 17:27:59 +0100
Subject: [PATCH mptcp-next 3/6] selftests: mptcp: sockopt: fix shellcheck
 warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-selftests-mptcp-shellcheck-v1-3-fed8ba9e6ca6@kernel.org>
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
In-Reply-To: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o+jSbvlYzxeuCb/O3UexE+kxh+qFTT5+46ZgSo6Gq38=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl13YaTmis9DgClAH6p6PfbTtKRNMvtDxoRVVDo
 hMyK/wsoKKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdd2GgAKCRD2t4JPQmmg
 c1iwD/4iG4Lszko78e2Eh1k61MF3QDlzTGxRZGox0vuk7NWx2wgRKsAc8qC9Bbe807JSUUdVvII
 p1VYoLbR4I5Fet3DSkjUyccqWNMEMHOBTRJkurMisv/1h8RBMac/81ZWkYvBn/jN58G81d+X7Vo
 mQrX83D3svP1LmX1t0f0/CZBxCyGMC5oQhj3O+aHhjTaTFyerulaG41CpVshuVcT9CeG/9sOsnS
 4VRuRPgM+VWciR2ZrC2zDIibwTNNTtneRjeficoEL6W8tZ0zhD2I/JKNQ1Soe/8hHrEokMz6PFT
 RaDvv6rswy2BGq0nwP6lZOBRj/gSg7wfyD+lqMWiksSeBmtU1hlf6UShYIV05ma//79WHhpKDQj
 kJEOyzETSmpsFCMliVjy03qAle8bxs7IuZaSWFfCW8wKsK56DLZkGopTrl+SC+IgwQTRHUYOsnQ
 rtaT6fdSONIEkmqKDXGYQtaTI9WfXhAnQTU8jY6yuurK2mlD/j4VylS5YWSKCyU9ZyCuk+CopJ+
 cABP89I4EXb8bpGce9UBguKf9n8y9ady9uFekoKeedZ3OY/FIpE11omCHBqrCHxh5z+7xs7xsY8
 o55SR+AXlOi1v/4ysxIyVQKd1XE+VObKsZ9efAjpr1MrW+GhRqChA4PJQVwtdReHHX9J6aXMmzB
 3LWM/W5pvPu8oWA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Here, two categories of warnings are now ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoked indirectly via the EXIT trap.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended, but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

For the modifications:

  - SC2034: ksft_skip appears unused.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.
  - SC2145: Argument mixes string and array. Use * or separate argument.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 7dd0e5467d35..6ed4aa32222f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
@@ -8,7 +13,6 @@ sin=""
 sout=""
 cin=""
 cout=""
-ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
@@ -41,7 +45,7 @@ init()
 	mptcp_lib_ns_init ns1 ns2 ns_sbox
 
 	local i
-	for i in `seq 1 4`; do
+	for i in $(seq 1 4); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -68,6 +72,8 @@ init()
 	add_mark_rules $ns2 2
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
@@ -257,12 +263,12 @@ do_tcpinq_test()
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-		echo "FAIL: mptcp_inq $@" 1>&2
+		echo "FAIL: mptcp_inq $*" 1>&2
 		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	echo "PASS: TCP_INQ cmsg/ioctl $*"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }

-- 
2.43.0

