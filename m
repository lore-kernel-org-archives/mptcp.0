Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B89443
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767520333; cv=none; b=gh/Mhf0ntaXYBNeDPfWbJOa5qLnNd5s39SZ3Fg0fmhJFM58MSdkvyM+sJaCvXijuYgYdqsFf5t6qPal7UJAlrgsTfjDxoR496GvWwVtQxzJ8X0z+GM1mekmotJEGVabJWy9Cj3xm3NS8qKhvQ6jkpv7e6aXpweQHI0PuS2JKIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767520333; c=relaxed/simple;
	bh=qQwHjEM5p/aFl1Mv6bAYkxhI8UkAlT/vC/pcp7Ibp/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NqFDGHNDXzbOsr1lHv9vYsmewHpaPzmRXGnIs7bvaPXia1NYK9TaaqNkERjOq6OhPenAavhfiX7RSCjrk8ntV69U1JuwEAO2dWkytWo/8TsHP+LhbM1cWE/Qc/V8MQ+W1rAy+34qoPLhEHBpJ0BmE87mpn+0l1aQs4yWT5gAmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDfCMwqR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDfCMwqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EB5C4CEF7;
	Sun,  4 Jan 2026 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767520333;
	bh=qQwHjEM5p/aFl1Mv6bAYkxhI8UkAlT/vC/pcp7Ibp/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cDfCMwqRgKf5nkMok1d/Y2oLXHVIia53RYlkouiUejnBPFZ5iHqr29l+tf59B3v2d
	 Gy3Bqkzhzf/vvyx68b+JAqJq1i09eCycAqmO4qTQh+8YTK2DQ8tEqD56W2M8N864js
	 qfiJTLMlIf8Xp5fbPRnwnY+MJ800CpM1MCr5KHWwrIOO1VWh2mSyUNkPwGOsorYPQC
	 bUCvKWpIUIRYhpc2Ksj//IkZtcMYHu9rcBDWUC5qHinpnnwx0iyc8AlFVIjBxoW3pA
	 a1e/s0iBkxzaPPFOda2/dTQQF099AYEAq4WxWBS7Mbd+K1phRcZd6FkJekTtgQo1vg
	 Nas/3aPRCzORg==
Message-ID: <d5c42db92494cb4259ee9386c3b800e12898f152.camel@kernel.org>
Subject: Re: [RFC mptcp-next v5 0/8] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 04 Jan 2026 17:52:07 +0800
In-Reply-To: <13eb9cae-9243-4706-b873-c11ad11e266a@kernel.org>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
		 <13eb9cae-9243-4706-b873-c11ad11e266a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for your review and happy new year.

On Tue, 2025-12-23 at 17:35 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/12/2025 04:15, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v5:
> >  - As suggested by Mat and Matt, this set introduces struct
> > tls_prot_ops
> >    for TLS.
> >  - Includes Gang Yan's patches to add MPTCP support to the TLS
> > selftests.
> 
> Thank you for this new version!
> 
> I just did a very quick reviews. Please see my comments in the
> individual patches.

I just sent a v6, addressing your comments.

> 
> Also, did you check the behaviour with MPTCP and multiple subflows
> when
> KTLS is used with HW supporting TLS offload? (TLS_HW mode)
> 
>   https://docs.kernel.org/networking/tls-offload.html
> 
> I didn't check how it works, but if the NIC needs to have a
> continuous
> flow to work, it will not work with MPTCP if only a part of the
> traffic
> is handled by a NIC.

I haven't considered TLS_HW mode yet. I think at this stage we can
disable TLS_HW mode for MPTCP TLS. I'll spend time working on it in the
future.

> 
> (Also, in the selftests, I don't see any tests using TLS_SW with
> MPTCP
> and multiple subflows, that's important!)

New tests for multiple subflows are added in v6.

Thanks,
-Geliang

> 
> Cheers,
> Matt
