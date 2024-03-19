Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935F50A73
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832585; cv=none; b=UCQOO+h5Tih2lmP2NzzvR+Wzuzc6rJuK0o+khkPCzdBE2LNm18gl6/geURfwHqwIc2cYITniZtNopBCzra4ZLGQlZKN3NWCL/ZTCdnuqhRfNnRkPOPkO6+kq4psrJpMXFaaUmae1MnFaXqDL8pgtLhVhov2M8wgWKOf87C+iMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832585; c=relaxed/simple;
	bh=TmJZ0BziRjAjcrSW5Eib5CHbV5r0FUMmSUfXiQhta2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG28VrrbXTpV74iQ339/FK8SnoYFTA0JW9av+iVqQTIVTxDQW3wQMX0Fh2Du5nmmiShOYM269e8KTHmiB5auAtKgu4OKKVlIGhTYFsWbwN56mp2EuD6oE86VVAhV3fJJuFhI/wUL8YjLh/xqQM+4ZkbA5R9qeZTH0Qn4XnFt+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnpGwxaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnpGwxaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04EFC433F1;
	Tue, 19 Mar 2024 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832585;
	bh=TmJZ0BziRjAjcrSW5Eib5CHbV5r0FUMmSUfXiQhta2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnpGwxaFNUX2ZeZFpkTUvBju+2MTikUXK2u44+KLunnqGdN+vS35ET0iWekghaIsz
	 JkLnOXnrKSyemVPMhx44h9mnE8HZSbExtdKqBPKZfDEj85/Vi/j8XD9u+Rr+dR8so0
	 fEbVFe9zRzoKkcXLFX7DFCCh9y1tfHrnzVwzDKV1LILtSm4WuRHjZ+PXMrS5w56Xau
	 5R8vFxd0SoSe+7suv4OI5Gtz7ZhbvmPxss6IjtAkpiRakenPRTHKo4LMSb2RmXyBOs
	 cJ4Pmng7dZ5nHsPgPzhPWrTmVDmwxQ6ou9ZfIORqoaVfYNU0k3awT4tnkwmrc+uags
	 kLiD22/oIQIeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/9] selftests: mptcp: add get_limits helper
Date: Tue, 19 Mar 2024 15:16:08 +0800
Message-Id: <a624240c38553bfe25a88226a13e71e6642ac76e.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The output format of 'ip mptcp limits' command is much different from
that of 'pm_nl_ctl limits' command. This patch adds format_limits()
helper to format the outputs of these two commands to hide the
difference.

Just like set_limits() helper, add another one get_limits() to show the
limits.

Use these two helpers in pm_netlink.sh to replace all 'pm_nl_ctl limits'
commands and outputs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 6ab8c5d36340..d672d1e5d470 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -46,6 +46,26 @@ trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
 
+format_limits() {
+	local accept="${1}"
+	local subflows="${2}"
+
+	if mptcp_lib_is_ip_mptcp; then
+		# with a space at the end
+		printf "add_addr_accepted %d subflows %d \n" "${accept}" "${subflows}"
+	else
+		printf "accept %d\nsubflows %d\n" "${accept}" "${subflows}"
+	fi
+}
+
+get_limits() {
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns1}" mptcp limits
+	else
+		ip netns exec "${ns1}" ./pm_nl_ctl limits
+	fi
+}
+
 check()
 {
 	local cmd="$1"
@@ -69,10 +89,9 @@ check()
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
-default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+default_limits="$(get_limits)"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+	check "get_limits" "$(format_limits 0 2)" "defaults limits"
 fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
@@ -120,14 +139,13 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
+check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
+check "get_limits" "${default_limits}" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
+check "get_limits" "$(format_limits 8 8)" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-- 
2.40.1

