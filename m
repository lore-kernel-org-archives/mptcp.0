Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D674D2FE
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270989; cv=none; b=aH/26e/VT7eiiRXK1b1wqMhvvsN3K3E1wJoJ89F3oTWN6J+i2CzbXo5wz8DA0+8gthJzE1ayFkCX46Ms0tChj7ytNwcBQlFsabmIY50TMA4refI7LTbUsiGO6H9ccfoX5bYvVdQQAFZ5MkM+ldFsAJHZl6Ws++Frs7hZy18FSWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270989; c=relaxed/simple;
	bh=Z+Vtn8CNUb9VKj0QkqWbEeIE8gQVooWN6EUA96xWkv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7xa0NOrxYmi7QgJKFTasZocZvshEKF3j9ciVmb5Bn+pALOG23c7a1UcV4OxombfKtPAk39TMAFLzkAOYJu+H17aURtvszrTe6eAOcW2UdQdkVOPZFGmSGvPdaIAJwBtxgLdGXF1slwLiM/XtL2cAOiTV27h3vbJELBWhh5xdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQtPL9mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQtPL9mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45906C43390;
	Wed,  7 Feb 2024 01:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707270989;
	bh=Z+Vtn8CNUb9VKj0QkqWbEeIE8gQVooWN6EUA96xWkv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQtPL9mkGey2PIoSOtVbErIf+CB0ZlfwBErCIjzIZti2GnCSXdwFgPWAPIZqQhIXk
	 eczfxcTF7SnP8maJlEdyoEH1EsGoGrk1kF6JvbCxxlTBd/wbW7e+J3MTLYm7nBTLbW
	 x8ctmth1hVkTwIkygfqBIGjbeoawFyn/g5UmPwj6OAr3qiOpcCjbh338cnVkRq3QVS
	 W95QRb4ZLZUyP2gsVILTTWEVh9jWhF3CnHx8imkaI6K/AcQ5oRu+2ZH+OXarJKxygY
	 6OPvAoLTis17Z1KrGV3OgXqeVRX6VefF12P/YEagYy39Q2UgptDA2SAlGBBNsQ83LE
	 um4FssDvQys0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] selftests: mptcp: rm subflow with v4/v4mapped addr
Date: Wed,  7 Feb 2024 09:55:14 +0800
Message-Id: <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707270765.git.tanggeliang@kylinos.cn>
References: <cover.1707270765.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  7 +++--
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c07386e21e0a..e68b1bc2c2e4 100755
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
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t $2)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t $2)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t $2)
 
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
index 3a2abae5993e..69001d2a8dab 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -213,9 +213,12 @@ mptcp_lib_get_info_value() {
 	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
 }
 
-# $1: info name ; $2: evts_ns ; $3: event type
+# $1: info name ; $2: evts_ns ; $3: event type; $4: addr
 mptcp_lib_evts_get_info() {
-	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
+	local addr=${4:-""}
+
+	cat "${2}" | grep "${addr}" |
+	mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
 # $1: PID
-- 
2.40.1

