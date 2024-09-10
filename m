Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16A142911
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954988; cv=none; b=Dxw0pwicaa6VR7tvgVd7S40XL41JgSiAr1Fz72uuvApKGN6cck1V9VqtD/uJg87iBNxzyBgICSU01KBR9ZEhYXXcj4PYUUVCu3GRS++AeoVrkmrMIHVW/EzqWrFZ5+l/e1BaX/Oswb7HjdTve08PyJ5uu1h5ulyjQ8Vkcm+pq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954988; c=relaxed/simple;
	bh=aD9SPoslerrKtfHJyhXFEHpn9h/uSTWnxW/3S6ITmWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q6Nfj8c4SqS0GQXc0l0gtnFZ6PtkeRLt2yYHyZfJrUBHXO44vfvHRG/iwtOYyUqZxjlwBVhrfU2XJ1QzbsqKZLNum1FK3Hfix9h6w1KGqZnoYpejmpjZTvjzZLgEAmr4H8RSEf3LXm0qV0gqIhmcW+Sjlwqkw3SKUET9ePNmCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esrY/6eo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esrY/6eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB36C4CEC3;
	Tue, 10 Sep 2024 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725954988;
	bh=aD9SPoslerrKtfHJyhXFEHpn9h/uSTWnxW/3S6ITmWo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=esrY/6eoNXSsNyjFwukhcax2WNvn6HLFu/WxKN3VKhohUL1UrPskvLTtwsnAMCx3b
	 UoEaxx2H+kBfpAm36dKo3KFnQ84qLnxeJNmxqyWJ2bCgWe4V8/ZcHymJMAZ02sWA6A
	 VYAmaOxSE6mp5r0tpsQ+XXVGHlf1Qpr347AThKMrCZ1KAAn2zZ6H1apDusfK+EJBRu
	 b4ucYz5mvcV+e3LXVTPzfVbTSn0pJ7Ypli9nAZW/LJMDTYl6gtMXeMGCg1ZGUqgV+o
	 VVQplsMUYkea8yWm1JQRJeLrmnp2ac7+fShC0OR28Gt2o6mix+dTEs770m4Vms6raR
	 vOACHD6ZqKkBg==
Message-ID: <b3897b35-29ee-4b33-8a79-813642cb6554@kernel.org>
Date: Tue, 10 Sep 2024 09:56:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/5] add mptcp_subflow bpf_iter
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
 Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
 <34c218c7-bab6-28b3-1940-949977146e87@gmail.com>
 <7bfdec07684954b812924b51f7295ef3a8ef7226.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7bfdec07684954b812924b51f7295ef3a8ef7226.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/09/2024 08:30, Geliang Tang wrote:
> On Tue, 2024-09-10 at 06:02 +0000, MPTCP CI wrote:
>> Hi Geliang,
>>
>> Thank you for your modifications, that's great!
>>
>> But sadly, our CI spotted some issues with it when trying to build
>> it.
>>
>> You can find more details there:
>>
>>  
>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/10786552828
>>
>> Status: failure
> 
> These errors reported by CI should be ignored:
> 
> Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
> net/mptcp/bpf.c:215:17: warning: symbol 'bpf_iter_mptcp_subflow_new'
> was not declared. Should it be static?
> Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
> net/mptcp/bpf.c:228:42: warning: symbol 'bpf_iter_mptcp_subflow_next'
> was not declared. Should it be static?
> Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
> net/mptcp/bpf.c:243:18: warning: symbol
> 'bpf_iter_mptcp_subflow_destroy' was not declared. Should it be static?
> Unable to compile mptcp source code with make C=1 net/mptcp/bpf.o:
> net/mptcp/bpf.c:247:42: warning: symbol 'bpf_mptcp_subflow_ctx_by_pos'
> was not declared. Should it be static?

Can we not squash patch 1/5 and 3/5 together?

It is strange to add the helpers but not using them, then register them
in another patch.

Or did you split them to ease the review on BPF side?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

