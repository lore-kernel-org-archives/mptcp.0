Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026FA1C2330
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765719; cv=none; b=PgIRlHQaHpeMh6QtbtBV8bsHdYpiqXCoQAgZ79JvCLFnU9cjpq3nr9fok/w5RVjnJGtCOyhuejtJNpQnovBa7iFqXdYGnaVU8jOHHUToH92rXEielbCxpcaz/hXhJM3Qt2O7QjyGDZFk9MyDDr9Z7qm1/A1YYHcG43qnSHQIKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765719; c=relaxed/simple;
	bh=VVrro10mqUZOcJaiRiC3g0dR3rSnbd42V5/CBv2bHcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+lLv1EY8PZpOlsaB8rTagieRnurBmnDEViUPwqKM3ep01dHz3PZsXvXbw2HvaAgoIB/lU+IUSZVHBu/dOjrHce5CKe8Ogfg3+07WQH1DJpGrVuE2iE4Z1X3KuCxFbfef8X3ZJhYDWU0ty+vYuopAdxsU1D3gara9xvLToAjLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6dWZLRK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6dWZLRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E13C6104A;
	Tue, 27 Aug 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724765718;
	bh=VVrro10mqUZOcJaiRiC3g0dR3rSnbd42V5/CBv2bHcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C6dWZLRKWk7xrVQ26op+Qd1FaGo38ZskDrPIj9tFe+9Ob9ykUOkSuVevYI9BSVFkg
	 ZWqa5YBPR7mPSJJt8f4qqtiCog8u5Vm+IwG8qbL/qgNRdFGebmxN3YOjSt09lF5dCI
	 7FCz4gwHuKTNICpND7EBXWWdDFCF0SXg7uO7GzK/ge4tC7H6JxBWg6Y2BmKAaaIOx7
	 2UBWI2V1QKFz9r6F9tkkaprmE1/RMnQTEQWp6H5xYlq6G2i+9/+kd8MQKp+O1DCsbG
	 36ME7Juv5kxKDFtL6Ke7fqiClphWuOBL3xUL0I6TtAlUJ/pL4LEmdKqVjRifofk/dV
	 7oQZdMGD0SZdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 27 Aug 2024 15:35:10 +0200
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: join: check
 re-re-adding ID 0 endp"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-selftests-mptcp-longer-tests-v1-1-ec11c05fe980@kernel.org>
References: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
In-Reply-To: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VVrro10mqUZOcJaiRiC3g0dR3rSnbd42V5/CBv2bHcg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzdYUQ8kql0PjuLvedVc91zXZSiOZMEYpQKmqE
 dKN2VxNb1eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs3WFAAKCRD2t4JPQmmg
 c34KD/9t6aVTBqq5cY86aI9cXiD4w+0uUEtdaN5Tz/uhkD1CxsjTNdHEUfuvaUUn4rTNHwjde++
 u/IDuruEwH8dqCsd0Meo0d0d6r3Ax2uSFwbPdnPcLjR2Hd6qC782hV+xZCUDIg/22/CSocOaYQ7
 H/pxxk6hqDEqKxjf2qoHYIOq4m6ciFg01uHwoVtPo/B9Y54J7KBuN/3kDmvAW25+2zevQ+RS38H
 TKommJhoWeSc/eqradq/jvW+D6TlsUWV+QCNSLnauIr4ogJ95z40ET3PY7prR87GqXkgfhuMnmO
 vOiqe5YnHuteyQvtyUvra31QGTVmf5KhJXgjvx2AFIpraktEw9h5zAhp5Yb4iDe/Ohr7mOaqj0k
 OQiKQIxxokpgitXVq0pOflehDlO2wIykcEKNvOdpJb4LOQBHHoivy85pdBSd4HJI44KRDTEGaEw
 3cMaw8BQ4L6gPYxQqMGoLlgLq47XMXIpBqqvF2mvvS+OFXBZJeolOlHSVb6QvkE4NAU92ceHQhi
 8WOC8s6qzxWbugO4heyPSyaP8LsS8xrRQKbXv1b/2iJ2jgNrYjKxfr3xlRK35KB1DAlzqIw11U5
 Qk4445qmb4dLKi6O+AUNKexuDz0V0ksUeBture28gcAl0wrby95ucMvBTcLL/WopmmGqH86fg5O
 twfN8b5d8uw4GjA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This will make "delete and re-add" MPTCP Join subtest longer.

This test is manipulating the endpoints while the connection runs in the
background. When all the manipulations are done, it stops (kills) the
connection. It is then fine to make the connection run for a longer time
by sending smaller chunks per batch, as it is anyway stopped when the
operations are over.

This modification is needed, because this test is doing more operations
now, and this causes the Netdev CI to fail, as reported by Jakub [1]. In
the logs [2], we can see that there is no more subflows for the
connections, plus we don't see the "read: Connection reset by peer"
message, telling us the connection has been killed. (Note that this
message is removed in "selftests: mptcp: join: mute errors when ran in
the background" patch, queued for net-next.)

We didn't see this error on our side, probably because we disable
CONFIG_SLUB_DEBUG_ON when using the debug kernel config, plus the Netdev
CI can be quite busy from time to time.

Link: https://lore.kernel.org/netdev/20240826192955.3dbb469d@kernel.org/ [1]
Link: https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/745102/1-mptcp-join-sh/stdout [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 321bc5caf7da..19abc3c1a7ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3685,7 +3685,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		{ test_linkfail=4 speed=20 \
+		{ test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 

-- 
2.45.2

