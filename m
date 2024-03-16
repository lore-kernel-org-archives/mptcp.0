Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1946BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561092; cv=none; b=UJVqsTUrVFpz3kHuDVuiriQcJb51Nx2OfTJWRKVaiQPeFyteqsmFvf6cwIV1VJqPl9TxE2deOuIYABXu25QSB8ZvhKT67lMU3LCeQUnRFqDhLFKo2fZu8wzVEU4SFz8Zat1x/7ke9uKZDqsPoPkkkmyiWeVX5JcltEMp1eSx5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561092; c=relaxed/simple;
	bh=LR9EzXIX9B04uncI5Sk4IatiAg+vo1UQtwv+NJ7iws0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+l60AHzkv24ai6Vwc42VjAtcnzxMxPXcqbHv8yvtaV8sybexGDZ9Gg6nGezrI5+7hZQDAQ7A+5CGVU29NLzL+cFwQu2V4E6Bh0PQ0BXyyf7/R3sBCyMPl5Ft0YIAw/abwh4vOvL/X3tNZQmEqNGKGreCMyTp+l6/ZIITyDqQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgBdPx68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgBdPx68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDB4C433F1;
	Sat, 16 Mar 2024 03:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561091;
	bh=LR9EzXIX9B04uncI5Sk4IatiAg+vo1UQtwv+NJ7iws0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgBdPx68COhmEcPA8NrZdU83fdUEolgXK2r/89cLVFy7edhlRUha01TyvSk4ApHQu
	 2v2Tz0iTnNCF6okIuZzaXG7JRfFrh7IcE/MouZthqu1vDd/JftFoN1q2vO4UjMfdJE
	 gFUEBvt/L+kBj9+G9NdBLY6lA3JE+f1iFbifktdkLM7DYcyYidwd3N5p8VpmzotCyb
	 g90rfe6LywmD+JBcB3DZd/gpJGOe8l587dtY2YDwpUxe52B8EMT5NG7OhLZWSKWN6R
	 W3kn/52yq7I/8K1i0R39eAl14xn6OUsstNri0rACgLzW63oqQuo9DyvCwy47ncXloi
	 TZttsQ1DokKiw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/9] selftests: mptcp: add get_endpoint helper
Date: Sat, 16 Mar 2024 11:50:32 +0800
Message-Id: <698a378299c286df2badeacd09181648590493d7.1710560839.git.tanggeliang@kylinos.cn>
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

All endpoints are showed in show_endpoints(). This patch adds another
helper named get_endpoint() to support for showing a specofic endpoint
identified by the given address ID.

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
index d7a4e4fe7800..b1c47c00d699 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -715,7 +715,6 @@ pm_nl_check_endpoint()
 	local _port
 	local dev
 	local _id
-	local id
 
 	print_check "${msg}"
 
@@ -729,7 +728,6 @@ pm_nl_check_endpoint()
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
-			[ -n "$_id" ]; id="id $_id"
 			shift
 		elif [ $1 = "port" ]; then
 			_port=$2
@@ -739,16 +737,12 @@ pm_nl_check_endpoint()
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
index 00d6cb287c04..86b8ad092611 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -565,3 +565,14 @@ mptcp_lib_pm_nl_get_limits() {
 		ip netns exec "${ns}" ./pm_nl_ctl limits
 	fi
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
index 9430e91e48ed..d349cfb8834f 100755
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

