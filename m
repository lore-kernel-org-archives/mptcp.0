Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BD3A3E88
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767744; cv=none; b=suTZIbD+u8sYejOkp11LAbSJHx2USWiFHvkwrDhEOzOBVj08F2GDXQwMc3mchsBNe/5JPQSvYp9s0YwXDN1TpuSpXmNJxlrJnEADYXn4gvGVkGEV/czigUVD/AJW3DivMpUA1b4A1U7MREiwAdJZoD+J6cm+sdT7uzO5b8cNwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767744; c=relaxed/simple;
	bh=mP2Xx8OVvV+s8o0s3KnkeOcnpTBEidNmN/cVN610Wck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz3AFP3C0/AMGNqQjyDHrkn1Ol5XydDj6ATtJcvacrZxgQKzRLaq/JQcbjb7lR2eGLEm0WN1kBOYovFVDx85VolYr6U1pHjOnWM2GSNc3WoI+pP8VO+u6UMocfgEHmG584yBE5CVAwiCeIzVa5bjBs/k8bC5IMrCpypkvA7keL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeKFvGH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeKFvGH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F61F00A3A;
	Mon,  7 Sep 2026 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788767742;
	bh=lSvdQ0q5Evn+3rssvVe6jG1w9jAP7/KpRmK/r5wFfGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EeKFvGH4HnSjnQL21i8xkhZgf+gRWZ0cMt40ccKzkNtCLj4o4ipOTuYSew5BmX/Un
	 TeJbUmUxKS2YXGUFTdM5znNzpClZvGPHqPR+bBpRr7UD7GGFv9k6cYLAV+ywFV+2hm
	 xxqeEDTjL3S6ph6Bvn8o2TXukeggNK1WNP7GSMYBPJ/UB12ustupZV94vzyH+wVaxO
	 E99IBFLZfyN8pmLs3bCqXCkr5ZFDabi8RDsH46+zUid2YSpmOvTmdncnHv1JNSbpOL
	 qV1oTl7BCwpmsEa9mSuoSp/dfE2+FenxLU8KLzE+tFi9Fh6SzuNNpmSQO6srFGqTHl
	 XXY0Wn2nAGbsg==
Message-ID: <225ce3d3-be08-4247-9d72-7986b8313114@kernel.org>
Date: Mon, 7 Sep 2026 09:55:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org> <apjU-uM8dvxnVcaP@fedora>
 <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org> <app68h1_rYkPBpvn@fedora>
 <aa5678f7-7089-4049-9120-6604372667ac@kernel.org> <ap4NEvXYLC1U8hqO@fedora>
 <afad1474-88ac-413c-b81c-1ff1de2c6738@kernel.org> <ap5gzozOFWNTJPDc@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ap5gzozOFWNTJPDc@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/09/2026 08:59, Hangbin Liu wrote:
> On Mon, Sep 07, 2026 at 07:50:04AM +0200, Matthieu Baerts wrote:
>>>> If a global nft_handle var is used, that doesn't seem clear, and I think
>>>> it would be clearer/easier to:
>>>>
>>>> - either delete a specific rule (but I don't think that's supported)
>>>>
>>>> - get the handle from the test and use it to delete the rule
>>>>
>>>> - or flush the table.
>>>>
>>>> So up to you, but probably best to avoid using nft_handle as global var.
>>>
>>> Thanks, endpoint_tests is the only test that could delete iptables rules.
>>> I use the nft_handle mainly because the iptables also delete rules with
>>> specific match (iptables -D OUTPUT -s .. -p tcp -j REJECT) other than flush
>>> the table directly.
>>>
>>> endpoint_tests
>>>   - reset_with_tcp_filter
>>>     - iptables -D
>>>     - iptables -I
>>>     - iptables -D
>>>   - reset_with_events
>>>     - iptables -I
>>>     - iptables -D
>>>   - reset_with_tcp_filter
>>>     - iptables -D
>>>
>>> While from the logic it should be safe to flush the tables. I can avoid the
>>> nft_handle in v4 (after v3 review).
>>
>> Just to be sure it is clear: nft_handle can be used, just better to
>> avoid using it globally I think. An alternative could be to pass a local
>> nft_handle to reset_with_tcp_filter and set it there, but in bash,
>> that's not very clear either.
> 
> reset_with_tcp_filter is also used by subflows_error_tests(). It's not easy
> to just passing nft_handle to reset_with_tcp_filter for endpoint_tests and
> leave subflows_error_tests() not affect. If there is a new version,
> I'd prefer to just flush the table if you have no objections.

Fine by me. Deleting a specific rule doesn't seem to be as easy as with
IPTables. Please mention in the commit message that flushing is fine and
easier/clearer.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

