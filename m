Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3118629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038216; cv=none; b=tTox+FsAsrnwqUNeIEDS9uzrnCkDAmIIEtWO4rRNs//k9uyYGuaOhHgABQOA43Xt4pUyj4gU/iVkbZX9mgTpM92vt0tNtjuR/2K/UBM561Q7oxZRbfLfMlRcbDEcTNKLZgrMZxEzILOzpyx6X8LjvYkevzPCUomkqPFVYYYghTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038216; c=relaxed/simple;
	bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9qYnQg7N/cVcYNqz7A/K5x6/TijeW5NvYAErBgaO8WV7Zg8Onjfu3QfPgZS3ZCGdPW8tD9ldxz0aUb9hjZUUmgHlhYMo0r+TlhR/xMU1gNNTxWdxrs3ORPOqNw8ZVAs/BGum36EoiHSVXyhzFYkTr0/dTNB6UPnvxrxaYCL438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw63ZEM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw63ZEM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDD9C4AF0B;
	Mon, 15 Jul 2024 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038216;
	bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uw63ZEM4D3fMG/uQFc80JNSwVCYnPCLMiZ1Vdve/IWWq5wEv3k32qEINx7EVC0Q/7
	 AJ0R+yCmpZ1w80FMllYW5nXGkObXAB4HZhguev3dCP9kgYVmL18D2DPOBIkHdQGHy8
	 Z9sfp97Np6caIRBnx4xJ5qOo5/YV7ZZkQhn+n1NAUuw+M9Qepnv2XhrptnjPGq1YQn
	 UvP93UocPf2okGtXnrtohMTHdl0DXYiI4CS+fhwxEso0l8nxVDNecB21kXBg+3IrtR
	 n4n0BFa4/hG/ybAvYf4AQb/ShLFeELa0rGPzlJ8B9SFV0NgCzHHJAsakrOTHh8+akh
	 t/xhEhUO2AWAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:49 +0200
Subject: [PATCH mptcp-net v2 11/17] selftests: mptcp: join: check re-using
 ID of closed subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-11-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u8qIDXTTzowhUR4HkW0eiXruuNaZM+rGz61FM/Q9y9Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3ebkYUEph3OCgfsVBzjO+IcfyouqvUU3KT
 0YCbp18jP2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 cwgGD/4qRvZNjgtrWRhdes4uBAzfE5op/nq3Kjx2spNJESRCCF9FgzIdb0uxD9Tlvx7Fxz4rs9/
 HQOlAI+YWoYVmV8ptHg1SJbLLVe3DIJK7qtaF2md18Ij2/rRxlwDAG/VKdIAb8WocJgSOQWE8aB
 PyP7uNGOy8DGA2u9s/D0CPkgcPpNPg3vcHz6mxCJLQ920TwebRpNXu00bK2MGbz83pdhvWpxi/T
 EEdJ/niAZaYXhhqTCSn132WVgqlKELraAszLZMHCUGw8oliZN+Pw7xusy33oB6aD1vw6a/As0EJ
 0WDPyulKjK8oAgf4PArUbOcitCzTZW2LfBO2KbdPQen5DPXMPE6XbI6WsI9D8TPIKBchoS8qrT8
 AljnpWzdcISvQgobqv//0xQRf0+YHw2+bQH1XO53U1gW5wOJtHmR9LPkNACdB2ei5LZenIuh+Xp
 GC7dxnPlh8wNOBAMqzrMpZZkN5qcB8J1NhSCPHqnBDPWmf0NZt8gpxwoFwC3hSNeluki4wlVIfO
 62ahe1cbvpn8pCkANsDqsWIxvy3zT9S3yqWilubK5d+2lwhk/dnhOyIBEDVnsKUkHNOnJNG1Pfn
 cszDpcjQ/XU6EG4OobM1MacdOE9Cld5wD1g1EzLR232C5+zUAHZl4F8urAOxdGDmId49ZVTjt8G
 JeFdXOn4xZbx9Fw==
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

