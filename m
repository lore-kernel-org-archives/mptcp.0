Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AF2264CF
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452941; cv=none; b=f6wMRQyuussi+4aMR3+9bony7z0VqTm1C3yh/rafLH9E7lImm6YYsVd9CiA4dmD5htf27XJQjzshdID2JWhp9dQ8L63sTuz6JiD8krxIW4AXyOjXIt6Gy3EnlYt+5LjABVJISvbmSA9y8vSVnxmpm3oYS1NQ5SL3gYomeszKzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452941; c=relaxed/simple;
	bh=5UhboGGuxeJj1FplZR3z/sMihoYZB87OPHI3gQlqvpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=SHlKMqwK2SGWd2dzpiHJJ2Kh2L5qF7d1PpS4FOcJxKF/ABpYavyul+NMw/qhKGE160IY6erUiOMuufOSuorPWO+SxtDRSQTMOvrToSPQam3fNaSzp+c4HiOe7u12fZ2luzVHH03o+omdzD1mr9VPxmQds9J7YS7sxAyGD/Fl+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElZCnc2M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElZCnc2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38324C116C6;
	Mon, 26 Jan 2026 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452940;
	bh=5UhboGGuxeJj1FplZR3z/sMihoYZB87OPHI3gQlqvpo=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ElZCnc2Mpe5A66R7X+wL4eP5GmVrhYEy3wbWuqfqG0NMKx9HifzSq0oF1+b2UHVZT
	 SQ9S94JwUa0Pgxf+WTAT7pcsiDMSaC/Y6J1NarFU8aHpUCvfKiIIMweHiGU1kQ0OON
	 38spb0VLP3l+9CNOqmaVkJ3suCdCO407HJHj9PECPeL1ae9Y8wKWw3hFsWWb1Fw5Sw
	 PFJdvp8Z6/fpsof1Fl66Ycc93iXhb2xPBNAKyG7e2Xp/asXVIboGnc30efy5hrmW92
	 /NocuEZTZ0eKnUcdFewOaos2AW0mF6A8sJk+k13tD9p/ik0OjgW/m4l0RHyjm9998I
	 9wlLc0XYDZvMQ==
Message-ID: <db374b02-06fd-4be8-96d8-e6be55d522ea@kernel.org>
Date: Mon, 26 Jan 2026 19:42:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: no SKIP mark for group
 checks
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
References: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
 <c24cd268dc2f6797425e022a515776a006eaded6.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c24cd268dc2f6797425e022a515776a006eaded6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review! (and sorry for the late reply)

On 28/12/2025 04:06, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for this patch.
> 
> On Thu, 2025-12-11 at 19:09 +0100, Matthieu Baerts (NGI0) wrote:
>> When executing the last MPTCP selftests on older kernels, this output
>> is
>> printed:
>>
>>   # 001 no JOIN
>>   #       join Rx                             [SKIP]
>>   #       join Tx                             [SKIP]
>>   #       fallback                            [SKIP]
>>
>> In fact, behind each line, a few counters are checked, and likely not
>> all of them have been skipped because the they are not available on
>> these kernels. Instead, "new" and unsupported counters for these
>> groups
>> are now ignored, and [ OK ] will be printed instead of [SKIP].
>>
>> Note that on the MPTCP CI, when validating the dev versions, any
>> unsupported counter will cause the tests to fail. So this is safe not
>> to
>> print 'SKIP' for these group checks.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++---
>> ----------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/test[ -z "$count" ]ing/selftests/net/mptcp/mptcp_join.sh
>> index b2e6e548f796..77370b10651a 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1407,7 +1407,7 @@ chk_join_tx_nr()
>>  
>>  	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynTxCreatSkErr")
>>  	if [ -z "$count" ]; then
>> -		rc=${KSFT_SKIP}
>> +		: # ignore skip
>>  	elif [ "$count" != "$create" ]; then
> 
> In that case, wouldn't it be better to remove 'if [ -z "$count" ];
> then' and directly check with 'if [ "$count" != "$create" ]; then'?

No, we cannot: if $count is empty, then "$count" != "$create", and the
test will be marked as failed instead of being ignored.

We could have:

  if [ -n "$count" ] && [ "$count" != "$create" ]

But I think it is clearer to have an explicit comment for this special
case than multiple conditions. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

