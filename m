Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703667E69
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608746; cv=none; b=Ya16gA7QafhfY8CcsJERroM6eupJWAE6QUV/MqE+/3WPRYWXjfiykNvtPXNzBZo5la2wI00E3eXtqUmX4x7CFttMR0AOor9ShmcTKvhjoHjLKYG2YEqm5G7SikhU2gvawJG7MNUD8KdCcNcHYKI+31veHqMtpaxK1fFv4P4nwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608746; c=relaxed/simple;
	bh=uTyoeviZGK/PKwROa2SqoZJMi82HaSxoRy0Rs0gbP98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihUYwqmpHt+3TAmvjb2KkTHFjtOn6NI51ddRPM0Rsp+T9VBw2qhsPUn0/VycQ4jkHxxFEbhoRV10rz8gUGKGnqKATgz4WcWSouXPbbJNyW0jUsrc27wlf8+XyNv5NREJw0M4TZh4rR/FJS6ouOy/g4zy6ta4Qo9iwiO/9jMOz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STmQDWaR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STmQDWaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A648C433B1;
	Tue, 30 Jan 2024 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706608746;
	bh=uTyoeviZGK/PKwROa2SqoZJMi82HaSxoRy0Rs0gbP98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=STmQDWaRd5vmSdjQTcs1iLnPpLnq0ck3W1Se9p4aF60oHFcCsRp3f+zNlMZJ2bE7t
	 vieqVTBM6/1RFqZoi3zoP5hA+JQnEDXUF9l/5LFlRrvxOFEoPD5/0DtB9QlaMJMcTl
	 ZANVpNf1HytAkaDNYXhFtp0SF7t+9LujzqEZ6dyyLAlltfI9oTxEELfbcBPUzKnIm/
	 Vf0imKTCUaBQ2bu8d09kjxJpIYkwNhkLf7Vsy+yit0Whu8BPyXl43Ubfb0/IpjnDaW
	 mMjIj5W2cXXw86UotEU1X8ugJdH1ktmVQMUGWH9ZFJpAXzUD/FeP+oo9920SRGp7pq
	 u1drIclcvdlvA==
Message-ID: <625fa4fe-6ecf-4185-bc43-a268f55a3bf9@kernel.org>
Date: Tue, 30 Jan 2024 10:59:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/7] selftests: mptcp: add missing kconfig for
 NF Filter in v6
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-2-f3a4db41c3be@kernel.org>
 <CA+WQbwtkbYkxMkfhs0yUOx5RnJ2_ftNf7i0URMpcBL7qK7GdhQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+WQbwtkbYkxMkfhs0yUOx5RnJ2_ftNf7i0URMpcBL7qK7GdhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the review!

Hi Geliang,

Thank you for the review!

On 22/01/2024 02:47, Geliang Tang wrote:
>> Since the commit mentioned below, 'mptcp_join' selftests is using
>> IPTables to add rules to the Filter table for IPv6.
>>
>> It is then required to have IP6_NF_FILTER KConfig.
>>
>> This KConfig is usually enabled by default in many defconfig, but we
>> recently noticed that some CI were running our selftests without them
>> enabled.
>>
>> Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/config | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
>> index 2a00bf4acdfa..ec70b27288fc 100644
>> --- a/tools/testing/selftests/net/mptcp/config
>> +++ b/tools/testing/selftests/net/mptcp/config
>> @@ -20,6 +20,7 @@ CONFIG_NETFILTER_XT_TARGET_MARK=m
>>  CONFIG_NF_TABLES_INET=y
>>  CONFIG_NFT_TPROXY=m
>>  CONFIG_NFT_SOCKET=m
>> +CONFIG_IP6_NF_FILTER=m
> 
> How about adding this config right after CONFIG_IP_NF_TARGET_REJECT=m?
> 
> Since "IPv6: Netfilter Configuration" section in kconfig is always
> after "IP: Netfilter Configuration" one.

My intension was to place this new entry there to keep the file sorted
by alphabetical order. It is often recommended to do that for that kind
of files to ease the backports. So I put it before "IP_ADVANCED_ROUTER".

But now, I realise this file is not fully sorted by alphabetical order :)

I don't think the order matter, but I can place it after
"IPV6_MULTIPLE_TABLES". I can do that when applying the patches: I don't
think I need to send a v2 just for that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
