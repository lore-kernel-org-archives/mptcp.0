Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040B2570
	for <mptcp@lists.linux.dev>; Sun, 28 Jul 2024 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722138374; cv=none; b=P0A3YEP6+NxrKoONh+MH2Mk1BFRYIbWx13S0eEwgJpINSrvuuhKPldUdh+JQabG2ZZo7QQiVmpJzWbflXvsLDsr1ocGodGc2H32aFvKqni3kcsGIfRXTEmzMtYIrLQQv8ib0BP0QhyY8iYy50+c+9xWKWhKE5JEYcYh3FTMiEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722138374; c=relaxed/simple;
	bh=vywci4LciWllSQMvrFuBmMnRdAMOutIeFuxMdqyeM8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cM67POzVmOdgbahRRCXi9BSBaS+CKvBsN/1UzyMc5R6y1jPTNaI6fqwa1YKjx64K/ANDrFN0LDbm7VtdbeDjQFFCmNtctsZCXFe3s8lQydT2hOuuETt2/8cobRDKU5BOjwfw/M2CSBrdavA9s0Jl8nJXhlSQw4RLTKudgl/EVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krjdQbLN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krjdQbLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11158C116B1;
	Sun, 28 Jul 2024 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722138374;
	bh=vywci4LciWllSQMvrFuBmMnRdAMOutIeFuxMdqyeM8c=;
	h=From:To:Cc:Subject:Date:From;
	b=krjdQbLNqReQ7zI+8z5Ij6W0422Z1MhAlfN9IPzkaEE3oBmhYgh15i3dEoAK614DB
	 FZo7cZPfLnZLWl7UUZ9rpntwS3pVefo5Ff64gZ2R2BjbJ8lLDQkXWuu10/hkfUy1hO
	 hyw77dEBBxZxkQIushFyKpWhd/2kXvEBgBJxfLxW6t0Nn9QTiAJ9der4ARONLiJilG
	 JcBf26nJGwnOn1WxhAm+w7Zg3bI0M4fNQIRsJ3+USKNOaYdaUA1IpDSXsJZNxSnrG5
	 +Gc1j+GgPMkGAVjT+IFKL74+67aaWYsUsfpgcF5r+D9K9pUO7cMe7OfQ0lcl/pGRrc
	 LJObH3JWXV/2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: join: simplify checksum_tests
Date: Sun, 28 Jul 2024 11:46:08 +0800
Message-ID: <1a05890e3e65de00b45b2453232eed12fe55ad14.1722138313.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

The four checksum tests are similar, only one line is different. So
a for-loop can be used to simplify these tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
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

