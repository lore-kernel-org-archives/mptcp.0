Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF76393DDB
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133783; cv=none; b=nkvBtJowp6p71/geuKMaXItjr74p6oFSHVbmI63oeYXRMdi8AJzGN8HHGU7TEO3ZIQZT6JRdouDJncB+AZV8cy1pLOb1XCsyH1bItt2UTlD93FFVSyrKYKdvqCgAPNX+TG831HONwTlfxsA0cuW5wObiI3zRgSFlEnebhK4nRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133783; c=relaxed/simple;
	bh=J+q4kkUiQ0AcdLLSpJGwJEe0i90NPmEmXW55+oMk57E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f1cfkF57VAHXukHCNFQv581iU5EtXy4mMdpcvghdcoZeH2K5cG9ZnW60GHhyaIMGREOwlpX/jbJ9SEouxlfrBdiNb6kyRFeR0ntUJfHP6VhfuluksgmSfzrLe6CsnNf3dc3aPCUcCs7kGNR877ovcfwlyIeW2RW3D/03w/9wjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FamW1J4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FamW1J4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C011F000E9;
	Wed, 19 Aug 2026 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133781;
	bh=CiIKk7Cjx1ZuODoEjcXi9g3m/tEvZKuRmsGE4vaIgsc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=FamW1J4tSZg6T3491257GLCQs/DleQNvfmZgI8m9uooZm5k8JH+qbdYjFtUH1WvPt
	 lteXD0UzJiecGBD8ly49wO5oRIV8DDytpgylyG8iQU8yuVl1uk9dM7bnboxYU0tq4d
	 eidZ/Iajm+qIXyQ+ZvVow2w+Pp/4BEjUks+cv4JN/FEKQXaRIhuxvzy5ewdBOx+wLj
	 esl94CXPslMJr/1mCGAQ7lhXvj2yUz8rzDvT+tRok+DgSCEUKF3r22n7Q2VWhqcchX
	 hMNOUw3iPhrlujMJ+d3mBsFu3txLXHnzJxLxnXnbl20rRacHuAVHxX/SWQ14Pxy1SP
	 jglKZ/5eBM06w==
Message-ID: <db4d2939-e543-42f6-b3e2-e044943a8e29@kernel.org>
Date: Wed, 19 Aug 2026 12:02:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH next mptcp-net 3/3] mptcp: remove thmac from subflow ctx
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
 <20260818-mptcp-cook-reqb-v1-3-052dea9a7f20@kernel.org>
 <b38f34dda21fcfe46b1ecf493c268ca393a8e570.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b38f34dda21fcfe46b1ecf493c268ca393a8e570.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/08/2026 11:56, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2026-08-18 at 19:55 +0200, Matthieu Baerts (NGI0) wrote:
>> This entry is only used in subflow_finish_connect().
>>
>> Instead, use the original value from mp_opt, and pass it to
>> subflow_thmac_valid() to do the validation with the given truncated
>> hmac.
>>
>> While at it, rename the variables in subflow_thmac_valid() to avoid
>> confusions about the received one vs the expected one.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/protocol.h |  1 -
>>  net/mptcp/subflow.c  | 18 +++++++++---------
>>  2 files changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 7e168e450fb0..d414065d1966 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -592,7 +592,6 @@ struct mptcp_subflow_context {
>>  	bool	fully_established;  /* path validated */
>>  	u32	lent_mem_frag;
>>  	u32	remote_nonce;
>> -	u64	thmac;
>>  	u32	local_nonce;
>>  	u32	remote_token;
>>  	union {
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 01db7edce18a..2d7ccb01d234 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -408,20 +408,21 @@ static struct dst_entry
>> *subflow_v6_route_req(const struct sock *sk,
>>  #endif
>>  
>>  /* validate received truncated hmac and create hmac for third ACK */
>> -static bool subflow_thmac_valid(struct mptcp_subflow_context
>> *subflow)
>> +static bool subflow_thmac_valid(struct mptcp_subflow_context
>> *subflow,
>> +				u64 thmac)
> 
> Perhaps we could rename this parameter, say to "subflow_thmac", so that
> we don't need to rename the local variable "thmac" to "expected_thmac".
> What do you think?
I initially did that, but it fell more natural to use the "expected"
keyword, similar to other places, and in the selftests, than the
opposite. Also, we pass "thmac" to subflow_thmac_valid(), but seeing the
argument renamed didn't feel right.

If it was for -net, I would have minimised the diff, but here, let's get
thing rights I think, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

