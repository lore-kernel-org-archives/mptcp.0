Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577D33F8A4
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876053; cv=none; b=S/wch+cdm0J4SzorofUwYiYRRfxlE9hyStrqJuewwb4xTZl9GWd5iffz0FHgIKnU3RNJQLXoi4WB2siNlvVIhvLPGi/IPfpVKzzTvNj/owiEO1DhSCI1jenvqh0xiFMxYNGMPmSzTjovimpqcaCx5TLCVbl9sYAiSItHRiHDO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876053; c=relaxed/simple;
	bh=wu+DrPmFVj8SMzi8BY9NKQEjf6TMjlO4jJY7sS/18DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr5siq+DDd5tSF8Sq2XsSCRgu8G82tpqGyYtvbCI5bE2rLNsDXq8dZICfIaCVUyFiidAdFDurzXJAiAh/M+oCki6m6faXeUl6KCeNKsnZwzXtd79+bOt500X1YTF2JoDA9rkxllQEpWv0FwS9ME5qdzSzpFMf3OHyncYLQ/Gz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsZ9GgSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsZ9GgSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEE0C2BCB4;
	Wed, 22 Apr 2026 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876053;
	bh=wu+DrPmFVj8SMzi8BY9NKQEjf6TMjlO4jJY7sS/18DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FsZ9GgSh1IN2yBEGosCwyHwPsW1aoJtL5PefqzNuuKC4zaXDVF62nAndUSY1cJrTg
	 nXBAEAHC/QDQ6sMs3TxW1565muJ0XLQ2AN/A1TAnc+2n/qBKnL4D/A4fd6X2DNVwCr
	 1RvcTiUJQOWEWb/MIbpPzqBVOXQopvBRpGBbMbfZLLvwpEC1gq5jC9DLFQ7TNTsnpI
	 NDR7d37pIMsn6SVeSEMJa9gMksC4bzaatB2VyXGd+POmD+na1t75ZdiJVpxOXzLjW1
	 g2TIty83MaHjfG6q02KVOGhmu2tlblkDGblye50vgyRy6dCzLlUgWkjkGlNiAPcXde
	 2U4jSrCyw+DDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:29 +0200
Subject: [PATCH mptcp-net v6 15/19] mptcp: pm: in-kernel: increase
 endpoints limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-15-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wu+DrPmFVj8SMzi8BY9NKQEjf6TMjlO4jJY7sS/18DU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GK1W/HWTeXGTVWp/u8bzJU0L9xcmvWX/Z7chmbDl
 0VyL83mdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk/zdGhomrK91e9Zm9bTxT
 FhDxMeCU2gf/xx/+5t96ueG/YtTHWTsZGQ64B86tvNP98oPsxMsP/xn8M1x9LP34IRNlNp6vLDu
 mfuMBAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The endpoints are managed in a list which was limited to 8 entries.

This limit can be too small in some cases: by having the same limit as
the number of subflows, it might not allow creating all expected
subflows when having a mix of v4 and v6 addresses that can all use MPTCP
on v4/v6 only networks.

While increasing the limit above the new subflows one, why not using the
technical limit: 255. Indeed, the endpoint will each have an ID that
will be used on the wire, limited to u8, and the ID 0 is reserved to the
initial subflow.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v6: commit message: limit is at 255, not 254
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

