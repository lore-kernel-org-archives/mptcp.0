Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FF13777F
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969967; cv=none; b=WuFf2NaWpQlzXF5E/3Jh+emw2cqAcH4LwsfwGCpxkKD65BG3FDlqF+pln3gy7sPqe2hUKHQLhf4dSAtkyDRXD9l1jirlkQZ6oLNPgpzFi4gAJeNDF+Ejgz5HZ8jAGZIiyIhbdKgPCtjkQz1iu3vMPtkCpyg6DV/bkowUQD4OrWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969967; c=relaxed/simple;
	bh=Y6VXgJW8GgtqI5kCBA/qVF/VuXTnQ1NUPzKFUkh7sRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPwX1tP6P9yQS0tSIsNFfqB+aGsTATodqRknKYCtSF1zW43pzp2kGlKWkDIlKl/oe+RGcnMaUARKUDkEsTAuy+mJXjPOjaqR+xR0XFIYWHKfyxT0P4dCDw7EL9Ls4Q3vZTB3adkZcGhkASoL/ajTgOIVxsF8VQ09yh4rYQptuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgceCfSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgceCfSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4215C4AF09;
	Fri, 21 Jun 2024 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718969966;
	bh=Y6VXgJW8GgtqI5kCBA/qVF/VuXTnQ1NUPzKFUkh7sRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bgceCfSg39lGkslEP61W+GTbM3rZKLzMF6z9qZDYUFhEotaxcCeasViAEtfxj0+me
	 0lxApBTw6WsyMLDi3tuRtkirDlp+YvJ/AkxrRA0xDzbMNZlL4SBOTe2lDwt3A3dYYG
	 lSxnbIW6QfPHfeNszZVlW8PRldDRVPKRkfN1WBKfKm/nkHQPd6tDNSTEYvytQF0O6C
	 0aOP+IdMt81Ot1Xux3TQL650D/+T+/6yUrvjTIVVpgbYSuc0+ppvUtHovNctYcSTfJ
	 /bc0dT9CEUNvb0JIl1vV1Xy0+021bKcYoRdJhNVqc++TTvJiKJDs8Kkm8IP+PcNgFO
	 LM5z9OD6tY9OQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Jun 2024 13:39:07 +0200
Subject: [PATCH mptcp-next 1/4] mptcp: fully established after ADD_ADDR
 echo on MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-mptcp-pm-avail-v1-1-b692d5eb89b5@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
In-Reply-To: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Y6VXgJW8GgtqI5kCBA/qVF/VuXTnQ1NUPzKFUkh7sRM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmdWZsXO97qRQ2BltmnwNx/frP5e28XURLAe+DR
 czRpcfqnomJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnVmbAAKCRD2t4JPQmmg
 c8RPD/9oW9zVr7eh10bppjyOPQIcN02JDpxiVgJS5jmQ63xi8eYfo+j8CHMe9AEw8gOx6UrV/r3
 eZO8fL9cyFCSKj7P40A63dumH1iKQt4dkpsOVm+SHFvNyj5a7zHGdFx5X/opMImfFg5KrMywFQQ
 D9buWu1sG8/iKGoCznxiikhQsrSPYoc3dNpq9iYhc7wCLy7hEpjaxTDmwS9e53L2zahR5N60Shv
 lD3EuDW7VzmKuHlMipHmAwBouboGNX++HM31dXitaanehD+hdgUd8wctwXxc10P04UkpXQyRCnB
 zWtm85xyOBdLHO4meUVUPUQR3mSWBk8iwQ2ee0uVmDtQuOsKKr34dAOYfD2Ui15FXN5UV2Jglia
 t+whaNdU1s9a6eJdGvLxfzwZbVm6IHm+mW+95Zs0sf+Qrkrb/QKbwBmYlE8jyxSiPE1Wg3YmSFL
 o49TLgviks3B/ICfZDswI2wINKiWpWORE5smCRDhHNoVMscRadkMOoPDzE8SNCMCeHb+NwIzp9R
 dlmnGopa4hIjNGMnwuLV6Iv6nI289JA/CmvGry3q3n6u8JfVquwHNk8PZOQhlixapvXBT/z1MJl
 ao5A1pIp54UZmRpeOy4L85JHe74nlZIEn9p6aJkfA6skQuWlAMbDZE6nT721df7Bs0MgVWENUqx
 FraLkI+O3JuoS6g==
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
2.43.0

