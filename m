Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147C50A80
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832593; cv=none; b=o35UbGwzsY2+t0/3NmTIfpZFj88oqtszc3G7awbG/yz+K+TgWNutZ/zsli3L8YKvaxyeDXxH9npXJHwVHHXzvZCwtWR5PajTh8Pm3bEzTAKO5nlB9TpaCZMM4ZlWWbr30P1ThHU8Y7X7vnaH1Hkgp10rFkztLer5Up3zSY1ZAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832593; c=relaxed/simple;
	bh=M0eOZBMS7Gvpzmk0H0G0/i3T5y/jprYJ9l/sDKbLJNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8f/rYyjMZ1NXHSP2Cz5dz63afSUEl/hoiEBAJdlRgM2/Lf1Onuyr5/L4xha8MZ6taBu8MqlpDV0ec8LQM1o3TaLvTF1qXy+clQbfPw8r0tZLxym7wQ8Eshy11AfeZAsjzTIYbAOvSO5RHOyrqRl4kSsstWKpjuKRJ28Wwwy6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhxrMTgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhxrMTgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F77BC43394;
	Tue, 19 Mar 2024 07:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832592;
	bh=M0eOZBMS7Gvpzmk0H0G0/i3T5y/jprYJ9l/sDKbLJNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhxrMTgvHeI2LduaFw1hjJA4WbnAt2x13qb8yPjNkTWcg//duHv6x3cyqNyIbfaIc
	 P0t9mNRF2VjhpCPC7rNIbIUgxM0md4T7N7cWZyolfNaRV/gVTwv5xzSS9shVsNtPxP
	 zL+qmf/4vJl96P/UFdGtIWxEAJ/hJX+Ai++Jx4pB7ImVVRPpPrVPrh5hxwfrrRVogv
	 TnJDteZFTsEuuKbqI0LwNMkKlBAH6jtY6mddGSqYR1bNh+GW53AbTD/uTM54RZLbop
	 iFpCMimZu/Vp5o6IbOVYFsBNdyD24NJAhTa/eimFGzwwOPRuupnlYBH4tOBCQJW9kc
	 9CVIep+uIBwvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/9] selftests: mptcp: export pm_nl endpoint ops
Date: Tue, 19 Mar 2024 15:16:12 +0800
Message-Id: <3d0c9b0bdb6be6d70befeeee1667b40e03f99400.1710832493.git.tanggeliang@kylinos.cn>
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

This patch exports six endpoint operation helpers with pm_nl_ prefix,
pm_nl_set_limits(), pm_nl_add_endpoint(), pm_nl_del_endpoint(),
pm_nl_flush_endpoint(), pm_nl_show_endpoints() and pm_nl_change_endpoint()
into mptcp_lib.sh as public functions, and renamed each of them with a
mptcp_lib_ prefix. Then these old pm_nl_ prefix helpers in mptcp_join.sh
can be wrappers of mptcp_lib_ prefix ones.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 ++--------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 85 +++++++++++++++++++
 2 files changed, 91 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8862b6a5caa0..fefa9173bdaa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -605,92 +605,32 @@ kill_events_pids()
 
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
 {
-	local ns=$1
-	local addr=$2
-	local flags dev id port
-	local nr=2
-
-	local p
-	for p in "${@}"
-	do
-		case "${p}" in
-		"flags" | "dev" | "id" | "port")
-			eval "${p}"=\$"${nr}"
-			;;
-		esac
-
-		nr=$((nr + 1))
-	done
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n "${ns}" mptcp endpoint add "${addr}" ${flags//","/" "} \
-			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
-	else
-		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags:+flags "${flags}"} \
-			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
-	fi
+	mptcp_lib_pm_nl_add_endpoint "${@}"
 }
 
 pm_nl_del_endpoint()
 {
-	local ns=$1
-	local id=$2
-	local addr=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		[ $id -ne 0 ] && addr=''
-		ip -n $ns mptcp endpoint delete id $id ${addr:+"${addr}"}
-	else
-		ip netns exec $ns ./pm_nl_ctl del $id $addr
-	fi
+	mptcp_lib_pm_nl_del_endpoint "${@}"
 }
 
 pm_nl_flush_endpoint()
 {
-	local ns=$1
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint flush
-	else
-		ip netns exec $ns ./pm_nl_ctl flush
-	fi
+	mptcp_lib_pm_nl_flush_endpoint "${@}"
 }
 
 pm_nl_show_endpoints()
 {
-	local ns=$1
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint show
-	else
-		ip netns exec $ns ./pm_nl_ctl dump
-	fi
+	mptcp_lib_pm_nl_show_endpoints "${@}"
 }
 
 pm_nl_change_endpoint()
 {
-	local ns=$1
-	local id=$2
-	local flags=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
-	else
-		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
-	fi
+	mptcp_lib_pm_nl_change_endpoint "${@}"
 }
 
 pm_nl_check_endpoint()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ceb8f272c69d..834efb806b2e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -554,3 +554,88 @@ mptcp_lib_pm_nl_get_endpoint() {
 		ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
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
+
+mptcp_lib_pm_nl_add_endpoint() {
+	local ns=${1}
+	local addr=${2}
+	local flags dev id port
+	local nr=2
+
+	local p
+	for p in "${@}"; do
+		case "${p}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${p}"=\$"${nr}"
+			;;
+		esac
+
+		nr=$((nr + 1))
+	done
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086 # blanks in flags, no double quote
+		ip -n "${ns}" mptcp endpoint add "${addr}" ${flags//","/" "} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags:+flags "${flags}"} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
+	fi
+}
+
+mptcp_lib_pm_nl_del_endpoint() {
+	local ns=${1}
+	local id=${2}
+	local addr=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		[ "${id}" -ne 0 ] && addr=''
+		ip -n "${ns}" mptcp endpoint delete id "${id}" ${addr:+"${addr}"}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl del "${id}" "${addr}"
+	fi
+}
+
+mptcp_lib_pm_nl_flush_endpoint() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint flush
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl flush
+	fi
+}
+
+mptcp_lib_pm_nl_show_endpoints() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint show
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl dump
+	fi
+}
+
+mptcp_lib_pm_nl_change_endpoint() {
+	local ns=${1}
+	local id=${2}
+	local flags=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086 # blanks in flags, no double quote
+		ip -n "${ns}" mptcp endpoint change id "${id}" ${flags//","/" "}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl set id "${id}" flags "${flags}"
+	fi
+}
-- 
2.40.1

