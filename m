Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D922139E
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637146; cv=none; b=lo8WdFyzZLOENGmrML2+7NoAvpqXZWXKGgFTjyiw2SRMf0OB0QkY6rckYtbI5NTnGezLExHQHrVoE+4ZblvqPy6lCWKzDMaELUAcz673/IB9WanPcA+YqprTimiCtNENl23EqTfhAzXJRBJuAW7gPPBUxvYnbFrEVAZS7qiyHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637146; c=relaxed/simple;
	bh=cFVXoh2U/hplWRt91eDX6/DiWwZND6n4Nao9Qqb7VaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdKkK993IOlxQoReAY5yWOri/vRA4ZyeQXBfEEJEykiHbz2/Cwn3UXbU//Duyn9MPIKLpBq+HbDwSSWSLOsfnJ3K+k7bAhd7q6OifzD5+rr7KmtfzIiSuX9+OCH6cvOTGjAbOr00bjq/bvsVL6xP/kOuzgFWhlp5odcU4CsL44w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmZhf60M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmZhf60M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E9EC43390;
	Sun, 17 Mar 2024 00:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637145;
	bh=cFVXoh2U/hplWRt91eDX6/DiWwZND6n4Nao9Qqb7VaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YmZhf60M9CsmfA6oX1nQYtrJg8tr4xr4UrhPKrhWDfZSgFbR9Efuk8am/rN5kzERH
	 Z7JhqHpDjiAnFYGprDrANhglBy6vfSunuJIlqXs2l+0layZylZLOKXVGbCgH8sHKHd
	 H6UjodUYf990LCdEUH8DMT7e97+XfQdAu115NpGmTM/l6bnWZUhQ0jvY7yK6UW7rpN
	 8O14w9QU9RzSRhoNO7U/tSU8wWfPkGtT7ENP5dwZymBljt/iKnDjreiPYjTjyrcE99
	 /yDd8EXOlQyPLEmwaLA6w7uHiCsNLuKhc2ZylRX8I3N7cJTYYFaBrErQlXO/sBjxFL
	 FLtID19rABzDw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 07/12] selftests: mptcp: add get_endpoint helper
Date: Sun, 17 Mar 2024 08:58:06 +0800
Message-Id: <c845f5894ba4cd21bfd9e74af2cb59a191dabbda.1710636726.git.tanggeliang@kylinos.cn>
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

All endpoints are showed in show_endpoints(). This patch adds another
helper named get_endpoint() to show a specofic endpoint identified by
the given address ID.

Usage:
	All endpoints - show_endpoints $ns
	One endpoint - get_endpoint $ns $id

Use this new helper in mptcp_join.sh and pm_netlink.sh to replace all
'pm_nl_ctl get' commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 11 +++++++++++
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 12 ++++++------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3d0051b57ecd..c06c1bd4d621 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -707,7 +707,6 @@ pm_nl_check_endpoint()
 	local _port
 	local dev
 	local _id
-	local id
 
 	print_check "${msg}"
 
@@ -721,7 +720,6 @@ pm_nl_check_endpoint()
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
-			[ -n "$_id" ]; id="id $_id"
 			shift
 		elif [ $1 = "port" ]; then
 			_port=$2
@@ -731,16 +729,12 @@ pm_nl_check_endpoint()
 		shift
 	done
 
-	if [ -z "$id" ]; then
+	if [ -z "${_id}" ]; then
 		test_fail "bad test - missing endpoint id"
 		return
 	fi
 
-	if mptcp_lib_is_ip_mptcp; then
-		line=$(ip -n $ns mptcp endpoint show $id)
-	else
-		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
-	fi
+	line=$(mptcp_lib_pm_nl_get_endpoint "${ns}" "${_id}")
 	expected_line=$(mptcp_lib_format_endpoints \
 		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
 	if [ "$line" = "$expected_line" ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 92b89f3a7605..d83a67922b17 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -577,3 +577,14 @@ mptcp_lib_format_endpoints() {
 		fi
 	done
 }
+
+mptcp_lib_pm_nl_get_endpoint() {
+       local ns=${1}
+       local id=${2}
+
+       if mptcp_lib_is_ip_mptcp; then
+               ip -n "${ns}" mptcp endpoint show id "${id}"
+       else
+               ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
+       fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 95e393c95017..28c89b576d1f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -78,7 +78,7 @@ fi
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" \
+check "mptcp_lib_pm_nl_get_endpoint ${ns1} 1" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
@@ -88,25 +88,25 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 	"dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
-check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
+check "mptcp_lib_pm_nl_get_endpoint ${ns1} 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
 				      "3,10.0.1.3,signal backup")" \
 	"dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
+check "mptcp_lib_pm_nl_get_endpoint ${ns1} 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" \
+check "mptcp_lib_pm_nl_get_endpoint ${ns1} 4" \
 	"$(mptcp_lib_format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" \
+check "mptcp_lib_pm_nl_get_endpoint ${ns1} 9" \
 	"$(mptcp_lib_format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
-check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
+check "mptcp_lib_pm_nl_get_endpoint ${ns1} 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
 for i in $(seq 10 255); do
-- 
2.40.1

