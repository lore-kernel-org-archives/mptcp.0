Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DB45A28C
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547011; cv=none; b=hpOqUSWL5Ub2WOgAxajwAd31NiuDiauXFlicsDzEER16n82wAKzMVnvilZhPRaKfcIERbS+siW1qoBQIyMHrsc7l9iGjFtkgM+bQzNH3fYzRI0lC4d9lI2tzkKYfXxAyQdfeCP6Fd/TtW9MDPYmjnfqILPGY7KwvHGjSYEHS1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547011; c=relaxed/simple;
	bh=6kkNIgf6NYDmzWuTuoRBmit3NprP05qoJCL6f6x5b4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2iCKAf8JUw5e/XuKQV9jD0kRz99Lo2wiGi1gMaDAY/ty2vtvYvV9eMgyiWxWU4rDj1lNE3MH65uPtVM61wpQS/TMiyG2qgyhizsVT1VcVQPXAi7O8qI+4kfgXPtmZKF7qSYFkO+QRvvCNPna0AlqhtflMMaXCIbMuxLILBqph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSHEuiOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSHEuiOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA11F000E9;
	Wed, 12 Aug 2026 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547004;
	bh=GA2NJUaSv6HxX6VQHWh4kfpug83P3Shn7mItuJfthPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lSHEuiOfo6/F5m0ps+GqrlTH031bAU9xfEJvTwPISqU2x2SVhoQy0qMx1ozv/OuqX
	 PJjehEcGk8SyKQ9R5Rl8mv/PlKlCznsgnEuJwq71yNXopVx3jXbAZhJLDWOnRL4CWQ
	 gs5kMQRO386HTNkiX6YXPXgSE4Wzj1K61PPDsZZbbAzrYrd8E/2EWXg+yunmznvaAp
	 fhf+Suy/ySo/FtuxPJMRDfVGE+22eOelGeqFZ2hpmZTfY44U2JaX85rb7CqtGN3PMU
	 0qJwBg27BruA7sE8xyrgraD7ngTXThIEkyHkCsUW7vVpm2Q/x4JcPCJewfFTw5+msE
	 joizTm5/Ywjkw==
Message-ID: <d5ac123f-51f0-45c1-856c-c4693fc17a33@kernel.org>
Date: Wed, 12 Aug 2026 17:03:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/2] mptcp: MIB counter for invalid option
Content-Language: fr
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260812100550.148670-1-gang.yan@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260812100550.148670-1-gang.yan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 12/08/2026 12:05, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This series is designed for [1].
> 
> Patch 1 passes the 'net' to options parser, I used to use
> dev_net(skb->dev) for MIB counters, but the AI reported it is not
> suitable for this. This patch has no functional change.
> 
> Patch 2 adds the InvalidOptionRx counter, and increments it when
> receive the invalid options.
> 
> The packetdill testcase is submitted, and can be reviewed in [2].
> 
> [1] https://github.com/multipath-tcp/mptcp_net-next/issues/628
Thank you for the patches. Please next time add a comment on the GitHub
ticket: I already have the patches ready, but I had to wait (for
administration purposes) before sending them:

============

commit 8173df5a467cac6ed421bb832ac3ee675b490fa6 (b4/mptcp-mib-inval-opt)
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Fri Jul 31 14:10:38 2026 +0200

    mptcp: options: reset parsing in case of invalidity

    When an invalid option is detected -- any unexpected suboptions
    combinations or use of invalid sizes -- the current behaviour is to
    ignore the currently parsed option.

    Receiving such invalid options is suspicious: either this is coming from
    a buggy host, or an attacker. In this case, it seems safer to drop any
    previously parsed MPTCP option from such packet.

    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit be5492962195d2988a9c508bc8ce4d3f55ac1da7
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Wed Jul 29 20:01:45 2026 +0200

    mptcp: options: track invalid ones

    Any unexpected suboptions combinations or use of invalid sizes are
    suspicious: either it is coming from a buggy host, or an attacker.

    Better to track that with a new MIB counter.

    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 684c6244b5b76d30aaf30d62597247485b89cdb3
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Mon Aug 3 20:24:02 2026 +0200

    mptcp: options: use a dedicated bit for csum reqd

    Instead of mixing that with suboptions: that's the only non-suboptions
    that is present in the 'suboptions' field.

    This even cause a workaround with OPTIONS_MPTCP_DSS to exclude this
    non-suboptions when checking which other ones are set.

    Move it to a dedicated free bit, and adapt the corresponding code.

    This is clearer like that.

    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

=========

In your version, I see that you increment the counter even when the
suboption is not invalid, e.g. the version or the hmac is not supported.
I don't think we should do that.

If that's OK for you, I can add a co-dev by on my patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

