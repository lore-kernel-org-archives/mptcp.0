Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581994A5C5A;
	Thu,  3 Sep 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445138; cv=none; b=gRM/5qmmuaCCiZH2zEX+dl02aGBYivBs0ZIF8W8nIii+2w4FXqYzo/3xi/60liS5gDH23kclJD4Ts57xh7KLQ9CGuUVsLfSVm93COQKURsWXa2bpitS5uM5NQ1n7L0o90wJYWs+rlNC3cFESm2gZjZ7EWKz+3xYMRkNkjDC2Ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445138; c=relaxed/simple;
	bh=Gx75y4ScOA7q8K8CiomJUo2TldES3aJd/4SPikQgWRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/gXzaHo9nwOphRaFA7/IDu/Wg2G8WcMPEvzza099+n8/78KYKBDsoatM5mFGThYsxLIzLD1tv7SYlhM1gZGVKXzzTR5Vgu/6AZXMRWJY7uT2hWYY0VRrrvkN+706UxSKZZuWI8ChwLESedI1voNGrG/vaGkZEGbiDilnGP9wGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH4XBxBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH4XBxBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311AC1F00A3F;
	Thu,  3 Sep 2026 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788445129;
	bh=hVwCftVtopKNaXgm6dbtLSWZROH0doX8x2yFaD6FjQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TH4XBxBvKhUcnd5DzG3qyJPOVYUIIzZFLDw6cXezJnPJ04WcQXVrJyO9CKo6PemOf
	 9SEAx9VY4bgUVDdltpVWfoYTZZYcAT2bGdatY17E+iv3plYXA6f6SH6zEy+SWZB2Cg
	 X0hP9xZZkE3FdkMCI3uzVuxkgT48isZ6AQ3cgNlFPrUbn8Px/7uYtPFi1F9jxlLaKO
	 eJuUVUCN5t/KxaLKqi3Y8lYbzTJ02vmLK6EFTe2epb/5ZNVpGIk4ynkZrzZYJrLdU6
	 YgCG7EtUS8j7Vi/F5Vf5t8/pEIGAXBCrccKE95L0K4+99IP2JP1BH+9v6qZfhhBujW
	 HO4zatrDJ8owQ==
Message-ID: <32c614b0-b103-4962-8206-4a25ee7cd766@kernel.org>
Date: Thu, 3 Sep 2026 16:18:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 3/3] mptcp: options: reset parsing in case of
 invalidity
Content-Language: fr
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
 <20260903-mptcp-mib-inval-opt-v1-3-84a553c552b6@kernel.org>
 <20260903113800.968991F00A3A@smtp.kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260903113800.968991F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 13:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `break` statement inside `mptcp_get_options` incorrectly exits the `switch` statement instead of the `while` loop, causing `length` and `ptr` to become desynchronized, leading to an infinite loop, out-of-bounds reads, and MPTCP option smuggling.
> --
> 
> commit 60e4bc5aa7cfc08049c3062323eeae263a824439
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> mptcp: options: reset parsing in case of invalidity
> 
> When an invalid option is detected, it is safer to drop any previously
> parsed MPTCP options. This ensures a fallback to TCP or a subflow reject
> instead of just ignoring the currently parsed option.
> 
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index aaaabcab0f8f9..b6d2e39f8464a 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
> [ ... ]
>> @@ -461,9 +456,12 @@ void mptcp_get_options(const struct sock *sk, const struct sk_buff *skb,
>>  				return;
>>  			if (opsize > length)
>>  				return;	/* don't parse partial options */
>> -			if (opcode == TCPOPT_MPTCP)
>> -				mptcp_parse_option(sk, skb, ptr, opsize,
>> -						   mp_opt);
>> +			if (opcode == TCPOPT_MPTCP &&
>> +			    !mptcp_parse_option(sk, skb, ptr, opsize, mp_opt)) {
>> +				/* invalid option, drop previously parsed opt */
>> +				*(u32 *)&mp_opt->status = 0;
>> +				break;
> 
> [Severity: High]
> Does this break statement exit the switch rather than the while loop?

Arf, it was supposed to be a break for the while loop, but I missed the
switch... Let's use 'return' here, then.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

