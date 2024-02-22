Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087317C62
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589053; cv=none; b=XVaLjIBXmCShViT8kEX0nKziF/oa4gfw1tFjyp9IYwGm3T8cbbnKB1Ll2AaFrTXvZMNkqOumxv11L+QL2PduBp4jOSf2wzfVosND4P4DMsMyqbgMa44CoSjKKNWcFmI5w8DA2VBUWGGGpbNfIXJ+jyJGhla5M6dQuRazhIwjxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589053; c=relaxed/simple;
	bh=ATCTVAieJLmgW4Gyo/eDCk/g6pDUtWhemFOfGV3JkCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrE0Z042W4BapdA3ND5pYywXmxNTL35vvxGAY2k7Cz/71azjkREG09GdAKYzyWv1iWuwjQ1oiOJKiC0kDrmCFH0B5h02UZtIj7em1O4Pn6GAyNNkCeeHaaDADUZ98nsz6P2oQBb+JWyoDTq9muTQApZdeb/rtr9DG0XCojhuqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC9JL61G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC9JL61G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FD5C433C7;
	Thu, 22 Feb 2024 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708589052;
	bh=ATCTVAieJLmgW4Gyo/eDCk/g6pDUtWhemFOfGV3JkCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DC9JL61Gex8A1uRfXKL5zPpbu7VeMabnJltHEr0smjD2NACpSChZBP85+9oUVKeU0
	 y51WsC3VsaT/piIOcFdX28oGRZ0g1NXc2QyGlebBdOxVbep6g8O5ryYzUpGvZAKt0S
	 skzwP0RGrKi04W567efqnoBxoI+IAqs4mmetmoiBOZ9Aih6Q95xyIt8484QV/vKzT9
	 pguGFPSm6uclyh7J4htCnEzk7smv6/iHtB2fnbXZFDgFuL2Olpriy4cfuhC6VQoR/6
	 7WiIT+2xfgSkCzaEK5MvFZrjommJ7Y84ZA3Qhu5sYY2W3CqqfODH7AoRKEPWPtmKNN
	 SAkGLY8w0XPKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/7] selftests: mptcp: flush userspace addrs list
Date: Thu, 22 Feb 2024 16:03:58 +0800
Message-Id: <2a89f983d02141661c2f7cf0bfb4109ee74db60e.1708588977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708588977.git.tanggeliang@kylinos.cn>
References: <cover.1708588977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_flush() to flush all addresses
for the userspace PM. Invoke it in userspace pm dump address and subflow
tests. And use dump commands to check if the userspace pm local address
list is empty after addresses flushing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 41 +++++++++++++++----
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 292fccb1f7f4..be1d2005c4fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3356,6 +3356,19 @@ userspace_pm_get_addr()
 	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
 }
 
+# $1: ns
+userspace_pm_flush()
+{
+	local ns="${1}"
+	local id
+	local addr
+
+	while read -r _ id _ _ addr; do
+		userspace_pm_rm_addr "${ns}" "${id}"
+		userspace_pm_rm_sf "${ns}" "${addr}" $SUB_ESTABLISHED
+	done <<< $(userspace_pm_dump "${ns}")
+}
+
 userspace_pm_chk_dump_addr()
 {
 	local ns="${1}"
@@ -3500,27 +3513,37 @@ userspace_tests()
 	if reset_with_events "userspace pm create destroy subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
-		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns1 0 2
 		speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.2.2 10
 		userspace_pm_add_sf $ns2 10.0.3.2 20
-		chk_join_nr 1 1 1
-		chk_mptcp_info subflows 1 subflows 1
-		chk_subflows_total 2 2
+		chk_join_nr 2 2 2
+		chk_mptcp_info subflows 2 subflows 2
+		chk_subflows_total 3 3
 		userspace_pm_chk_dump_addr "${ns2}" \
-			"id 20 flags subflow 10.0.3.2" \
+			$'id 10 flags subflow 10.0.2.2\nid 20 flags subflow 10.0.3.2' \
 			"subflow"
+		userspace_pm_chk_get_addr "${ns2}" "10" "id 10 flags subflow 10.0.2.2"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
-			"" \
+			"id 10 flags subflow 10.0.2.2" \
 			"after rm_addr 20"
-		chk_rm_nr 1 1
-		chk_mptcp_info subflows 0 subflows 0
-		chk_subflows_total 1 1
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+			userspace_pm_flush $ns2
+			userspace_pm_chk_dump_addr "${ns2}" "" "after flush"
+			chk_rm_nr 2 2
+			chk_mptcp_info subflows 0 subflows 0
+			chk_subflows_total 1 1
+		else
+			chk_rm_nr 1 1
+			chk_mptcp_info subflows 1 subflows 1
+			chk_subflows_total 2 2
+		fi
 		kill_events_pids
 		mptcp_lib_kill_wait $tests_pid
 	fi
-- 
2.40.1

