Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA652EAEA
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117562; cv=none; b=SuCwD5txv/QFhTnEcf2Y9+zHDdASTAJ7cu8F0ydBtPy6yJYXRq/Uau95DenhHo/DO4VPw12u7mou1rFRu1ff+aqVto6z74HDF+F9ifU1miXW3VWphQPxxmfvcqmqO9lIwReRuWgDNML/BpGLhmaP4eQKe8kELpi8IkEw0UGBWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117562; c=relaxed/simple;
	bh=5TcfaNx3e2cI+qvmdP5ChZvxgIew+8Pc7Aswu0cXPx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2GNNtD74RhkU0sTFlUsOgItVV07Xjz7HYGS2ezLf3828UvRhn89XbGNHnORKvJ2EKeRUKErYFcQGVTldwz6134pzkWYfRaLX9NyTiC6W5n0eGfBC0vQeuOcIbR5HKBKORlAsVoew3B5dt/oiYvPGLqntVLaYI5HyiJKxja3ytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sftRlEF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sftRlEF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DB9C116B1;
	Tue, 16 Jul 2024 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721117562;
	bh=5TcfaNx3e2cI+qvmdP5ChZvxgIew+8Pc7Aswu0cXPx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sftRlEF+8T8HUdNMTypvhFGvSw3ri3Nz74kBv7YFXxpQZy/rp7kjqtHtSF9Cs1e79
	 1O2cjLnMyT0gs7E63aa+rRD8KIg6SMbbon+7VBTrB6hhZJYNF8Z0QzG/D2uHqh1eGB
	 W6NCg+MFU4Z8yNv92YHjCbD6aHaEMbHhlJT2IVk7tlgcBwe4dbObzZmQhCzxs4ClKx
	 vJ34QIu4drHaGr3xeDlHaj13EUt98/WUmoJCzPk5Ue/BKIe1thPV3pyKT0vwu8Q7/9
	 O+TFztN4k8UYRvGDNOPHUSXb5jGuRK5AWwslCQeZQ01q7w9n41TMDgKQTuxpJp9SHr
	 jLwZG0SZ/9CTQ==
Message-ID: <9b98925b-addc-4be9-ab27-d9054ebc51fe@kernel.org>
Date: Tue, 16 Jul 2024 10:12:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 06/17] selftests: mptcp: join: ability to
 invert ADD_ADDR check
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
 <20240715-mptcp-pm-avail-v2-6-fc5153bd1f6e@kernel.org>
 <f62e151f743c4e6358f8745f2ba9bfbc746f6bab.camel@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f62e151f743c4e6358f8745f2ba9bfbc746f6bab.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for this review!

On 16/07/2024 05:20, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-07-15 at 12:09 +0200, Matthieu Baerts (NGI0) wrote:
>> In the following commit, the client will initiate the ADD_ADDR,
>> instead
>> of the server. We need to way to verify the ADD_ADDR have been
>> correctly
>> sent.
>>
>> Note: the default expected counters for when the port number is given
>> are never changed by the caller, no need to accept them as parameter
>> then.
>>
>> The 'Fixes' tag here below is the same as the one from the previous
>> commit: this patch here is not fixing anything wrong in the
>> selftests,
>> but it validates the previous fix for an issue introduced by this
>> commit
>> ID.
>>
>> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still
>> available for each msk")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 40
>> ++++++++++++++++---------
>>  1 file changed, 26 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 55d84a1bde15..55ccc4fdf18a 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1415,18 +1415,28 @@ chk_add_nr()
>>  	local add_nr=$1
>>  	local echo_nr=$2
>>  	local port_nr=${3:-0}
>> -	local syn_nr=${4:-$port_nr}
>> -	local syn_ack_nr=${5:-$port_nr}
>> -	local ack_nr=${6:-$port_nr}
>> -	local mis_syn_nr=${7:-0}
>> -	local mis_ack_nr=${8:-0}
> 
> nit: How about moving the code that reduces arguments into a separate
> patch?

I prefer not to in this case. If the patch was for net-next, that would
have been a good idea. Here, it is for -net, and backporting shell
scripts is a pain: there might not be any conflicts, but the script
execution can be easily broken, and the stable team will not notice it
because they don't execute them. Here, I want everything or nothing to
be backported, not half of it. I even wonder if it would not be easier
to squash patch 6 and 7 together. But maybe not for the moment to ease
the reviews. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

