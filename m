Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABD10E3
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121746; cv=none; b=pKrFg2lLihGMFMY9U/yY5BmSVwDHqCHJ9dAHuRTu8QkQYwX+27koxhLxXYNGhk2LNkBUGG8l1wKkzWzwi7ws2NBXDXySAaUZxdgCYKIQ32lH3fZqvv405nGP692vitkt42w0w9TqDYZVVly6LAlXF/QnTelbd1XyrSsRLRY4d1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121746; c=relaxed/simple;
	bh=bwW8CgsMzTap7/Wu1tosIS9ne2+WovQH8EoaXbwrozo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAzkeemFeT4I1AQPoA8rGHTwmJp65i2sgJb0HKXMLgrJrGuY8iXsN6rKi3oFNjFDzt8XBwZQ/KhsCrSbYWZsyue5ejficqUFZOPJdnt3Z/jbFAdy3vAti5DlSApqN6goHIn/o/riHCHuzWVByB9R1waW+QH2Y3OqgtwjlAX/mOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHOyt5rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHOyt5rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF6C433C7;
	Mon, 11 Mar 2024 01:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121745;
	bh=bwW8CgsMzTap7/Wu1tosIS9ne2+WovQH8EoaXbwrozo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHOyt5rvE8C5PppDO/q1o48bEim8dIQUbk+NLNBc0cGndMalA/cCa9Xu06xRiWyxe
	 FezobKCeZD8PsNVgZWYGuCFqoQC+wz/ZmlkK9VwSum3I/F9MVSMOjrWencCJOV98uQ
	 zk6gPZo4kGd+tHKXvTIvotAKf78JYdkmSOomx+aW8QXwhi89fn4PkiEgmMPvVE/uMx
	 45gSKWkO6EE2JyMQVkuF8UvvBAjeH8UbYDsETzq/pwTkks6VGUIh9D1uqsfM4byVjH
	 kpNz54SGOyOHjcxkKhiP5I5BHYWzINQvd3QyoZatdP/8Fwo5lDYyzM9K44Rs2KdY9P
	 fOKFNsYWK2j+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 07/10] selftests: mptcp: add endpoint_ops API helper
Date: Mon, 11 Mar 2024 09:48:44 +0800
Message-Id: <d327fe8645094080a922dc5075a0d2b45166a5f8.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch moves six endpoint operation helpers with the pm_nl_ prefix:

	pm_nl_limits(),
	pm_nl_add_endpoint(),
	pm_nl_del_endpoint(),
	pm_nl_flush_endpoint(),
	pm_nl_show_endpoints() and
	pm_nl_change_endpoint()

from mptcp_join.sh into mptcp_lib.sh as public functions, and renamed each
of them with a mptcp_lib_ prefix.

Add a new helper mptcp_lib_endpoint_ops() in mptcp_lib.sh as the API for
all endpoint operation helpers, which invokes each of mptcp_lib_ prefix
helpers according to the first argument of it is "limits", "add", "del",
"flush", "show" or "change".

Usage:
        mptcp_lib_endpoint_ops limits $ns $addrs $subflows
        mptcp_lib_endpoint_ops add $ns $addr
        mptcp_lib_endpoint_ops del $ns $id $addr
        mptcp_lib_endpoint_ops flush $ns
        mptcp_lib_endpoint_ops show $ns
        mptcp_lib_endpoint_ops change $ns $id $flags

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 148 ++++++++++++++++++
 2 files changed, 155 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 431233e25abc..8e35f875147b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -603,132 +603,39 @@ kill_events_pids()
 	evts_ns2_pid=0
 }
 
