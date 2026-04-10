Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AD26CE05
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831527; cv=none; b=Bxp/+82ION2sKsdLK/3ZGgkdBJGXAlVA769o5/opKpsOhUq9zYdBgj1+9llcLpwAXlQUyzIHony0E6Obg0Iy+KY/FaGLzTAQnEkU/MUdJm2OjhxuE7fjvxvB2p2/lIrY7lKCcYM1mE6zoiucr7eyrbGf6l1G74pNQDNxSCPWYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831527; c=relaxed/simple;
	bh=eX/lXtQo+xV/gG1QYefv+KlGzyuA0g/SxpiBYJwB2Ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4hLqGYh5Kk8JlrvH7Wt+yBEZatMMaWGshKtLkg0RX/0Fih3VYrtWEScVT6HsjURjlPt94eHKwpVrHRzjJ4+5wS63Du1OJtZlRLysVPljklVS/0g0nJ3Pt8SwgIt1vRR7hR/n3ikDMnBjhGnT46e0p8QnXFrXlV+gxYuEKjDxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw6YYBpQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw6YYBpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4043BC19421;
	Fri, 10 Apr 2026 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831527;
	bh=eX/lXtQo+xV/gG1QYefv+KlGzyuA0g/SxpiBYJwB2Ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pw6YYBpQ5BMqFwHuLTRd0yJBWhSHUwADuJu0XPzTDOcLwmrPyGqucwLnY5kBjot/e
	 i5/BsKV9nRdtv+GVnbmrwGzbcaYZVHTJ0tQMcEiQsradBy60hXlYAlnukyFW+9Q6P/
	 f6Q+MASz+AsEG1jC13o3Noo3F+jkXTYGxI89C677yU3hLF8mae/GBD0EMwgkAznqqI
	 3k3PVWAa2qHTZPI80UCvXAXX8rTCux0QqDM7IPsvAhjGoYH1z1tWw6sEprKlFBiy0F
	 QVx+52/wVXd3Jj9g/OuB4BAcpWnBixdRGP6qNDXjDSv548IAYQbv/bWKSPlKY8k/YW
	 TFRXdb4Kw9fQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:39 +0200
Subject: [PATCH mptcp-next v2 01/17] mptcp: pm: ADD_ADDR rtx: free sk if
 last
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-1-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eX/lXtQo+xV/gG1QYefv+KlGzyuA0g/SxpiBYJwB2Ac=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct5w41sp+cdcwSN+VqU9U7P4m12KMX8fhAsKl0/tP
 Vj4tDqyo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKv5zL8D3n4+aNrB3P5co3A
 wF/Pr2duE94Q8Sqt7OrxuZd3rwrWOsHwPzhg3b6d3i+tVqq1RvwIX7O3cK7usgSj3jKv+L1tB5d
 y8gMA
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
index fdadd0e8f77c..52f8f4eddfc2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -368,7 +368,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
-	__sock_put(sk);
+	sock_put(sk);
 }
 
 struct mptcp_pm_add_entry *

-- 
2.53.0

