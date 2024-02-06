Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A47F461
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198225; cv=none; b=KcN6/Y0XcRH6qufbby5foTFB8NwHGBEK7LZsVWkueenVUlw9mg4J1EMBQxb8aMQDHDtCcC+i1x1049TBvN9lPhA2+U4jUNeyjj8o/wdr62AJjhN9WRkDacRrTua5U8wZvRtS2axSp6L/Jj4HVqW7UhXjEUsRwE/DFyTiaNA5rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198225; c=relaxed/simple;
	bh=Iii7CiLpB4vG4/e3u8aYvygKsgzzbdorjUZUDyyky5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiCm5IwxoL0VBSrg5qvEcA3mdE80DyYs3z2cfuRHCaWOBxddiJzfnCxuOwxyz5IUI6SHaS6MGTAkgjcjNhRWzlSYeg8iW/vKhYlN5uewyUEwGnx6WiI4UMdWi3HIcg6IFSKLHPcaxmH44QH/ZuHrCmgV5/jcHXMcFI9iP+jmMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDKh8QhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDKh8QhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F10C43394;
	Tue,  6 Feb 2024 05:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707198225;
	bh=Iii7CiLpB4vG4/e3u8aYvygKsgzzbdorjUZUDyyky5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDKh8QhMc2VJ+4jWK5B7Nlh2VraWw98YkMt4Q03eSLj+vbvUNWRgT1XCrHOBhO6L9
	 Uk5p/SwmtZJpnMhm4+g/0wRSjK+nYs81Fi0tzqcGzN9a2Fku5Uf4A9T+TeJQLMvNib
	 g8lDEuze27KAKmV5ZW9T3+YOo1F//zYR++6HWOYeHpyX2cuOXYNNWTrMgyJu7Cojx8
	 VPp7SijFt3dNJ7C2kzEgiKiHFDQvZk10YEZ9nFPgG5siRkA3+fKZycvE3w7glaCU6b
	 1eL052QM6GgAXJ3E5AO8ra3bhq75q8+pezqVqWhm0XsxWTpnj0SuniPoh6K4mWhXHy
	 zBttkYLgRxiTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Tue,  6 Feb 2024 13:43:35 +0800
Message-Id: <683704e855c0b54d003d6d635d0850aab0b71525.1707198093.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707198093.git.tanggeliang@kylinos.cn>
References: <cover.1707198093.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now both a v4 address and a v4-mapped address are supported when
destroying a userspace pm subflow, this patch adds a second subflow
to "userspace pm add & remove address" test, and two subflows could
be removed two different ways, one with the v4mapped and one with v4.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  6 ++++
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..0aa6c5b3aec0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3333,16 +3333,17 @@ userspace_pm_rm_sf()
 {
 	local evts=$evts_ns1
 	local t=${3:-1}
-	local ip=4
+	local ip
 	local tk da dp sp
 	local cnt
 
 	[ "$1" == "$ns2" ] && evts=$evts_ns2
-	if mptcp_lib_is_v6 $2; then ip=6; fi
+	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
+	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
 	tk=$(mptcp_lib_evts_get_info token "$evts")
-	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
-	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
-	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+	da=$(mptcp_lib_evts_get_info_with_addr "daddr$ip" "$evts" $t $2)
+	dp=$(mptcp_lib_evts_get_info_with_addr dport "$evts" $t $2)
+	sp=$(mptcp_lib_evts_get_info_with_addr sport "$evts" $t $2)
 
 	cnt=$(rm_sf_count ${1})
 	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
@@ -3429,20 +3430,23 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns2 2 2
 		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-		chk_mptcp_info subflows 1 subflows 1
-		chk_subflows_total 2 2
-		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_add_addr $ns1 10.0.3.1 20
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		chk_subflows_total 3 3
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
-		chk_rm_nr 1 1 invert
+		userspace_pm_rm_addr $ns1 20
+		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3a2abae5993e..29c92e127905 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -218,6 +218,12 @@ mptcp_lib_evts_get_info() {
 	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
 }
 
+# $1: info name ; $2: evts_ns ; $3: event type; $4: addr
+mptcp_lib_evts_get_info_with_addr() {
+	cat "${2}" | grep "${4}" |
+	mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
+}
+
 # $1: PID
 mptcp_lib_kill_wait() {
 	[ "${1}" -eq 0 ] && return 0
-- 
2.40.1

