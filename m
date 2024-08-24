Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0435894
	for <mptcp@lists.linux.dev>; Sat, 24 Aug 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724502490; cv=none; b=NlXvhO52xKZscpDVA3weA//RPwV7etgA8lfWmi+NEMnInQQOvxNKQqpu9Ak5u11N605xkKeED9fYEGzx6j9nirNwsbeer7mqI0xj58Zteud0gN/V5TWejFvglMzZYAHtfT22bnUNWLq8xu28ZKNc2hgPbpFnVkeV2V/h3ZFThqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724502490; c=relaxed/simple;
	bh=+o8O5NApz1gfsdQYNFs8KjG9JI9+msXU8c3j99VWAu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OFs8eoG+U+TQigLZh2WroVtb1FtI8/QuzH3dxVtuE+9RVwPbgDtzH9N0MoruKhzqhoyk2zawi52r4+MdE7FzE3XkMbpT77EaKSbyRKEDE1QZaYyRO4o4sY7VjGIzBgDoyZIGb9Jwvsl5X/vM67+J56I8NRSRs5GB4uV9SE1ZO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt9QJ9HW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt9QJ9HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D09DC4AF0B;
	Sat, 24 Aug 2024 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724502490;
	bh=+o8O5NApz1gfsdQYNFs8KjG9JI9+msXU8c3j99VWAu0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Yt9QJ9HWSJp3c0D1ofOTZZ/T3a01JdDtkZRXoVSH9hhr/tEZ819B4+mbPZCmz5BSr
	 amS0OGXBaPqzoEJxcC0uzyvE4cVMW7m+YBitWs95z7pkadABqMjRoLhq9B6hogdaRf
	 Cz6jq21qUy0yuULkjqt/HTOg6uzxYl5r+bO6FNqGKxrL+C9ETPxFaH5OuAB1zWzveX
	 OhPF77JqRvQlDEQeIPSxyjnoOY5GrYq5nKxVAub6E732YkmjESiXj4DT5M/bw+b1g0
	 OvwDNHZOFMMZbwpNnuc5QHvJJy6pkIQy/KCOpJylBDSvJLCWdUBQPtBj9lj0QKQceW
	 2C1xD/YmFnQNA==
Message-ID: <edc3b935-26e2-4926-b9d3-4c4fc1eb0cf9@kernel.org>
Date: Sat, 24 Aug 2024 14:28:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 09/12] mptcp: avoid duplicated SUB_CLOSED
 events
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
 <20240816-mptcp-dup-close-evt-v2-9-8a33f6617f5c@kernel.org>
 <35a841ef-ca3d-347f-43d1-fafd82639214@kernel.org>
 <2ec9ae4e-bde7-45d1-8f28-f4be1f534838@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2ec9ae4e-bde7-45d1-8f28-f4be1f534838@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/08/2024 13:44, Matthieu Baerts wrote:
> On 24/08/2024 02:44, Mat Martineau wrote:
>> On Fri, 16 Aug 2024, Matthieu Baerts (NGI0) wrote:
>>
>>> The initial subflow might have already been closed, but still in the
>>> connection list. When the worker is instructed to close the subflows
>>> that have been marked as closed, it might then try to close the initial
>>> subflow again.
> 
> (...)
> 
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 22b7eff311f5..ce15e7db464b 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -530,7 +530,8 @@ struct mptcp_subflow_context {
>>>         stale : 1,        /* unable to snd/rcv data, do not use for
>>> xmit */
>>>         valid_csum_seen : 1,        /* at least one csum validated */
>>>         is_mptfo : 1,        /* subflow is doing TFO */
>>> -        __unused : 10;
>>> +        closed : 1,        /* has done the post-closed part */
>>
>> One small naming request, I think something like close_event_done would
>> be better so this flag doesn't get misused in the future.
> 
> Good idea, I'm going to change that when applying the series.

Or just after :)

New patches for t/upstream-net and t/upstream:
- 3138fa0a53c0: Squash to "mptcp: avoid duplicated SUB_CLOSED events"
- Results: bbc47d79e5c3..77bc31f37f6d (export-net)
- Results: 07b49b0ab9d5..07b49b0ab9d5 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/e5ce71220ca9cd3ae413de9bf6b0f587fce9e94f/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/d11a08bb27165964dbd97048bfad3b89f47fb355/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

