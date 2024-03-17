Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A6139B
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637148; cv=none; b=t+ua4dbXJirQRuqc5wPR18zcHHirmadnkulx7d01V0lNdHsi0hAY6XSGcQWke6Jmp21iC87HGj3ymtN9D2sHkkonH761TN786lS/nRXuaeT6uZ9t6GEptHF4R5c7YhBxiae3tykhJ6zCDaig9OtKxCT9hAbsy701mIYWJCwLwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637148; c=relaxed/simple;
	bh=lfRKlJZ3nHOVZY1u2F7eFDm9yvvJ3nD1wmQVeiWI0a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6nGTJBEu2QOVPLdg8RG68E/SfVJNWxC6MmSXeT7uQk8HhmVW/Hwxg6G3m9gbHA4SNQ1NVZQUKUllABY9HavHtwalhXAryHoxYStZFhxwzjeylwgw8+JNPu++B4dJs/MXpWLau8XDU5h8x+QjpJLXguiBmAapM5tmHINnKs4/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reZBAcvF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reZBAcvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98BDC433F1;
	Sun, 17 Mar 2024 00:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637148;
	bh=lfRKlJZ3nHOVZY1u2F7eFDm9yvvJ3nD1wmQVeiWI0a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=reZBAcvFPp4ib1ljQ61LeoeBRAA+Dl7Kj14FyZrP9LmPYEvFwF851teFB8PmxvYlS
	 ug5aEiMWX+00Dv+XFmcI8fJjji+wnCwOF7Ntpw+nSydKr+sj+KKKpK8OOFHPDkSYwm
	 +wm5ctZ82TSsrJ/x3MXRJRYH7MUz37AL/wpzBYUf2xSPjixaBydZWuEN9KOQS+H0CH
	 WpWU3+yYW5gu5UEqtSxYtwLsaVEFHmi0lZRsVscZi1NttvjaKiMScgj4c+GDHWh8Gy
	 qbatdS2q5bxFishaCiuagWhocSwaXwUHDvaAJa4XJ7M4Mf0JxD9iXwb8GeZ2mt4asX
	 02PoWugmkYVDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 09/12] selftests: mptcp: join: update endpoint ops
Date: Sun, 17 Mar 2024 08:58:08 +0800
Message-Id: <a7fd2cb720e25b322f9c1b66528e292c3464486d.1710636726.git.tanggeliang@kylinos.cn>
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

This patch uses 'case' statements to simplify pm_nl_add_endpoint() and
pm_nl_check_endpoint(). And simplify pm_nl_check_endpoint() with
check_output() helper. Also update pm_nl_del_endpoint() to avoid the
'double quote' shellcheck warning.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 ++++++-------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c06c1bd4d621..ea99e45c3a0a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -612,39 +612,27 @@ pm_nl_add_endpoint()
 {
 	local ns=$1
 	local addr=$2
-	local flags _flags
-	local port _port
-	local dev _dev
-	local id _id
+	local flags dev id port
 	local nr=2
 
 	local p
 	for p in "${@}"
 	do
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
+		case "${p}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${p}"=\$"${nr}"
+			;;
+		esac
 
 		nr=$((nr + 1))
 	done
 
 	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
+		ip -n "${ns}" mptcp endpoint add "${addr}" ${flags//","/" "} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
 	else
-		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
+		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags:+flags "${flags}"} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
 	fi
 }
 
@@ -656,7 +644,7 @@ pm_nl_del_endpoint()
 
 	if mptcp_lib_is_ip_mptcp; then
 		[ $id -ne 0 ] && addr=''
-		ip -n $ns mptcp endpoint delete id $id $addr
+		ip -n $ns mptcp endpoint delete id $id ${addr:+"${addr}"}
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
 	fi
@@ -699,49 +687,35 @@ pm_nl_change_endpoint()
 
 pm_nl_check_endpoint()
 {
-	local line expected_line
 	local msg="$1"
 	local ns=$2
 	local addr=$3
-	local _flags=""
-	local _port
-	local dev
-	local _id
+	local flags dev id port
 
 	print_check "${msg}"
 
 	shift 3
 	while [ -n "$1" ]; do
-		if [ $1 = "flags" ]; then
-			_flags=$2
-			shift
-		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="$2"
-			shift
-		elif [ $1 = "id" ]; then
-			_id=$2
-			shift
-		elif [ $1 = "port" ]; then
-			_port=$2
+		case "${1}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${1}"="${2}"
 			shift
-		fi
+			;;
+		*)
+			;;
+		esac
 
 		shift
 	done
 
-	if [ -z "${_id}" ]; then
+	if [ -z "${id}" ]; then
 		test_fail "bad test - missing endpoint id"
 		return
 	fi
 
-	line=$(mptcp_lib_pm_nl_get_endpoint "${ns}" "${_id}")
-	expected_line=$(mptcp_lib_format_endpoints \
-		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
-	if [ "$line" = "$expected_line" ]; then
-		print_ok
-	else
-		fail_test "expected '$expected_line' found '$line'"
-	fi
+	check_output "mptcp_lib_pm_nl_get_endpoint ${ns} ${id}" \
+		"$(mptcp_lib_format_endpoints \
+			"${id},${addr},${flags//","/" "},${dev},${port}")"
 }
 
 pm_nl_set_endpoint()
-- 
2.40.1

