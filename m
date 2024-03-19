Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812A51005
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832590; cv=none; b=gRZqNQHC2KSv5AVewxKVe1NGp3Cr5kG01HQ2vs9GM4+2UwzGHi5YF4lww837d8KpZP60RSoWE1krqTdSyuwXXCj4hmLkihfTj3IPPyuNqfCaOxBj9XZzksE3y9/6nMtXbSkPZ8Scl6CkGZmLE+9q+mk+y6RH70p8gpZSr6sw/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832590; c=relaxed/simple;
	bh=4pthKABVG0UXNhMI2sFl22VCPncUGCWo4uHNkZ+fVss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=una9cieTbfJia7/FDkPoBeUxhgLOG7SdI/qnILKQrwv7B758LqWTrG4mqcBs+S+G5Gq4cKeJgoeV3VjASJzF6Uvp5PatZMBv2TvHR7FucR0eOefbeFJBBxKGc3DzBbqGmsOP1sqlS8/Saewf66vJ5Tl+2RNt5e50K2MV6SpHV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIrWwxWL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIrWwxWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5296C433F1;
	Tue, 19 Mar 2024 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832590;
	bh=4pthKABVG0UXNhMI2sFl22VCPncUGCWo4uHNkZ+fVss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIrWwxWLakT0g0BziBXQ0zbzWDoZMwgPzs8zJ8Dea8uLJSu+aSCbqjOprjVxd3FYM
	 tQWXhG8xjYWSWbghiaGDaV3aRdLOXNjdL0DVyfvAbc/MxMnrJOm0D+UeMOmFtfay8p
	 ClmCC6N2ok8EDgikalyw6PO7TqjMoukKDykXAPs4swznEuVkpCRfDS9osq4pc3sCjM
	 uDNlOeungIyO1hP9iJZ3XNbKilsjlTS+qtCLXYbh5vAwo5iwyoRLVNAq37UhaIHkVK
	 kxH7hCL+G9grrvyfyqo73uXNcsEZGc3au1hzH+pZXolRYiCfad4f9UhbPd+5zZBnzy
	 JYFA3H5gFsYnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/9] selftests: mptcp: join: update endpoint ops
Date: Tue, 19 Mar 2024 15:16:11 +0800
Message-Id: <bdc7da15b61ab50b6472cda04ef643c38978c23a.1710832493.git.tanggeliang@kylinos.cn>
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

This patch uses 'case' statements to simplify pm_nl_add_endpoint() and
pm_nl_check_endpoint(). And simplify pm_nl_check_endpoint() with
check_output() helper. Also update pm_nl_del_endpoint() to avoid the
'double quote' shellcheck warning.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 ++++++-------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d48da81daa06..8862b6a5caa0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -620,39 +620,27 @@ pm_nl_add_endpoint()
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
 
@@ -664,7 +652,7 @@ pm_nl_del_endpoint()
 
 	if mptcp_lib_is_ip_mptcp; then
 		[ $id -ne 0 ] && addr=''
-		ip -n $ns mptcp endpoint delete id $id $addr
+		ip -n $ns mptcp endpoint delete id $id ${addr:+"${addr}"}
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
 	fi
@@ -707,49 +695,35 @@ pm_nl_change_endpoint()
 
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
-	expected_line=$(mptcp_lib_pm_nl_format_endpoints \
-		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
-	if [ "$line" = "$expected_line" ]; then
-		print_ok
-	else
-		fail_test "expected '$expected_line' found '$line'"
-	fi
+	check_output "mptcp_lib_pm_nl_get_endpoint ${ns} ${id}" \
+		"$(mptcp_lib_pm_nl_format_endpoints \
+			"${id},${addr},${flags//","/" "},${dev},${port}")"
 }
 
 pm_nl_set_endpoint()
-- 
2.40.1

