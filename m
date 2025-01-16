Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2441199FC1
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012683; cv=none; b=JKeY4cWrnnbtxfQDzjh2NAvIJ+GzmbnTw/WECJFuRf7rLYjdlG/aRWUnARRkzt4gJWg5bRiSuLk9EBI0zlqiCtL6hfeu67tiN8iaPlNFBUNiNvZEuOZPk+GWES1uBq2T/kv/k+1OgdPiLfC6z1QSeXNYan4iI4+AnjnMuGYUj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012683; c=relaxed/simple;
	bh=pQz8Z3Bty8tZrMNioP2N06J06QoKPM8HciF6SKoqP3o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JlUqUxDHi5BDCJlGfJsyF5S04O29txdMuxKSolo2YrcQXec/86pemoNlyGMEH4RuDdTxCzGcfd1babxR7xMvZtbXz7ilp9f8/39EQNRu3aAfSmMWbZJPtLRWFp+irpVfSLJeSg50ilJtd0dxvkJos04/uvYpLrq51WUgaO9ay2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpXhW75L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpXhW75L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F0C4CED6;
	Thu, 16 Jan 2025 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012683;
	bh=pQz8Z3Bty8tZrMNioP2N06J06QoKPM8HciF6SKoqP3o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=dpXhW75LDHh7J0dkICjR3d021slZMkwG8pMZCGPvNEthKrMGOdlY/GbVwxY3wbO60
	 ileFSDt8Vy0A/GjienONBbsceQy4nxGaXoPd4+2DVGfHh9n3mg4Bp9WM7vtmVblwMF
	 OJvsXndGv9gAnEq8ld2Cu58pmg00hMhZVYJckM/6dp9HPTNHmSir3bQWnuGW4tK5HF
	 SOngMHjFrjuwBzZaQjsyqlGR5Lx9vNYeU/NYx8VEvlrE+HYxAwdS92AuL+OfoFks4o
	 fT8h4w312YtyGPdQIBpGEsWyGnsE/gVAxsO1mO74T+fk44vrlCQ3SdwvLEZb/4laMj
	 PdLvFXNSmrKPQ==
Date: Thu, 16 Jan 2025 08:31:18 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <09ec2f1c-1a9e-4a6a-a316-3bbf2d713130@kernel.org>
In-Reply-To: <c12ee9591c031a519dc706987fd78ae8752421f7.camel@kernel.org>
References: <cover.1736935086.git.tanggeliang@kylinos.cn> <27f1c41a7a532e09596979e895af8dcbaca9313a.1736935086.git.tanggeliang@kylinos.cn> <c12ee9591c031a519dc706987fd78ae8752421f7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 3/6] mptcp: drop inet6_sk in
 mptcp_nl_find_ssk
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <09ec2f1c-1a9e-4a6a-a316-3bbf2d713130@kernel.org>

Hi Geliang,

16 Jan 2025 03:41:25 Geliang Tang <geliang@kernel.org>:

> On Wed, 2025-01-15 at 17:59 +0800, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> In mptcp_nl_find_ssk(), 'issk' has already been got through
>> inet_sk(). No
>> need to use inet6_sk() to get 'pinfo' again, just use issk->pinet6
>> instead.
>> This patch also drops this 'pinfo' variable.
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>> =C2=A0net/mptcp/pm_userspace.c | 4 +---
>> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index e53426a5fc52..de17b18b78fe 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -465,9 +465,7 @@ static struct sock *mptcp_nl_find_ssk(struct
>> mptcp_sock *msk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
>> =C2=A0#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case AF_INET6: {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const stru=
ct ipv6_pinfo *pinfo =3D
>> inet6_sk(ssk);
>> -
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ipv6_=
addr_equal(&local->addr6, &pinfo-
>>> saddr) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ipv6_=
addr_equal(&local->addr6, &issk-
>>> pinet6->saddr) ||
>
> CI reports a warning here:
>
> WARNING: line length of 84 exceeds 80 columns
> #27: FILE: net/mptcp/pm_userspace.c:468:

Please note that this is a recommendation and not a strict rule.
It means that if going a bit over 80 helps for the clarity, that's
fine: no need to break lines and have something hard to read.

So up to you: check how it looks like when breaking the lines
before 80 characters.

Cheers,
Matt
