Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734482A1CF
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806130; cv=none; b=N4fyF+yN1hBRkuv9J4kq1u35UYre0pObbu4RwUvCcTIEFkLO1ytP2Hfw78w7gNigHx8My+0h1eGguKxVmNqvXKb+39G1lIJ49SRxUKT86qBI4cRuhUk1ku/VMuhZsw8N1jAcrXkBN9M7TE8q8IxdjZc/kb9c8RlHjzCKPkyElD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806130; c=relaxed/simple;
	bh=PiTzOMgVE1dFUlDrqVvyhkaMMO3fp8l4gkC9UWV1y1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6UnzpWR7cJG9/yh9X4C+isQqstHyL5HiWy5j+0cGglQmeJR1DSHzbJjet97peMPfNcxXOUd14kQiRBt1Z1eCEkXstS1b+JPzxgqMC3/hZHkDG7boBCYcUPctmBhiW+tFVRlT1y4lJwGliWI399sWYxuPvbb8OqVf3knNDTJAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjj+s02p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjj+s02p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498CAC32782;
	Fri, 16 Aug 2024 11:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806130;
	bh=PiTzOMgVE1dFUlDrqVvyhkaMMO3fp8l4gkC9UWV1y1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pjj+s02pERy2xI5B23Nl1D5GY/F2H5uja69XCXuH5g8N1Y6e19i8zHVkrsSWvIKUt
	 Yi7xFDTryGcVAgrlgMgK9f2F6+RISrTmREYiEBglXK25EOjxAuUpGQ9ZC4yiyx8jCp
	 cPmJ7j7AtYsl9XJU8WLRTjFQdJa2ZbKqiIOr7Rt9b/Co9/RsyrSu1ibUsd9w83//ye
	 tM5gTzkQLfA+ZPQAFqNhRTXJym/08mCt5DXfgZrJBkeCW/RN+ANuSS2fLPnb4zCOFW
	 gKHPEXdQEb2QQ+FotLmGN/vAzrO2hbqJ4iwDXOCVp6In8i6EgkqbeBGlpR2GOFct17
	 RWTkAuBhxapcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 13:01:56 +0200
Subject: [PATCH mptcp-net v2 02/12] Squash to "selftests: mptcp: join:
 check removing ID 0 endpoint"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-mptcp-dup-close-evt-v2-2-8a33f6617f5c@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PiTzOMgVE1dFUlDrqVvyhkaMMO3fp8l4gkC9UWV1y1A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGutg8LhM0aJY3GYR11J7vOafYBfvfjrvmhK
 kPSvjjKGl6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrgAKCRD2t4JPQmmg
 c6XnD/9P/iiDyxBaLpUhoKxB4IHSBXz8NlsA6h9JzVHSNXT4rayX2E88EHw64OHaD0YeawxuAEr
 a6YjglxmRSS5I46y2edjlsBhgLz8tUxiFlarKbIIBRM+aOsLZ5w4kIYvmVC/1xzQeJUbHUwcLOS
 tB/uKo5FK01JirdnwXcVYDj75IghvDeIa9jkhFY9iWdeh+BK74YLfPcez0JVZmot/EIZnlmx+fE
 vmpmeETKCRCp4IDBUPUulh51BE2gIXKFOAt1Q48U861obaebv24v8PrmTznsBTg7dLJ3qNAIUe/
 YSA4VYr2Mc1gjYDDxIEJnwwaCYhbPkWOIHv51kq/tPVy/AtJK9BYfcQbKFBJ3Ru8bNkBdkNFpmw
 q/1Z7w6g3pcUQfJx5YU4e27SsZjBFucA2j90gehVOEYVlecCBUJ6P/LP15vQzP0y2Yi+qwj/ucU
 4DJu2bYKEoGEg5WT2snUYa7uA/0zQfQ1yxQF29WUiPK9phQSqtQKLJZo4B9BUVQx3hHpDM9DPqL
 /Swaah/wT7oHK2cyDxqmAMmQoCzk6NIF9F2ke2QHFA+uzt5nLRf1OJMUyLtjH4felyFE9sDrQc8
 4AiJOJohw8unl+GuWlQQaZTxR1MB3850nxlzobm/tZXXw7n1lkWBKOE3SDG7B74NL7rf6zhxZLo
 XyG2JvSeAp8GRaw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The original commit was replacing the recreation of an endpoint used by
an additional subflow, by the one used by the initial subflow. Except
that it reduced the code coverage, as shown by the previous patch fixing
a bug no longer visible with the modification of "selftests: mptcp:
join: check removing ID 0 endpoint".

Instead of replacing the endpoint 2 by 1, here an additional del/add is
done on the endpoint used by the initial subflow. So the two cases are
now covered.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 77b3a68bd8f7..0494610694df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3659,36 +3659,46 @@ endpoint_tests()
 		wait_mpj $ns2
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
-		chk_subflow_nr "before delete" 2
+		chk_subflow_nr "before delete id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr "after delete" 1
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after delete id 2" 1
+		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 2 subflows 2
+		chk_subflow_nr "after re-add id 2" 2
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_attempt_fail $ns2
 		chk_subflow_nr "after new reject" 2
-		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info subflows 1 subflows 1
 
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "after no reject" 3
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 2
+		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add id 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 
 		mptcp_lib_kill_wait $tests_pid
 
-		join_syn_tx=4 \
-			chk_join_nr 3 3 3
-		chk_rm_nr 1 1
+		join_syn_tx=5 \
+			chk_join_nr 4 4 4
+		chk_rm_nr 2 2
 	fi
 
 	# remove and re-add

-- 
2.45.2

