Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464E83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391884; cv=none; b=biHAWIbdbiuekzIZYY38YwwvShY5W1iqX5JWYIUG2L0roL4iZs3O6IN1nQdt+xFGYTnubbX4TTLQTd9/Dkt4i4U3IkedYzL2MaZZm59xW5gO1IfFp4y/aP/zCMg7esXeKbYVQoQBoh33BxpogABRypkoOytFAhZFnhVbRBBxbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391884; c=relaxed/simple;
	bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJOamUz4kLc4XDKuzfiRo8d70gsSnnpYhAZsnHskUJpoInHzWduimBr5/w+9VMeET+jTDokqo7pMLO3QpBHJNhEOvtNRw41xcWaAlpwrLA8P3oo7Fac5uBWBirBUy+yr5QSgmujnmKBsJ6P7QOlKeVUeKgqF1YGx2IOHEA9XVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWrUUBr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWrUUBr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93913C32782;
	Fri, 19 Jul 2024 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391884;
	bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XWrUUBr1of0GYzMEJs5T7H9iAdBhEfqEfmhshOMcRdLUjszkinhGFkk3oGzPpqcMl
	 kK/4BXjT3FGHqTRIqDqDjqJoB3/6D8R/gonPHvzaN4GL3T/sl/pB//sZv07B3V6zBD
	 tHRewWDSiZfAi+VOxB6vqG+ZInMUWO0+JSE2m7v4VZjzJq1weue4eV22MvX5hnZrRy
	 TR4BLRIx7eu1rSWXDvILc4EfboJo1TJ4JkHkPE981ZHEwmbpUZED0rg/YRmueFMSPq
	 cdL6Hr3TrviOHz6UI6dDMJ+aCOugdeFKxuvh6EcZzD5WRwEMvCxeQMdCqk7+2rkV38
	 jtTrPHWGyDlng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:20 +0200
Subject: [PATCH mptcp-net v3 09/20] selftests: mptcp: join: check re-using
 ID of unused ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-9-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/l+JEJCbVcXEQjizd1qEuALB/oD4y/3jlA
 Uq/zIv1zamJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c6GZD/90eaaxpsz0OB8aNCI1NDuj4iwVEAb+YNBBEWVt2fRvmVxCb3bdt0dAfj3eqp3gffIPDAN
 iJHEvy6kNmj0IoYPpQsi2Ch1/TkqFgNMxOQhQAr9XbIT5ODSnQBtm50O9+7VZJxvTyr5nnQkMPb
 FyxoBo8lzuZBHv1Hvf0umBAv3ylOOEEeVeS25qbF7Pmagsb/yVlNuHwsEz8idYCCufXSyJmWxMU
 Q8tXWGlg2ZKC1CbVANkA/zL/z+nX1UJIyRXt5GqW7uXqwmaUaH2badnC+N18UIqtmPejx33xGi/
 FFKeHsGQaZ/563wjbOVgcPGJAseF+tJFBhfcYM5dz3HOBBK8zJTe8lCJuFFHgHPWsDEh80mreiA
 L/iOu6kTAwCA0wgMmr35rTveMvftLwprzyXzX+kPkkA4QFXPpHyNnXl6nXgM7EMD+q1L0+PFfqt
 d559c1ssAumJJuBmy5elE55q6y9w2hIzbNL4m/+VktcTr1xdeZLvt6Pt48/2Krhs48iIqT4toNf
 nZan7am9SsjbAbrbMS4lhvTzmVj3s9zpSRre30anwPEu1dUFBqjKEwYOCeVnsp2vZV8Bla15ANm
 S1yTxqZZQ0qKfArHJRBCCFkA1XBGR2X9ij51/HW5CvYK5u7sQ4DVfNObdW3C0xBCGAKjAfTcThN
 ve1oLiRcVvwKrdQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d25ac561e050..b4dc5f2772dc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3557,9 +3557,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3571,15 +3573,21 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 }

-- 
2.45.2

