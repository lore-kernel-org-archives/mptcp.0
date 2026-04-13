Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A903806AA
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089537; cv=none; b=gqXkvsazrpO9JbemB2Ferssr3WnlLAXWQ1BQ/gtaEqnrS0ta+3uDoLPW8ZKRSIzroGUeL9eHeMvmYkdL/P8WUgH+ee63lO+zGahaZcrCxCxmDuyOmnKt4rwICWqA5eq67XP6NB69sAe3vzb9L0FXSV1Np1V6ugG8nuWIrHrMo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089537; c=relaxed/simple;
	bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAjMw6ivum6xIdyq5+KaJnN2WhWKUTH3zRYrOL18w/DU41YkaYJUYZA5g/3SsheY390az7vTVHvXPm2H2MhM5Ddhm19SGSbRwcNrHkGfcAacunPfQ0H6VVUFfbBCr9banFot4UwoOVkcfCNSpnswfk+nQZ3OEqrX41St8n9/yZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd656njF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd656njF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2768C2BCAF;
	Mon, 13 Apr 2026 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089537;
	bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fd656njFzHf+b/TzAqfx1QoEU6tK48NKjs+hajuwoywHb8aNJ0vEkrjIiuneWkOpH
	 Xj2i7XHO4FbM+90rJTRTWq2/ju7VIy/rdW2HK0gLUlsDXhok/6ePUeZ4spQFejAmom
	 2XWnD0dHnNNFMxxsSpM2atPBjYmUY8TfiDwtmCtfzrl6/DLBIeqLpGa1LCVnn/6+Mq
	 Pe55gPSYhC5H9hqpg0Bv7SL8bmVP0LSXy1NaeFLOX44Kze9pPbe41FxPRIXKGu70/Q
	 Bq9bCDidPdlv4xylGiAuAi7uNNyqp2Kax/82WApG0zGfilwX5k1a2PJ07RuP+VzytS
	 krLADEeHUz1AQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:12:00 +0200
Subject: [PATCH mptcp-net v3 14/19] mptcp: pm: in-kernel: increase
 endpoints limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-14-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/NzYEqzT9S7xqs6sOuV9R+Za3vK/cWp1fIiXwPLFJ
 17tCzqp3lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARNyOGf1ZaOxPeyPUdWDVP
 bcGGOXHrdHeIrz/NIu204l3XMmv+w7YM/+N37X+Us1DWOXXT0aJ5G2vK5vlF3/Ver94TxbKrK7e
 HgxkA
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

