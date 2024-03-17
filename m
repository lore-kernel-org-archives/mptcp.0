Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B315139E
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637143; cv=none; b=EnN2bsx+hOhVbdjfhAj5ovSWG47Z8T6mL4tdavQWBb4PuVMhn6rrK0JMyZNt5rtupBb8bBwr8fn2G5PU9pg9UqpJMKs7HvuAhhM6rrdzJow8a5NoGVmgiR7LRILTHq3xujm+AO/RQyn/+QokzCyLkkTJANGdi0mfn36dXxv2zrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637143; c=relaxed/simple;
	bh=iFgnp1jPmeKG7D76JnoezOzO5R+1YMfbNNbMwDEJWrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5GT65B2p7YdL7a/oJ+QCyguUA7ZpcDMCJoJom0+MJHZmNda8Qe22DpdeKh0X9waBditlnD7CnRGho8uGIwA5qx+vpDatXgfmhpYPXt/gisvUdh5H4XDIqdYdFcp+KCVcnM7Hh0HTW+OJFdJGb0NFL3IJRgXDZC+QUBYC1hYZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvkKgViT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvkKgViT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD64C433F1;
	Sun, 17 Mar 2024 00:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637143;
	bh=iFgnp1jPmeKG7D76JnoezOzO5R+1YMfbNNbMwDEJWrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvkKgViTLEnQ4OS2VP9+e/5HZ4sXpOo5QD6cTUWwBv4J+x+MZIqOigPWkeYEClIlR
	 YddKCs+npdpS2iNDQQi0sI94MJuRtWI5oa6j3OtnHaYoI1+FEU1Hoy00h61W9nVFKm
	 reHGarBrYopU00+gFJy31SBoLKJ7Gk6XErQL9WjMMhqZRY9G/lUwdXChpFh3C+L+x4
	 cOzSXCw4ZecRjBIaxRB8RfXxZrXOF9FN6aeMIpWw1fPWI0QcQ7BoI02MOsUlyxeuBX
	 9n1zhq//9tFnNV8/7Dd4jL6sFPynQR0FAgfVvSX+oAJRABKmOb4OJejqUt20+HzQJg
	 tJQyLgOSYW2ug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 05/12] selftests: mptcp: export set_limits helper
Date: Sun, 17 Mar 2024 08:58:04 +0800
Message-Id: <766f66639975d46d12acc30bd672c8b34df3529b.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports pm_nl_set_limits() helper into mptcp_lib.sh as a
public function named mptcp_lib_pm_nl_set_limits(). Then pm_nl_set_limits()
in mptcp_join.sh can be a wrapper of the public one.

Use this newly added helper to replace all 'pm_nl_ctl limits' commands in
scripts mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 10 +---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 12 ++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  4 ++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  6 +++---
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  4 ++--
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 62fcfeaa3430..0bdb631a9ddc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -605,15 +605,7 @@ kill_events_pids()
 
 pm_nl_set_limits()
 {
-	local ns=$1
-	local addrs=$2
-	local subflows=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
-	else
-		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
-	fi
+	mptcp_lib_pm_nl_set_limits "${@}"
 }
 
 pm_nl_add_endpoint()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 813d6406ccc3..d16b82f7e35a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -542,3 +542,15 @@ mptcp_lib_pm_nl_get_limits() {
 		ip netns exec "${ns}" ./pm_nl_ctl limits
 	fi
 }
+
+mptcp_lib_pm_nl_set_limits() {
+	local ns=${1}
+	local addrs=${2}
+	local subflows=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp limits set add_addr_accepted "${addrs}" subflows "${subflows}"
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" "${subflows}"
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e2d70c18786e..6f39a5d6d02e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -65,8 +65,8 @@ init()
 		ip netns exec $ns2 ./pm_nl_ctl add dead:beef:$i::2 flags signal
 	done
 
-	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
 
 	add_mark_rules $ns1 1
 	add_mark_rules $ns2 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 87ea4973235d..d369096d0df8 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -119,13 +119,13 @@ id 8 flags signal 10.0.1.8" "id limit"
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
+mptcp_lib_pm_nl_set_limits "${ns1}" 9 1 2>/dev/null
 check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "rcv addrs above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
+mptcp_lib_pm_nl_set_limits "${ns1}" 1 9 2>/dev/null
 check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "subflows above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
 check "mptcp_lib_pm_nl_get_limits ${ns1}" \
 	"$(mptcp_lib_format_limits 8 8)" "set limits"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e129fcb5a598..b8414cff9b4b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -85,7 +85,7 @@ setup()
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
-	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
+	mptcp_lib_pm_nl_set_limits "${ns1}" 1 1
 	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
@@ -108,7 +108,7 @@ setup()
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 
-	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+	mptcp_lib_pm_nl_set_limits "${ns3}" 1 1
 
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure
-- 
2.40.1

