Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD72130E32
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619292; cv=none; b=dTQqsgzRuALNPAX4jJm2NnVJOKlvlWQKuf8du+7npZ7QBugds2Zxq1p25o/q5stBSUTAXrJA5TndY+hSZX0lPZTjId0+WunYqFnbkQJoNXR9Mq3aDaqGk3TgCuvXPHnB39b9lD4Fpac99daHzHEDLrA/+EHHqP+16sjf2cKjMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619292; c=relaxed/simple;
	bh=6ppa6gVZX7Mf0YViq2iuuXIyOA1XpMhNbWorGleUM38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDJkqjgvme51oKVARSyrMIkPoh2c+TmAjz0ym6StR96B5whSQPJ1n6Z8gPWg5a5NcLHjSS9yUCBSbHAqYgBnio4CmPox/qK13kycNAsS3KBwBi4fUxRJ8wGU5G/x/0n8lqyYejWgX0sZ5YBwVVRd7zM+PgfvinKulIveTW09204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7GfuB0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7GfuB0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E63C43390;
	Thu, 22 Feb 2024 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619292;
	bh=6ppa6gVZX7Mf0YViq2iuuXIyOA1XpMhNbWorGleUM38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X7GfuB0HBOGRdVfkmSzQM8yMr769OJZzqALC3YSfWInl6zKMiai2vfYGpBVKQsHa8
	 8v8oCSaFc8jO4j2OJJTW9IR0egFUXJ0g0gkpksaLrxhlQ2zLI4MJqN+VfcZDb2XCCY
	 DB4NVzv9fjvQAqnBAK0II6Vvd+M1nXFOkuCCGYt7u6yD8NnW+kMRpfiRMkEaQUVafZ
	 LQiCzlOyt4KfKbPugeD7Z7dYNDZ7Y1wy5q84NyMDX48b2YBiqvYrQOtAEOxYE6ZHQT
	 jKLfPOI9ATXtcEfsDkyElvK1t9eVpqcDn9WLstNUiVDRd/4bnXSB1GibkI0fx/d/97
	 ao3aUN7nwuZjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Feb 2024 17:27:57 +0100
Subject: [PATCH mptcp-next 1/6] selftests: mptcp: diag: fix shellcheck
 warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-selftests-mptcp-shellcheck-v1-1-fed8ba9e6ca6@kernel.org>
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
In-Reply-To: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6ppa6gVZX7Mf0YViq2iuuXIyOA1XpMhNbWorGleUM38=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl13Yaitd6PE7F/3RpDPMJXuO3c3KUp5QiqvkcC
 NvWkg+zAMuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdd2GgAKCRD2t4JPQmmg
 c6jVEACh6WStwVKtPvnSE1evZ8iLRwP2ZD4zFh1u04dMID4qUgMVkuFhqymiiNvNdReFuLGYzwi
 cw6ahEzT2BZVNog4ckR0g5FNcHOJD3+Gi/nLY4cekOK7Qhf2ukk8lRouMxgA7ARt+aFg3iJpVvg
 4dGIgoGP4Fl3dhjYhXcaub2Sy5bleTvjf5AAxky4eTYOfws9wnW22zzQFk+dODRMgY0HwOhJ/kB
 /2mklvCg8ylz9gQCCTza6BO3DffThm6G9x8I8Go9cTfd8WNvphoeY9wd+aMtHaLG0cpW5JZ0cwq
 9uVEFB6aVsZ6cOw1MD+UefZQ/DTJAAUcBFHHyzwM7eJIvpGtINeSwGheR077rRwkL4g0wr8oKkK
 ry7BMEXauYocXdqnzc0oAxsBSMjqmXGszOsTcgSXMkJ15sA1oh8k9Gp+NVBxO1bkxqYhI82SGja
 ap7etNavhCc68MtinqvHdi5PT3LigjtDXso5QNqW5413XL3UU/bTKwi5mDx4yuXnD68S5MdSXPp
 fzItHrttw4IeiLbKOyTygetwNs8anc85JzxYf8A9wXjZNfy07MaQo+/h9+IBSZV5s0qDlesfenM
 Le/8BdkaQAL43euFabx3FfLEqTOIaZO0c1bVs/Qhjhhr8OeUPK6Nv3rqfznBsOJkT+4mDcereXC
 UPYSkXaFz3ZphWg==
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
  - SC2046: Quote '$(get_msk_inuse)' to prevent word splitting.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0ee93915bccb..d8f080f934ac 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,10 +1,14 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-ksft_skip=4
 test_cnt=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -24,6 +28,8 @@ flush_pids()
 	done
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
@@ -174,7 +180,7 @@ chk_msk_inuse()
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
-		if [ $(get_msk_inuse) -eq $expected ];then
+		if [ "$(get_msk_inuse)" -eq $expected ]; then
 			break
 		fi
 		sleep 0.1
@@ -260,7 +266,7 @@ chk_msk_inuse 0 "1->0"
 chk_msk_cestab 0 "1->0"
 
 NR_CLIENTS=100
-for I in `seq 1 $NR_CLIENTS`; do
+for I in $(seq 1 $NR_CLIENTS); do
 	echo "a" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
@@ -269,7 +275,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
-for I in `seq 1 $NR_CLIENTS`; do
+for I in $(seq 1 $NR_CLIENTS); do
 	echo "b" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \

-- 
2.43.0

