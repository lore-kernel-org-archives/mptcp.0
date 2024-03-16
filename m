Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5146BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561095; cv=none; b=pdiwxzgNDER2PzXIVThOT6eLplLs+EIti6tOyjkR1i60UN89E8YL0Mawa3HR9qyu+6BuU/SqVtg7vibTyOdkW5getgyaMZicQiOTAKIxWaXOHbZaVxTOMIXT0fhxp95+B6ZDAQeP1sHzpNFanq4Nc6PS+zCkdpX+FNbjKeb8SZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561095; c=relaxed/simple;
	bh=PUJeLESW7LG6trMotsmQ2j4PMmOFqvnr5/8G5SvImr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzWQabPqGZQyhcKchkxAn9uVo6dvMAvlCPgzji4GEJUtWruk/+IQX66FZ5SEyZFBdFmcpGGQzhb1GYaBVwJh8QdFB1Ic5bVBWylqqUxveivUs3YuFv3lzrjtftIQhVZzcqVD/kg+50weNNCX74ygb+5+8wn/hC4RAanVOhkokxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4QUq9Us; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4QUq9Us"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B67C433C7;
	Sat, 16 Mar 2024 03:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561095;
	bh=PUJeLESW7LG6trMotsmQ2j4PMmOFqvnr5/8G5SvImr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4QUq9UskUSQwcq7FbIggE0NJiKgKbRAQLf72TXv1cU5wsIYHX5qKrTjHeM5Y0X7Q
	 o4GzJ8q5XvZgIoszfPpzetJbdFO0YZf4tgjdQ0GMLtdgLeFKa3nhSEX5dNuiOC7Fvo
	 Bruo+QfvlLY9BrAH3okMjiOeH4zm6WNigzTTyLgN/4aggkxwofieF+nYzVRaJdyS3w
	 Cv1m6sCICbyMkNaUd0kLuEO13n9gIZoiHrArFUq48emXrVnBPbXmeIiuohE5XaTUSj
	 9EtUz/ZZ2iVJ2hy0QxcR93Wf+rzKTH1kPGB+DDwj8YnsgF1m51x+7K8NHo6bfx/1eo
	 dvUXFXap8d9nQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/9] selftests: mptcp: join: update endpoint ops
Date: Sat, 16 Mar 2024 11:50:34 +0800
Message-Id: <6b8e5cb916e24acd0fdba0779b53d254fa02f114.1710560839.git.tanggeliang@kylinos.cn>
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

This patch uses 'case' statements to simplify pm_nl_add_endpoint() and
pm_nl_check_endpoint(). Alse update pm_nl_del_endpoint() to avoid the
'double quote' shellcheck warning.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 64 +++++++------------
 1 file changed, 22 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b1c47c00d699..4dd9979c8fdb 100755
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
@@ -711,40 +699,32 @@ pm_nl_check_endpoint()
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
+		case "${1}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${1}"="${2}"
 			shift
-		elif [ $1 = "id" ]; then
-			_id=$2
-			shift
-		elif [ $1 = "port" ]; then
-			_port=$2
-			shift
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
+	line=$(mptcp_lib_pm_nl_get_endpoint "${ns}" "${id}")
 	expected_line=$(mptcp_lib_format_endpoints \
-		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
+		"${id},${addr},${flags//","/" "},${dev},${port}")
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
 	else
-- 
2.40.1

