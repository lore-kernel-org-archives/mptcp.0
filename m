Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BEEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004129; cv=none; b=BqOSx5VD20FT1XsY14gBOHcMaq9APGqhNpeX30TWxLWbXVf/hq7LYPr/gIqA5kYFHD17nJnv2RPRFkpRxuWZmRBLi3pvJfsxpKmzcMhJj/f4QXfLJDuEpwaKAsHbxd1JA70smRhF0w0mDw94MBMgJjo/JRf0TXj8jUDcGOkt2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004129; c=relaxed/simple;
	bh=7OL9zvu2u9aLyHzCDngnpG9zPMbwRs6yG2DXD+ku5gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiXjLvgL2j07h//BnxlnJ6u20H9cYKncBFqUsw3VgZQEeBIx2WoKFBnnPg65rPC0yZms36uEMF+iWxNCkMZegKWPSSHdgSGAFNSRX8BuchANAHq385oIUuO7ovB7nvzsiqXcsL1+ir1F2de9IXqFk9+VCdESPDpgRrTFBqARfCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha+h1hHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha+h1hHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8B0C32782;
	Fri, 26 Jul 2024 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004128;
	bh=7OL9zvu2u9aLyHzCDngnpG9zPMbwRs6yG2DXD+ku5gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ha+h1hHnE9jyRJuzhddilhj4xJAA/BLEMsVlYCIhcBcjuMlk2A7nkTU9P3R038rSH
	 SoBVPBSQZXHwISOJ/MC4BFcah3aZkfyUZlQY2n1APtMiiQxzycOKCQ5HtNo/mtr9lF
	 rhTUpV9RtDkZv0u1v7xvgW7m2SgGjveADQxBySOTu3T0x7itzZPL/sgw493xnBNk0O
	 GS/1KgmaNKSqJWWCo+E32F/502yLHaIr9ly2YAA9vpOsgSxAFN1XJiRXj/fUdXL0Le
	 WCJ52Q9ob+6Us0YeKyj1RNsOno0gBKeZZXjyNE33taq14/2s/fG04I6Jh3R27UhNGk
	 n+dR+1qf2iBug==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:28 +0200
Subject: [PATCH mptcp-net v5 02/13] selftests: mptcp: join: test for
 flush/re-add endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-2-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7OL9zvu2u9aLyHzCDngnpG9zPMbwRs6yG2DXD+ku5gs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KbTkL+Y9BDtm3OhlTggcDz5BcloIjFqjlGE
 7PgOb22PhWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOymwAKCRD2t4JPQmmg
 cyKRD/95klQg8SG+DYyLytK424doIJnBQOzoFFS4w0Aa5VDSzK4AWqAtGyhFWp9IUtX3EfRbitl
 xwVOV09BDPcttYDnSQw8YfENG6H7aOAG6FIDzMpeUHfAkcxGEBE+pKQ0hF2wnZ4GK+weJFiMLHv
 +T9eqTweL+15hbRQhQBhjAsL5J4nW59Q2WcWkdgoiQ+63JqFBg5uUmTalF4CF+ofcJTde89aOD6
 yW8q2DJeasUFaVG/8j9Jnn3HbIK2uthv0Xc3fueAjXF1Rm1Zzx7i7/fIKdZRjJB42se1vz54Yp8
 OqjVF+6nNRpoGA/hQ24Pqyo18yGi7es3FjqwIhwAjypte/ImVFmgqCnxnM3I9nBCiz6WgydQw6t
 Q8VGDb3PCNlcwe6sx020MUwfQycWRFcD7Rb9aznUZdxUb7y9ulTESrvNetN1ETMWYidwKLqx5jF
 WjOisY6ZcPV68TVWOx03YUfMwTG+iVQGizIHgy8g8ETB8XpQCcX2HAKxZzNebPzL4D3vQJTxL8N
 AldMkFKP2mRmcCDRCQxDErKR/ic6QrLrWwTZLHHaAQ36ki4wnWqxfj/68vWgp+GA2LudJxtWuC7
 5DoHsWyar4eT7K1f1kya0EfSEgEdEV6Vw0gS7VGS0nX9ZIJ/CQp7yo9bUYcJGmlDmJbMEQQvzF3
 ht9IpylG3sFBGmw==
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
index fbb0174145ad..f609c02c6123 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3651,6 +3651,36 @@ endpoint_tests()
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

