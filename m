Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1A18629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038218; cv=none; b=W8SUol6nmismWH3oxkdCrW445tgy8rNjpvzZrWMJH1Qf+6V6l54cxjLttfNZ4he4aiug0fHkZah57J1ciXmtwvWMXCAySLsRTZqR5tS28+pWsRpFyBlgiIU4X/M6Vatj8PPtZ7DuwknLcKn37TD94uGoS84Xyz5KvVAWU2rgE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038218; c=relaxed/simple;
	bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMIMmunvzlFfZNPQuZnzLrXKEKAHm4tqF56g0gUbUPeYiMmX7M4485TrtGU5kMlPbBTMfpcmhf3ph5ej7SCcaaLC+3G66vZfp1V3YXYnKYhNAx/mjJRD3WuWIDuvSaH2ysVXoMqdcG4fOLS1bLlqjhWDUpgSoJDitei7syRnjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz0OAtyu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz0OAtyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B793AC32782;
	Mon, 15 Jul 2024 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038218;
	bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gz0OAtyuQWHYlJ2HeXG2M1NVNBNnI72IhmIV1IICkDlvihojYJJbviaQO2TQGYuEk
	 3QHLFldTRG5SBmP3InoZHPjADLlix20Rb512FWbnWBAH7yWzz5TqwCpqBzn3ucbEDQ
	 0EldMLTw1ociCEuEofnsaudwDsoAGu88HtB0OxphXu8dDM4yQvXmaVDKqSDEI5HzCy
	 4zniMDYfkVv1MtRqVa62rn3orgE3QkhkPJ7f2+WV7XprHJXHCEAoVZIPLBB4s3S0ke
	 Zh6i6OxrvjQAwwHLiCZsZbuXzg89SCiM0Dd3GbKvU1lO/AW0MGPhwAYRxl3bvVZ+X4
	 qJkPhhTdw/y1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:51 +0200
Subject: [PATCH mptcp-net v2 13/17] selftests: mptcp: join: test for
 flush/re-add endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-13-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3x000Xp/L5fV02vhR1bitCmjmqTb1DZ9Sf
 YcyaEd41CyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 cxD4D/0UFYz/WHkW+G4xWsnlhej9qcyVARau+Q3syItadGawhwXmpJqVNm0Tf57KRmmA3s7PN8i
 dkp3AxtzigrYcbM2o3Sk0a4EktPFe+uNjso/5IRySkug0YrLd85vzQ+0CUQqP5vZpfFknl/nU7m
 XXDvVrSdf+ah51akPXhNZe+hMsCQ9XhydrF59lUW8o7Fjq52nlpGq87XPps/41ZuVvZLvb46lLB
 7pgsGEEOlmC9C9Xw7jYhic7qAIpnp3HjBKaYfVR03zTYmDIxuLbIvuT4WVNtSQRFMsFdhKTf2Rn
 GV6NSH1ZssguDNndh96J1Iu2xuMc7drfeDEwgDXYuc8jpD43/lCjS5Gpgair1AC86L/CWi1osLh
 Cws/8zkTBqkndwUbDd8RZpL11asUuhkIBICA50FX1OsLMc9+OOC6hr/AXpnSoQOEpj44icv/7su
 ZC6/9TSyuZeYKXTvCNvZBm+4xxe0ITPH+9WOhFR/1fl1aRZGeX182Xedk5FeNem3eUKue5vqCyX
 x+vSnHmflKwni10ax8hf+c5Tpr47ayd4zYpbqZpCIVrQIqb4uu9jea1fgqYAEweXOpHTzkchfkl
 t3WmqTt5QZOpJCwWR9y/X+UXWdiY8SxlQQzObC4egbGPRLoys1Xl2SioU6w8xUhbTR9XQY76FHW
 g613qUL3dBGKfqg==
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

