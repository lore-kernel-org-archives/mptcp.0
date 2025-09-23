Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6022ACEB
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619986; cv=none; b=C7xd0Z02ga/LmAH473vPG8hKytg+XkPHMnqmG041WzqeRokfjpI0bWijl2nUttoWaDdrhSJQfSbJYdkSGz/5U3jSG4W9IwfJtxxJyPSvzHur1SyUHU0TdZmnjuIM1NVeDRk/QnYzHUITLsMjElJdSgILCqGZwmvMqEo0ZjskY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619986; c=relaxed/simple;
	bh=6yfPBzZSyhsri2II2OENRj+P9fe0Ytg3eeV3x75kBME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onIDxsDVzlexV6lXrCzsCim5E0TjE9p39571cH6FkE2trogMd9rhBL6YD8tTcsBu3MMhX9xVL/T//LLUqaCvl20T0wbO2hE2Tu64jxPD9HOipEFu+4zuJgI356D0ooHbl1ajzE3qku1XBC0e8a164GDwNeXbE4ITmN4eFBQgn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U86hRRjn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U86hRRjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A33CC116C6;
	Tue, 23 Sep 2025 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619986;
	bh=6yfPBzZSyhsri2II2OENRj+P9fe0Ytg3eeV3x75kBME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U86hRRjnwx5XhtUm0MtDA5R5APFu1r6zdN/si10d6eqs1XM4KboEdbTivU1BwJ0oZ
	 LzAeYs6owAv1XIxfbmSYjnH4rBRilCxH2prAa/NIoIiFDMjw6TL2KAuP+kiybOpK47
	 G1e8PmhEHmoisPxIyQGGsPWuUqiHThDllFS26oLytj3Ri8f4goZvIOOphLPSy6I0BY
	 p9Gg4SrRv9Y7bpT1I0dd5W0zDBPh08z5/hepkHFLgrMj33ZE9ezQ5dx/hORI/PtBPW
	 fFKk2uXtgXh/AqhfHv3Ez4PFa+q8OeHdSeJ/e55RLYAl6fluPv+8wEp8+FQlnKw+ub
	 3Nb1w1oHSS2ww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 11:32:47 +0200
Subject: [PATCH mptcp-next v2 1/6] mptcp: pm: in-kernel: remove
 stale_loss_cnt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v2-1-ee5369dad569@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6yfPBzZSyhsri2II2OENRj+P9fe0Ytg3eeV3x75kBME=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIuZXrmvE8Ot712VnvvjocJE/c3Fm64nsiywP+LpNVKL
 4mSe9FrO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyJZKRYf9ce+OEE8sO2up9
 +344rJ/78saqZ2wPzv+7GZF39zfT1r+MDAtLLlpoZIf8mdJ7d/ljt1Dz5vQ7kfN33u/84/As6X9
 APj8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is currently not used.

It was in fact never used since its introduction in commit ff5a0b421cb2
("mptcp: faster active backup recovery"). It was probably initially
added to struct pm_nl_pernet during the development of this commit,
before being added to struct mptcp_pernet in ctrl.c, but not removed
from the first place.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index e84c381aa3a4e2ad8a05e4b0daa7a5e8daf2c35b..52ae6304b311189ab927857ab74a9ee44ac6d76a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -19,7 +19,6 @@ struct pm_nl_pernet {
 	spinlock_t		lock;
 	struct list_head	endp_list;
 	unsigned int		endpoints;
-	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
 	unsigned int		endp_subflow_max;
 	unsigned int		limit_add_addr_accepted;
@@ -1461,7 +1460,6 @@ static int __net_init pm_nl_init_net(struct net *net)
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->limit_extra_subflows = 2;
 	pernet->next_id = 1;
-	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
 
 	/* No need to initialize other pernet fields, the struct is zeroed at

-- 
2.51.0

