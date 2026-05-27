Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2E3FC5A8
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882261; cv=none; b=MDMpd6gsDAmQ2vyNbHwMeR6stU/R6lI2kChJu0ES11CowzXswMV0H7GX6o+harj7D3vMsjG/6uLVsAJyhvSmotS4kkjFJYNVCKcJtVCQTCbJYTvARrjm/BZseoi2maHvT5LD03gl07zrqBfvfcAZHZoLPS3wlkBo3g32TX2GEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882261; c=relaxed/simple;
	bh=dLpRfjVZdFY72L8ANdnsWqZ/s7TN36ayOb/sNfrVa0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wb29tKStzppHJO2t3eCZOr3IhlnUGahl5jLQ4XBmw6i9E+WruHN0wsNre3THZKlEj6tkYpWbJy08SFEF9ULu9HglF3+z0iTht5qLSL6ME8C/9HajjPOZKTRbPmhrnqDxQa9kEbQ29cCrFf6/TrEl5KiB6R6T7FzBjZQcBqCimN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LewKlG6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LewKlG6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880C31F00A3C;
	Wed, 27 May 2026 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882257;
	bh=pwz2ffDg9B306oYyvlpr5Oj9U9gLXb1pZiNVfo2DUew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LewKlG6sqm9PMdhXO8pjoK3GLI/Uuwh3HMqYTS9cslZFb+sCdDEvJ0VLgEu4Ld1TC
	 MZ00ujjq8oEnUNLoLSW3RW2t9aNEnEjQKEZOh2RkFNTA8kXu+7fF1WOZc4VBem/RPv
	 HcNIiWiuCWrpfrpNkpq+6ztUmC4iBhdV4mEHdN1sHKiwOSaUS+cSrVTe53IZBt3TwX
	 HwX3CbCmQ9L7ifYosWmT0GsGb6ii5cucAJBfcjRq9mXpBRVzWYqeldCKFEUBaJ8u/r
	 +nQIh4lejVdcmU1PG9O1FSkCzPz6FiA8Abs5Tm5sImGMnzj++BppXVeH93G+aRDbz6
	 dMkcCC3kwc9/Q==
Message-ID: <298da9ba-889e-4ff9-bb31-8cbd77166859@kernel.org>
Date: Wed, 27 May 2026 21:44:12 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: remove unused data_ack from struct
 mptcp_ext
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Paolo Abeni <pabeni@redhat.com>
References: <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/05/2026 19:04, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The data_ack and data_ack32 fields in struct mptcp_ext are no longer used
> anywhere. Remove them from the structure and update mptcp_dump_mpext()
> trace helper accordingly. Drop the data_ack field from the trace entry
> and the corresponding output in TP_printk().
Thank you for the follow-up patch!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

New patches for t/upstream:
- f51ec6de6c5a: mptcp: remove unused data_ack from struct mptcp_ext
- Results: cde220b5fe28..2b800cf792ef (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/8b808b715575367c7e00bcd76a597b7b57d674b8/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

