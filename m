Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25C43A1E8C
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610696; cv=none; b=R3eRlj1r9rkfSkTxTsILAWQt2p7PAZkkVc1+TwMLZWdVhrwsBExnItr0dDzPQ8HA8z9S1P2JmNlBAr0/mrhx+jXuifY396aCcRlmlCPCaTBBgKhb+rK/XRZzo2lHZud2LBEPBjG3a0s+DtBRKeWi2XsUAfeYbRJks6AayyojpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610696; c=relaxed/simple;
	bh=+hz4oaT7vzYvds2gUn+6IOmnFJLfMzVUKUW0q4t0Dro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnJloNgbi/HODKcWe2d2fR3Nud3ehp/mtWZK7N7h98UzFhWSiXcp8rgqSAeU8v6a6PhVJsql15sWiL+iCBNjpL8x/P18fFvyjy0Ta7NoXs3fSe1a+V2oFptAW92QWkC0hyoO7P7FULwvROh2YUk0Lb5PaQcXNKMijQkJyQGvmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6LDdBoW; arc=none smtp.client-ip=95.215.58.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6LDdBoW"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=+hz4oaT7vzYvds2gUn+6IOmnFJLfMzVUKUW0q4t0Dro=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786610692; v=1; x=1787215492;
 b=W6LDdBoWW1hzSsmJiUBep1GVzzN8Rl1ugRtzYwDdQg+5qqQLTEEfivbH0ppvP2MY7ZbxiJkm
 +apKEusyaZ9RO3/oZFm6MfJJchaWMMJqhXQDEjtRNFWa268XjLoZwPCiAI2OnUfkBJ0ty2AZ863
 j7tMjYCOh8wZzV/FUdy6ITyo=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.109.30] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id e5696dfefdcb8984;
	Thu, 13 Aug 2026 08:44:52 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <91381212-7d87-438b-a04b-50a3be4c5388@linux.dev>
Date: Thu, 13 Aug 2026 16:45:01 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/12 17:45, Paolo Abeni 写道:
> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> After fallback, treat the connection as not fully established so later
>> MP_JOIN attempts are rejected.
>>
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>>  net/mptcp/protocol.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 7e168e450fb0..bf2483a7ed92 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -957,8 +957,11 @@ static inline void mptcp_start_tout_timer(struct sock *sk)
>>  
>>  static inline bool mptcp_is_fully_established(struct sock *sk)
>>  {
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +
>>  	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
>> -	       READ_ONCE(mptcp_sk(sk)->fully_established);
>> +	       READ_ONCE(msk->fully_established) &&
>> +	       !test_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> Does the above improve actually anything? The test is inherently racy,
> as lack the fallback_lock, and AFAICS all critical paths have already
> explicit checks under such lock, see i.e.  mptcp_finish_join().
>
> I would prefer avoiding additional conditionals, if not well reasoned.
>
> /P
>
Hi Paolo

You are right: the extra FALLBACK_DONE check in
mptcp_is_fully_established() does not actually improve anything.
It is read without fallback_lock, so it is racy. The paths that must
not complete a join after MP_FAIL already reject it under that lock
via allow_subflows, e.g. mptcp_finish_join() / __mptcp_finish_join().
I will drop this patch in the next revision and leave
mptcp_is_fully_established() unchanged.

Thanks,
Chenguang
