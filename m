Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4A369234
	for <mptcp@lists.linux.dev>; Mon, 23 Feb 2026 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872412; cv=none; b=MDgxcl/zb7LNSjsgoKjbnOJzcvmjXFp2lR4Ql/ZL/tKh1iMGRncSFsyA3bbxxes9NfQXKDu3qb+WrI7D74XEJMmuTUnNXy/d3g2C8HYBR/DcG8V5hcGhitnLQKhi3yeDiM8ZSI4iK/OKbs9t0OaLuU1FoC3aWuU3ve0zGque/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872412; c=relaxed/simple;
	bh=zm8Ec64aTB3ZSnJWaq2/yHRD5An8Bq9Vo5Y4t8jAvn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IKaK44GaJcAQw2MDotlGlVkhS3reAvzKryeZbZQk88kYuFo1YuxHYeJCDetxrD5+ET5Su5AA5BC9yN7OHZLVIhW+QU8J+IW3E8rU32/f6gsYoHctA6MJXJiik4ytBGJwVQn4q3ShPMUvQwAr2KaDdF2GLDwtbEl01lbmLHPIkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPBjpmHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPBjpmHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A0C19421;
	Mon, 23 Feb 2026 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771872411;
	bh=zm8Ec64aTB3ZSnJWaq2/yHRD5An8Bq9Vo5Y4t8jAvn0=;
	h=From:Date:Subject:To:Cc:From;
	b=MPBjpmHt0OwsU0UK+Wo/ayyFiQ1oPQbaUapJR+B3h16C4YFF1o+EGk2ojnAM6Pg/+
	 D/m30YFamhCE1y3eVM9illWFh3ocWCOdPy4n7LhzbXgr1cd+5mzbDOCihSFlPG1tUt
	 FaUjkC79c+DpaNcKtSskPK4EI8pc0IILtESkCO4b4zRQN/fCmq6jV/G+J0e7NdpO3n
	 bp10vylB8CYJc7QI3U9x50Oc8+LNPxKf74DQSNSgFf5IBLCIohMC5ztCoYDLrYJO56
	 mOLvpSp3VkyF28AZcYYVQmK/zo18cNpLjLNXmgsstt2hyPW1z40BkpbCsM9EMiYBPp
	 87pcG78dtxC4Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Feb 2026 19:46:39 +0100
Subject: [PATCH mptcp-next] selftests: mptcp: join: recreate signal endp
 with same ID
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-mptcp-sft-re-use-id-v1-1-ec648a8bda22@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI6gnGkC/yWM0QoCIRAAf0X2uQVdOaF+JXoIW+/2IRPXQjj89
 6x7HIaZHZSrsMLF7FD5IyqvPMGdDMTtnldGeUwGshQskcdnabGgpoaV8a0/j9GGGM7eBbILzLJ
 UTtL/1yscQebe4DbGFz1Fxa1xAAAA
X-Change-ID: 20260223-mptcp-sft-re-use-id-c06c69316205
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zm8Ec64aTB3ZSnJWaq2/yHRD5An8Bq9Vo5Y4t8jAvn0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLnLJilar63cJEQ38XQDtMC9pmCG0099nzQviL8e++z1
 EdXha6pdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkjS/DP/tVXv/j3iXdXR49
 n11S+S7rsTXLfbxXPFhSltaeG1bM5MDI0HrwwqF3Zj666xaK2/lKNaa90Hdy2xTnptfmPv1b+yN
 JVgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this "delete re-add signal" MPTCP Join subtest, the endpoint linked
to the initial subflow is removed, but readded once with different ID.

It appears that there was an issue when reusing the same ID, recently
fixed by commit d191101dee25 ("mptcp: pm: in-kernel: always set ID as
avail when rm endp"). The test then now reuses the same ID the first
time, but continue to use another one (88) the second time.

This should then cover more cases.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/615
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc1f200aaa81..e22ed8cab27e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4294,13 +4294,13 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		wait_mpj 4
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 
-		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after re-delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2

---
base-commit: db54d4a79a413b2702191c0dc1d855bc3c9e1a98
change-id: 20260223-mptcp-sft-re-use-id-c06c69316205

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

