Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E623A0
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711543; cv=none; b=P1KW++VUd8cUeB7lLeT8ul3Vn3tzjrrgrk0u4DUDUEL3Y5OlylccaJe9/pEiM0V+x4hjIPvix9EoUX9xzzJ9rObNH9dISdAYLyLoxGfoiBVNt8jBJwo1EZE+xQT89DijYeCH53edFM4V2pNcazCkJ//pa1Ya19NwhA+SYJBbjbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711543; c=relaxed/simple;
	bh=cg2buXbf2Zh17oXLl+m9N5mHsmK0zDgy4avZ9Ql/gsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7vGLpkhCEs5k7ZuTTh7OfsK2S8oQAmxMEgtqeSyc2P+3b41tci52orIZg4q7cPpyyg4wDQaNTe0kYY4tguasFBAMtuzmbLNjUCUjLh6CiTj8O6FXEWmY8bAhzUmNZt5e0LdSPjx6u3R3ASxgfYja+7MKyyqp8GZXmttyYu/m80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc3N1pQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc3N1pQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E39C4CEDD;
	Fri, 24 Jan 2025 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737711542;
	bh=cg2buXbf2Zh17oXLl+m9N5mHsmK0zDgy4avZ9Ql/gsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lc3N1pQ5jp/HRGhjHQD/KciTvucSw7YPBWIwbj/AaA9f9y2Q5gLhcKa5GiIWh2BLB
	 F62rusO0ewZl1o7aJY5h6fh6Lzb6LWMvKEJ6sa4nuQ2lVrEV3PK8hA3uQNFLMRiTzY
	 a8mfvzWZRgIfLhlKKsq3gb40cOEIRVlbdCVtXm0sB9DjBAfOnkUF9D34y12DRzLawk
	 GN9P23y6/btQH3/eeckGqtPIKOCqkiG97u8TjbmVM6I5n9e2r/57CatL09sagCH3qo
	 jcW2KAqREnCOBei75tgiKK9QwqCPr84Fb29z5LOzxvf85/Lk1ZjpOxx0fPPER8rCGu
	 C5B+oC6dRJA2g==
Message-ID: <b311bbb7-73a6-4bda-9efb-47cac0cb402b@kernel.org>
Date: Fri, 24 Jan 2025 10:38:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: pm: change to fullmesh only for
 'subflow'
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
 <20250122-mptcp-issue-540-v3-2-4aeed3022f23@kernel.org>
 <a75623be-882b-0d3f-97e8-7adb04c46f39@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a75623be-882b-0d3f-97e8-7adb04c46f39@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 24/01/2025 02:53, Mat Martineau wrote:
> On Wed, 22 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> If an endpoint doesn't have the 'subflow' endpoint
> 
> 'flag'?

Oops, good catch! (fixed)

>> -- in fact, has no
>> type, so not 'subflow', 'signal', nor 'implicit' -- there are then no
>> subflows created from this local endpoint to at least the initial
>> destination address. In this case, no need to call mptcp_pm_nl_fullmesh()
>> which is there to recreate the subflows to reflect the new value of the
>> fullmesh attribute.
>>
>> Similarly, there is then no need to iterate over all connections to do
>> nothing, if only the 'fullmesh' flag has been changed, and the endpoint
>> doesn't have the 'subflow' one. So stop early when dealing with this
>> specific case.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>> v2:
>>  - clarify the modifications: new comment and updated description (Mat)
> 
> The new comment (with the one fix above) does make it clearer, thank you!
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- 6a6c787311fd: mptcp: pm: remove unused ret value to set flags
- d7fe0f41b38e: mptcp: pm: change to fullmesh only for 'subflow'
- Results: 9ddf0cb9d180..3b679399ffaf (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/848d0e332ae8b7807e4afe73b7d7ceb6e689f4e3/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

