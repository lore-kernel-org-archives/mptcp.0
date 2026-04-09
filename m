Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131F33F591
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767934; cv=none; b=Rq/qSdtkUWQuw6iQ2ld66Qsfz9UiFnT65f6cH5uzwiftwlpNZZxXc5OuDRSWoJmPuKUQMBjPVkUcyYquyFewLlSSiscRRv+tjXbuLjnlZyYmCLupOgj7CvfIgjw77NgoRT529XjUC1+F/qwo5aQKIupLuaDxRaw1R+ZWh3MmbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767934; c=relaxed/simple;
	bh=4rGOfBmIYTwKhUSRTaf0053myUCNtNMlnIYborgxb/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSQ9BfCU6LqwpffuxZOgOOTNihKbQ3VzF52xHTPTG0lXqjFeFYqycfYvD+qOFqeX2JXTo6wXMCXZSGQMhkGdacvKnJ2YJA404V+DSvCn0Kbt74BAPJiRX9MWy64CYYPm9yDMZsCrJ6blpPl6cS584KDNgdmH9cSNp4+/OzSLJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny84R1fn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny84R1fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54329C2BCAF;
	Thu,  9 Apr 2026 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767934;
	bh=4rGOfBmIYTwKhUSRTaf0053myUCNtNMlnIYborgxb/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ny84R1fnfvnDinGTXTWw4WyWn3H1ts8nqecqhiqv3xwSqUuKHZ2nafnUfwcVaDXtS
	 QAwiCSxqYOf3pw7YhiBkYObiPaI21zrD3LMkNkHuaksETzJFkFXRqzgBE3Iidtub11
	 u4w6eTcdqgXj0+T55jwP4r2eUTq9AFopX57mpZEpuXjhWK7TRV19kOXULaRvWkEfjy
	 ndA06ktThQl2e20KDDCuDWj1roJ58l6IIUF+S3YcgsLEbmPfUeGqI/n6bxG/yRh053
	 tcLCpulxvPDmnuErqIuJiRHqRgVWWnPBFTkztvCDDkb9+grB4DFfYN+Nn6rIRu4ozg
	 oujQsPbRIqJuA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:43 +0200
Subject: [PATCH mptcp-next 03/16] mptcp: pm: retrans ADD_ADDR: free sk if
 last
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-3-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4rGOfBmIYTwKhUSRTaf0053myUCNtNMlnIYborgxb/8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCBZEe38NNLn1f95Uhps3VgsZKOxrPvvR4/jBnaaHu
 f9lax6+2FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARpdeMDG3Kmemb7CZOc5gv
 r6Msc91xn0fwDs9b578fXzw76NpNnfOMDHMti3R1FqombuH1FZmzLqahmJf/VW/hk7nB/lGX49I
 k2QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
and released at the end.

If at that moment, it was the last reference being held, the sk would
not be freed. sock_put() should then be called instead of __sock_put().

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f7c9a1f94d50..2cefc9b6c1b8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -365,7 +365,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *

-- 
2.53.0

