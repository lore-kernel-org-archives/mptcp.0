Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D03C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497091; cv=none; b=J2lSsDrgU08iX50MiT0tedY/8OZ2A0T9NrmjmxKLBNTItS+ti3H++dtwTLN/hUvdBwJpkcTzPf28uRir/p96/IMmRYz0AL26eqcXgOzbAg9IjjPo1Q1JXWx76/6lv4iXO/fB1sI/k5/PZmGexjLg+NFZzhG1DSwEukfE93vL9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497091; c=relaxed/simple;
	bh=222RzXjZJA8AQVKDVGycSKBUCPSGxv8k+PUvCTbYJ00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SU3OwN6jiDy8k0DBdgCHj8NidiEYBW4vD3DpackEi/YDSVzCJ+T8EmJSsGKteOuSsvDUXof/YrAN4bknDGd8usMSFiGB/Dw2h1aIeraRg0aIiJk73z9FFBmT41qWbn4Smj6Xu3f4rqH2Y3/YazoZS45eYgK3tc9Ad15LslEFLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU5+/YJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU5+/YJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA66C433F1;
	Wed, 21 Feb 2024 06:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497091;
	bh=222RzXjZJA8AQVKDVGycSKBUCPSGxv8k+PUvCTbYJ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bU5+/YJMwzgXuf+O8hmG2Lyw0U2tRhw3xBsJuAafKOdI6hDQgJpoWaI4ukJJ4rTiR
	 96DqObAXKG5VUYzMVQX9QvBdtMlFYgErIZrmFn0Ieyo9P/UXc5d/gQi+cxQFzVO4fs
	 up+cPqf+MXn1rOpaBDEJsvNtUDcJzWpXSUVG76c6avyCqHhVnelKFkwPob9KK9/Lql
	 jfiUaZjN4uHo/UNlIoKaoEjgXtr8cWuxtT8fCnBJxOA//ceYQPpRu85XuX60GHtI97
	 9usMB1YeqaffpRLyaR1DHbMuvo4TpRPLM8DSRbNxA5mWqx5IG6YsbWbx6ijF0KPEkb
	 nfqPgKUo4C94w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 8/8] selftests: mptcp: flush userspace addrs list
Date: Wed, 21 Feb 2024 14:31:15 +0800
Message-Id: <bb5e3f97c4a225f616d82112570514114fce00c5.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aedc5698f26a..9f1476f0e2ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3374,6 +3374,34 @@ userspace_pm_get_addr()
 	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
 }
 
+# $1: ns ; $2: addr
+userspace_pm_flush()
+{
+	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+		local ns=$1
+		local line
+
+		userspace_pm_dump $ns | while read -r line; do
+			local arr=($line)
+			local nr=0
+			local id
+			local addr
+			local i
+			for i in "${arr[@]}"; do
+				if [ $i = "id" ]; then
+					id=${arr[$nr+1]}
+				fi
+				nr=$((nr + 1))
+			done
+			addr=${arr[$nr-1]}
+			userspace_pm_rm_addr $ns $id
+			userspace_pm_rm_sf $ns "$addr" $SUB_ESTABLISHED
+		done
+	else
+		print_skip
+	fi
+}
+
 userspace_pm_chk_dump_addr()
 {
 	local ns="${1}"
@@ -3518,25 +3546,29 @@ userspace_tests()
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
+		userspace_pm_flush $ns2
+		userspace_pm_chk_dump_addr "${ns2}" "" "after flush"
+		chk_rm_nr 2 2
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
-- 
2.40.1

