Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838262154
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200286; cv=none; b=kodjSAD4S3PWAwccaL7vlZYnyeOiYpga2s86bblbpDdWp9lHOqdGrZYKlGFV374c5dE4PEWmZW6iUyxZuPwaC99oisesfZEPieAHsQ5Dz2H5QRHav5rFzmjVh4Ejk66oEtqXLhuCcmgy7jGdyMBFw0k2LzNM5l6f3j672rrbNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200286; c=relaxed/simple;
	bh=mprnrej/0gLC63Pqw5hE0AB99UEFRq5m2fhCyfBqo8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/IP0At8HKUtremeVGaDjgoCF8OZrHlZoH609fyfAUGdciYSkKNfe+3bWlydxLLicRi55NAieTZpf9b5clIxZOLLCg99OohsoHgayNlvvLacjaO9t+5jyYB1MgfNeZ5vFBYX7L1gkgXEo4XP9GQAKLwBRHjiNDv//wFdJtZV6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9P4yLIJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9P4yLIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E856C433C7;
	Thu, 29 Feb 2024 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200286;
	bh=mprnrej/0gLC63Pqw5hE0AB99UEFRq5m2fhCyfBqo8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9P4yLIJUO5ls6mGwV0k/KFwQ/OXtOfKqUtVOn1vR1t3cVyT7pzmWl4tTHp6XJNmm
	 qxNcWT2cxudOYZ/JiF9JOm1l5T0ENy22FW3a9czi/Mtr6MTfRGAuYgn1M7XwScsiIf
	 D/Y5UDwHN/TGexmkLLTmrNZaZgF8PxUV9xnynaStN0UUvAho4uFm5z1SasmA4NjAyn
	 QSimojK9C9lh3bYFDmX+iCZI7Cad9ro2EqPk784tMo+fyokt2Nwiv9zW2MQz6cKNCd
	 zFYbkWIGCRaVHF/VXlAATVPJnwhdLHyzmrn3p1B7aCdwmSd/HYrRCK1mtvXI/bKK9D
	 vtAvXFmf4BpMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/8] selftests: mptcp: simult_flows: fix misaligned output
Date: Thu, 29 Feb 2024 17:51:07 +0800
Message-Id: <c5534d2e878f0d776e0f46a28ba6703e0a05abd9.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The last line in the output of simult_flows.sh misaligns with the other
lines, and all lines are over maximum 75 chars per line.

This patch aligns them by using the newly added print_title() helper,
and truncate them within 75 chars per line to allow it to be displayed
normally in regular terminals without breaking lines.

The new output looks like this:

balanced bwidth                                        7395 max 7906 [ OK ]
balanced bwidth - reverse direction                    7484 max 7906 [ OK ]
balanced bwidth with unbalanced delay                  7394 max 7906 [ OK ]
balanced bwidth with unbalanced delay - reverse direct 7399 max 7906 [ OK ]
unbalanced bwidth                                      7692 max 7906 [ OK ]
unbalanced bwidth - reverse direction                  7614 max 7906 [ OK ]
unbalanced bwidth with unbalanced delay                7425 max 7906 [ OK ]
unbalanced bwidth with unbalanced delay - reverse dire 7473 max 7906 [ OK ]
unbalanced bwidth with opposed, unbalanced delay       7639 max 7906 [ OK ]
unbalanced bwidth with opposed, unbalanced delay - rev 7611 max 7906 [ OK ]

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 467feb17e07b..d5f8521b88d5 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -184,7 +184,7 @@ do_transfer()
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	printf "%-16s" " max $max_time "
+	printf "%-10s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
 		echo "[ OK ]"
@@ -249,7 +249,7 @@ run_test()
 	fi
 
 	msg+=" - reverse direction"
-	printf "%-60s" "${msg}"
+	printf "%-60s" "$(echo -n ${msg} | cut -c1-54)"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-- 
2.40.1

