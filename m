Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7581C695
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676965; cv=none; b=hS0JlJSRBD2w62xgceD3ZP7NN2Cy6Ow5xY+e/eiJQ8+oZOx+LjoMTiydhuHKJBCKq7NTgIwVKNiY2hB37TSTuifv5Ot5QdeJTH62QF9sQ/+jtKu++cEWE7B+iwt5Rrt44oSPEb2nLrNo1fZnjOLVuUW7Ae9+umqAxYmfJj4CoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676965; c=relaxed/simple;
	bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iePSU5OhfSIOiHGbwYpQjBTeW5TgGgWGKxm6HXPrMQtJND1TfIOXHuUbi8Z8icbd/r698mtxKZwiqWtnGEW5B7bAOWRhIf4YMauc0GZEFdi2CV8Ss3zk3UiER2WEdyqL+biNVQK4QQbvygp2xj0PYXbBveIO0RmJ/FjkK6XISr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc97+8NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc97+8NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F11C4AF11;
	Mon, 22 Jul 2024 19:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676965;
	bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nc97+8NWWpoVSY7cPexiOgN7EKjrAgooZcQJ9tepRo4tdOPLjloSlu8qXz93YQ/z8
	 HG5u0ZxJMoDIQp1mhaWM5c2BD+a0SLRUAnijI1KH2Lml2BAUjQjd+w7aQY78ExGMM1
	 XmRyj+VtQlKmi2r1Z4hS1zUWrfZoz7c+/17WSbsTl4vdVJ5wgdfG/MRDh4hAhRdggN
	 q6ktoAje3gjQf+Z8VWt4VkJgJCVaEaoOMacMo2PMuIOUuecdLAGvs8lKzVe5wPiFng
	 krhs77LIFxDVdbYwh9U9SQK47YQ9mAC9vRxzjuJwZ7xLsGb+QtvfJNzqOXm01oNbhE
	 O9P6NTmQ9APNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:49 +0200
Subject: [PATCH mptcp-net v4 11/23] selftests: mptcp: join: check re-using
 ID of closed subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-11-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSW+cAdvf4D5IyehLeTETSDs9tfDOgT/QF5s
 zLEwrOysxeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c1ZYD/0UJnM36C7IodNC5cjll8iLRijfae17zo3fAo0a6IezsieuvjzwmStxIIhYJwD6zipIM9k
 SjIizuDNy2YyzTBbZ14vMDC42avWB0xkHfsrc37SE3yo7cCm2ifuJBwn8DEwVlYmNW/HMufXJQ0
 QA5QLpEePZ8dmWLpFoUsDQZUfbJJJAFDRuWnQzSqPjhBNBDdXVQaViQ4sTJDzgRlkJOyE6pR8PU
 QSxgTMJiC8tPw0DiPwM5lPJYwOqIPOkRVb5sT/iqM2G2tuL6Llch0KiwRiOts38wl5+lL3LMUDV
 17KVd/9AE8B5dFwsA2iFYSxvqSad+qoG+NvAeYUZfzdWTpXnwwhbosgUZctbQGJoNCgvJycfMZ0
 KDPH6CVzBPvYAvKBy0XftBAIVWBMLkxYGMSt2m/8GLFZCO5Ci2i3/kDCynkJirIKQ6vBwVejTv5
 GLFpPt+SD+zLJdZcXQ26340/LiX0YndOd5AnAcktDOG0XGgL+WeMmumsB3BoGM5tmPO/6vbYwl2
 cf09Bd+GRwtHy+LWmxWDlDoMb7XtIwXkR3zKgZTXRDjiHX9f9WgysFFfjW+tmd5m501EiHM4pTK
 Z4EU0qgoTH7YVbTGAjxr4srHDhOFj4lihVEHwyD+y0K5ARh+3W+H/N3aBrNF52RV7+hiRAS4G/i
 nHVkRBbUq/NSm8w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit. A
new 'subflow' endpoint is added, but the subflow request will be
rejected. The result is that no subflow will be established from this
address.

Later, the endpoint is removed and re-added after having cleared the
firewall rule. Before the previous commit, the client would not have
been able to create this new subflow.

While at it, extra checks have been added to validate the expected
numbers of MPJ and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b4dc5f2772dc..c5aa745a36f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -436,9 +436,10 @@ reset_with_tcp_filter()
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
+	local chain="${4:-INPUT}"
 
 	if ! ip netns exec "${ns}" ${iptables} \
-			-A INPUT \
+			-A "${chain}" \
 			-s "${src}" \
 			-p tcp \
 			-j "${target}"; then
@@ -3527,10 +3528,10 @@ endpoint_tests()
 		mptcp_lib_kill_wait $tests_pid
 	fi
 
-	if reset "delete and re-add" &&
+	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3547,11 +3548,27 @@ endpoint_tests()
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_attempt_fail $ns2
+		chk_subflow_nr "after new reject" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after no reject" 3
+		chk_mptcp_info subflows 2 subflows 2
+
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 1 1
 	fi
 
 	# remove and re-add

-- 
2.45.2

