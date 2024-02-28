Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E324B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106247; cv=none; b=iGQPJkKoxcKSLT1OI6htlLsLcK/5n6geeMrmmlI1MuGx+5erVd9bKzhhouFdEp0tbEL9UcENLQFeqFzNpw89yALQuA61YaMTAMS1DkjNtmjgcqACIKcSoTVF1cpbNdualxpfCFbX+RYhA+GcChkJhpiUAv5FKb3Um7xkityWKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106247; c=relaxed/simple;
	bh=6T1wCvCn9OjC3QkdC8u3/O+aJElgh/cvdAYsAeFcrFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQMW9W6X88Jj+optPE++4hlRSt62ftdfUvNYrnM/+8uzj44aw5y8FE0OU3s+8TqNAnmYEVivZGe2DiOtlCoCGzTKwBrbJ1zjPWATdBLuWbw4uxyhalnmSytrZuH/F7MZFr9MeCaEI1lKs1QRwOjSXyQfazJqKHj0xmWqHdHjQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prqbAMGH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prqbAMGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D9AC43390;
	Wed, 28 Feb 2024 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106247;
	bh=6T1wCvCn9OjC3QkdC8u3/O+aJElgh/cvdAYsAeFcrFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=prqbAMGHVyjyiT8oEX+2ptv2HdFnibencP1nf21A1cPHRGTeNs+jcT7bslc3hjvmY
	 EMOvhAtjp400JsKgneMCILeMvbOjBgsTwg5qF5PdXo2SLx4blG7FC9DO7C4TG9k8QP
	 i0UGwATVfDhyYXl9aC4gPGFQBvSS/wUZ0t1PYv2iLd3iEQCimtEpZcsPvB7g2WqTiB
	 nz9HAQ3iLkfeNxJHWFIAf1iPnC/or+JYXTZS+EUaDEK1QXorPciAKw3h3oPJuwXEzU
	 dOU/bcE8a9ZMO3SYX4GnHMzMuWHqnGSXTsgilIomq0NPdjE1skz+CeqW+cDetbijpM
	 ZPguRKXX7RfEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 7/9] selftests: mptcp: add more print_title helpers
Date: Wed, 28 Feb 2024 15:43:45 +0800
Message-Id: <6c61dfba93c4cb7d10e9d2a6258d256257e45abd.1709105922.git.tanggeliang@kylinos.cn>
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

This patch adds print_title() helper for diag.sh and pm_netlink.sh to make
it easy to change the output information. Only print_title() helper needs
to be updated in that cases.

It's useful for the coming commit "selftests: mptcp: print test results
with counters".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh       | 9 +++++++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7830bc043d52..dd9c5bf7a415 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -45,6 +45,11 @@ get_msk_inuse()
 	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
+print_title()
+{
+	printf "%-50s" "${@}"
+}
+
 __chk_nr()
 {
 	local command="$1"
@@ -55,7 +60,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	print_title "$msg"
 	if [ "$nr" != "$expected" ]; then
 		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			mptcp_lib_pr_skip "Feature probably not supported"
@@ -114,7 +119,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	print_title "$msg"
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_pr_fail "timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ffa79df99d38..e6b8e3db7788 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -46,6 +46,11 @@ trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
 
+print_title()
+{
+	printf "%-50s" "${@}"
+}
+
 check()
 {
 	local cmd="$1"
@@ -53,7 +58,7 @@ check()
 	local msg="$3"
 	local rc=0
 
-	printf "%-50s" "$msg"
+	print_title "$msg"
 	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
 	if [ ${rc} -eq 2 ]; then
 		mptcp_lib_result_fail "${msg} # error ${rc}"
@@ -189,7 +194,7 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-		printf "%-50s" "${st}"
+		print_title "${st}"
 		mptcp_lib_pr_skip
 		mptcp_lib_result_skip "${st}"
 	done
-- 
2.40.1

