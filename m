Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAC192B7E
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203758; cv=none; b=NsPfjFpYOX+eyoOsrRbLx50JuabJiM+Ou5sZUihvYKnzHMZVgPDos4aeioykgsZk+o9REyNmQnB/TNSfFQKzUSFh3JG5We9rUHroyGRiIPp6CNi84b8bkCaRXBdHws8yXblQ8RPGtwj63AxYUr/rlvmc9DIyNl/fqBAuwalu9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203758; c=relaxed/simple;
	bh=3oAIqeHluLb0kZLqYR4oL/91WjN+ewbLSebWUq3LJnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kzk2Hfp5FwL/z1rlmAu2mGkpcFL1AdqHRzQLRme9btmqGddOEoW/5bSY0TyyTBaJG6ccUEpIlajpTqH7k3hOn/TkZV08rSp+igbVmTL+KRS+QFdvhuuv1MVVIPF2h1/U97VS2GNKK3eoqAugw1bWnFNER9QwWjv45tnfuz0NHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK8HvpSY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK8HvpSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF31C32782;
	Fri,  9 Aug 2024 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723203758;
	bh=3oAIqeHluLb0kZLqYR4oL/91WjN+ewbLSebWUq3LJnw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vK8HvpSYZthVf0GA5gmaPQS14+6EK/9Ten3dX8mJony5hkvJXrodUeXSTTVdcKf9L
	 +aWmOU9fZX2V09/7WpMxwS9kR+7yM85oKl0Hj9QBKDL0dGFCSKkaXmdeat7a4Atcdr
	 L3C3rWOxWK50bXrKNY2x0nslMrVCgWVesKx1CVVgnZPgeqtXP+f0eYWA2olRUUm+E6
	 GKu9K9P7vNFBq+ceWwJUrK11y4pjv1xX9osffyq/m2EnKcfCYe0Rqr+W2j46RUPAqB
	 MIkj4ufy18evwnGZ6FsfU3hLj9bxHvZAxeo4veOMEBYL+VoJAZSS67Otx1JF/FPYTX
	 fvXLcKClfxa1w==
Message-ID: <4bff36f9-809b-481b-940f-69156075cafc@kernel.org>
Date: Fri, 9 Aug 2024 13:42:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 5/8] selftests: mptcp: join: validate MPJ
 SYN TX MIB counters
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
 <20240806-mptcp-join-tx-mib-v3-5-c3b54d2099e9@kernel.org>
 <e2fc22b0217c36fa516a4926994ae171f97fec38.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e2fc22b0217c36fa516a4926994ae171f97fec38.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 09/08/2024 04:21, Geliang Tang wrote:
> On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
>> A few new MPJoinSynTx MIB counters have been added in a previous
>> commit.
>> They are being validated here in mptcp_join.sh selftest, each time
>> the
>> number of received MPJ are checked.
>>
>> Most of the time, the number of sent SYN+MPJ is the same as the
>> received
>> ones. But sometimes, there are more, because there are dropped, or
>> there
>> are errors.
>>
>> While at it, the "no MPC reuse with single endpoint" subtest has been
>> modified to force a bind() error.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>   - v3:
>>     - Force a bind error (Geliang)
>>     - Validate join tx with rx ones. (Geliang)
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 84
>> +++++++++++++++++++++----
>>  1 file changed, 73 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index b10bcb1ac970..23ea8acb7a36 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1331,6 +1331,54 @@ chk_infi_nr()
>>  	fi
>>  }
>>  
>> +chk_join_tx_nr()
>> +{
>> +	local syn_tx=${join_syn_tx:-${syn_nr}}
> 
> syn_nr is only a local variable of chk_join_nr(), does this limit that
> this chk_join_tx_nr() can only be called in chk_join_nr()? I think it
> is necessary to break this limit. WDYT?

Yes, I can do the modification, just in case for later.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

