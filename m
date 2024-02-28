Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3A24B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106242; cv=none; b=ot9sCcElhlZzlHjLpxlDg6IAifFX2ZzsSXYn2Gh3Re8CHyjQ5T4BMRpk5WL3qSubHyhldQDJNuLq2fuDsqL5eC2G6S7AIlXVHVVEptSUt0FiQHlYExBvt7h95l65hA/3Lqa/SvkRkgthPWbtEn4KPUHmqgO2qLkwvTC6zEVeX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106242; c=relaxed/simple;
	bh=b5jCspjERldTCq7YMxgEfz+DX416x+Zk3gB9G/vc18Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bv4yfpqbH04A2ybS8W3lqBV4CfZYj42C1Tv58T8BFJU3tw5RT1mybV2bQJQAf2u3o1a4rFxOyNJCvNKeYRRuzhWzUJi0ZE6M2oNUhjC1RDzZY7jpHdiduBF498gu+gHsUvt31qehAarZArASEDT6HaKL5fxyOtwdLRpt1tUQESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfboXAhl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfboXAhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92465C433C7;
	Wed, 28 Feb 2024 07:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106241;
	bh=b5jCspjERldTCq7YMxgEfz+DX416x+Zk3gB9G/vc18Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfboXAhlDC0Vu/WZEOGANWtAghxwespFvT4pe771HkcRVzrEOaG+crH8Vufwt34Yi
	 Vh7VXYF7qucuQYwX3XvYncFc0UdhPtQ55KJHuaIAeMhTsFc5S30KrQKh39QhMWznY7
	 VMMMEct4oGTyoCDEZHAz498nP9jYTeoTTe+e9z8sWyqirW6wGUrYpw1KAhd8UACjln
	 262Hd60nFDlySuzR4tHvTtMjItbrfgSW8sXBWIqntEhrrLQuUcb6CjNatinK3kxyJJ
	 WeUz0W9fsH2+KXjiutbeBdTFBr5VaF+RMIqCAh93EzpmxxQEh3eqGKWfcpV2oWEcu2
	 wXT/JMwCkmHvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 4/9] selftests: mptcp: simult_flows: fix misaligned output
Date: Wed, 28 Feb 2024 15:43:42 +0800
Message-Id: <0d087d6856e7919af1f3303669468bd8bcc45778.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
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
and truncate them within 75 chars per line.

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

Notes:
    add print_title helper

 tools/testing/selftests/net/mptcp/simult_flows.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index af6d9a81c317..4aa0f95ae11f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -184,7 +184,7 @@ do_transfer()
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	printf "%-16s" " max $max_time "
+	printf "%-10s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
 		mptcp_lib_pr_ok
@@ -205,6 +205,11 @@ do_transfer()
 	return 1
 }
 
+print_title()
+{
+	printf "%-55s" "${@}"
+}
+
 run_test()
 {
 	local rate1=$1
@@ -239,7 +244,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	print_title "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -248,8 +253,8 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	msg+=" - reverse direction"
-	printf "%-60s" "${msg}"
+	msg=$(echo -n "${msg} - reverse direction" | cut -c1-54)
+	print_title "${msg}"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-- 
2.40.1