-pm_nl_limits()
-{
-	local ns=$1
-	local addrs=$2
-	local subflows=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		local limits="limits"
-
-		if [ -n "$addrs" ] && [ -n "$subflows" ]; then
-			limits+=" set add_addr_accepted $addrs subflows $subflows"
-		fi
-		ip -n $ns mptcp $limits
-	else
-		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
-	fi
-}
-
 pm_nl_set_limits()
 {
-	pm_nl_limits "${@}"
+	mptcp_lib_endpoint_ops limits "${@}"
 }
 
 pm_nl_get_limits()
 {
-	pm_nl_limits "${@}"
+	mptcp_lib_endpoint_ops limits "${@}"
 }
 
 pm_nl_add_endpoint()
 {
-	local ns=$1
-	local addr=$2
-	local flags _flags
-	local port _port
-	local dev _dev
-	local id _id
-	local nr=2
-
-	local p
-	for p in "${@}"
-	do
-		if [ $p = "flags" ]; then
-			eval _flags=\$"$nr"
-			[ -n "$_flags" ]; flags="flags $_flags"
-		fi
-		if [ $p = "dev" ]; then
-			eval _dev=\$"$nr"
-			[ -n "$_dev" ]; dev="dev $_dev"
-		fi
-		if [ $p = "id" ]; then
-			eval _id=\$"$nr"
-			[ -n "$_id" ]; id="id $_id"
-		fi
-		if [ $p = "port" ]; then
-			eval _port=\$"$nr"
-			[ -n "$_port" ]; port="port $_port"
-		fi
-
-		nr=$((nr + 1))
-	done
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
-	else
-		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
-	fi
+	mptcp_lib_endpoint_ops add "${@}"
 }
 
 pm_nl_del_endpoint()
 {
-	local ns=$1
-	local id=$2
-	local addr=$3
-
-	if mptcp_lib_is_ip_mptcp; then
-		[ $id -ne 0 ] && addr=''
-		ip -n $ns mptcp endpoint delete id $id $addr
-	else
-		ip netns exec $ns ./pm_nl_ctl del $id $addr
-	fi
+	mptcp_lib_endpoint_ops del "${@}"
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
+	mptcp_lib_endpoint_ops flush "${@}"
 }
 
 pm_nl_show_endpoints()
 {
-	local ns=$1
-	local id=$2
-
-	if mptcp_lib_is_ip_mptcp; then
-		local show="show"
-
-		[ -n "$id" ] && show+=" id $id"
-		ip -n $ns mptcp endpoint $show
-	else
-		local dump="dump"
-
-		[ -n "$id" ] && dump="get $id"
-		ip netns exec $ns ./pm_nl_ctl $dump
-	fi
+	mptcp_lib_endpoint_ops show "${@}"
 }
 
 pm_nl_change_endpoint()
 {
-	local ns=$1
-	local addr=$2
-	local flags=$3
-
-	if ! mptcp_lib_is_addr "$addr"; then
-		[ $addr -gt 0 ] && [ $addr -lt 256 ] && addr="id $addr"
-	fi
-
-	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint change $addr ${flags//","/" "}
-	else
-		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags
-	fi
+	mptcp_lib_endpoint_ops change "${@}"
 }
 
 pm_nl_check_endpoint()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index c465f1d59419..d395692fac0d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -523,3 +523,151 @@ mptcp_lib_is_ip_mptcp() {
 
 	[ ${mptcp_lib_ip_mptcp} -eq 1 ]
 }
+
+mptcp_lib_limits() {
+	local ns=${1}
+	local addrs=${2}
+	local subflows=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		local limits="limits"
+
+		if [ -n "${addrs}" ] && [ -n "${subflows}" ]; then
+			limits+=" set add_addr_accepted ${addrs} subflows ${subflows}"
+		fi
+		# shellcheck disable=SC2086
+		ip -n "${ns}" mptcp ${limits}
+	else
+		# shellcheck disable=SC2086
+		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" ${subflows}
+	fi
+}
+
+mptcp_lib_add_endpoint() {
+	local ns=${1}
+	local addr=${2}
+	local flags _flags
+	local port _port
+	local dev _dev
+	local id _id
+	local nr=2
+
+	local p
+	for p in "${@}"
+	do
+		if [ "${p}" = "flags" ]; then
+			eval _flags=\$"${nr}"
+			[ -n "${_flags}" ]; flags="flags ${_flags}"
+		fi
+		if [ "${p}" = "dev" ]; then
+			eval _dev=\$"${nr}"
+			[ -n "${_dev}" ]; dev="dev ${_dev}"
+		fi
+		if [ "${p}" = "id" ]; then
+			eval _id=\$"${nr}"
+			[ -n "${_id}" ]; id="id ${_id}"
+		fi
+		if [ "${p}" = "port" ]; then
+			eval _port=\$"${nr}"
+			[ -n "${_port}" ]; port="port ${_port}"
+		fi
+
+		nr=$((nr + 1))
+	done
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086
+		ip -n "${ns}" mptcp endpoint add "${addr}" ${_flags//","/" "} ${dev} ${id} ${port}
+	else
+		# shellcheck disable=SC2086
+		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags} ${dev} ${id} ${port}
+	fi
+}
+
+mptcp_lib_del_endpoint() {
+	local ns=${1}
+	local id=${2}
+	local addr=${3}
+
+	if mptcp_lib_is_ip_mptcp; then
+		[ "${id}" -ne 0 ] && addr=''
+		# shellcheck disable=SC2086
+		ip -n "${ns}" mptcp endpoint delete id "${id}" ${addr}
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl del "${id}" "${addr}"
+	fi
+}
+
+mptcp_lib_flush_endpoint() {
+	local ns=${1}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint flush
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl flush
+	fi
+}
+
+mptcp_lib_show_endpoints() {
+	local ns=${1}
+	local id=${2}
+
+	if mptcp_lib_is_ip_mptcp; then
+		local show="show"
+
+		[ -n "${id}" ] && show+=" id ${id}"
+		# shellcheck disable=SC2086
+		ip -n "${ns}" mptcp endpoint ${show}
+	else
+		local dump="dump"
+
+		[ -n "${id}" ] && dump="get ${id}"
+		# shellcheck disable=SC2086
+		ip netns exec "${ns}" ./pm_nl_ctl ${dump}
+	fi
+}
+
+mptcp_lib_change_endpoint() {
+	local ns=${1}
+	local addr=${2}
+	local flags=${3}
+
+	if ! mptcp_lib_is_addr "${addr}"; then
+		[ "${addr}" -gt 0 ] && [ "${addr}" -lt 256 ] && addr="id ${addr}"
+	fi
+
+	if mptcp_lib_is_ip_mptcp; then
+		# shellcheck disable=SC2086
+		ip -n "${ns}" mptcp endpoint change ${addr} ${flags//","/" "}
+	else
+		# shellcheck disable=SC2086
+		ip netns exec "${ns}" ./pm_nl_ctl set ${addr} flags "${flags}"
+	fi
+}
+
+mptcp_lib_endpoint_ops() {
+	[ "$#" -lt 2 ] && return 1
+
+	case "$1" in
+	"limits")
+		mptcp_lib_limits "${@:2}"
+		;;
+	"add")
+		mptcp_lib_add_endpoint "${@:2}"
+		;;
+	"del")
+		mptcp_lib_del_endpoint "${@:2}"
+		;;
+	"flush")
+		mptcp_lib_flush_endpoint "${@:2}"
+		;;
+	"show")
+		mptcp_lib_show_endpoints "${@:2}"
+		;;
+	"change")
+		mptcp_lib_change_endpoint "${@:2}"
+		;;
+	*)
+		;;
+	esac
+}
-- 
2.40.1

