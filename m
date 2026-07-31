Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00009439014
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510790; cv=none; b=La+2Pl60ZlTJStOBG7GSc6VYNI83QoRGCeSKNJpxaqaRpCEuYBJgc5Yo14L082pOXE3ocDn2uLUPIYn9wtbmn9gKx0Ic/2xJi/J6uIK5qSyA2GewoHwaIxgVLQKCU5ZrnSONQLOFM2o4UbyoXpuX/4ICZw/WsFJar6Qo9fb2vXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510790; c=relaxed/simple;
	bh=rWmsWBSDHtnYFmrBxqc+UBJIZqobRJuWodWqYNwNN98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWUJyjbING4k3iCTmYgAP/fLlYgIAyj2tK4nR3PfuDWVgcpKTxL7ioakzAylOcSsrkZ/RNkcnJrS5Ed8dRO8j2ZEtGq3Yf0gGO8AntpoqG/wRnkK31BfAi/F5FPBw//JSFBci0Ckey5mG/ExUoVbdmO5rkkZfgGfk6JJEYDF9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWBZ0VE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWBZ0VE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F51F00A3A;
	Fri, 31 Jul 2026 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785510788;
	bh=C0P78TCODWQt0Rm0RtdmfiakZ0wKgyVlSrr+y8fVvjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eWBZ0VE2lAi+wW6JBatqYH8kzhKUv9U1sUjvbJlP38VQ2TshBS8dfYfw6ZXB5ASPi
	 aWyeKcSIcOlZtINcgg1a3Ye0TNoZshj+faLeAFX4jxMDEcv7uxMB87+G2SBLAgXDzE
	 WLLlHQcAzTxyYgNNBXIWoTQGLJbELV4xmsUbDq00RKyvogmgOJBN36bXwJ35RZf+8s
	 +2WrODpR11t5q9sp8pHRzhTH7/yAF9HcaTH0/YPAqCP3sAa+TNzzRyLl3jKE6/nqqr
	 Em5U4rK2nnqM3M4Vv0S9m8H7Rpba39Z/lHMEBdYVbi4GUSV2mJBQWKOPj5AnB7wzwQ
	 RlvHRobYfHIOw==
Message-ID: <9a65ac39-48fb-4398-8527-8ab6eca1c794@kernel.org>
Date: Fri, 31 Jul 2026 17:13:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: diag: fix stack buffer
 overflow in get_subflow_info()
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: mptcp@lists.linux.dev
References: <f66bcc626255440b7fc7ef8c2a9b9dde0675f30e.camel@kernel.org>
 <20260702062909.4147641-1-yijiangshan@kylinos.cn>
 <9155c24a8743c2648ced51f304bc72a9c96036d8.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9155c24a8743c2648ced51f304bc72a9c96036d8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiangshan, Geliang,

On 03/07/2026 03:09, Geliang Tang wrote:
> Hi Jiangshan,
> 
> On Thu, 2026-07-02 at 14:29 +0800, Jiangshan Yi wrote:
>> get_subflow_info() parses the subflow address string with:
>>
>> 	char saddr[64], daddr[64];
>>
>> 	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
>> 		     saddr, &sport, daddr, &dport);
>>
>> The subflow_addrs buffer holds up to 1024 bytes and is taken directly
>> from the command line ("-c" argument). The "%[^:]" conversions have
>> no
>> maximum field width, so if the address substring before the ':'
>> exceeds
>> 63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr
>> stack
>> buffers. This overflows the stack, corrupting adjacent stack data
>> such
>> as the saved return address, and can crash the tool or lead to
>> out-of-bounds writes controlled by user-supplied input.
>>
>> Bound both string conversions to the destination buffer size by
>> adding
>> an explicit maximum field width of 63 (leaving room for the
>> terminating
>> NUL), so at most 63 bytes are written into each 64-byte buffer:
>>
>> 	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
>> 		     saddr, &sport, daddr, &dport);
>>
>> Reviewed-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
>> ---
>> v3:
>>  - drop the Fixes tag: this is a cleanup/hardening, not a fix
>> (Geliang)
>>  - drop the Suggested-by tag, keep Geliang's Reviewed-by (Geliang)
> 
> Actually, there's no need to send this v3, since it doesn't introduce
> any code changes compared to v2; we could simply reply and continue the
> discussion on the v2 thread.
Thank you for the patch and the review!

When sending a new version, please start a new thread, do not reply to
an existing one:

 https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

New patches for t/upstream:
- 46e0ae412a9c: selftests: mptcp: diag: fix stack buffer overflow in
get_subflow_info()
- Results: e486d89a0699..588708fb07a7 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/59dd662fd0777835b9f742de6298ba0953675008/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

