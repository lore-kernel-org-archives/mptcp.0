Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F2130E32
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619296; cv=none; b=hu4J7TsjbMEDPV6pwDcFGBI/L/yMtCLt4CvREAj9PdsRnMYPuSEnCyB2MjIoSxevnsP+FniyqFVK17Fy5TxXQKoU3/mAui7URrD5v/kKyU8V5ySMxL6LOngJX/cm25VVDFC1WDpxWdKCwUR7fBxs7zc9YXQqEQbkxZGegLi5uEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619296; c=relaxed/simple;
	bh=6gp3tMz4Awm0XC4OVK37KQh1Stbq3kFN1MWg7WiNC+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQRnLL1MJCeqwWzGuHWxp8QNdisGkEIOfuxgVfLdI9pAfFPHjMrP6XeXhuNt+QmINC0THcb25gEEZ3Hm5XQhVICImtuo9WWen3YyKuZ9VdjrVo9M7Gjm5yFJO3S7VaeiOhC0KvPdRpSWTRD+lpSMycBG2LUl4aVEwCu7n+WTsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo/Smj0L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo/Smj0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A52C433F1;
	Thu, 22 Feb 2024 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619296;
	bh=6gp3tMz4Awm0XC4OVK37KQh1Stbq3kFN1MWg7WiNC+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bo/Smj0LFNS0UA26I9UbI9BhQ8WwnAW80EmFQPqQ1kicVFrdVG2Wm9kMuIzMqxIs9
	 Z2qiTpbQ8hgyS8awQv1aBlJqbWbSoiJOM/0FE6oq6v5VG1DIEw/F2ngmortS9KwkK9
	 MLKbStZJ9iqjgCgRwN5iwTa2bwPCzr2E8JZlQR1SY+HJKmhXN/SjO8I8yVjIZO/bQH
	 eUeJv+3T+O4YUq0vXHmALkndfkJnkceN1kHAIn+NqK80bg4dG8CwTlyEI3hOBoTFHL
	 qEc8v7Rw54XNErr4d1Id6BoXO1p8jHqJCCLBIz+8PP258g1zsxTFNV/sH4RyZ7AMLB
	 l2YtBblQUevnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Feb 2024 17:28:01 +0100
Subject: [PATCH mptcp-next 5/6] selftests: mptcp: simult flows: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-selftests-mptcp-shellcheck-v1-5-fed8ba9e6ca6@kernel.org>
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
In-Reply-To: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6gp3tMz4Awm0XC4OVK37KQh1Stbq3kFN1MWg7WiNC+4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl13YaIeksgYAGUuI+LLgikd+42gWL23KWSKsLu
 ZnWkdtizvWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdd2GgAKCRD2t4JPQmmg
 c2IGD/9ReoQkkQjQk2V8K6Vkoe2g/6TA86U++KsxAK6vsbpUs3snSK04slp/KuXy5AG8VrIxUux
 EORObB80dMAnmmWOyz5Df+B1KqECjgjna1ZEabiiDZFAGbsrQhZExXpaXCphf2DZU+2pSFee5vj
 UoYkjPyqP/dbePrluX2dUE9J+S6kh5QJZmYo2eRfAxM63YKl6S7pvWQ7WeQsSZyP1g7kBQbvKjx
 d9+nve2R/gIf8sM0URbpvNWJM6vUfrsAWrk2+Tm2tByTXMfCaykY4XqPa2iLHRCSknojK2brVEv
 gg5GdY9D4e7m56bY4Dx0R0NP1VpvZIpPsPWCeVNMSgnN7Tr921+H4vYiRSR2U5horn5EmtTAtDH
 CZSqPdeC3XyUPNnujJRxMia4dRhRo0m/SbHDga3UggiJljqcweYlNfa9ot9UuYPc6jkAviEWJbZ
 Nbptf8w92NJNIY8YOuLmN6S9pTj1isDZdfdS8gQy/xqeH+ITamQqspud57pa4Jpl2bDhH2Qkhzd
 Qp8JiJuZ4vAhQ3hOxa9gBOxTd6MvBTMEwauK0LhCgU6uU6inD9+UU45ZdBfU+y2PQaqYGZ6gjpH
 wqLt8aaAnKNFWWWaMXZKDuTsAAnTh9bKyz1gfsRrMi2neFC7bAI272dHC2EVINUvPiuwShZE/Ma
 iJprk/YJhQj/WAA==
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
  - SC2004: $/${} is unnecessary on arithmetic variables.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index bc8f107357ac..467feb17e07b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,13 +1,17 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns1=""
 ns2=""
 ns3=""
 capture=false
-ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
@@ -28,6 +32,8 @@ usage() {
 	echo -e "\t-d: debug this script"
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f "$cout" "$sout"
@@ -120,7 +126,7 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
+	port=$((10000+test_cnt))
 	test_cnt=$((test_cnt+1))
 
 	:> "$cout"

-- 
2.43.0

