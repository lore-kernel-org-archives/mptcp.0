Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DD46BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561097; cv=none; b=iFnsqWlEbzC6+rnm2zN2SKs4DOflswENpTSWb8lCrWmFCt5pKF5fyl2zcGZyzGbkluo5kdalBRYKZbO/o8nn/HH+LGzFYjmHspCa5NZw2R1OA1ELc1Th2F+4WDFrul/i37XlYCXZ/k61yymsEvUi9LRwUas4ElPVYRvzfccMlwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561097; c=relaxed/simple;
	bh=TdhvIMiuH1Lv1+PpQpk0gDsMOhM7pbvDxaxhQPfa6V0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsSXoSYi0wyDS6OaCcsHd8kw9yHqNO5wDtgQpEe5iHFZi5uQjZyJMU8MFTDz/8C0hbVu1f44iXqZZCjRuDVZaQ4iK2fbW7l+uqV+lJ/EP38RD4PQAv4b+53FuZKZae0MvZoiby1d4B1sMjLLzhn6ni2tg6B3onmEAbuINvDx6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMxTpLxt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMxTpLxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FEC433C7;
	Sat, 16 Mar 2024 03:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561097;
	bh=TdhvIMiuH1Lv1+PpQpk0gDsMOhM7pbvDxaxhQPfa6V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMxTpLxthSj557dTAEZTERn2uw6tz8hQZbCcbdTt0w6u8S0Q6IrWjOLam3io+HmlU
	 P9HaO4mC+iTmrx/SKkCC8m7QWeSXygWGYXupzsNtUSPv0VsLAiqSNjskizgj0pS5y9
	 RsPEa5SkYYx6MhJLiQzlTB1hYRjwyfUf47Ot6JcLO5eymsSd6ccDJu8sdz/RPsiYED
	 YQKmJe2x5V9OXDrdPcvc82Gtf6oMSR19H/HLbFvagwHzjGhTdhYXGowULDMBMaAQDq
	 +3AbLFSaJZjGM6nSiFx4+ArFWs7B6gxPe9aEHG10683ZPuSZG+ZnRnWkBxf8I7HFuf
	 t5854XKoKa8rA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/9] selftests: mptcp: export more endpoint ops
Date: Sat, 16 Mar 2024 11:50:35 +0800
Message-Id: <f6166fd55d9621413875932b2865f649dac318e2.1710560839.git.tanggeliang@kylinos.cn>
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

This patch exports six endpoint operation helpers with the pm_nl_ prefix:

	pm_nl_set_limits(),
	pm_nl_add_endpoint(),
	pm_nl_del_endpoint(),
	pm_nl_flush_endpoint(),
	pm_nl_show_endpoints() and
	pm_nl_change_endpoint()

from mptcp_join.sh into mptcp_lib.sh as public functions, and renamed
each of them with a mptcp_lib_ prefix. Then these old pm_nl_ prefix
helpers in mptcp_join.sh can be wrappers of mptcp_lib_ prefix ones.

Use these newly added helpers to replace all 'pm_nl_ctl' commands with
'limits', 'add', 'del', 'flush', 'show' and 'set' arguments in scripts
mptcp_join.sh, mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  72 ++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  85 +++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +--
 .../testing/selftests/net/mptcp/pm_netlink.sh | 100 +++++++++---------
 .../selftests/net/mptcp/simult_flows.sh       |   6 +-
 5 files changed, 150 insertions(+), 125 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4dd9979c8fdb..eb807db4b91f 100755
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
index 9ba37d12d960..53d306f6f61a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -589,3 +589,88 @@ mptcp_lib_pm_nl_change_address() {
 		ip netns exec "${ns}" ./pm_nl_ctl set "${addr}" flags "${flags}"
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
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e2d70c18786e..36e81383f0e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -58,15 +58,15 @@ init()
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
 
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.$i.1 flags signal
-		ip netns exec $ns1 ./pm_nl_ctl add dead:beef:$i::1 flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "10.0.${i}.1" flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
 
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.$i.2 flags signal
-		ip netns exec $ns2 ./pm_nl_ctl add dead:beef:$i::2 flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns2}" "10.0.${i}.2" flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
 	done
 
