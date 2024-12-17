Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B01DBB35
	for <mptcp@lists.linux.dev>; Tue, 17 Dec 2024 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430939; cv=none; b=ecbzLoYb0sdiW4oa37B5NudLxr/FhA2IopUvwVXEv6MQkrX+tKb6Ubh1o3Tl5VzZxokOuCyektPGI6QCx3H6w6R8+NgBzmo0JcytAyYRSZGUT7LvgBwTsV9Q4zEGcFQwCPpfEJgRMyn4ytvzlb4xs8mpwc4GEaa03mFX/HaFVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430939; c=relaxed/simple;
	bh=4pCzIAFEiYf4dO0N6R8cdkfDvaYPwgLvFeVPLHQKlsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SDfKvessouAvAj2g7kd6ZAZnqPivl5+s9i2Cz6Vfni/8Y09Q+/crWTPkflTYe5qlBBdBwBznpT693NdhQ9ywNnW8awE62RQbwd++xdj1qN+BGlrCsTxD+DsEbO6lpGnorWDT3Kcfv9+3bW1ZVS5hbDdrL31x4pART7NWighu75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2jgD9mF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2jgD9mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BCDC4CED3;
	Tue, 17 Dec 2024 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734430939;
	bh=4pCzIAFEiYf4dO0N6R8cdkfDvaYPwgLvFeVPLHQKlsI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=W2jgD9mF4/8WWlx6QF8Iuahr+B0ruDWhnuO2kXdtWy/wsWS1uxYXfcaf/zwTEbv1K
	 QnMHussidzT/MvkDtVnlAO1q9tS+uBlkOxqEzfGvrpQlNyhebxp9qF2j/HTG26/wjZ
	 EjIaPHvLjC0/a6kMSEB0eJyj0Q5rM9SmpSBnMmD3N4WGN7Sz+jvwdctqw0bwM/XuWL
	 IRsWtyWuh/xcxYQ7v4jrZQAyNShFg/uWzL4YTciMyBd7gFKavDQal/F46ecQLX+7I6
	 h6VlrYZmP/r0MEDMKb9I0McOBqO1PAUF7LBCAraMJPORVCVR4wA+AJl4O3okZR44vT
	 Eoo5AZNVSKj5g==
Message-ID: <0fa8138f-cc04-445e-bca4-3412a1f25f38@kernel.org>
Date: Tue, 17 Dec 2024 11:22:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 3/3] netlink: specs: mptcp: fix missing doc
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
 <20241216-mptcp-pm-nl-spec-doc-attr-v2-3-68807f55d42c@kernel.org>
 <08c74ee545c76173c523a5839c4e714ba29c40b5.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <08c74ee545c76173c523a5839c4e714ba29c40b5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/12/2024 07:37, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-12-16 at 11:39 +0100, Matthieu Baerts (NGI0) wrote:
>> Two operations didn't have a small description. It looks like
>> something
>> that has been missed in the original commit introducing this file.
>>
>> Replace the two 'todo' by a small and simple description:
>> Create/Destroy
>> subflow.
>>
>> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for
>> mptcp")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  Documentation/netlink/specs/mptcp_pm.yaml | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
>> b/Documentation/netlink/specs/mptcp_pm.yaml
>> index
>> 59087a23056510dfb939b702e231b6e97ae042c7..a9519ae77d38ce2af58de77c059
>> ef22cd2e3f563 100644
>> --- a/Documentation/netlink/specs/mptcp_pm.yaml
>> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
>> @@ -375,7 +375,7 @@ operations:
>>             - loc-id
>>      -
>>        name: subflow-create
>> -      doc: todo
>> +      doc: Create subflow
>>        attribute-set: attr
>>        dont-validate: [ strict ]
>>        flags: [ uns-admin-perm ]
>> @@ -387,7 +387,7 @@ operations:
>>              - addr-remote
>>      -
>>        name: subflow-destroy
>> -      doc: todo
>> +      doc: Destroy subflow
>>        attribute-set: attr
>>        dont-validate: [ strict ]
>>        flags: [ uns-admin-perm ]
> 
> This patch looks good! Thanks.
> 
> I think other three doc needs to be updated too:
> 
> "flush addresses", "announce new sf", "announce removal"
> 
> ->
> 
> "Flush addresses", "Announce new address (?)", "Remove address (?)"

I initially thought that it was not really a fix, but yes, why not,
while at it, I guess it can pass.

Regarding "Remove address", I think "Announce removal" is better: the
goal is to "announce" the address is no longer available. That's also
the term that is used in the RFC:

  https://datatracker.ietf.org/doc/html/rfc8684#name-remove-address

Is it OK if I do the modifications when applying the patches?

> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index dc190bf838fe..c260a972a394 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -306,8 +306,8 @@ operations:
>           attributes:
>             - addr
>      -
> -      name:  flush-addrs
> -      doc: flush addresses
> +      name: flush-addrs
> +      doc: Flush addresses
>        attribute-set: endpoint
>        dont-validate: [ strict ]
>        flags: [ uns-admin-perm ]
> @@ -351,7 +351,7 @@ operations:
>              - addr-remote
>      -
>        name: announce
> -      doc: announce new sf
> +      doc: Announce new address
>        attribute-set: attr
>        dont-validate: [ strict ]
>        flags: [ uns-admin-perm ]
> @@ -362,7 +362,7 @@ operations:
>              - token
>      -
>        name: remove
> -      doc: announce removal
> +      doc: Announce removal
>        attribute-set: attr
>        dont-validate: [ strict ]
>        flags: [ uns-admin-perm ]

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

