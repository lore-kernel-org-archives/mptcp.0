Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F532F83B5
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173663; cv=none; b=CY0cLlUvoZ9e5GW5fAUCqJoqlOl+7zot/j3iIPlLtOMGkVSDXenSPHVo/UXVaqS5rnQFSRIj3RZrOSpBvqyZ7SqHZjAQgSD8ptX7wz+NWabrZZOZP+hVWfu1IO8dLQdfi1zoAILBiGDYJ6Pk1vxzVVNSX1VjZYoGbnXZtEJaw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173663; c=relaxed/simple;
	bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=as81kIFWT6GDSdItVpnuP8pids9rXkfO8L2/ITw+kiJrb0DZXtril7PssHjl7YbVag+KROm9BN6zhPM9hm692UL9ve67k7Jru93OtpgmmesDISytm/mo6YhMJDDYDTnCgvOYdBFcfO2TpTivQmknT/xDv/vympyd7r8CFmAP1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKdqFACp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKdqFACp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDA9C19425;
	Tue, 14 Apr 2026 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173663;
	bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iKdqFACpx3H8LriNxFEc3jJeCYYOsStURh00e4zewUO5v8c3o5jN0FXPwjqIs/tLm
	 qqW+x+T1hOI6Ssk7xL/wvHjEJOE8vgpg2E3/z9cnY9FQfUruFFvFV/hQClW4Lye23q
	 KZNqLpxJH5EAK0FLCp8sfu0gijRFctQv0WVcIMUK1XurOgbnPLu2gV7PzQlz2udlUH
	 TVXUWSKDO4xUnCFl1+vScrfb9/jlHJ9s7e+KSfWwp+SRvJvpfK2H5C9a0Jheuj+/93
	 9Qa6EcfLMfn29MOMGIdxVCXSY3ueJ6MMqDgY01EiBzJbiGHn568n9o6WtH2ZGiKjjA
	 iLnTlERaO7OkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:08 +0200
Subject: [PATCH mptcp-net v4 15/20] mptcp: pm: in-kernel: increase
 endpoints limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-15-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FzoQpH+/1rJAZNWER5wf3XVojQhw8DWII+Nl045Pjg4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOQVYBl986FvBYVlftoVRI/7Szykxj85NSpteInOyy
 EZhz4vLHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABM5IsjIsHVT0o57rTolxXyX
 ffz0PMOzudw+5ffGabjtnCoWVqEsxMiwyjOFX/6A4zbv7NlWrxLYm7YEmLRuNlQR3aDws6HX8S8
 DAA==
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

