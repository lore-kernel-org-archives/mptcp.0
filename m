Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541E2566F7;
	Fri,  8 May 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262033; cv=none; b=WHsLt+bNmxlQZzRK3mYYrNcoSN8BllqLVmkT9VpW5MsqgVQ3ia5VJe+qdiLiPsEwvQxqqhyf6GkSd1rCIb+X2EbZUcG/6NOUqLyoSFYNHiaOP+mT0n+nbX6jC7NRGw99xzTPPciRCeFYO2vnfd/otgt8BY8nWYzFoVwGy/I45D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262033; c=relaxed/simple;
	bh=GXQ5B1E4M/10/Qhs297jUYWm95hJVGjkrfRK8xxzgRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LB52s5EsJU10t9koJNuqc7qVfZ7qzSdn+Vc7PnrpBqMBGuINtcyg8/yZssSHLyYbzXWlO3UbR8EuM5XEBnmJbcKDtcRqcxIRtJcu1gP5IRvlsyf/bDx0tw4QSNDVHsNdTi16bDZPuYq9YVOiZTvaYFuF6be5v4sbnEzdPAPdKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgb/oTAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgb/oTAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15D1C2BCB0;
	Fri,  8 May 2026 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262033;
	bh=GXQ5B1E4M/10/Qhs297jUYWm95hJVGjkrfRK8xxzgRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qgb/oTAGNVPb0Nva+oNEMhOZBH9r4l/H+XsomVNaoOkPhk8wDd4D1W3sAp9J43U10
	 LDuRhayRSEZ4ZbL/k+zaRCudW2U62HWLc8Hz/SCzPmuiej73Am7kaxXK+tWe5BNNAK
	 FFtJohz0eui1M4bXsBnUuB4nJwaOsTCAo64w1fR577QuVbsBhnQb5KARhQBOOQie61
	 IQf6d8pylYO9k37YixpveFLWKyXpSpRq2BrjxD7XJXG3azj3+ur90G5z/rTrFtALnr
	 JJfgBuAQonzCR4qPqP7UIUGbytceo7yb87F/8Vki+ollVKuC7JjYMVBK6OQYFrCs3C
	 eLi+ThUMNoMOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 17:40:49 +0200
Subject: [PATCH net-next 4/8] mptcp: pm: in-kernel: increase endpoints
 limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-net-next-mptcp-pm-inc-limits-v1-4-c84e3fdf9b6a@kernel.org>
References: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
In-Reply-To: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GXQ5B1E4M/10/Qhs297jUYWm95hJVGjkrfRK8xxzgRg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KTAr7POvLTcsSt9VLjbt9fOtTU/5ebQXid50vz7Vc
 9vD1jarjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIncFWJk+GQccSHeqFrW7RWr
 veDqhgNPpzVYXS748bDqmLmhiojPNEaG/bUMnO/eKdkePTiB40rjw6BbrXNm1ISI3pdz9K636Lv
 ECgA=
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

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index ea3a7ea82013..4ba4346d7adc 100644
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

