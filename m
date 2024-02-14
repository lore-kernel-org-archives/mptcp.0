Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D341B976
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910872; cv=none; b=CIaZkKGocJ46cq1w4TrQ3HzVW91vXne1gme7Z+w746TxHB0pdmZRHgK2BMbK79pabOywVO69va3Z9TvAwULCsO9AacTXa2GbgLR4XWQDbm4xjt9QRevqDQsJ2cfqVxgh0YiaLXUFsxMS7lDLhBLoJRzbqCTqnX3nWcK0tQ/dx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910872; c=relaxed/simple;
	bh=pcas8o1Hov+9xVG4j0howEbP5BXoYZQSqtOSrwtgVAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDyRXobsslYRdYJbYxtYXqCJnIT86CxilgC0QcV+iyv0D/svzIMdQ3ycQKyt5gePp2YUlGA86ISEoAJtHTPlAQY1SJBVlkok7cdwW1PgZRW0+evyR08dhffBCZX6g7/9oBY3QseqDgvQreTzqEy7CK0y6a23FaTd7qAhGkTJv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URjmbFae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URjmbFae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32708C433F1;
	Wed, 14 Feb 2024 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910872;
	bh=pcas8o1Hov+9xVG4j0howEbP5BXoYZQSqtOSrwtgVAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URjmbFae/Y+X89N+kP+gSH+7DVIxVfyAZr1v5ccYaxXOgiFH5zYklzZlzqNBci0C0
	 /CS2W7SZsDMYq0Arc/wp3NP3tfgkTQuKOZF+ZtJZUi8qkucK0T3/19KJN1WwaAwed0
	 jufAFR+yIPJKD0FMz91ObUampZ7v3aXRamntKLdRKLVFm4IBqnZwemGrozyIXJlP3D
	 tYfRFjcasuY/iPvJzxr/I1FWl4d1njtGeaKgrfmRJD7fc99ltMY2Iva7DCzpdZJdfz
	 wXia0Wm3PXi8EC3oaL0QEJYoIaEBB3rBbVXNVVeCpyt0uVooiXngtTU88YmYx3Wk/U
	 P33T3feT1bxkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 15/15] selftests: mptcp: userspace pm get addr tests
Date: Wed, 14 Feb 2024 19:40:06 +0800
Message-Id: <b46824466aa1ede15dd8c8e0e5d6233b8b85ddfb.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
In it, parse the token value from the output of 'pm_nl_ctl events', then
pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
dump tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5f12bd1de383..7cf55609b7d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3366,6 +3366,18 @@ userspace_pm_dump()
 	ip netns exec $1 ./pm_nl_ctl dump token $tk
 }
 
+# $1: ns ; $2: id
+userspace_pm_get_addr()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3602,6 +3614,8 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_get_addr $ns1 10" \
+			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
 		kill_events_pids
@@ -3624,6 +3638,8 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_get_addr $ns2 20" \
+			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
 		kill_events_pids
-- 
2.40.1

