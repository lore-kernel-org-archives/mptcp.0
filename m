Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315F28371
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861688; cv=none; b=DJzk6NE2Z23fjmOT/NGdja3ib2TyB2XyyS8Ki54M1zoDbksQHuJJ8nxQo1impp0hm3ElICNIYl1b1bD03AKyw5qdHBwHNSfigKDLVLw8C5s02ZGJnwTjz8yrKFFcoYuZDEfU3J4RtkkT+cxO9U7bUb5HSwMjJSowf6filWTyIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861688; c=relaxed/simple;
	bh=m+A4F97lfE4LAijaKtWq1G0hWaPz9YVH/QNQ01k+zLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X4yU+kPk6YxJSpl8et7OcX0a0T+FcV9S5XuGU1cn1IsecDAYyechSJPMNslSzmu03jpEoGec5dAaGHHdVqvOWC0WB2nNE3wjZ61aFfdCZ1RZXa4aQgwwAkjCqW22PruKvySE7dyw0p2GWW2ERLXaEDf4fKnmHt/YGkRDBZ7tM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIWJdjra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIWJdjra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247ED1F000E9;
	Wed, 27 May 2026 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779861687;
	bh=UT8C6Zx2odFG6TqWTYN7UP8qU4Jc9hfeJs1QP+abT6E=;
	h=From:Date:Subject:To:Cc;
	b=DIWJdjrawyN6+gmfnjO5I01qpDCDai18wKSYXbjQKO3UJIlfG1C0TPamCA9DZnTh7
	 3sSLKdf+6bicQmHng2bHtSpLPEszO/Jc+C/6C8dkmRrssRrq128c54ONtQaKIjf/rt
	 FER66SMmNQnSmeZDLzKvzA5uYSu4U8c3HKh2+pQSENQ+4mmUXhNq3UpX9gArlMoQ8X
	 IfHlh0iZGbM00Y0uoihZMuxK//2MhMfrQa2/schFs3fXptys2jO4zihUlqu5OjiyVP
	 oyaQ3/j93vEYeGpqVtYuVTmfyPKQU2DKC/32is5D1UbjQKk7fnFLAZ4WQza3YhgagY
	 4ULIahGZ3O7+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 27 May 2026 16:01:21 +1000
Subject: [PATCH mptcp-net] mptcp: sockopt: set sockopt on all subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-mptcp-sockopt-all-sf-no-break-v1-1-4318be7b1e22@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBCF4Vchs3aSUgEvr0JclDLVEWybTjUkh
 He3yvLPyflWEEpMAtdqhUQfFg6+RH2owD6MvxPyWBq00p1q9QlfMduIEuwUYkYzzygOfcAhkZn
 QjHXjXHdRx/YMxYiJHC9/v4f96inDbZ/kPTzJ5p8P2/YF2n0BH4wAAAA=
X-Change-ID: 20260527-mptcp-sockopt-all-sf-no-break-ad14ff690358
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=m+A4F97lfE4LAijaKtWq1G0hWaPz9YVH/QNQ01k+zLA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqFoi1qhyGArk8CrhWD6wIZXr0gXTrJt0wIKGyS
 dc1sQAWGPOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahaItQAKCRD2t4JPQmmg
 c8lbD/wNEldNf7tEk2tpQaYD2Si9ymlUT7kdh84cbWPe+pE+Y3k2r5tV1rXNjtj1DK+CCyjzp6Z
 jKkOzPWHoiCwXFVwHQTQib/ssMTom4t1MhLu7AdCaHUJfz0UCHQ3quovIzjoEzPsufCrDHgn7r8
 6KT9f5eHIHKXM0ecuv/A7vYJ1yySxbIRUnXjfkkDqLN6zmWbFYZ2Bb8lQR+BnKB/KoCR6Xu1vkO
 Ntwu+qaI2pecehTL2/1lsOvNW14Vy4xB56uzzecQAV07yKh3yhL0Vs8To/jyiHRvOT2qFqf3X09
 behwjTm04tq1XsFCWuuWV74TocPTjO2T1URjcsgwGv9iJiSorJ2C69PWt8fvrf8VhPssVdKTo85
 6SoZc6plq8baSP8PlLrj7AWLHcxInCkX+NrdslJJZ2UmJXwr9WF82ozbWxGXK/Fhx66altcv1uP
 RKCAORXhJ1sVQQseQSSK2JCFtrpisbqC//98AY577thmiOwIio5xZSYhdAtCzV308ys8JfqBQS8
 It2139UNsfb6iIOwOqonlKqQp2fBYErIi/ffFh13gjqPk1dSXbSIGTYrKPH3GcHqErlsBWoQW0w
 jRwdBxaQoHhaeACto/rixI/1GhqgJs1yFgjwrn4lAh4Q0eKJkO0xl7ilp/YBM1PTF50gUM4CUKs
 Pky6WPXb1U3s2fA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The mptcp_setsockopt_all_sf(), currently used only with TCP_MAXSEG,
stopped when one subflow returned an error.

Even if it is not wrong, this is different from the other helpers trying
to set the option on all subflows, and then returning an error if at
least one of them had an issue.

Follow this behaviour, for a question of uniformity.

Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 87b5796d0135..bc2cded00187 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -813,10 +813,11 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err;
 
-		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
-		if (ret)
-			break;
+		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		if (err < 0 && ret == 0)
+			ret = err;
 	}
 
 	if (!ret)

---
base-commit: 19d4169d06892e0c451ec370292ec71fa6bd8028
change-id: 20260527-mptcp-sockopt-all-sf-no-break-ad14ff690358

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

