Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D718733B
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038202; cv=none; b=h+NKeCimpC9mDf6Xia9Tn8fRBYBWIryjGoeA5N4PqKHgMr8WQHUmH2iWCK/lL+7tJOBGTyDgtxm3RW8uZ3atmtV/+DAk0wt8cKuj+8kTJ7npSGno1W04KhjXwtk8pANeo+HOuopM0FH7SZU+kDZPgcxyCvG7D/0j73XkC5nJFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038202; c=relaxed/simple;
	bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fygheu2kXTfXh8EJ7z6y9UQrvYzkpV7T1GORC9sAtN6F68EjDnQxmFJV26uAYGKdZOKiocXtAHNnmCaiYQcZFG/TN9nvdSjelLBPJjjrGoankNIiS+mNot7HQ+HUsomhKCbr1THQZA7GGcEGnrKxBaFMHdaBnIHB9nnJbZt3hrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwLj7Uzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwLj7Uzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F94C4AF0E;
	Mon, 15 Jul 2024 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038202;
	bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jwLj7Uzvmb0ZgyImUbzTD9P+bsqb7PDNQ/GPf4ZjyEfwLbe/7eYbTFo9R2kJsZtEg
	 eWwMkRf1p8p0Be0gW8IKgewGyJ3hAgbuNh+g38A9NKQcyopYqau43dmzGvQf5e5h3Z
	 /mz3AiaPrhFqCvWfH7JZqvHyfK4DWthsdGyBPHt20jB8SKGsekJd/za8op0nf/6cy9
	 htqSw628hu40EoZUuzieywHJ5G8jfXf18R2ioLZprc5cDEcqM6xrmHeowpi4ppVKwY
	 PV4GGKSG7L/mKK2wlxFiHzs75ufcnIQ/nUA/Ie3iRsywW1dqGK4/Vpv5grpa5RpZ7S
	 ZJeDVmdKXEM9w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:39 +0200
Subject: [PATCH mptcp-net v2 01/17] mptcp: fully established after ADD_ADDR
 echo on MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-1-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3nZ4ka7RAChPT4TnmKy08133IfeqSoeYP+
 FFlfFi8+JSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c7BCD/0ZKZbvS4NuA4KvrvvqsatNrAV66XkZJIHEll61LySx84jGDvJ+AYMJdINfdlB1GIkA64O
 dGFpw0KYjwc1OUyTz5Uep4fWSo8qhPBwFznfM3kxZfHlpx39V98P0j4Kk2LNbhJ2qH5X7QbxmEN
 gSPqJmfSMWIr/OGz6OFNSAg//2tG4LqHlwcweuooFJ7S55Y4krUgyQA7X7YzdA8uBMFbRZ/gpST
 tFRWqnDXTqvbkzypE3NTr+9hLcURNyxEv7qvCn4YZvP8IEHDGbyTk1ukEy9QhhvyPBMFOUVvTyh
 3yOyimYVVKdQsKym+cvH4NAjJd6uwBTc261Ga5Y/IA+qF6h7ezrcWEeKe8gEdTPU57IevjR1yOR
 2cbMWfWZIBvsDQwl7le/l85TVFM9buUo9gu8Xb6RUPLxtTbx78lmcfmf8mNnoEVojyrYHFG86P0
 SQI0XNBc4BLwUU3QjEjUo61YbkK6Fo3LPKq5x/ENUGhTwiC0DuGK6ZMpPgMTeIXT8QQew/nT+nJ
 T81ly4Xbl3uMLczLTDdg/aFkdHp0L7zWdL4etHokq2hFUla0yDRYVkRI6wQRpGIPwDp+1tFDmb+
 W6dP/7pvz56S85FURhMSiNgODl0xNQZ8mF3e/oW1xpR6DB5PQcxNd7nm0mD65FpFR1nDQOhcvKi
 wyY/A/Gm3HGVgnA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c0832df3b0a3..4ee2e3605f5b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -958,7 +958,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	if (subflow->remote_key_valid &&
 	    (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo))) {
+	     ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	      (!mp_opt->echo || subflow->mp_join)))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */

-- 
2.45.2

