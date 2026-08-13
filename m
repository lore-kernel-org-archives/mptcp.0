Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E473B3BF5
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644392; cv=none; b=ZB14D1Wh6kuy+ySEWy3sS7N80DDQhXkm1Or92ldgU1WnADeThZGb9O2hDtJfgtAexyDKkhs6tB6rRCxBTB/1xfzlf7sg9QHXL573mOeMSWJWL2HIbRHkQip9W91ybDf5rIqOI1vQykdlfiPxWW8aUXwFY+T74VoLMkMj24fGo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644392; c=relaxed/simple;
	bh=AzjB4HCcLVmutuJLFiMrtSto5CjVSlmlzBPYQ42ETpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJqRauPDFU+WKe0LWIFZOJeM95CNuNNOApKKPJOC2SIY5k84+IJznTh99B6thZO+lgL5HWUp0ovVYD6D/U7X/AF9FnJO8R98z2Cte0fIEWNFJqk/Ki1I8ZlK0PyfB5v5fM1v7onhhmWkWZIFo1QRSuJc/m4WG3cH+PJXVd8vpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQVAFCQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQVAFCQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A371F000E9;
	Thu, 13 Aug 2026 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786644389;
	bh=bvRLFsux0S98eEHhXGBT0sfPN9fNVVbzgUN/ovbWCbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mQVAFCQA5g5dt0Vd3ad6cdGKkelLDPd4q/IfAg7z1WhZ851ruWfh+uMyp4vgNYKHs
	 g5P8E01k9EB3FgyWYS07xrMO9FH3HNE2c2oW48k4SQO09LjHzgDVsV5uCS6MznG24X
	 +ND0FKKJ+A66DL1ssIPhw559XimpAVSEwv1rCZf7IE0uUg+nXaDpTbRVxAYFRI1lnR
	 euuOtEIJymJQn2uJ0wlQPtb91KauIlsiH00U1kFOuZA6OWdnio63txq5OWRTOSirP2
	 kb+BenP9FH882Yt6L0NDyB4kKU7Bc+BJas/fTeuSbuyNc53GewX82ZYIr0Thplqoso
	 Ap07Y3Q88lOtQ==
Message-ID: <d7269e8a-b9a5-4a93-ab4e-92d677fef09b@kernel.org>
Date: Thu, 13 Aug 2026 20:06:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
Content-Language: fr
To: Chenguang Zhao <chenguang.zhao@linux.dev>, Paolo Abeni
 <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <91381212-7d87-438b-a04b-50a3be4c5388@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <91381212-7d87-438b-a04b-50a3be4c5388@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chenguang,

On 13/08/2026 10:45, Chenguang Zhao wrote:
> 
> 在 2026/8/12 17:45, Paolo Abeni 写道:
>> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>>
>>> After fallback, treat the connection as not fully established so later
>>> MP_JOIN attempts are rejected.
>>>
>>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>> ---
>>>  net/mptcp/protocol.h | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 7e168e450fb0..bf2483a7ed92 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -957,8 +957,11 @@ static inline void mptcp_start_tout_timer(struct sock *sk)
>>>  
>>>  static inline bool mptcp_is_fully_established(struct sock *sk)
>>>  {
>>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>>> +
>>>  	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
>>> -	       READ_ONCE(mptcp_sk(sk)->fully_established);
>>> +	       READ_ONCE(msk->fully_established) &&
>>> +	       !test_bit(MPTCP_FALLBACK_DONE, &msk->flags);
>> Does the above improve actually anything? The test is inherently racy,
>> as lack the fallback_lock, and AFAICS all critical paths have already
>> explicit checks under such lock, see i.e.  mptcp_finish_join().
>>
>> I would prefer avoiding additional conditionals, if not well reasoned.
>>
>> /P
>>
> Hi Paolo
> 
> You are right: the extra FALLBACK_DONE check in
> mptcp_is_fully_established() does not actually improve anything.
> It is read without fallback_lock, so it is racy. The paths that must
> not complete a join after MP_FAIL already reject it under that lock
> via allow_subflows, e.g. mptcp_finish_join() / __mptcp_finish_join().
> I will drop this patch in the next revision and leave
> mptcp_is_fully_established() unchanged.

How do you plan to deal with the case where a fallback has been done
while being in fully established mode?

Could we add WRITE_ONCE(msk->fully_established, false) in
__mptcp_try_fallback()? I guess it is acceptable because
__mptcp_finish_join will check allow_subflows under lock, no?

Or maybe we accept this behaviour?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

