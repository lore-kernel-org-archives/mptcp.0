Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75903E7BC6
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408399; cv=none; b=AIJ/qhZob3+NmWdBsC9SM05ShHNwxW7ofcBhOmkudHx3fDJs7ZWXtlFYMTnW0DMT+hhq5f2l0M3swtaCJKDd4lGz61pBvuP+tlpuQ4JPts4JRQ5qaPsT2lkoQBpX7TOvbcashXAa8MKVG4Ta0bNzZg4koI0cm5ZJndUEbPdvsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408399; c=relaxed/simple;
	bh=8E6VPd4uEksxZmi2YU39PC0mkOv+VfgVb8XjOJCHqRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gNKLQmKaOOO3mS2fQSlwPmU1Tincd/cTeEkTymxMw0TzNmE71HhRVLQ34UVTQmSi7NFPZM27K/by7jS2WRW/OLwVdJpiaG5xs0DUlBWhYeMw4e3AZVvZ9Ubix2T2T2g3DsUp3BDvtEdFEbB/ElcfjBz7E58OhBqqhiH350vXKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VstEvC4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VstEvC4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24E51F000FF;
	Mon, 14 Sep 2026 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789408397;
	bh=LWzQ2e8fOMdPqT60SbMyZTg4nKRKfrKMwNGs074zo2E=;
	h=From:Date:Subject:To:Cc;
	b=VstEvC4hafJH3tLd3Wg4C6utkYOHA7ITS72p/XZlF0MR/YDUNjwqouPQ2fFGSMHsv
	 hkZlb+QcivNd1gKCR6qT21Kbbbzig6SQmhhM7LJzKB3ZJX1l0c3cF319vZatMgBNBl
	 AbtbCfydd44ZlPku7ifG271lTNr4BkNYtsnfkUq2o8b7PEarElYDSBqmQplJYWfAiy
	 lcuY9v1tAA2IFDs/5+CCfmRe2+vVKjJbdokSTwKiyvrXwC9v/06dMNoOv14ImnGbOa
	 eLtSY3i3XOdDothqoyMNduWrUpHoRC2/CV+Kvq+pkB7bDuyAXn7dOuJlkeWQsQqgQh
	 q/jRMYcFOXeVQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Sep 2026 19:53:07 +0200
Subject: [PATCH mptcp-net] selftests: mptcp: join: dump stats with right
 title
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-mptcp-sft-join-typo-ns-stat-v1-1-30d5a5802b57@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBCF4Vcps3YgDcHbq4iLJJ3oFExCZhSl9
 N2NdvlzON8CQo1J4Dws0OjFwiX3GHcDxLvPN0KeeoM1dm9Oo8NH1VhRkuJcOKN+asEsKOoV3RS
 sSSYcvDtCF2qjxO+/foHtmEnhuk3yDDNF/emwrl9TuCBCigAAAA==
X-Change-ID: 20260914-mptcp-sft-join-typo-ns-stat-4db20f0b7a48
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8E6VPd4uEksxZmi2YU39PC0mkOv+VfgVb8XjOJCHqRI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWmPQsfdCzbLMu64nzy9PUvm59d47B0Sdzikf/lnluM
 wXD3N4+7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIjTjDb5bK7IcPtlgyfjw4
 oVF9Zs7R9edCtggejf92unjmgT1fO44zMrzIOvP4fJd4fUq1yUuft7/2rBYRrJs7w3bHuqR7G2J
 7t3MBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This fixes a typo when dumping stats to print the right netns.

Indeed, the client netns was hardcoded instead of taking the netns given
in argument. Fixing that to avoid confusions when debugging issues.

Fixes: 658e53141780 ("selftests: mptcp: join: dump stats from history")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b16e24418e73..bec499047e06 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1163,7 +1163,7 @@ _dump_stats()
 	local ns="${1}"
 	local side="${2}"
 
-	mptcp_lib_print_err "${side} ns stats (${ns2})"
+	mptcp_lib_print_err "${side} ns stats (${ns})"
 	mptcp_lib_pr_nstat "${ns}"
 	echo
 }

---
base-commit: 060af37701a3aca2c02cb5e874d740be6acbf1a2
change-id: 20260914-mptcp-sft-join-typo-ns-stat-4db20f0b7a48

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

