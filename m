Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90535A939
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793511; cv=none; b=UewO3489dGDXuXvixMFJp2Ymf99KDxYF64o49lRZUfiUZZ4l8HWRMa+6Z3PRYjVQx0i+ZKHZAvTEk/d6Cjx/qdAyudSNu1Y0Iyc9cMwcXyxv/DW5wK7Xc0vyjBD2Zu2wvgI8dKj1s4gsIVVZK8g7JANea8JgUQ8H6LxmSv2DjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793511; c=relaxed/simple;
	bh=g5C2bCdRlw3bLjDlz9nnspvan/S1lsyTK6DW6S1pbLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmbWAmDzGsI5ulTr02ep1IesvLuiSs0ZQmz0xsoJnHl49PvgA9CY7GmE7zMU6mt172wNHtOLHt7iHzr/HJ3WtUdTQGmxCC9bvJYDOtSegnsG7VPO1NakBIR8hJ69RVN6zecBnn/7aa4R7E+KtVjeRk/Uj4jDaCiquhxvZVqU5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny1LYGWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny1LYGWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836ACC116C6;
	Fri, 30 Jan 2026 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769793511;
	bh=g5C2bCdRlw3bLjDlz9nnspvan/S1lsyTK6DW6S1pbLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ny1LYGWj0zw6Fe/3AEu6LKDjjxYLSS39ovrcJDoH2/4m79TBaJgiwjrusvCr7nitG
	 QK+dCubJJ9DcEveizNv38DY/Cpbfm4pd11r7E7EtxwDgUqsfcfUJ3IisUGK7JrUEwO
	 3sBX2Nfzk1muzWOGHrzn06VlOrM7CIQOJ5EbsGrAdorhM6sOgMKd99GzsCXLUXjjJq
	 QyLS/DwWq5KfA7J9edVIOtX0A0Ok9dwPxvLL3OVOGsOjZOF4Op5BlbV9wGGU/5zdj+
	 UPbjL2uTJSFUOAHg3a/CVBWXVM8jpDB9+NTtjPBTvRL3w0PfIAX8HD23uM/hvNj3oR
	 SubTbuV1HkvWA==
Message-ID: <b6b936bf-ba4b-422d-b762-55d61e8712f0@kernel.org>
Date: Fri, 30 Jan 2026 18:18:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v15 4/6] mptcp: implement .splice_read
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
 <eb8faceedfba8da224fa5467dd80d0c7f99cfd3f.1765023923.git.tanggeliang@kylinos.cn>
 <24a4b887-393c-46af-9166-ab7b6c0e3762@kernel.org>
 <bfd9ef7479eb2696b8606ba1e34702303dd01fe1.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bfd9ef7479eb2696b8606ba1e34702303dd01fe1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Matt,

On 30/01/2026 14:54, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2026-01-30 at 08:19 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 06/12/2025 13:33, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch implements .splice_read interface of mptcp struct
>>> proto_ops
>>> as mptcp_splice_read() with reference to tcp_splice_read().
>>>
>>> Corresponding to __tcp_splice_read(), __mptcp_splice_read() is
>>> defined,
>>> invoking mptcp_read_sock() instead of tcp_read_sock().
>>>
>>> mptcp_splice_read() is almost the same as tcp_splice_read(), except
>>> for
>>> sock_rps_record_flow().
>>
>> (...)
>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 01d602f0d556..334fdb10fdf3 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>
>> (...)
>>
>>> @@ -4423,6 +4535,7 @@ static const struct proto_ops
>>> mptcp_stream_ops = {
>>>  	.mmap		   = sock_no_mmap,
>>>  	.set_rcvlowat	   = mptcp_set_rcvlowat,
>>>  	.read_sock	   = mptcp_read_sock,
>>> +	.splice_read	   = mptcp_splice_read,
>>
>> When looking at this patch in more details (after the issue with
>> kdoc),
>> I was wondering: is it not needed to also implement .splice_eof,
>> similar
>> to tcp_splice_eof()?
> 
> Thanks for the reminder, I'll try to implement mptcp_splice_eof later.

Thank you!

I didn't check (yet), but do you know when it is used and what happens
if splice is used, but this interface is not implemented on MPTCP side?
Are there issues with the current implementation?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

