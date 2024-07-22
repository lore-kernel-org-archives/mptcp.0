Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BA171088
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676954; cv=none; b=VNd4K83qLMfi3/KXjhKmIyAwl9Kw0HItcEHaCmNCP3u7BREF0DxgcW5Qayl8HDU3ivT+bMDjGmlQuaXocIB6ID3iAulUmVb+tYhapI43ymWMc6I01/jtBIqOJ/FNDXeVWwjv+1KWEmhQX+dDPhFX7/SYVIzFFbS9L9X6YEQhmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676954; c=relaxed/simple;
	bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfTEI+lKpOfVg5t8GNv7b3+hWopjRCiurq++OoarCutSEyVBUCl2ZCF1lGsdX/EBeT9PBMkpxnqj7apenReTUBb7mFQt+BaaPZeyk+n1uhCdH9mcmII5Hl5azsV2JekVFfMi9k74N0s0zzgwxL8Ggy4eRtogfzTNULG6/jg1DHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1rzwha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh1rzwha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6348C32782;
	Mon, 22 Jul 2024 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676953;
	bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kh1rzwhacrLUnynAJhZL7V3mOagndZpAQqXaTP/V48o+dRPwGJ0gVgh0UmrtXEZzR
	 LLTb+XV9MY/y7bWRXI0r4bmiSCKA4l2dwHFpXvXzBQ1IjruT4S9uypjLBCA244QpI+
	 B6zyqvT1ktrSB69PMKm/QFnZrV/2NJwtU9N57qH7ThEj3lsudG9LXCK+k6hkE9v10o
	 jW8F86mPK95WgGrVdLn7AL2DGYL33+F8QLmZ367JY3Hqxy+yBYQzPUAL+vbK2dgsHo
	 BbcUX4lPf510K1jOIwCtwW1GGn3/TVD4F2OaP/SBPlf36CfPpNNaYzkjSfpzgpr/7s
	 cTquxJ5ddWoOA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:39 +0200
Subject: [PATCH mptcp-net v4 01/23] mptcp: fully established after ADD_ADDR
 echo on MPJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-1-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lVYzLe5JrCLEvvxaysYG3kgQy2v6ncdEAEe/A6edulI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWBS2rYPlzsU/sH5P0wZrdgEAuccol3XxZK
 o3Y6pde5/KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c/cpEADYPWtqYVv6DNxc+ReC8bByC/W9nmOXGUgK7dHOUI7aRIZgX9nUVcNcgy0WVRr8g62CxJf
 nUNcyDhVTUPhv6sXJp5Te62J4RaUZR6shpTM5WuJmGoV0LhNuS/mfvPGPdjCDz+/3M0HEwR5dCh
 HDt41VEssGLSZUNLKn/AoeqT43R3DIBSImANU1mMQNGv5Q3Ra2w8AoEHT6V2+FpTZ4L3SY3FjIi
 7CdRH37dre2FUoUEkv/+8Da1RxOkulUK7q8N7+UebLCqcFhmKGzypxSNGgKMOPC/vdRhagQeUzG
 R6O9WCvK2j9xL8wNeKP3MX8jPR4qrDj20yTsFHHkr9+2EaEZIoTdEsgnYu0k8BuPt5+aWZhoocW
 8/NodnIMuuhFvzrnF3FTJYwOCFRXP5B20QebyCGQOORu5YRLfcXJDB0mQyuF6iOBkL0Y0KCn33H
 O3vwHFMzH8AorHVAP5XXbr8STXVfHxabbBzef1RlLwXVvnziJ5/XhxilQFixVOlSkc6zP1yYCu4
 i0afjnkuD0hdLWCQwtayp979jdRUmwT+kUoNQ3gKc5QRkIe7cOEtLL0NaGVPslYxXMvsrHnk3Mc
 NevgCQEj5fppw4FlrNLSqvKsgfkD3wOGJURWO2o/3CQdz69WLeWhTRl2K783/pmATb1DcaGzLOZ
 X/PUNz/1yS43Cww==
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

