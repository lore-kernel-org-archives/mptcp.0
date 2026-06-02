Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0982248A0
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401826; cv=none; b=EJBK3qpkRf7efpsu4eVaL80e1pOywIUFdqdrEnaeWRteoIAr28f779oP/rR8TezY6a6+VGxpzY62vgh2Lz6wWaJXxTi+9S8k+4JrVvygBq32kvggpY2jjj9/tCi2KhnmFJp/9ZrEjSqkhMZ34A54v3SxxVU8vNhhkivi4Lrsxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401826; c=relaxed/simple;
	bh=3iH5Sprh/RlnKuRu1uMkdXhRX8zvjI4rPZkxIBWHNLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MAyvQV19hVlE+SEEBQ0omCZeFjyzgZ2dGW1mYMOmXZxQ89lBPBKkdxu4CA8otdX130hh+dUsdIySY2+mVuXCnVZ+tPVrKIzfLr6CqMN35vHq/pzBsr3hxTy1zzl0+XR4PGEdbwtbJg5I/tSOFySRJQuw0nI0kpjYLsgz7KIIVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx2svAo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx2svAo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB871F00893
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401825;
	bh=Rv3MJ0NQoEbSB96P7Jvnbpskb/d6ApprG7sZiNxzONk=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=Mx2svAo6r61rmDLpa6S09CoaEkNwZGopQPlCzTKdtBHLnHdcQYTbBJgdWsOw1yP3T
	 KIy1xlCqOrab9lcYIjdgxHd20x0we/xTGuiFjQnDC4z4/Lx4GEI5CCZlJ7Jp7zKwtr
	 HaJLpEQZrOcyxUtnpHUwqA/FfEzeO6CIVpNs7HaKAbOrbmY2KtjTOcoxX5fHOrZVy8
	 P08fvzOJW6q7ZgC4J0ov7XODuPZYHerX/MBoWiwqc0q6qyYevKf3A2tcERCPIcK6iG
	 KxeHfUAXeXExSH8Fc9i2n5K+QI5yDjj8Agb+r7MuBOQ8+bparRBbQNvXFszGamoHAj
	 OSVD6mqvUYqaQ==
Message-ID: <ff8cfa2d-5466-4dde-88f8-933fdade7682@kernel.org>
Date: Tue, 2 Jun 2026 22:03:41 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] mptcp: add-addr: always drop other
 suboptions + unused param
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260602-mptcp-add-addr-always-drop-subopt-v1-0-4cb4b5f446c2@kernel.org>
 <0e7c967b-5c99-4352-88ac-4b8cf1f3a08c@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0e7c967b-5c99-4352-88ac-4b8cf1f3a08c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2026 21:24, Matthieu Baerts wrote:
> Hello,
> 
> On 02/06/2026 17:12, Matthieu Baerts (NGI0) wrote:
>> Here is a fix for an issue linked to something spot by Sashiko [1], even
>> if there was an issue even after the recent modification in how the out
>> options are initialised.
>>
>> And another small fix, for net-next.
> I hope that's fine if I apply these patches and send them to netdev now,
> so they can hopefully be applied before the next sync, to avoid
> conflicts on net-next with future patches.
And just applied:

New patches for t/upstream-net and t/upstream:
- 9f38dc531a21: mptcp: add-addr: always drop other suboptions (with
conflicts)
- Results: 6432a10e9ece..eac879c1e918 (export-net)
- 5b41a083470c: conflict in t/mptcp-pm-avoid-computing-rm_addr-size-twice
- 748780f95bc9: conflict in t/mptcp-pm-avoid-computing-add_addr-size-twice
- 479431e78400: conflict in t/mptcp-pm-drop-TCP-TS-with-ADD_ADDRv6-port
- Results: 611e80cf3a35..d52ceeaf058c (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/6dd27e4cedbce421b040cbc8798cb456d9566f34/checks


New patches for t/upstream:
- 3758f20ba2e1: mptcp: options: rst: drop unused skb parameter
- Results: d52ceeaf058c..daefa9c068e1 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0c8d473f43cfab0ed926d694c77cb7824893af04/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

