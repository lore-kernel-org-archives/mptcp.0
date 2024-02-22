Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23736130E32
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619296; cv=none; b=c+Q9YLsdUB5YHASwwzU0BelSnmRUAYTym7yvk7ULx8GO26x9haO3HOuEx6WiNdtdhqUMqpmjXvN1EJ7W9AZzjzVxBBdWyG220jmIJ0Hx73QZGClgLYrW2eXrR2k2UZpws9npxMIs+vI0yZMS2R+UP2li/Wa+VLBsyBijFMFfmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619296; c=relaxed/simple;
	bh=NdzuTZnT4mM3C0AQnuBnVv5/NzPYTKcBpWEYp6mEj9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bk2wd/Dqmfq0xgbHxn4vtsaD0+Pvu3Q8tJMzXy6OPwOuXqVR1S2NAFwZHGVPyyYlWXL3/uC812Ec4HvVThmiKmLPibVF+K59j0ev53KCaG5JwIII5saA2kIAPK8fqvjERYuMDE5oWe6IkIEbG2rquhe5OSLtUx7g85VPZWgk4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehQYmTYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehQYmTYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA345C43394;
	Thu, 22 Feb 2024 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619295;
	bh=NdzuTZnT4mM3C0AQnuBnVv5/NzPYTKcBpWEYp6mEj9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ehQYmTYCVjLfWDXAdvP8gFs2KhNZOZa112bg+aZacAF1d4EWlrLkHY/jyrQSSJzuY
	 8BvALWmXRzZRPXmcUdlOR9KW1Vzs70dl54g7eiaG6sCXJEwaORM3KbcUrsuoJX/VJ8
	 fGP+5FILfIhi3Tx3yVSb1V1v1eud0k7chMsw3atrsQz4UMI9UBurrFH8FDLgDR4zdw
	 xtVr0FjsAMQYfruu5gi/iufnFMV3oveWrVVu2wAGABH8DRMWZ5OxggPtA6/mxpdSHI
	 f6PfeERzXVU0DhHKx09Kr6SGstzaMh/VkgTX+ISo5IIkfSlyt87gm0HJ3YTu5aJzmu
	 bcEzCIlOkYoDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Feb 2024 17:28:00 +0100
Subject: [PATCH mptcp-next 4/6] selftests: mptcp: pm netlink: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-selftests-mptcp-shellcheck-v1-4-fed8ba9e6ca6@kernel.org>
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
In-Reply-To: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NdzuTZnT4mM3C0AQnuBnVv5/NzPYTKcBpWEYp6mEj9w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl13Ya3LT+xyBODp4oJYTT8+f7lIQAgNdsWalQR
 g8QvWh40MOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdd2GgAKCRD2t4JPQmmg
 cwetD/wPYjL3HhU/xpwPxFSuqRygOCiqUlYlsQfDshIpkcqxw5Qi1+eeFeSQ8Hj9fb8cSxWHz4I
 Au1KcUACtKxIDL5WpFAbSG2d882WIyLYqyePfVQ8b1HyPj3nnhaOEjgayRJZOHxe16Hr87u6YYn
 RtGjlhEl8dCbLPmx2T5eT0ayClo6eJmDspZBbRW5ixuReRzvUlq00kP2oOpWJ134G3aYpfbgZa6
 6Pp6A7HSniEVNuWcnuMOqRHD7x5ONrShnnb2tFDyE82coLwcI+md1tF4VTS8JJ6/wELsM7/aPQ6
 3GIoeJobhfNgUD0wAO/Ip2j2lhnsQO0tuJf3PbwjKokfR9PGp/3Oes5jp5CE+GnCRYgETs2m9qh
 10T5Rpt6GoFH3AzGmJc2LzTtGo8RBvfuG2+4lTMtb7J1jOLIqGPWud7Vp8O1i7HV+7yQGQAaDEN
 gg+kRM4gJ6X7olzZ1F8tYpO0id9iZMxhwwBofVbP/XHnNsUDDt02OTadoUy80RCaZ1ZIlfqtecV
 9pl+omgskDlc6GTrlGMrEnDEousUhxljPKAg80es9zla2JKynbD+bJQ46OmC3QnbPrsmtoq1pwM
 UO2fb+Bxly51rts0lB5X9C4q2NJ+YTgejaCGZGu1Xw62+eWDB2uGKaFFQWh9CsnNe7iBbchEvnz
 bRnnp+QaRlFf12g==
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
  - SC2154: optstring is referenced but not assigned.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index c7c46152f6fd..427fc5c70b3c 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -1,16 +1,20 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
 ret=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
 }
 
-
+optstring=h
 while getopts "$optstring" option;do
 	case "$option" in
 	"h")
@@ -27,6 +31,8 @@ done
 ns1=""
 err=$(mktemp)
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f $err
@@ -91,14 +97,14 @@ check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
 
-for i in `seq 5 9`; do
+for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
 check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
-for i in `seq 10 255`; do
+for i in $(seq 10 255); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done

-- 
2.43.0

