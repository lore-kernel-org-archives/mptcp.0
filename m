Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90CC13D
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299592; cv=none; b=Ym92TC9JjkrdlLmg6/gT3RaezynrPLsqvqLRuXCd6HYnHSqFmpx9qAsgv1L7TpfYjaqYNoxtAYUx9v9lQwfJHRLWLF+EIKWb1xMDGz2lnhBb1dcc2yAgoZ0cvAa0lZRCATOd8TRSkTAVzfpAYC6FC1Y6EqgW95kHRHUDwB3rg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299592; c=relaxed/simple;
	bh=j9EXe1WutUxjz98ImRCc3F8ALyEz+psFS2lmjCxQcsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7x+xtFO8jzNprkLH6lA2RyVc5moeH2Wy9s7NCavXb+t5IOdiimm/hIY3iGwGhOSCm2SLFp/ucYtr3+Wtd+9fLzIqcGADPeBTAgio77vtJcBVMz9VsZapdJZCC1C5hXnUKRgZVCOiJVlEapaAq9WX2CsTC58DSOD0qxH+icrjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gegXZZBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gegXZZBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B08C43390;
	Wed, 13 Mar 2024 03:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710299592;
	bh=j9EXe1WutUxjz98ImRCc3F8ALyEz+psFS2lmjCxQcsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gegXZZBrMmTFlYrrqbQCi5g6QElUaR56HYRbGGzB1jeah8sg/FPPUH4zpUMONB8M/
	 04JJ6QFchUeGJtUTN7spdPfTxMNX/KYdZYJFYqFZmXpNDgpkba7qUtafAKeMlQUssD
	 DaHzWOB1/nYG/uvqJXYbs4xmjA/kXUt7UyOog45j8mamZWXquoXf2DzIFcGbwGwr/k
	 S7AfE0tWBtPrpn+zszYzRFCU05fJKmO/EQrJLm6tdsq8fuCqrCAfIEoSjMo+MJx1Kk
	 myWdCRRU7v10SNtCbyH1P369/7LboJJxQ87AemGehvpW/kleNHsccHWS7/9X4dDSkX
	 w41RumJ1g0KxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: add tc check for check_tools
Date: Wed, 13 Mar 2024 11:13:04 +0800
Message-Id: <b63ea360897ca7c51920529c7cf40f068a0a9f33.1710299501.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710299501.git.tanggeliang@kylinos.cn>
References: <cover.1710299501.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tc are used in some test scripts: mptcp_connect.sh, mptcp_join.sh and
simult_flows.sh. It makes sense to check if tc is installed before running
these scripts, just like other tools. So this patch add 'tc' check for
mptcp_lib_check_tools(), and check it in these test scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 6 ++++++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4c4248554826..90c1c5c9caca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -147,7 +147,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-mptcp_lib_check_tools ip
+mptcp_lib_check_tools ip tc
 
 sin=$(mktemp)
 sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5e9211e89825..8f95e730f4e1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -142,7 +142,7 @@ init() {
 
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
-	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
 
 	sin=$(mktemp)
 	sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d529b4b37af8..1fa05405f65e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -384,6 +384,12 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
+		"tc")
+			if ! tc -help &> /dev/null; then
+				mptcp_lib_pr_skip "Could not run test without tc tool"
+				exit ${KSFT_SKIP}
+			fi
+			;;
 		"ss")
 			if ! ss -h | grep -q MPTCP; then
 				mptcp_lib_pr_skip "ss tool does not support MPTCP"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 68ee92eccccb..72ea563c923c 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -45,7 +45,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-mptcp_lib_check_tools ip
+mptcp_lib_check_tools ip tc
 
 #  "$ns1"              ns2                    ns3
 #     ns1eth1    ns2eth1   ns2eth3      ns3eth1
-- 
2.40.1

