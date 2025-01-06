Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8991D86FB
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153122; cv=none; b=cRFAvUdL4TM98W3NsNe8qlD9PWc/IvU17dZdEggYUjgHNF/76kdLpasUV04MOaxZOcMM9TLyhBWwffwOzbjX5HEiyQ1s70RbN6VrKwsz5UuqooDGLTrm3j3yxre3o/0heX6WlbCmVfRMmff+Qk7Tg9tKy7vRPOi8Kz1i1qKf45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153122; c=relaxed/simple;
	bh=PFhIDj2A8WMQA3bAupX2l2bR2gCS+gxYqO20j1NWpSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BvW958qP23k4r4tmXYUN2M5aZNj4ApsghJvDX6RauiFBV9cKmWm8iXW1ZwOwS9cgiRg0IqaFRbCntXsFL3smO+fGI1IPIPWP2X8xO5c6tFZa484JhL42rNb4SJ6n81cTlZcLV9RWQqUyCZ0twHCZi6gLD5fUp4c5uwTtbA/slQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt/41xAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt/41xAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3B1C4CED2;
	Mon,  6 Jan 2025 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736153121;
	bh=PFhIDj2A8WMQA3bAupX2l2bR2gCS+gxYqO20j1NWpSQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jt/41xANaSlOfeYPpAjbyOpsDTyz2sFIMh/08vwks8/xx6vjhPylYyOeH+pBL2YnG
	 mMrieHEG1h5ZEaJ1+Z8cn8ilbTnV6Q7SLFGVHyFgobPgeDeyc/NFgPyHs/seM7XNvA
	 4wDMjCsj/yPbtGISACucfmj/ZuHBhKpvSZwMiL1JEgO6lGWrvJWGKJOKA9MqTqZKsy
	 wHPwwxrhu07C9CJp7f1Zb41wLfyar9t4EyuqZIb/f65Q4gXo5OOIpgd1Ao0XEOrZYj
	 N+FwAOeTOg76UwG9RhNlOv4i/buwpLKqJrjSp2/evS1klchIqpuJlGeiodn7LIAKTU
	 wyiH3TGdeAzuw==
Message-ID: <239060ce-34fe-435a-88f4-9e171d7ee0ad@kernel.org>
Date: Mon, 6 Jan 2025 09:45:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 3/7] mptcp: pm: improve error messages
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
 <20241230-genl_req_attr_check-v6-3-3ec9103559e7@kernel.org>
 <e22df271143ccf0dd9d7f20398c37dcd68db01af.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e22df271143ccf0dd9d7f20398c37dcd68db01af.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/01/2025 09:41, Geliang Tang wrote:
> On Mon, 2024-12-30 at 14:24 +0100, Matthieu Baerts (NGI0) wrote:
>> Some error messages were:
>>
>>  - too generic: "missing input", "invalid request"
>>
>>  - not precise enough: "limit greater than maximum" but what's the
>> max?
>>
>>  - missing: subflow not found, or connect error.
>>
>> This can be easily improved by being more precise, or adding new
>> error
>> messages.

(...)

>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index
>> 9c0bec588c498e0aa78acf4018db509abe90cad2..a8f73b082460ba00f7fa998cf76
>> 46368f8201e2e 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c

(...)

>> @@ -634,6 +638,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff
>> *skb, struct genl_info *info)
>>  	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr,
>> &rem.addr, bkup);
>>  	release_sock(sk);
>>  
>> +	if (ret)
>> +		GENL_SET_ERR_MSG(info, "subflow not found");
> 
> I guess you don't want to use "subflow not found" here. I changed it as
> "mp_prio send ack failed" in v7.

No, I wanted to use "subflow not found": mptcp_pm_nl_mp_prio_send_ack()
will fail only if it cannot find the subflow matching the local and
remote attributes.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

