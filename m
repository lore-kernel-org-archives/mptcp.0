Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655931;
	b=4bCbHZivULUuFAkDuVK6WGqfL8EnT2vyeC82dpre6WfQ0HvZRr8t7lXuXvIF19spHdgc
	 uCUc10MWnkIo1yEHvPguciNONQlaP5OUL5/7Oq2wAXrzmotGpYTxn3KmSb4DtOw8pAIv8
	 a7smxpTPvGklopijf+iOoBFfjwP8TfNbDQ366BnZlfatsIzPJWU2Sawylufz1mLmzMrJI
	 OgEghgQtcpdC6D0+JKRQL7kfgExQ9/+E9YZ/LD//4sTH9vkDEEb8ul1yj1bZMp1otOTvq
	 hMSNoHW9q+uYJC9GQJMaff9T7xPzCzOHEDYgBrHC5b07oOh0mLzTPNoriugThOzXPaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655931;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:Cc:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zW8CBSjI+6wltdQTDVN6yb0qZl3H5FIxUI7tVgQ/JPo=;
	b=dQrzNGmnNl0QdkLSqd5in+yiFpC1b3T50knIXkQ0YG+YCvUccmQMn2HxoriZrI7Jy+Gk
	 +fmho6Ub//+ir69xgkorovJGZPodjshEMjWu0FwA4fYOftKSuOO2YRFRvsH6cdJ3rt5y3
	 KVYU2ro0+MW8XHswx4E0V52Rf6EaKj5b9xO8Npn0nthqYWHLAREB9uEosMH8yV9Ws1cGk
	 U4q2Db5pjdIgt94xWIG5GZ0jmvzJWE8+XJ2FHFp24bAdoIzoT7WUCDeU6N6KK7b/4ABVR
	 ZXTHe6vwoWHdUX5vZMR0g3aTCKCCtcmn0HmIDboqyVFeL15w43wdl6dLm7EBjXqRXRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbCLmjLi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E32606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbCLmjLi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DD81F000C1;
	Thu, 22 Oct 2026 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655930;
	bh=zW8CBSjI+6wltdQTDVN6yb0qZl3H5FIxUI7tVgQ/JPo=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=fbCLmjLiWCgKPKKmgYOS3VSfalFXPkF8xTHgM46aijmkr7tr+D1BO9GNWHFBe9Kns
	 D4q6tjesq2jub5TbgPpuSseMcEcBjoIb6TWiNJgTgKaGDqY7oOKjX+ftWUwDBAfeeJ
	 vYQalrtcv9IcrY7Iu8v1ljKVYxmzQYtOyKw/BqX0lQXMDnGlQQAV1PfDF31S41Tipp
	 GBMsAAjKd7bvayACljhHcDhQ2axUvUrhqK8qHHR5rZKSSMbAbn9JczEHOLfrfykEXV
	 d/u8foJ+aaYOp6bRuAFdH1E9cjCC8/V1FOT6mb8FJfEkJ1ysJZkfQZu9FSVEC33+l1
	 M1ikZHbCXlDZg==
Message-ID: <1cbd0011-38fa-4467-9894-d4b42219936a@kernel.org>
Date: Thu, 22 Oct 2026 09:58:48 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: dump stats with right
 title
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
References: <20260914-mptcp-sft-join-typo-ns-stat-v1-1-30d5a5802b57@kernel.org>
 <adfae8144b8e274753ea15d8798b8c29d4e139d9.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: MPTCP Linux <mptcp@lists.linux.dev>
In-Reply-To: <adfae8144b8e274753ea15d8798b8c29d4e139d9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 15/09/2026 08:12, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2026-09-14 at 19:53 +0200, Matthieu Baerts (NGI0) wrote:
>> This fixes a typo when dumping stats to print the right netns.
>>
>> Indeed, the client netns was hardcoded instead of taking the netns
>> given
>> in argument. Fixing that to avoid confusions when debugging issues.
>>
>> Fixes: 658e53141780 ("selftests: mptcp: join: dump stats from
>> history")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index b16e24418e73..bec499047e06 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1163,7 +1163,7 @@ _dump_stats()
>>  	local ns="${1}"
>>  	local side="${2}"
>>  
>> -	mptcp_lib_print_err "${side} ns stats (${ns2})"
>> +	mptcp_lib_print_err "${side} ns stats (${ns})"
> 
> Good catch!
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

Now in our tree (in -next because it is not urgent):

New patches for t/upstream:
- 348b1436ff01: selftests: mptcp: join: dump stats with right title
- Results: 8bf8f58e5882..894c5749a613 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/f5652e342b128698e90c4f11ec8a95056f91178c/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

