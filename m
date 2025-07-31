Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAE187FEC
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954810; cv=none; b=HjIgBF+HhcRcNhz9v2T/EA0nKsukYaORB8xUf+S9+TRi9kyWQ3gexo3qtgcsrKIRy4M+Ep4uh2X6YhKlbb9M4jQyfu9cnqkiTwXYQ1ecU5vIvkz/DoKiSS7cagckbGuOQcORyIMTV3AsOg0gDoeIU/XAKQ1bzZRi3qGMSMgPjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954810; c=relaxed/simple;
	bh=JEfHYf0pBTzHeU0qKVAJM+6WiW1S4XsBV0ZP7nh1d0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYy02+8m5xl8fycu0khJ83LBCCa1C9ovN83logimaEjhXbhl+d8CnmWEd6M6CSymgHy6Y8pC8BgrBs1AgiwPXD5t5tNiWVf65eXlOgsZ32xY7Y1CVJSnRPC3s3fLsl1WYQpYd45ptDFRwjdlF0sdeyJM3dbFIvwq+fXZ1YUkadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra6kK1lF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra6kK1lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28460C4CEF6;
	Thu, 31 Jul 2025 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954810;
	bh=JEfHYf0pBTzHeU0qKVAJM+6WiW1S4XsBV0ZP7nh1d0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ra6kK1lFnNFaI/pr8Vol+KRU2MHUmTLEOPuyoj1QyQKkVD2aSibzVxBOnUZ86EgAV
	 khrikAhNEnN2ttwQ7f0G8xWe1i/E1Q/jPCda6bbjVMysUT4eHOKT3s+s4EA2j5wYPO
	 7ITKZwbLuSkr+0SWbI3msxrBlnnG36pM+sm8jt7gyb/TCcIG5k2XJKeuRPTeZTnnO4
	 O2Cyy0n9uI+2LV2pMLA18lrnzgkmbjYY+/+6iOe445+XJvnvZljFl0D08/8OJiJ9w3
	 8DgwOM6psgrTDHDxyIHYfToWJbkWhEqJdJQkl4VqQ/b6sEBJnMvE7LwtqEZINs4ez9
	 hZ0gkBjgCtVOg==
Message-ID: <9aa94cff-872b-4831-9f38-ce291f2c0a9f@kernel.org>
Date: Thu, 31 Jul 2025 11:40:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/3] mptcp: setsockopt support for TCP_MD5SIG
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1753859907.git.tanggeliang@kylinos.cn>
 <7f2aaa80eef99f64ff6d7a48ce0a6bf06d1cacab.1753859907.git.tanggeliang@kylinos.cn>
 <CADg4-L9m2=4d56kEpy48YYAaEhAe66m6fuG8qN_MdGi9W_GURg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADg4-L9m2=4d56kEpy48YYAaEhAe66m6fuG8qN_MdGi9W_GURg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 31/07/2025 00:19, Christoph Paasch wrote:
> Hello!
> 
> On Wed, Jul 30, 2025 at 12:22 AM Geliang Tang <geliang@kernel.org> wrote:
>>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
>> The implementation:
>> - Allows setting these options (getsockopt remains unsupported)
>> - Applies them only to the first subflow
>> - Maintains MD5 compatibility limitations with MPTCP
>>
>> Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.
> 
> Is there even enough option-space to have co-existence of MPTCP with
> TCP_MD5 ? I don't think so, right ?
> 
> The only way they can co-exist is if a bunch of other options are
> disabled. And in that case, do we really want to use non-MD5 on
> subsequent subflows ? I doubt that, because the goal of TCP-MD5 is to
> "improve" security.

Correct, there is not enough space, and it doesn't make sense to use
MPTCP with TCP_MD5.

The patch description should be clearer about that: supporting TCP_MD5
makes sense when MPTCP is used by default when creating a socket. With
Go, all "stream" listening sockets are MPTCP sockets. MPTCP might not be
used, but without this series, we have a "regression" compared to TCP
because TCP_MD5 cannot be used.

See: https://github.com/multipath-tcp/mptcp_net-next/issues/575

> So, shouldn't we rather disable MPTCP always when an app sets TCP_MD5SIG ?

Yes, but no need to do anything else, because a fallback will be done in
mptcp_connect() and subflow_check_req(). (even if I guess an extra
protection is always OK there).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

