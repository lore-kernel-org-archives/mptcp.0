Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDE1AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622674; cv=none; b=jHjiWtfYbdry90iTn+IidX2hFy6/MKLIIuwDrm4b0ILCGbCVIxDUaWDdY9irJqDb/eCmBEfoDEuo6Z0cuiXiLla68RQqAMVHRuC4VK5dwDSelEf+NLM076nbXJudK1ka9lZfvuWfpyXHlzQ6ki1su2Mrsa2ymzkLnND9KuaBvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622674; c=relaxed/simple;
	bh=p+Iln57asuVn1sxGEGudit793w254/OS5jvagw/jvwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dswMX6b/Q223apgjaXit8kTh6oWqORUCG6+vygjRRh3ktDkeXTav3j3629jkhwU1XCi1YEP00I+CuhCQWXB7MgaVNBcPiJmPZeDlWWQU1OGqNolGhdU6GyuDP4pP9d8kyQPIoseKQvBS/CosZhlzcw5BXdYqrbd+HRyO6AIolfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN5GgbeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN5GgbeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7807EC32782;
	Fri,  2 Aug 2024 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622674;
	bh=p+Iln57asuVn1sxGEGudit793w254/OS5jvagw/jvwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WN5GgbeVQ/VSNVcBCodArosSRMrQkDe9oljtTK54Tv6/uUCPLIY5U/JrVVaEUc8g0
	 ihB0zG6xwKMYr4+L3DqBnJT2eQ2MNiks3t9qy+FaR5uz2sJyHIPzVfyObulBVfB0BJ
	 TI4WQqAMHjiW92qLU3o+LHeXy0G3zRRbtNNu28lBy0Oud6GQoQR7sSN7L7mm1JfXFK
	 s3ZsJyKcQV3GVkA6MsDvqjURcCCORqnSgv0h56fL07jvWNcxpXfZB6k8VQOc81yhLB
	 KXlS/Y4+NqS3W5ePl0P5pV6LZ4W26JSedrhPHInEZ94+Za9cKsoRDc2eJ8gGw19FOt
	 4oSczszz0grwA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:41 +0200
Subject: [PATCH mptcp-net v6 04/11] selftests: mptcp: join: check removing
 ID 0 endpoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-4-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2915; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=p+Iln57asuVn1sxGEGudit793w254/OS5jvagw/jvwA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLL/7ejsF7vWxGYkFqf/TPqEdffHegRikW5C
 IrVptlJ0iGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 c/84D/9TY1mK6EE88dqOc+ujEJabmJ0NumbMrCKXOCjkg3LvcbNYUUmZFhGExagrwfQQjb8RbN1
 LIgm+Zn7nVAtNO+hFLWmyCTli413TwfuVmHFNlj7Z//PQfnXlpXkQhAjaKgTPUmMUnJ0mD7kv0X
 xBucH2F4kkKYHoCyaIHhfjBA0Ta8kliv+5olwTm4jMXqkEKkE+NN66Ivc9QLZ93dp4SjkSvdFhK
 nqJ+Xe+NBXrabhSmFclGXRc29AKJC5wG1NYoIDx/rdT1IlM0sDJEkLIRuwoVmY9DQFxg9OqmcaQ
 BVMYHcEngFgM7d5ygnyXEg4o5mHKOg6R3lik8TaxrmVXfDGM3Dg3f1WDrbVjx95UZPo9NC/53jh
 dN0wa9F8VgRHGfpM/WbPLcQfBH7gONrF7RFJ8GLbqvUeRmwhFvd7QFXZc9nlS6AZxcCFQqnSczH
 V5+46la92b5C6Y1o7w4QoIYj8CkwNvLBqBFah0pJJyWz/rbu5WTrfYyI1bnOL612D6rkenh62jU
 Wk7n12KIjqpzjQqru8HGgwIuxitJ3NQctGZfmMDN1Pc7/HHL4PpkBLhVDIE94TjFOzo2bhyt/Zx
 RtHiFoZw9q29EdhbmrETymBjjSgdYWUkq95kU/R5c5JWTcCOEdFXspLFQcodkhZSu9jdSMzB1p8
 kh1Z18wriG03qBA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Removing the endpoint linked to the initial subflow should trigger a
RM_ADDR for the right ID, and the removal of the subflow. That's what is
now being verified in the "delete and re-add" test.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01c1e0871aca..03d92852de8c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3554,8 +3554,9 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 0 3
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
@@ -3567,27 +3568,27 @@ endpoint_tests()
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-		pm_nl_del_endpoint $ns2 2 10.0.2.2
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
-		chk_mptcp_info subflows 0 subflows 0
+		chk_mptcp_info subflows 1 subflows 1
 
-		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info subflows 2 subflows 2
 
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_attempt_fail $ns2
 		chk_subflow_nr "after new reject" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info subflows 2 subflows 2
 
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after no reject" 3
-		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info subflows 3 subflows 3
 
 		mptcp_lib_kill_wait $tests_pid
 

-- 
2.45.2

