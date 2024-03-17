Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1837F6
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637150; cv=none; b=lcNTpHzkCHleGRONbSDvzPNSxg7qqgMrnH7z1mITin4Bp5fzVrTDOwTMCwnCIl7jw5LpnP+KHPdeefJPEjfU31lZpZBEmuT6lmGUl4/XhS/4QrdIS0RAXpFa1Y2fSoyAjTADsa0yuAwjGaGFke/Ewsl1k05c3PV92+XmXUHXR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637150; c=relaxed/simple;
	bh=YF+El9DZLe82sChkznqcNKSQljzKegApFp5nlAd4OJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sP6zmj4sI90cYnqNW2bu8m9ArMjdF9LLs+6rcDxuRoBb3/TubAAG7q5Et1S5ZePh8sd/l+59ev5PvyahUE4pN71ytBFsU+h5BClQYsuVKrecU9TWyUvR84VqMnapN3TpIxS+ldpn1zCvH7N1mcUJXb/q2J+nK4Cv6V6+ay4sLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLvHq+dY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLvHq+dY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0730FC433C7;
	Sun, 17 Mar 2024 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637149;
	bh=YF+El9DZLe82sChkznqcNKSQljzKegApFp5nlAd4OJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLvHq+dYxqOPhUaquelSH9vCSUTo6HWxEcfcr40Gwxx8nDYqbxV6rCfxAeGa1im63
	 /9D0qbVSH7mL5t8bxCI27l2xXWxb+OuToTiwRqU1l8OpQbfSkE3/PgES2pS0wKFvD/
	 xWVZw70T7DtUDZY27K5CGsirx28IlMx9SpBA6q0ynqn3I6E3gOpx1vaUzv+y9Htw8h
	 LEYSDHD2lBs8lNUt61K5J9SjClANw/QBdtgYoSl8SzIGPEQsZJeM8r1TI/FheuBl4+
	 WJQKkJuk0QCWdGaFF+pHo2OM0clIsWqau8qGyLCodW7KmVYbPbs8MDdPDTzl+iVJaW
	 jPfdGHnk41/wg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 10/12] selftests: mptcp: export more endpoint ops
Date: Sun, 17 Mar 2024 08:58:09 +0800
Message-Id: <c7e92b80a535579353c18304f5194994e1d48a49.1710636726.git.tanggeliang@kylinos.cn>
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

This patch exports five endpoint operation helpers with pm_nl_ prefix,
pm_nl_add_endpoint(), pm_nl_del_endpoint(), pm_nl_flush_endpoint(),
pm_nl_show_endpoints() and pm_nl_change_endpoint() into mptcp_lib.sh as
public functions, and renamed each of them with a mptcp_lib_ prefix.
Then these old pm_nl_ prefix helpers in mptcp_join.sh can be wrappers
of mptcp_lib_ prefix ones.

Use these newly added helpers to replace all 'pm_nl_ctl' commands with
'add', 'del', 'flush', 'show' and 'set' arguments in scripts
mptcp_sockopt.sh, pm_netlink.sh and simult_flows.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 73 ++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  8 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 94 +++++++++----------
 .../selftests/net/mptcp/simult_flows.sh       |  2 +-
 5 files changed, 130 insertions(+), 109 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ea99e45c3a0a..7a3a8b8254fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -610,79 +610,27 @@ pm_nl_set_limits()
 
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
index e26ef67e4ef1..34f78dc7c8f0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -601,3 +601,76 @@ mptcp_lib_pm_nl_change_address() {
 		ip netns exec "${ns}" ./pm_nl_ctl set "${addr}" flags "${flags}"
 	fi
 }
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
index 6f39a5d6d02e..36e81383f0e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -58,11 +58,11 @@ init()
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
 
 	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index a42490885d88..31f7021734fe 100755
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
@@ -123,8 +123,8 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 				      "8,10.0.1.8,signal")" \
 	"id limit"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
+mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+check "mptcp_lib_pm_nl_show_endpoints ${ns1}" "" "flush addrs"
 
 mptcp_lib_pm_nl_set_limits "${ns1}" 9 1 2>/dev/null
 check "mptcp_lib_pm_nl_get_limits ${ns1}" "${default_limits}" "rcv addrs above hard limit"
@@ -136,16 +136,16 @@ mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
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
index b8414cff9b4b..acc49fa652a2 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -86,7 +86,7 @@ setup()
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
 	mptcp_lib_pm_nl_set_limits "${ns1}" 1 1
-	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
-- 
2.40.1

