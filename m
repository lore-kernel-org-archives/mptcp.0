Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1902848AD
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887207; cv=none; b=EBTNaWsDtpnyNcAvTzLJu8/JpSj8WPQdYv+Vc6RgzrC7mldLGjYR4ERkp0Uc9AmK8LWnbNfs5nBM1jgg3Gqufj+oj34KT89H+16mQbLcfa0TjG80qMLOgRwJOwiptBE9b9T+W5qF8YJgh1osSRZRo4jP7zAs1Q076j/40k9s3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887207; c=relaxed/simple;
	bh=b2AOTeQH5gUd5wNgHfaUUO5WBWWvvfHSU4csTs6tqd0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VljyRJbiXYzsBX0G0LjTQBvXB/BO4EFS2JyosvZ4Ac+qgA0KS7rhBTab8OMlyTZB4SJomhldI4xYiMmVJjVijj5bCWJ8SaWnDKrA/+zSD3GLopTcUDfUVS/ugweMbSeIYuTyRj4QGgLJRT7KWS4+LDIb5itgQHTZMmN05yxf/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfUmz8BW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfUmz8BW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D212C4CEF5;
	Tue, 11 Nov 2025 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762887207;
	bh=b2AOTeQH5gUd5wNgHfaUUO5WBWWvvfHSU4csTs6tqd0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ZfUmz8BWkYYiS8UcQUBmxEhqqLzlhsQyVcs0kuTJ41CwYMr2X2cCD1l21lTgvA1pv
	 yRpbV2XfX928nST4ZBUQcUqE3N5V2PTWqjAaVBpysuR/KiwNf+IXvAJ+YyYpEc+F2T
	 zbipaxZkqWx4k+WMDESJxgZf7GsojCMkyTdJGWyEfPdqWSAtuHFL1gvZsFE0/sVbPV
	 uHH1agjWdJmR+Xm9y1mQoEiSreBW+0JQpGqPUAImeRks+ktUvUsOxBWuF3LYiDlLjH
	 skbRJGdPiffTmKFg8BN32A1Jv0ka4Jljr5JB91XF5DU5VhUnZZWBoE8LzETubKepLu
	 4X57dKD8vOOnQ==
Message-ID: <127e3172-3a82-4286-a095-b8cf884df056@kernel.org>
Date: Tue, 11 Nov 2025 19:53:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 mptcp-next 2/7] mptcp: avoid unneeded subflow-level
 drops.
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1762504059.git.pabeni@redhat.com>
 <6af807a4d56bcac85d0908e30251ffa6d28ea38f.1762504059.git.pabeni@redhat.com>
 <e820a52a-7944-45b6-b3f1-4012a3856a4a@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e820a52a-7944-45b6-b3f1-4012a3856a4a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 19:43, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 07/11/2025 09:32, Paolo Abeni wrote:
>> The rcv window is shared among all the subflows. Currently, MPTCP sync
>> the TCP-level rcv window with the MPTCP one at tcp_transmit_skb() time.
>>
>> The above means that incoming data may sporadically observe outdated
>> TCP-level rcv window and being wrongly dropped by TCP.
>>
>> Address the issue checking for the edge condition before queuing the data
>> at TCP level, and eventually syncing the rcv window as needed.
>>
>> Note that the issue is actually present from the very first MPTCP
>> implementation, but backports older than the blamed commit below will range
>> from impossible to useless.
> 
> Thank you for this patch!
> 
> It looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
>> Before:
>> nstat >/dev/null ;sleep 1; nstat -z TcpExtBeyondWindow
>> TcpExtBeyondWindow              14                 0.0
>>
>> After:
>> nstat >/dev/null ;sleep 1; nstat -z TcpExtBeyondWindow
>> TcpExtBeyondWindow              0                  0.0
> 
> Should we eventually track this MIB counter in mptcp_connect.sh?

(This can be done in another patch later, we can also create a task to
do it later if that's easier of course.)

> 
>> Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
> 
> While there are still discussions on patch 6/7, to ease things, I
> suggest already applying only this patch in our tree (fixes for -net),
> the only material for 'net' from what I understood.

Done:

New patches for t/upstream-net and t/upstream:
- 9250eb1bd82b: mptcp: avoid unneeded subflow-level drops
- Results: 7d372ea35141..25f5033b9887 (export-net)
- Results: 3b1f54eb2ace..3dad323fd8af (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/ef271ef4961b23166a56d80c5136bb85b29826d8/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/473f3b6a6838866eed83d85449df20f654ac4c1a/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

