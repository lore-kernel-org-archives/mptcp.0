Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF846BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561090; cv=none; b=tKfQ0rPuAz7jOE9mWbntO87Jy6u8hQAvu8zEo9+PvQFDcV5GFofXS3TvisLYZQ8oGG3vO+veXHKQNjXr0SasZmnuh44LgV8WyrMUq/fssGDZ/cVeXh2aieJCm5wCLjOG2bP6ID8XI60r/zt8/j/rcYp0/+/FWS/GaE+T/OrbNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561090; c=relaxed/simple;
	bh=6SxXdW9dyJXWzKCnAtoTrf+xjr+T19T+dhVQpIuBHHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByKbUdT+vlMIHo8/3/t2NN3C9y1M6EXmiizVG0tmR4n1ZP2Qnr1pEEIWDb4e4yUOeoDU7PT9ucGf+s+jgz/+mzvP4MHcAYw/0vLKc+bZEv70Uj/qjYV76LxR9KKn/dqcssl0jbNXCi+vPaSWYlXCkhQ5qkhK0WzsDSzCgo4cM5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu7uHUrH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu7uHUrH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A501AC433C7;
	Sat, 16 Mar 2024 03:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561089;
	bh=6SxXdW9dyJXWzKCnAtoTrf+xjr+T19T+dhVQpIuBHHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vu7uHUrHRaxumt+RbFk5hnRgyuKC5ANy/NIBIoMyk+78uROfPNJ6mYE4XlI2p/Sx+
	 JoqC3SVaGq4B1HQgRn/wj3VsQorOC1DQxXcmw6XghbG47Jj3TDXigoA27NTGNv1/uL
	 Jf1GowPFBurD2V4zeVePjO2bTnCf7wPQGDAp/qo3eI/WXMydgymNkGqujc/N3jPsGG
	 rRjkFfsMg2QHur9VzA1QdDeSFKmrvcsp7sm2V6dPGNKG2mtEPvUEYyRZC8Tw/YH6qe
	 XmXtmp/MTxFby6284YzFTQN4EZFkCL6DX+Lu/8pcPcSXPE3E8rld3loRxM3kEbdYV8
	 lqk+XUM95Bcng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/9] selftests: mptcp: add get_limits helper
Date: Sat, 16 Mar 2024 11:50:31 +0800
Message-Id: <3a8c9fa68a0d34ae3f3d685993876cd6bec23ace.1710560839.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710560839.git.tanggeliang@kylinos.cn>
References: <cover.1710560839.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like set_limits() helper, this patch adds another one get_limits() to
show the limits.

Usage:
	Set limits - set_limits $ns $addrs $subflows
	Get limits - get_limits $ns

Use this new helper in pm_netlink.sh to replace all 'pm_nl_ctl limits'
commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 10 ++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 +++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index affb2f4675c1..00d6cb287c04 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -555,3 +555,13 @@ mptcp_lib_format_endpoints() {
 		fi
 	done
 }
+
+mptcp_lib_pm_nl_get_limits() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp limits
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl limits
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index b5b7e846892c..9430e91e48ed 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -69,9 +69,9 @@ check()
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
-default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+default_limits="$(mptcp_lib_pm_nl_get_limits "${ns1}")"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+	check "mptcp_lib_pm_nl_get_limits ${ns1}" \
 		"$(mptcp_lib_format_limits 0 2)" "defaults limits"
 fi
 
@@ -127,13 +127,13 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
+check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
+check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" \
+check "mptcp_lib_pm_nl_get_limits ${ns1}" \
 	"$(mptcp_lib_format_limits 8 8)" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
-- 
2.40.1