-	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
 
 	add_mark_rules $ns1 1
 	add_mark_rules $ns2 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2e889fbd7fcd..31f7021734fe 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -67,7 +67,7 @@ check()
 	fi
 }
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" "" "defaults addr list"
 
 default_limits="$(mptcp_lib_pm_nl_get_limits "${ns1}")"
 if mptcp_lib_expect_all_features; then
@@ -75,45 +75,45 @@ if mptcp_lib_expect_all_features; then
 		"$(mptcp_lib_format_limits 0 2)" "defaults limits"
 fi
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.1
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.2 flags subflow dev lo
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.3 flags signal,backup
 check "mptcp_lib_pm_nl_get_endpoint ${ns1} 1" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
 				      "2,10.0.1.2,subflow,lo" \
 				      "3,10.0.1.3,signal backup")" \
 	"dump addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl del 2
+mptcp_lib_pm_nl_del_endpoint "${ns1}" 2
 check "mptcp_lib_pm_nl_get_endpoint ${ns1} 2" "" "simple del addr"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
 				      "3,10.0.1.3,signal backup")" \
 	"dump addrs after del"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.3 2>/dev/null
 check "mptcp_lib_pm_nl_get_endpoint ${ns1} 4" "" "duplicate addr"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.4 flags signal
 check "mptcp_lib_pm_nl_get_endpoint ${ns1} 4" \
 	"$(mptcp_lib_format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 check "mptcp_lib_pm_nl_get_endpoint ${ns1} 9" \
 	"$(mptcp_lib_format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
 check "mptcp_lib_pm_nl_get_endpoint ${ns1} 10" "" "above hard addr limit"
 
-ip netns exec $ns1 ./pm_nl_ctl del 9
+mptcp_lib_pm_nl_del_endpoint "${ns1}" 9
 for i in $(seq 10 255); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
-	ip netns exec $ns1 ./pm_nl_ctl del $i
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.9 id "${i}"
+	mptcp_lib_pm_nl_del_endpoint "${ns1}" "${i}"
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
 				      "3,10.0.1.3,signal backup" \
 				      "4,10.0.1.4,signal" \
@@ -123,29 +123,29 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				      "8,10.0.1.8,signal")" \
 	"id limit"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
+mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" "" "flush addrs"
 
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
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 id 100
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.1
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.2
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.3 id 100
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.4
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.5 id 254
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.6
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.7
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.8
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
 				      "2,10.0.1.2" \
 				      "3,10.0.1.7" \
@@ -156,16 +156,16 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				      "255,10.0.1.6")" \
 	"set ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.2 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.3
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.1
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.2 id 254
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.3
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.4
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.5 id 253
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.6
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.7
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.0.8
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.0.1" \
 				      "2,10.0.0.4" \
 				      "3,10.0.0.6" \
@@ -176,30 +176,30 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				      "255,10.0.0.3")" \
 	"wrap-around ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.1.1 flags subflow
 mptcp_lib_pm_nl_change_address "${ns1}" 10.0.1.1 backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow backup")" \
 	"set flags (backup)"
 mptcp_lib_pm_nl_change_address "${ns1}" 10.0.1.1 nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow")" \
 	"          (nobackup)"
 
 # fullmesh support has been added later
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
-if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+mptcp_lib_pm_nl_change_endpoint "${ns1}" 1 fullmesh 2>/dev/null
+if mptcp_lib_pm_nl_show_endpoints "${ns1}" | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 		"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow fullmesh")" \
 		"          (fullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	mptcp_lib_pm_nl_change_endpoint "${ns1}" 1 nofullmesh
+	check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 		"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow")" \
 		"          (nofullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	mptcp_lib_pm_nl_change_endpoint "${ns1}" 1 backup,fullmesh
+	check "mptcp_lib_pm_nl_show_endpoints ${ns1}" \
 		"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
 		"          (backup,fullmesh)"
 else
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e129fcb5a598..acc49fa652a2 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -85,8 +85,8 @@ setup()
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
-	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
-	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	mptcp_lib_pm_nl_set_limits "${ns1}" 1 1
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
@@ -108,7 +108,7 @@ setup()
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 
-	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+	mptcp_lib_pm_nl_set_limits "${ns3}" 1 1
 
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure
-- 
2.40.1

