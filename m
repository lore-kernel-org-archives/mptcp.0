Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B482D5945
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804969; cv=none; b=MhEDXDZmeR44kUEXgplnyYCTHu/FeRvLMN0rV3+ZbtvICzwIoeHnr3Ko9fqQtrPfg0F6rQKwvOazdWGegjMbHQeGAgLVnuBsbytBVuiq5m/QaXAkWnIZX/Ymw2le280YcNnNbC8tyLdIYnqLEfOQm8OOpK4Y0CwqabJZCLZNutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804969; c=relaxed/simple;
	bh=2DnikCQCPpkXbCk+F4dWRpwG7HNsfHjSke5Ohccfk8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oOjiW5X4tJS+/pmQiqNCPFYIvPuGPdj8uaTqkER1f2+1kYrj6SrN6fYW+zI/8PrX4stTWNmInNDL6afIUJZDFa5/v7mReO0t5MojsTOV1C5BdCNXhnnJjwRvYM/mtBH8a5xcpnjmtDdR+agh8GJgPw8YSozDQex6He/ENA3gpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJqixO8o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJqixO8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1983DC4CEED;
	Tue,  2 Sep 2025 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756804968;
	bh=2DnikCQCPpkXbCk+F4dWRpwG7HNsfHjSke5Ohccfk8I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FJqixO8ompvZCUTTu2QKfuQR+2ZGZnOHz+8p3ckFE8yT/dZBA7LuNWiU3OvjabjcA
	 rQFStt0i403WPl8fxiAzhmHvwgDdUOUhmpm6RiaIRThhS2+oSQFclwJPPfZihBxn1J
	 uD74BEUxdoYXDOJyAc8Dww4Dfklx6OvdPDSKXglUmf5/nwhoU8cbixoAXx+vXs572t
	 asVpDZb7XaDLVwR/px4XZnnkwuHv00BdZWhtW3JywR8eCDeRe+RA5p+lSrRrUzV/uK
	 4aFwGPV8f9DoeosMJGFWQGbrJkHRoIfjFUl6e41QmADsoudN23HyCWlq+IJ7r+cyy1
	 uf16J4UclEkOA==
Message-ID: <9d7fc977-0f91-4bc5-a88c-8c14829c3429@kernel.org>
Date: Tue, 2 Sep 2025 11:22:45 +0200
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
 <2cf621b7-ae02-48d0-81f1-1c56e24fd13a@kernel.org>
 <52b23670-87fc-4e88-92c6-5a4b2ed6cf27@oracle.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <52b23670-87fc-4e88-92c6-5a4b2ed6cf27@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Harshvardhan,

On 02/09/2025 10:21, Harshvardhan Jha wrote:
> On 29/08/25 2:11 PM, Matthieu Baerts wrote:
>> On 29/08/2025 04:28, Harshvardhan Jha wrote:
>>> On 28/08/25 9:04 PM, Matthieu Baerts wrote:
>>>> On 28/08/2025 16:28, Harshvardhan Jha wrote:

(...)

>>>>> I will remove this option for now but Fedora had added this way back in
>>>>> 2021 so I'm not sure whether removing this will cause any unwanted
>>>>> regressions or not.
>>>> I don't know if this note related to NM is well visible in the package
>>>> description in Fedora and others. On Debian and related, there is this note:
>>>>
>>>>>  By default, this daemon will load the 'addr_adv' plugin from the
>>>>>  'mptcpd-plugins' package, which will add MPTCP endpoints with the
>>>>>  'subflow' flag ("client" mode) for the default in-kernel path-manager.
>>>>>  Note that this is something NetworkManager does by default. Having
>>>>>  several daemons configuring the MPTCP endpoints at the same time
>>>>>  should be avoided. This daemon is usually recommended when
>>>>>  NetworkManager is not available, or when advanced per-connection path
>>>>>  management is needed, using the userspace path-manager and a
>>>>>  custom-made made plugin using the C API.
>>> Is this for all config options in /usr/local/etc/mptcpd/mptcpd.conf?
>>>
>>> This note only mentioned subflow so I felt it seems to be related to the
>>> addr-flags=subflow flag only. Please correct me if I'm wrong here.
>> This note is explaining the default behaviour: in short, the same as
>> what NM >= 1.40 will do. As mentioned, mptcpd should then be used when
>> NM is not, or for its main purpose: when the userspace path-manager is
>> used on the kernel side. That's not the default behaviour, and it is for
>> advanced usages: when a use-case is not covered by the in-kernel PM.
>>
>>   https://urldefense.com/v3/__https://docs.kernel.org/next/networking/mptcp.html*path-manager__;Iw!!ACWV5N9M2RV99hQ!IpYyHXknDf7OI13aAkdo-amupYoR7R-gsFQtsQwMZh29C_9taCiFSCK5C-JcJZ8-C4bv53kqSPUSzjpemFSPvx02$ 
> 
> I went through this and set net.mptcp.pm_type = 0 however I'm still
> getting the error when I start the daemon and use the same options in
> the mpcpd.conf file.
> 
> Shouldn't net.mptcp.pm_type sysctl flag prevent this from happening?

Sorry, I'm a bit lost:

- net.mptcp.pm_type is set to 0 (in-kernel PM) by default

- mptcpd can handle both the in-kernel PM, and the userspace one

- mptcpd's initial goal was to handle the userspace PM (pm_type=1), but:

  - the in-kernel PM has been upstreamed in the Linux kernel first, and
    the mptcpd's 'addr_adv' plugin got added to "simply" add available
    IP addresses as MPTCP endpoints (in short, the same as executing:
    'ip mptcp endpoint add <IP> dev <IFACE> <FLAG>' for each IP address)

  - for the userspace PM, the idea is that people can create new plugins
    to cover their own particular use-case. So no good default plugin
    using the 'userspace' interfaces, only examples that can be adapted.

  - so to be useful for more users, mptcpd loads 'addr_adv' by default

  - NM is now doing the same as this 'addr_adv' plugin, so conflicting

Today, mptcpd is then useful when NM is not used, or when someone want
to use a custom PM with the 'userspace PM'. Before that, it is then
required to build such custom PM, and set net.mptcp.pm_type=1.

It also means that 'mptcpd' is now mostly useful for advanced MPTCP users.

Note that the 'mptcpd' project also includes 'mptcpize' which is not
reserved for advanced users (more the opposite). So some people might
install the 'mptcpd' service but not requiring it.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

