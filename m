Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416734F476
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608361; cv=none; b=bVOHLNk/dk3bker6Ciz+wrtTBdbV0mwmZj16IVAs9nNJRVAiuvjqEcT5lAQGLZz0T38BHNJueGTrfjUrM08UsoioBILBid2RSe1qI0i03k6fD1Kqpw9WsiYZKJjI9SkhHu/ZrwCyHvAhMluXPrO6QM7n15fGAgP29O8YoZIvp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608361; c=relaxed/simple;
	bh=94nbIyuut35EuEucNVXDI08rvqSIqqie0rPeE1yf6sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QpLeT1XSGiD0jbYGo3ultE9J5L9NeNq3qeq1kX/o0AEx5jcG4XiV7DLkm0TgtHg1DfCZiEygHtf2WoFymw8ct0MJrxIj3TN6ifZ57IGJTqH94fRSV0WTn76a7syEWgecw4rNOOovFdY59mG17+QX/EmRbWRIJpWQvQbG4Q6IS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltVkQBsM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltVkQBsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DDAC4CEF0
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757608360;
	bh=94nbIyuut35EuEucNVXDI08rvqSIqqie0rPeE1yf6sc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ltVkQBsMGw/tShsZrDss5aKuD1F0UptV8yxOjkewJFhZNbFPgeq+wRPm+n4MKjFyw
	 IdRMrVHaNScOCxDm//Mksm5gq4jT4RwC6AOBlVhqGRIUJ3g63ppIjRGXum8Sw5MX4Q
	 eYDK2KFHKaSCjsjlyuQzKpfDIfDGfUbCIEDGWdvRHlUhA528P+r+pb3CmgY5U5WkOV
	 3kPBqquJfS9KrLAqvlhp5GW1yxPKulwxLqtUj1PnzzclgevH+CzT5N4UwtX/8o5ogU
	 EMle693qn5ddyYzImgaLFmrs1fvs66ITxmD1lgBmkkHRf1oNKfiYHQfuphWnRcaEmC
	 XSkb4yUfDDbxA==
Message-ID: <ba8c54a8-3ad8-4ae5-879b-05f6b6a45319@kernel.org>
Date: Thu, 11 Sep 2025 18:32:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 1/5] mptcp: propagate shutdown to subflows
 when possible
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
 <20250910-sft-mptcp-disc-err-v3-1-6799fa467d77@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-1-6799fa467d77@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 10/09/2025 10:55, Matthieu Baerts (NGI0) wrote:
> When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
> metadata to exchange, and all subflows can be safely shutdown.
> 
> Before this patch, the subflows were actually terminated at 'close()'
> time. That's certainly fine most of the time, but not when the userspace
> 'shutdown()' a connection, without close()ing it. When doing so, the
> subflows were staying in LAST_ACK state on one side -- and consequently
> in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
> socket.
> 
> Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
> consequence of this is that the TCP 'FIN' flag can be set earlier now,
> but the end result is the same. This affects the packetdrill tests
> looking at the end of the MPTCP connections, but for a good reason.

FYI, I don't know if it is linked to this patch, but the CI recently
complained about the "dss_fin_retrans_*" tests, in debug mode only:

> # dss_fin_retrans_close_wait.pkt:27: error handling packet: timing error: expected outbound packet in relative time range +0.200000~+0.300000 sec but happened at -0.017265 sec
> # script packet:  0.791882 . 1:1(0) ack 2 <dss dack4 3007449510 dsn8 8067261375896427910 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> # actual packet:  0.574617 . 1:1(0) ack 2 win 1050 <dss dack4 3007449510 dsn8 8067261375896427910 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>

> # dss_fin_retrans_established.pkt:21: error handling packet: timing error: expected outbound packet in relative time range +0.200000~+0.300000 sec but happened at -0.021432 sec
> # script packet:  0.791877 . 1:1(0) ack 1 <dss dack4 3007449509 dsn8 8629039693965256448 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> # actual packet:  0.570445 . 1:1(0) ack 1 win 1050 <dss dack4 3007449509 dsn8 8629039693965256448 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>

> # dss_fin_retrans_close_wait.pkt:27: error handling packet: timing error: expected outbound packet in relative time range +0.200000~+0.300000 sec but happened at -0.095031 sec
> # script packet:  0.745018 . 1:1(0) ack 2 <dss dack4 3007449510 dsn8 18052974533214962003 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> # actual packet:  0.449987 . 1:1(0) ack 2 win 1050 <dss dack4 3007449510 dsn8 18052974533214962003 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>

I'm not able to reproduce this issue on my side to get more details
about the previous delays. Please also note that a few weeks ago, I also
reduced the tolerance by a factor of 4.

Because it is happening only in "debug" mode, I just re-increased a bit
the tolerance on the CI side. But if you have an idea of what could
cause the kernel to emit the retransmission faster than expected, feel
free to share :)

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17638263507
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17638077933

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

