Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7D33C536
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247102; cv=none; b=F2pYbnhRBLhPaKLTFdD4n0F0VS9w5TUJSrs1EtigPr11jUEUIwIjM1Fao1ea4aW2Ur/sxGo70da8cvnArQsqwFo5wImvamT+JbKCFxwhHltwEiMNi8KRiPzIKK9lc6JvMLMDV1aaoUoBywi+9PrpQORYdccoReNcG35RGGrgHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247102; c=relaxed/simple;
	bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=su7u5mSOQmxUAqdC+OcpWvcmx8oRs2/f/52E20SFUHiWIKQDHCLK+4a8Bp94lbZFDi4xHVZywV9ZWpJcbcwMuKqhKoFtvzkMi6oVgfudi+GUUL4PElDy8bmeyY95xvGHS0QKdURdxG/MpPofnop2eYQRTDvh27EYcUXjqgX7nCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAoWGLtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAoWGLtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD84C2BCB4;
	Wed, 15 Apr 2026 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247102;
	bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hAoWGLtLg+J1EgxBGqoygnYVZWByzFrlyL6P3zP62j9/VoZgaFm6Mb7q9qRIpMUXm
	 W04pcuxmkKjEtKZ3sviPnO+EeXNBrdFj3ETh14JJLCgKa6FuBMDEXLa6d8Ca2Hc0qN
	 gNscNN998hAX+l4OpDS2Wu+pSHeGzR8g4cqbFZfLcyMksI0ux3Epl6Y9pbjl+ajNcl
	 hORVdaa2vV+Hd6mgQMAR4Lj1YfguhNHWtBqNoQFMTGzWeU5bEfp7F0x93I1RF2Zs7L
	 tNHMMQo+S2ISRON9YBewZfe/3NAO4jXeDNg3Y8yW0V2dGb6stNqJMDikeRjpz+UVdZ
	 8Z7Opgt8pLqpA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:03 +0200
Subject: [PATCH mptcp-net v5 15/20] mptcp: pm: in-kernel: increase
 endpoints limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-15-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ+qZf2363XfnInttfvXxxHUH10zo1r72lFWl5aory
 58AD6nXHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZsInhr6A63+oL9hs1c33P
 330g1L+FO3hDm17yptDAizlnpKU8HjIyPFjaqH0q9qL2Paa5baeSn56I/CfqtGa+LMOU1l7rT/0
 h7AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The endpoints are managed in a list which was limited to 8 entries.

This limit can be too small in some cases: by having the same limit as
the number of subflows, it might not allow creating all expected
subflows when having a mix of v4 and v6 addresses that can all use MPTCP
on v4/v6 only networks.

While increasing the limit above the new subflows one, why not using the
technical limit: 254. Indeed, the endpoint will each have an ID that
will be used on the wire, limited to u8, and the ID 0 is reserved to the
initial subflow.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1480bb7473b4..c75a2c29bcf2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -746,7 +746,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->endpoints >= MPTCP_PM_ADDR_MAX) {
+	if (pernet->endpoints == MPTCP_PM_MAX_ADDR_ID) {
 		ret = -ERANGE;
 		goto out;
 	}

-- 
2.53.0

