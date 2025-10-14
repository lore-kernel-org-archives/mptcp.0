Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA068222587
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435831; cv=none; b=nMSUF7N/celAPioQFLib343EuxL69QP4PUpfnVT75Ef8FKSeazu/Fq3XzTmwtpwNlxUfaYiCXEsr//2DSPT5bfGK/ytMg87H+ozC4NbRrwwl8WJ4WvKk3+vlCbZpfS9NfevPod3r3ErP15n+6AHP/IUIs4L2arSrP6FkMbPcg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435831; c=relaxed/simple;
	bh=lqWboh9cu0bs8CnNe74baKVWi21FBq+z2FUOXu81ES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FWn66riRAVfJiuK6ORGIojtyjojVnGCbv2kQAp2gfbTMS/CFP3AQpTbSenjOnZJyNBwaOIdDhtAAnBlQ1dq6olJxk4qyYgGP30x4itiAfyi6rBzxKtELrKTzcIfHCewW99rbTowctmXlC+hhfGUB7Yf+q5ZjFpJXIcuBmWSkiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4kRCgUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4kRCgUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA736C4CEE7;
	Tue, 14 Oct 2025 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760435830;
	bh=lqWboh9cu0bs8CnNe74baKVWi21FBq+z2FUOXu81ES4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Q4kRCgUoXqFVFmQIdhmTNf+AuYiR43cCubmy1wAy1h0FE1shdlPzzUjLu9SfFj4Lt
	 sONxsHRgFSQqpckT7DqE8IK57yzc3vfBMqDBQ88+A/fP4QPqvQbJwU8cJLhtBap/eC
	 /lvTomMuCN/XWm93DtBDGjoi8O2r/XoE8aw/4Adh8KEvcsFsgZeKjEBcmen6SxZRfz
	 086ecIGPa1071hSPoT8cZoKxr5Pq64VTgqkF8TAI182JCgT7Ro44uENuBeFiPo/tTT
	 5GjZM8ptNoFX5+lQId6EldbMeH9kP/91geN+vXc00lfd4X5gqc/7+PuFFlvgQx04zY
	 q8IVhqyDHMJNg==
Message-ID: <95e3acf3-9a56-47d8-8314-ed6133403283@kernel.org>
Date: Tue, 14 Oct 2025 11:57:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: join: validate extra
 bind cases
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
 <20251009-bind-extra-listen-v1-2-5ad2077d77a9@kernel.org>
 <6efea80680213decf83313995a7afd9e4ce4fafd.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6efea80680213decf83313995a7afd9e4ce4fafd.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 14/10/2025 08:46, Geliang Tang wrote:
> It took me some time to understand this test.
Is there something I should add in the commit message to make this clearer?

> On Thu, 2025-10-09 at 19:33 +0200, Matthieu Baerts (NGI0) wrote:
>> By design, an MPTCP connection will not accept extra subflows where
>> no
>> MPTCP listening sockets can accept such requests.
>>
>> In other words, it means that if the 'server' listens on a specific
>> address / device, it cannot accept MP_JOIN sent to a different
>> address /
>> device. Except if there is another MPTCP listening socket accepting
>> them.
>>
>> This is what the new tests are validating:
>>
>>  - Forcing a bind on the main v4/v6 address, and checking that
>> MP_JOIN
>>    to announced addresses are not accepted.
>>
>>  - Also forcing a bind on the main v4/v6 address, but before, another
>>    listening socket is created to accept additional subflows. Note
>> that
>>    'mptcpize run nc -l' -- or something else only doing:
>> socket(MPTCP),
>>    bind(<IP>), listen(0) -- would be enough, but here mptcp_connect
>> is
>>    reused not to depend on another tool just for that.
>>
>>  - Same as the previous one, but using v6 link-local addresses: this
>> is
>>    a bit particular because it is required to specify the outgoing
>>    network interface when connecting to a link-local address
>> announced
>>    by the other peer. When using the routing rules, this doesn't work
>>    (the outgoing interface is not known) ; but it does work with a
>>    'laminar' endpoint having a specified interface.
>>
>> Note that extra small modifications are needed for these tests to
>> work:
>>
>>  - mptcp_connect's check_getpeername_connect() check should strip the
>>    specified interface when comparing addresses.
>>
>>  - With IPv6 link-local addresses, it is required to wait for them to
>>    be ready (no longer in 'tentative' mode) before using them,
>> otherwise
>>    the bind() will not be allowed.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/591
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.c |  10 +-
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh   | 153
>> +++++++++++++++++++++-
>>  2 files changed, 161 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index b148cadb96d0..c030b08a7195 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -1064,6 +1064,8 @@ static void check_getpeername_connect(int fd)
>>  	socklen_t salen = sizeof(ss);
>>  	char a[INET6_ADDRSTRLEN];
>>  	char b[INET6_ADDRSTRLEN];
>> +	const char *iface;
>> +	size_t len;
>>  
>>  	if (getpeername(fd, (struct sockaddr *)&ss, &salen) < 0) {
>>  		perror("getpeername");
>> @@ -1073,7 +1075,13 @@ static void check_getpeername_connect(int fd)
>>  	xgetnameinfo((struct sockaddr *)&ss, salen,
>>  		     a, sizeof(a), b, sizeof(b));
>>  
>> -	if (strcmp(cfg_host, a) || strcmp(cfg_port, b))
>> +	iface = strchr(cfg_host, '%');
>> +	if (iface)
>> +		len = iface - cfg_host;
>> +	else
>> +		len = strlen(cfg_host) + 1;
> 
> Why do we need to add 1 here? I tested it and it works without adding
> 1.

If I don't add 1, I will not include '\0' in the comparison with "a".

In other words, if you have:

  cfg_host = "abc";
  a = "abc123";
  len = strlen(cfg_host); /* = 3 */

Then strncmp(cfg_host, a, len) will return 0 because the 3 first chars
are "abc". With 4 chars, they are different: "abc\0" vs "abc1".

So it is important to take the delimiter into account, just in case one
is the prefix of the other one.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

