Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68530AAB3
	for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586764; cv=none; b=TMif4wrM2PvB29su8Ne4/L4/wvcEwL3vcPXVzWlU90g6pXokuCgBCL1djM+6HQv1O0a4/CBErvow7Bqq4pn/HdWsVHQ0ntS0v+JqUDEs/vS+a/FPKLAQ7v9vGqFJ+opTiQf7tJcfCrewMwQxv+6YOOOiIF3zQ0QoRSWkba3G570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586764; c=relaxed/simple;
	bh=kYQdB8KQRFXXa9v895Q5Ur8/giutAWzYe3SK4Bs4KdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9gNkNBLdYVe+2jpZNJAwb933P8N7/Bz1SzCrGviN8pS387P9r4dzWZob7ZV/0LfhCOBTmtPo1xqFvOJuqph6JVzKkKQCGpHELPf7bJNwsubdgCF9/AIgT423UnZkLWqJ2jEX6+0t2qij8FS78w5ZLEoI/31AlJvLOef4o4lTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQUB/QBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQUB/QBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244BEC116D0;
	Fri, 20 Feb 2026 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771586764;
	bh=kYQdB8KQRFXXa9v895Q5Ur8/giutAWzYe3SK4Bs4KdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hQUB/QBY0jqXrHL3eH/mueb3eShJ2WlQKIcbhtfNRP1GmYZOIKMog4gvX64Y+wD0u
	 evEjORXeM5qXpkAIFhviy3n5+f67PFqtjXhGhQ/fHH781nTeKo1GojUm7yyWS0N2i1
	 gEhEnF9luX4ene7/9hHHJ0cwMhscXP9BJTAdcHSpcUDDwQg8eX0Ybhgwf4SJORCgsQ
	 FPW2VuWov+STw2HIDYFFKgAMQzlOAznt5iLw5Zmnz9h2B/Ip9skvYX/OGjNf6PKCoG
	 cchT5as5QPmWeLlIBogBMqraBkRQTFzBPFf1y/ET7pZBbbBjH+SxIGqabC7pDb10Wn
	 EZMQeocuniJjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 20 Feb 2026 12:25:52 +0100
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: check RM_ADDR not
 sent over same subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-mptcp-issue-612-v2-2-089684a6edcb@kernel.org>
References: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
In-Reply-To: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3877; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kYQdB8KQRFXXa9v895Q5Ur8/giutAWzYe3SK4Bs4KdA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJnuJzUfXhu3V+x3e9WTl/E7hAYyXpGJacl0z0/f9H5m
 FU/JhbKdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExk3x6Gv3IX25nmzPw+ccc9
 rzc7959b6tep4npo9e9Zz4JMbd5Xh8Uz/E8/0DLz93qBYzKCLH8mc77/y3DCbra5x52Ztwwe7f+
 XepcNAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the previous commit: RM_ADDR were sent over the first
found active subflow which could be the same as the one being removed.
It is more likely to loose this notification.

For this check, RM_ADDR are explicitly dropped when trying to send them
over the initial subflow, when removing the endpoint attached to it. If
it is dropped, the test will complain because some RM_ADDR have not been
received.

Note that only the RM_ADDR are dropped, to allow the linked subflow to
be quickly and cleanly closed. To only drop those RM_ADDR, a cBPF byte
code is used. If the IPTables commands fail, that's OK, the tests will
continue to pass, but not validate this part. This can be ignored:
another subtest fully depends on such command, and will be marked as
skipped.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: revert to original commit message, not sure how I ended up with that
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc1f200aaa81..058ad5a13d24 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -104,6 +104,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 			       6 0 0 65535,
 			       6 0 0 0"
 
+# IPv4: TCP hdr of 48B, a first suboption of 12B (DACK8), the RM_ADDR suboption
+# generated using "nfbpf_compile '(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c &&
+#				  (ip[66] & 0xf0) == 0x40'"
+CBPF_MPTCP_SUBOPTION_RM_ADDR="13,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 9 64,
+			      48 0 0 32,
+			      84 0 0 240,
+			      21 0 6 192,
+			      48 0 0 53,
+			      21 0 4 12,
+			      48 0 0 66,
+			      84 0 0 240,
+			      21 0 1 64,
+			      6 0 0 65535,
+			      6 0 0 0"
+
 init_partial()
 {
 	capout=$(mktemp)
@@ -4217,6 +4235,14 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
+		# To make sure RM_ADDR are sent over a different subflow, but
+		# allow the rest to quickly and cleanly close the subflow
+		local ipt=1
+		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
+			-p tcp -m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
+			-j DROP || ipt=0
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4229,6 +4255,7 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
+		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -4288,11 +4315,20 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
+		# To make sure RM_ADDR are sent over a different subflow, but
+		# allow the rest to quickly and cleanly close the subflow
+		local ipt=1
+		ip netns exec "${ns1}" ${iptables} -I OUTPUT -s "10.0.1.1" \
+			-p tcp -m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
+			-j DROP || ipt=0
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj 4

-- 
2.51.0

