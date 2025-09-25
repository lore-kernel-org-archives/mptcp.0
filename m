Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C1277CA4
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790489; cv=none; b=oIwA+UjPAcSjSKyIMM9vLCd2YaHQlWG7tpnlQjl1c1vaGYVaShbB1jNM1kQc1Ess0rNrqY92fZWKUdDX+R5LZIXuzh62OsQI4rxR1o2cCziH3lZZzWqXOMz7f/eosjV1vg6JShzOL5W1yx1yTAe+3TL9cbTzZ1G49mPGYK8mQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790489; c=relaxed/simple;
	bh=554n9NfoM2Z+O/8vzWUCCYFq5wvCR9Bsr2A0WAemMlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gx2SRGSjiTx+sDbV/GsOkNWvSc40a35eUWYqeupYglEmrbMuMlO58RTQz1RlgDYSuhYlSZOEzKqOl8Lh1fy8T5QgmwRMo1sxLmYJOeTNHGxyZCGD4mT3GT0w7cHbBEyHoyZ6cioaanNFHuI36QfstcNOZgR5H6H5u/GHlk4sjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6wb1Y6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6wb1Y6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F342C113CF;
	Thu, 25 Sep 2025 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790489;
	bh=554n9NfoM2Z+O/8vzWUCCYFq5wvCR9Bsr2A0WAemMlE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C6wb1Y6C2idf774VnArTMAPGpa+w7Yphqv+pikB0on+Rn4dPk8qennqLdz65gCdRo
	 e3wEEkvKSj2yXh6gdmuolRdGMT2xeUvnJ/J7Ae7NrkQffrqfN+GDUjtvaw+a9a7PyR
	 XtGFFbF3wNgmPMyMlAvmgCzS6mV7F0w2Y67CbDy55g/XOT3P/nU/NprzuTLUC8cXvJ
	 nAGYk+ZRraBjYzXEnMjz3fcKU/jcpnP4rI16/BHtouHDy4x1ztc5tgRHnBsG9N+FPL
	 FAf6kEayzGtd2sqA5Jw2gKORbhMRYfTGkRnYHrLQH4qrQauQjgMnq6WgAKDRC0hoAC
	 9cbBJItOeNxqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 10:54:17 +0200
Subject: [PATCH mptcp-next v3 1/6] mptcp: pm: in-kernel: remove
 stale_loss_cnt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-pm-kern-endp-add_addr-new-v3-1-1697a14ffa7d@kernel.org>
References: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
In-Reply-To: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=554n9NfoM2Z+O/8vzWUCCYFq5wvCR9Bsr2A0WAemMlE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuMgdsn/zizbpQxWvC8r+OHVp175d52Ls1rCJ3N2Wfm
 KJ6bMonj45SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJLL3HyPDU5uDeubp2VRvf
 zFj78arNinOMGbuZ7r53/HL83+KPB7k3MjK0OHUWCD1dvLO7J+WB5kR9/rgrm50VOfLfxzEF/On
 TCWEEAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is currently not used.

It was in fact never used since its introduction in commit ff5a0b421cb2
("mptcp: faster active backup recovery"). It was probably initially
added to struct pm_nl_pernet during the development of this commit,
before being added to struct mptcp_pernet in ctrl.c, but not removed
from the first place.

Reviewed-by: Mat Martineau <martineau@kernel.org>
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

