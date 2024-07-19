Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634C84A4C
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391889; cv=none; b=JZOluwLSl0Dt4IaNBzacChLW/KBnV99ajdL96WP8SJgWyFvXTYKbdVFuXSUH0zA3CuqlON2Rqk5o961bOIpnpxA2FmpZo112B4kpdYpjMjtNH6L4vt/220lOlLz6kSAhuoUbF/ZJzHAbmWNHoMgSRoVjzbfm3PzjHlJrY8xj8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391889; c=relaxed/simple;
	bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amTZq3vbOuj0SncZA3AgwpB3r0DHJNoZmYXxJ29MZPvvvIB+f0tClXxTBI3ExIXa4ybs30KPmqNMszW6oJ2DmfrBbIovkhMFop6fcR1MtTyLZ5zqhhLDeJ24RJa1TT+NaJTlrebXHG1RQjNxUE/DtSFoezWdatkyYUQyJVyhUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB4jpnIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB4jpnIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA28C32782;
	Fri, 19 Jul 2024 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391889;
	bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vB4jpnIrNN0a/J4aMI30aaYxVyz1PmKvHKukoKK3rFZ34t/eFRdcX8dvLSA8Yq62H
	 zvkdJItpS+IK+belij/+h3DI5qkVs7jFsmsT2ee7Ohvq5KN/9BZhmEFS7XIXuKen8r
	 w4C79GnHkgNE/uN7Ms0QUWr0llunp0ulTfeBzL2+feuXfmhnqcuE6ErIUiMzeJ6a8S
	 t8Y6eihv+H1wXv4YuWGSCyvqw+NylwQv12fRNUICr8qLMY3DNyuA4qLlAGnhw1D7UC
	 bCzb9FSXRygQmccA/eGp+Kc2QlC+OlX9HBk1ovckdbD5JQP8Ce7t/hqAh5SGT8Vzcp
	 h69uBZZkI+PSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:24 +0200
Subject: [PATCH mptcp-net v3 13/20] selftests: mptcp: join: test for
 flush/re-add endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-13-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsA9pBfFYYBgYdfslFZJLrB5ksBw/WPoSewo
 OLiYhyDVu2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c3ikD/43KJG6sdoy9hYlMWzGU99Z9nD3lUGwo2ouVN5iQPU+eMeSY92QQdaR6ewrxNVZAT6KUKu
 R+1PwxlP35lTCqihAxygq3WynrgtCZPswkGeGrXE5BKeu9MzNXeCDmTyHUr27ITbTnmHIbrTtYU
 XJ7t2hCbJ8fui+kxTq5hSAnV+bXsx+1jJ7BgB47bbYpR5Oop3bnsFAHLTUHVnXCKTuKgcVEMbPB
 ARgWGZXwsZem9npDQzeWzTNOrzMu07pn5WCwTlwe81Fi3RSCOZHohZM+Uc3GMMXvYuqxhIEccO9
 MsfXdCDj3AFV3RC8swYLqqvKeKpyxT4FbHXXCe9eSWya7Lg2I9B6halIg6v46IaEgzoTB+1VGo5
 U/MABEVKtyyY8rRBt1LokeA4wIR+Jjmayz4FjAjtCIAjptACAUe4I6TbdYRT5aKNgEvbwJKA2kX
 nWGuXERr6p85a/eAvqLmLxcTeYLWxLwhLSkL8OWzCq7T5gd1HhSDoc+k3v3yaW1ahwOqJy4YM1i
 ltbhUoBD+xrU9IeraWjTCx3i9oG7sJqDGXPyQl5i03XlWUV/nsCKx1sEQAMWd4OH5RhWdHjPYRh
 ffYDzPG3vk6bk8TEPymiE2os81+7uTCCblyAAfCt1nu623KkIce1URYbvs7uJskLJsYMKhiCjUC
 EX1ElFHOmu2OTsg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After having flushed endpoints that didn't cause the creation of new
subflows, it is important to check endpoints can be re-created, re-using
previously used IDs.

Before the previous commit, the client would not have been able to
re-create the subflow that was previously rejected.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c5aa745a36f5..3565d8b48125 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3607,6 +3607,36 @@ endpoint_tests()
 		chk_rm_nr 2 1 invert
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr "before flush" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]

-- 
2.45.2

