Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B329E109
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016361; cv=none; b=GKQethQakox18+GNonxenqcn/aZVd5yin7J7AX7dwTfm4ayWYeMl2YiSUzeYNaHahsLsmKlyXKCvDhr9+iTu07xBOU9MKC2gkVDt6Jks5jcaZxHKRQVESBYfDn1b/DXZQpTypUeGsjb3FMD6JVu64nLrN7luVSC5/eb0hpK/ZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016361; c=relaxed/simple;
	bh=Alp17NTCCl6QwReBMCEVEEyBERVV2g/WSY/bKyyWC8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eoMYNbg5idGDr2SiR/Q/eH+Y/FlNBZjC2M29DjVZk3d7jOKN2qGDRfT2/RNDqwve2/VpxZIMHDKwuoPYpNubx+Izp5m1MSZnWPxu/or+BxXLk8dGvsYN3wWExVYxM9oPCc5n4LOnrMXxPAOxa3naBvjrAhKLS+DETNzaY1PIi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV8P0kTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV8P0kTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3495C4CEEB;
	Tue, 16 Sep 2025 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758016361;
	bh=Alp17NTCCl6QwReBMCEVEEyBERVV2g/WSY/bKyyWC8s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WV8P0kTlFESNIIpp4OcgPcgVSatQnDmn8JODcSDrS73xjXe9JnfYK9wp4cO0701Z0
	 wt/MYAJ3D+CEywnx9XoxVEd+msAPOMPt4lvQOj4HJ/leRspB1xmRdSw52Jh//Uq9FM
	 oY9iPe0BVVDav9v8aIqtDWQMj5oG5LaVSZw328XCNVP8Zp6JHA5rkuo448gwHArqY2
	 GIJLXmAB4e58fATEtaI5p0nyVS+ZGf6V5+OlwzvYJhWzeq77gSqcM+n4kGih5rFaAD
	 nbbKDRRWp2faJF2EoCqdPr1cuq0ldeUMtbGZ5HUbBIGhagwXWvy2YxhkL+zVcLG5FF
	 s5Yr5oXKl5d/w==
Message-ID: <98b2019c-c59a-4ed2-83d3-8fd7823005f1@kernel.org>
Date: Tue, 16 Sep 2025 11:52:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: join: validate C-flag +
 def limit
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
 <20250915-pm-c-flag-client-default-v1-2-6bb241e4d991@kernel.org>
 <fc540d7f9ae539c3b9dac8757348b22a20ba7e09.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fc540d7f9ae539c3b9dac8757348b22a20ba7e09.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 16/09/2025 11:24, Geliang Tang wrote:
> On Mon, 2025-09-15 at 20:11 +0200, Matthieu Baerts (NGI0) wrote:
>> The previous commit adds an exception for the C-flag case. The
>> 'mptcp_join.sh' selftest is extended to validate this case.
>>
>> In this subtest, there is a typical CDN deployment with a client
>> where
>> MPTCP endpoints have been 'automatically' configured:
>>
>> - the server set net.mptcp.allow_join_initial_addr_port=0
>>
>> - the client has multiple 'subflow' endpoints, and the default
>> limits:
>>   not accepting ADD_ADDRs.
>>
>> Without the parent patch, the client is not able to establish new
>> subflows using its 'subflow' endpoints. The parent commit fixes that.
>>
>> The 'Fixes' tag here below is the same as the one from the previous
>> commit: this patch here is not fixing anything wrong in the
>> selftests,
>> but it validates the previous fix for an issue introduced by this
>> commit
>> ID.
>>
>> Fixes: df377be38725 ("mptcp: add deny_join_id0 in
>> mptcp_options_received")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/pm.c                                  |  4 +++-
>>  net/mptcp/pm_kernel.c                           |  1 +
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
>>  3 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index
>> fda8d1880224dedbbfb20954f93a04da435346df..5d037f9d4e0b4d158beaaa5a48c
>> 4efb50fe9b5cb 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -637,7 +637,9 @@ void mptcp_pm_add_addr_received(const struct sock
>> *ssk,
>>  		} else {
>>  			__MPTCP_INC_STATS(sock_net((struct sock
>> *)msk), MPTCP_MIB_ADDADDRDROP);
>>  		}
>> -	/* id0 should not have a different address ; special case
>> for C-flag */
>> +	/* - id0 should not have a different address
>> +	 * - special case for C-flag: linked to
>> fill_local_addresses_vec()
>> +	 */
> 
> How about squashing this into patch 1.
> 
>>  	} else if ((addr->id == 0 &&
>> !mptcp_pm_is_init_remote_addr(msk, addr)) ||
>>  		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
>>  		    (!READ_ONCE(msk->pm.remote_deny_join_id0) ||
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index
>> 408801e20ed6e874b80ccbf38af76abc13615a3a..aae9b92aea4715dabaf3101a034
>> 1ab7eab16f407 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -394,6 +394,7 @@ static unsigned int
>> fill_local_addresses_vec(struct mptcp_sock *msk,
>>  
>>  	pernet = pm_nl_get_pernet_from_msk(msk);
>>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>> +	/* linked to conditions in mptcp_pm_add_addr_received() */
> 
> And squash this too.

Arf, sorry, I missed that and squash these modifications in the wrong
commit. Yes, it is for patch 1/2.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

