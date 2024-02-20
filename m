Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810225FEF9
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423132; cv=none; b=KAV0LNJjEGOat2VyUdkaEhUmwxJfaV/yeYi94usZr/VooWGNOoT9gWngsc+dn139DKHOxNnjV3jNvQqd4nZIIygWQ8As9HzohgjM1F6hHXUti7Ombj6gqgE/3ekv3vJl+etT6dcKh6J+631D+REs03w/B0pdwoL/I8q2Mlzxov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423132; c=relaxed/simple;
	bh=NW0lHymhhtRDVJzF4WOMpbUgljVvmUlQ/S3qcGjHyJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1cAgaaA+OySyJtgq3Ndazp6NafNV9XTgUnOuT8FD+wEfyS2AY7LpXiQRJS/cnTwNeORKW6MlGWY/+QwMH4J4T5UfZPQ9ZkWKC0aEBGZtPd1KoNjrUJLkrPHblO47c9irHRD5m1b7o1Mkikf/9G/eCX3eBbGzmRhTMS/xFljglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1+iEEFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1+iEEFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A83C433F1;
	Tue, 20 Feb 2024 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423132;
	bh=NW0lHymhhtRDVJzF4WOMpbUgljVvmUlQ/S3qcGjHyJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1+iEEFOPK60lzC525C2r7MV9WSZtK4ytOQZEMZhB7ABFtlcji+W+Hv5m5bDZzkG8
	 dA+oEhMKx6ZnwiyspTpU84RdlxzQkBtf8IY9veq5EpAhn8JIkzLfVm0QkWGPOy12Lp
	 lchn4t43PHaX7cc/z3g7hso6oxKu9cHsL6PuuojNo7ee0c56vHd42xtNbcGYueAXPa
	 VeugfkP7q8h2Gw4QUeSQaB0jKad1/Q8wyThJD+f3QPkSn8G9kkmOipup9ip0IdaXU1
	 pOiMcpA4dH0xiSD3LAnLcY+mXdNFXuvWn3eIlWIpAihTVfq3+loEKAVKOZqd1EcF0i
	 f7NCwdyagtTgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 14/14] selftests: mptcp: userspace pm get addr tests
Date: Tue, 20 Feb 2024 17:58:28 +0800
Message-Id: <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9bdf2b535e87..aedc5698f26a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3362,6 +3362,18 @@ userspace_pm_dump()
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
 userspace_pm_chk_dump_addr()
 {
 	local ns="${1}"
@@ -3377,6 +3389,21 @@ userspace_pm_chk_dump_addr()
 	fi
 }
 
+userspace_pm_chk_get_addr()
+{
+	local ns="${1}"
+	local id="${2}"
+	local exp="${3}"
+
+	print_check "get id ${id} addr"
+
+	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
+		check_output "userspace_pm_get_addr ${ns} ${id}" "${exp}"
+	else
+		print_skip
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3471,6 +3498,8 @@ userspace_tests()
 		userspace_pm_chk_dump_addr "${ns1}" \
 			$'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
 			"signal"
+		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
+		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
@@ -3501,6 +3530,7 @@ userspace_tests()
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"id 20 flags subflow 10.0.3.2" \
 			"subflow"
+		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
-- 
2.40.1

