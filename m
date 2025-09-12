Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1582D23B9
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663448; cv=none; b=U13GynjvP2zjqV8AjG5t8zoJ14Wn2IhgWZKwJ2CdOHnCzmGzTcf6In1cZRtiLzWktftGmBPsjXxVwPcXe/ifq9cnVYpsVC4w6rR+aB8cMpzBsslQUeP2gsJUCLpiPcRhxXBIEqAMN6/kPuSc9W4AJs1MULUF6whIiMYSR3arhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663448; c=relaxed/simple;
	bh=SZ6W0Qj3/IWLneMQVxwmtkRWXntmX+rlvXXL8ru8g1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEuSO22C99dbnTaQ2ka8SssZJeO3Ygn98M6FvEB3wI5TdvJeoegb2aSPljwfUR7zHzKALDyLBaMyQxDZDG8p/j1gNKwoSCpeOzuOSrZxm9qpvDIITr1bIt1K0DnJc5Pzy9e/Oxu+lTiWEZr62DYFiXWe/97bv2QOlYeGwwoJfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTOj6ei+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTOj6ei+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A01CC4CEF4;
	Fri, 12 Sep 2025 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757663448;
	bh=SZ6W0Qj3/IWLneMQVxwmtkRWXntmX+rlvXXL8ru8g1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YTOj6ei+JfE8XwOUefixKTZvUxIPQKw/3Jh/ByqwZBBH+xhHQP+Fz9CM0YMr5z4kY
	 079NQB4bNBm8DKVFx3d/p7IDjHhgCiP9oBrjQYFfB52+jgTzh/hSGbZspJBu+89eUd
	 7MCGjjITcJzvW1QIbG6qacG3uE+CnC66mKSLCjEEdyBz45EL8nYbdSM7uAgPpkGb/R
	 gEpxnzpj7oQr8XkXBf9PgGEINGhXW61bDdIQM1s2LlxrV3prrHlxR4ReUybuCu823X
	 3gdkhdOl6GpVuCEv8bQ933kFDoc0Q8L6aIRAXmNLPs02KN1v/psrLjBXqCJu8QMa1L
	 CMI1uFa+2+aBQ==
Message-ID: <7211c209-f211-4614-9433-6d7e792a6961@kernel.org>
Date: Fri, 12 Sep 2025 09:50:45 +0200
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
To: Christoph Paasch <cpaasch@openai.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
 <20250910-sft-mptcp-disc-err-v3-1-6799fa467d77@kernel.org>
 <ba8c54a8-3ad8-4ae5-879b-05f6b6a45319@kernel.org>
 <CADg4-L9JGT1K9pjXOtL-SjvHTz2yAW5bXAqK-6J8OJZRw+fx1w@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADg4-L9JGT1K9pjXOtL-SjvHTz2yAW5bXAqK-6J8OJZRw+fx1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 11/09/2025 21:08, Christoph Paasch wrote:
> On Thu, Sep 11, 2025 at 9:32 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hello,
>>
>> On 10/09/2025 10:55, Matthieu Baerts (NGI0) wrote:
>>> When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
>>> metadata to exchange, and all subflows can be safely shutdown.
>>>
>>> Before this patch, the subflows were actually terminated at 'close()'
>>> time. That's certainly fine most of the time, but not when the userspace
>>> 'shutdown()' a connection, without close()ing it. When doing so, the
>>> subflows were staying in LAST_ACK state on one side -- and consequently
>>> in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
>>> socket.
>>>
>>> Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
>>> consequence of this is that the TCP 'FIN' flag can be set earlier now,
>>> but the end result is the same. This affects the packetdrill tests
>>> looking at the end of the MPTCP connections, but for a good reason.
>>
>> FYI, I don't know if it is linked to this patch, but the CI recently
>> complained about the "dss_fin_retrans_*" tests, in debug mode only:
>>
>>> # dss_fin_retrans_close_wait.pkt:27: error handling packet: timing error: expected outbound packet in relative time range +0.200000~+0.300000 sec but happened at -0.017265 sec
> 
> What is more suspicious is that the time is negative. Do you capture
> pcaps when running packetdrill ?
> That would allow to see the "real" timestamps independent from
> packetdrill's scheduling issues.

No we don't. I also don't know the effect it would have on the public CI
in debug mode.

Locally, I tried to reproduce the issue with '-vvv', but I didn't manage
to hit the bug after ~4h, even with stress-ng in parallel. I just tried
without packetdrill's debug output, but with the packet capture, and no
luck there too.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

