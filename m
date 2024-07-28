Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895863B9
	for <mptcp@lists.linux.dev>; Sun, 28 Jul 2024 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722138594; cv=none; b=vGtzgiS1RUf8yyXTVRXK/01/KGNW+Mv7d1MbNiolyU70tT8tPd800LwrqjJQw+/cjk+O8hmg6/TYi+RV3JDD5NRvbKzFEeDKflVmSba+o6DhNP2Wrpd5O7XYeBaXWELjTdfRForPfj8yLmEnrLHUzFaqusNRKGPqb4RraSZahWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722138594; c=relaxed/simple;
	bh=o4+5mqMnMN+RhlAV+gZZX/4s4mmVS3Fd4LXdymi+Hp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUHZFh9EqCRXN2vVQH+IMlpE1FXT1GT1hxB7/Vae7/GzODBBD/UIf1cSz+aHP90Lf+TyC42o1HwUjapNDAEJAUT7bMYOqaU9U5/mDbWPqq8QCNEdpJJxBv/uf+Hrt26zqfvywnk42RSw9hos1z7chrKcKTKqKTm61mNmNmKoz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGqZY5cB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGqZY5cB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8942C32782;
	Sun, 28 Jul 2024 03:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722138594;
	bh=o4+5mqMnMN+RhlAV+gZZX/4s4mmVS3Fd4LXdymi+Hp8=;
	h=From:To:Cc:Subject:Date:From;
	b=CGqZY5cB08ATlrspzbex7wshNHpi/sP7Tou2GJn7gdffVvdVWUP2iumbT/0p23nAx
	 xsYO0pVCwF2gfnuA2dAVUMBi9qWKUG6zf+JunAt9VJsbLzSQ6wr9WLwFCxmSSzdI4O
	 4Eh/HPPY1MsMgmgX0f/ElrOzuW6iH2IwgcDf81/H5kTFLu4WdCT1clG+1mQvPtuGPF
	 xmeIKs1nd6/g6qhhvUFR6gXUMAgZJbc0w56T2qcsKwCmjR2s9xmiAcbVAOKT58Ov5D
	 1qEkVGuc98M6KqbhopvxFPhfQAA+X4Nd4ObOHGWhYqHcSxas2XToAFpC8UNEIvHpvk
	 ehmXAzRNjapfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND PATCH mptcp-next] selftests: mptcp: join: simplify checksum_tests
Date: Sun, 28 Jul 2024 11:49:34 +0800
Message-ID: <b61be1bd6c70121fee3c6e183fb224b41d9dac90.1722138514.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The four checksum tests are similar, only one line is different. So
a for-loop can be used to simplify these tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
RESEND:
 - update the email address.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++--------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4df48f1f14ab..63b29504e547 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -337,7 +337,7 @@ reset_with_checksum()
 	local ns1_enable=$1
 	local ns2_enable=$2
 
-	reset "checksum test ${1} ${2}" || return 1
+	reset "checksum test ${ns1_enable} ${ns2_enable}" || return 1
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
@@ -2912,37 +2912,16 @@ syncookies_tests()
 
 checksum_tests()
 {
-	# checksum test 0 0
-	if reset_with_checksum 0 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 1 1
-	if reset_with_checksum 1 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 0 1
-	if reset_with_checksum 0 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 1 0
-	if reset_with_checksum 1 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
+	local checksum_enable
+	for checksum_enable in "0 0" "1 1" "0 1" "1 0"; do
+		# checksum test 0 0, 1 1, 0 1, 1 0
+		if reset_with_checksum ${checksum_enable}; then
+			pm_nl_set_limits $ns1 0 1
+			pm_nl_set_limits $ns2 0 1
+			run_tests $ns1 $ns2 10.0.1.1
+			chk_join_nr 0 0 0
+		fi
+	done
 }
 
 deny_join_id0_tests()
-- 
2.43.0

