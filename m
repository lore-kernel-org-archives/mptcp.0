Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F499634
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456870; cv=none; b=SRLlgO1dkbl405QyzgUqyPJpfKPfy5t6ME7jigYEWYA+ir0hRJJdiDmyvPYWux/AC4Mr5Hy/wmAobOhtB6S12B4rqpP25ERb3NaoRfV9tJMf6nvEw95hzzwK96UkTOuy2SJMwY/19+2WvnTF7q5JczxziTLfv0LrCh3G8aKd0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456870; c=relaxed/simple;
	bh=1SZ/mo9GVmn7qPwcJ2yVpB+qxIP64nkAWXrCfbVgn1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pzFynJuTOsHbMtd2LWcY9ZdJwYkGZ/JDjyD39MX6rJ4LeTlkac7KrmXrwcFEjN4SA2MdAejZ+pyPQ+xp7oh7vRgTunZdhSkd47SHs0mJXYyucN8F/1Ax7Esv4w2UeVUUdeLpNigifxepDGZRbTREGFJNoi3oMufy1N/7A+bJewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbsge32u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbsge32u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43D8C4CEF0;
	Fri, 29 Aug 2025 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756456870;
	bh=1SZ/mo9GVmn7qPwcJ2yVpB+qxIP64nkAWXrCfbVgn1w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sbsge32upJFGzmtnxdegVvZKN14yCMs3R8z5dgkb7oME/KtefmAM9ipopnMeh64xC
	 wgwyW6zLjhKEFvur++edlu8/sUwJ4GhL1j/g/Qu7cd+BR9EP+WvLFhJxijVrQXdfO9
	 0zohnDlw89RHj6B1L6ozMDTXK2ryef8R7udzg6JLnSpb4hZ/B3Xlyy7MRVKYADp+Es
	 jZ0KRo+J2wHALtqvZEbpugLdYL1CKsmH97Vo2jgioFiFj9Th8PytetOu22YkBUjK3G
	 MFJr6mRBpAYFlL3+VZ2ZMu+UlpeDPDABUJTldobvAIAzTMUtm4JDNszniFvm1Of1zd
	 WsqvItz99ESIg==
Message-ID: <2cf621b7-ae02-48d0-81f1-1c56e24fd13a@kernel.org>
Date: Fri, 29 Aug 2025 10:41:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Adding notify-flags=skip_link_local causes errors in mptcp daemon
Content-Language: en-GB, fr-BE
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, mptcp@lists.linux.dev
References: <05f302dd-2afd-4775-9099-5c34c23e462e@oracle.com>
 <d4c74f72-2595-4fea-8a3c-10bb374e5b06@kernel.org>
 <f6fee54e-cba1-4292-8ec8-f959bda48348@oracle.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f6fee54e-cba1-4292-8ec8-f959bda48348@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/08/2025 04:28, Harshvardhan Jha wrote:
> 
> On 28/08/25 9:04 PM, Matthieu Baerts wrote:
>> Hi Harshvardhan,
>>
>> On 28/08/2025 16:28, Harshvardhan Jha wrote:
>>> I have been using mptcpd version 12 on my system and observed this issue:
>>>
>>> systemd[1]: Started mptcp.service - Multipath TCP service.
>>> mptcpd[2996]: MPTCP address advertiser path manager initialized.
>>> mptcpd[2996]: MPTCP single-subflow-per-interface path manager initialized.
>>> mptcpd[2996]: add_addr: too many addresses or duplicate one: -16: Device
>>> or resource busy
>> Thank you for having reported this!
>>
>>> After extensive debugging I found out that this was due to the custom
>>> flags I had added to my configuration:
>>> addr-flags=subflow
>>> notify-flags=existing,skip_link_local,skip_loopback
>>>
>>> Keeping the first flag as is doesn't change much and only the
>>> skip_link_local part of the second flag is what causes the issue
>>> mentioned above.
>> Do you mean that with the following configuration ...
>>
>>   addr-flags=subflow
>>   notify-flags=existing,skip_loopback
>>
>> ... you don't have this "too many addresses or duplicate one" error in
>> mptcpd logs, which means it might be due to the "skip_link_local" flag?
> Yes, skip_link_local causes this error for me without it this disappears
>>
>> The "too many addresses or duplicate one" error seems to suggest either:
>>
>> - too many MPTCP endpoints have been added
>> - or some endpoints cannot be added because they are already there
>> - (or the help message is wrong)
>>
>> ... which is strange, because "skip_link_local" is supposed to insert
>> fewer endpoints.
>>
>> When looking at the kernel code (dev version), I think the "-16: Device
>> or resource busy" is supposed to happen only if the userspace tries to
>> add an MPTCP endpoint with a specific ID, and this ID has already been
>> taken. Which makes me suspect the following: is it possible either NM
>>> =1.40 is being used, or mptcpd has been restarted after a crash, no?
>> By default, NetworkManager >=1.40 will add MPTCP endpoints, see this note:
>>
>>   https://www.mptcp.dev/pm.html
>>
>> Are you using NM >= 1.40?
> Yes I am,
> ❯ rpm -q NetworkManager
> NetworkManager-1.52.0-5.0.1.el10_0.x86_64

OK, so I guess mptcpd is conflicting with NM, right?

>> If no, what's your kernel version, and the output of 'ip addr show up',
>> but also 'ip mptcp endpoint' before and after having started 'mptcpd'?
>>
>>
>>> The version doesn't matter, I installed mptcpd built from source on the
>>> main branch and upon adding these flags to
>>> /usr/local/etc/mptcpd/mptcpd.conf this issue still appears.
>>>
>>> I will remove this option for now but Fedora had added this way back in
>>> 2021 so I'm not sure whether removing this will cause any unwanted
>>> regressions or not.
>> I don't know if this note related to NM is well visible in the package
>> description in Fedora and others. On Debian and related, there is this note:
>>
>>>  By default, this daemon will load the 'addr_adv' plugin from the
>>>  'mptcpd-plugins' package, which will add MPTCP endpoints with the
>>>  'subflow' flag ("client" mode) for the default in-kernel path-manager.
>>>  Note that this is something NetworkManager does by default. Having
>>>  several daemons configuring the MPTCP endpoints at the same time
>>>  should be avoided. This daemon is usually recommended when
>>>  NetworkManager is not available, or when advanced per-connection path
>>>  management is needed, using the userspace path-manager and a
>>>  custom-made made plugin using the C API.
> 
> Is this for all config options in /usr/local/etc/mptcpd/mptcpd.conf?
> 
> This note only mentioned subflow so I felt it seems to be related to the
> addr-flags=subflow flag only. Please correct me if I'm wrong here.

This note is explaining the default behaviour: in short, the same as
what NM >= 1.40 will do. As mentioned, mptcpd should then be used when
NM is not, or for its main purpose: when the userspace path-manager is
used on the kernel side. That's not the default behaviour, and it is for
advanced usages: when a use-case is not covered by the in-kernel PM.

  https://docs.kernel.org/next/networking/mptcp.html#path-manager

> Even removing the subflow flag flag and keeping:
> notify-flags=existing,skip_link_local,skip_loopback,check_route
> Still causes the error.

mptcpd's 'addr_adv' plugin will still continue to add endpoints, but
without the "subflow" flag. Other plugins like sspi or custom ones will
not cause these errors, because they will not add MPTCP endpoints. These
endpoints are only used by the in-kernel PM (the default one).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

