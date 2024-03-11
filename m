Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C78ECC
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121739; cv=none; b=PuMNpxH5uglOhU2bXbvy3EbkuoNMct3BLLLkrpPQtvKGyongJ765ZjY89OZM6DfRXMKkGhjJ2BcLb9EColPapMtoSxCydAZhfEGtM+Amex1xachuMa5B/IBM2MU3uX5h89xtWVMx06le1BqQzgT4H1AjmCMCfFGn/uthUu1eSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121739; c=relaxed/simple;
	bh=uzNChWEYhi9H8b9O/hdjD/XW6jBMevtYn3n0BjWuWqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gM6+vWifWB+GnR7KzZX0/AA1CRmcMXNwXDvblq+kzVpVwqhdtLw9ysRIl/b6IpsnZcWhiXpKK2LybHqKl1ueZQQ6DWxA621GKyFM46ZtkHOAYcjewHbb4nyhu7/B2k4/RqD8qecdCN9ZenBNlat/3JGyHA94+shnWnN1LUAAR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLecKetS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLecKetS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7357FC43390;
	Mon, 11 Mar 2024 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121738;
	bh=uzNChWEYhi9H8b9O/hdjD/XW6jBMevtYn3n0BjWuWqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLecKetSVWztkS5xdtLgYLiExztdmeKsX83p0Qq7QEKvNo9baHhyx453zbAboJ/GK
	 GgBvWrUjKqfk/8k6U2UE9OfzYyq8eYL55fkRbzFWAROVg39bKgz/lsBZ39Ji48vigu
	 e4eDtFJLZquaemcx/VD9+UCDqs2bziDMw2wh2DcPyhvG7sIprZayLxxsYajP/yZ9G5
	 H8DmswCi9xHMAvWgVWMzz89OBlK5uWj2iFmJeAP+fHMVYPDaEPh6Dq43ZFJs77Pu+l
	 wVQb2R7A00bA3Xc3Qb4zV26y/vOo9ES8H4q4dnFeWIdxv5oLVJODDBG0HFXm8uw6OR
	 PJlTW2ddae8tQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 03/10] selftests: mptcp: id support for show_endpoints
Date: Mon, 11 Mar 2024 09:48:40 +0800
Message-Id: <3e52c3dda1c27337c482e4752c376fad1c4d4e67.1710121590.git.tanggeliang@kylinos.cn>
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

All endpoints are showed in pm_nl_show_endpoints(). This patch adds support
for showing a specofic endpoint identified by the given address ID.

Usage:
        All endpoints - pm_nl_show_endpoints $ns
        One endpoint - pm_nl_show_endpoints $ns $id

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8eb5cf54ea42..e33a136aef8e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -699,11 +699,18 @@ pm_nl_flush_endpoint()
 pm_nl_show_endpoints()
 {
 	local ns=$1
+	local id=$2
 
 	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint show
+		local show="show"
+
+		[ -n "$id" ] && show+=" id $id"
+		ip -n $ns mptcp endpoint $show
 	else
-		ip netns exec $ns ./pm_nl_ctl dump
+		local dump="dump"
+
+		[ -n "$id" ] && dump="get $id"
+		ip netns exec $ns ./pm_nl_ctl $dump
 	fi
 }
 
@@ -3598,6 +3605,10 @@ endpoint_tests()
 		mptcp_lib_is_ip_mptcp && output="add_addr_accepted 2 subflows 2 "
 		check_output "pm_nl_get_limits ${ns1}" "${output}"
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		print_check "show id 1 addr"
+		output="id 1 flags signal 10.0.2.1"
+		mptcp_lib_is_ip_mptcp && output="10.0.2.1 id 1 signal "
+		check_output "pm_nl_show_endpoints ${ns1} 1" "${output}"
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
-- 
2.40.1

