Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FA486BB6
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722307; cv=none; b=AVpRwluwxCCRsOl5860ZvDq5LNmcIcAATFrbAyyFQXSSvEyfw33ySECJ54YK2tB8Fy80a5dolX00hJ2LI14n155JDFY27p5U4RtmzxKxlqmgOp4slq8304qsj9RGuNjx4owx270/fAi7LH0brBXhhaUaTdXpihe6r0FAVgbuYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722307; c=relaxed/simple;
	bh=3oZKPxVkfqHyZI1xsUFa66BDKee+lspIGOHGCN8QPcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZiMvAYcM7ujzgTkY7EgRXr0zMx0kAudc8p0OUeIveoGPI25nhJU5ULbBI0nQ8Qv0GoVhmVBrq/eGBXCZZdN+UKPGxXnsHWPyBmvvvlNKTU66WAuIc9xYpm/6GC+0oM5wGPuuOWFEp1bQrr45mNsKyCms90uLxzKl0X5aD9wJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/jlrlZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/jlrlZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92601F000E9;
	Fri, 14 Aug 2026 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722306;
	bh=FnOe67U8og0dl9CYAoIlwFSvMxiRB/6xC5CBfBWbuMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k/jlrlZKO9xc7BQyQS4s0pSH83wZYk7Cupw7rD+rrOjX4/kfmjOYbGT6bEObSqh9B
	 L9+DAPKP8eYmdvGlH7WNCuGHmJG7JFpUWEWdUgEetZ90uVcZzBdNcDkgCePaPWvWU1
	 ARC6hYsCP0nWgLP6v7yIYDnnnxLNfkKu1Z6mn8xcG3KzVqkTbfHEbNm1Fs/v6Z/496
	 Hrrw3Dye67BRgMLtpFeptkQ5uOoUkYgjcQTbuT2RqMmiKyMJf5+V6zjoTocFkIL5Kz
	 owip0hgMH41Ct0U+N8ELXSpIzYY2zUm4ZiwMgdKDg01r1bWJWBnp0XRyNa5r+wMMin
	 6eYP0LolphIbA==
Message-ID: <4bc4a5c1-c6ca-4384-a355-ca709cd52f48@kernel.org>
Date: Fri, 14 Aug 2026 17:45:02 +0200
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
To: gang.yan@linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
 <564cb027be5e7972fc8f6f976707628ee32f38aa@linux.dev>
 <db6bd87f-f7cd-4b02-a471-db549cbca384@kernel.org>
 <3c9241d11965180046042f4c6079ebb1e38b54dd@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3c9241d11965180046042f4c6079ebb1e38b54dd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 14/08/2026 05:02, gang.yan@linux.dev wrote:
> August 14, 2026 at 1:42 AM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
>>
>> In addition, in the case we are trying to fix here, the MP_FAIL is
>> received before switching to fully established: the RFC doesn't explain
>> this particular case, but it sounds like there is no need to send the
>> infinite mapping, and a fallback can be done directly *I think*. The
>> thing is this situation shouldn't happen: we are not supposed to receive
>> an MP_FAIL at that stage, no data has been exchanged at the MPTCP level,
>> so let's do the minimal -- i.e. just a fallback -- to avoid issues and
>> reduce the complexity, no?
>>
> 
> Hi Matt, 
> 
> Thanks for your explanation. I have a quick thought:
> 
> Can we check the 'subflow->send_mp_fail' in 'subflow_finish_connect'? like:
> 
> '''
> ...
>  543         if (subflow->request_mptcp) {
>  544                 if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
>  545                         if (!mptcp_try_fallback(sk,
>  546                                                 MPTCP_MIB_MPCAPABLEACTIVEFALLBACK)) {
>  547                                 MPTCP_INC_STATS(sock_net(sk),
>  548                                                 MPTCP_MIB_FALLBACKFAILED);
>  549                                 goto do_reset;
>  550                         }
>  551 
>  552                         goto fallback;
>  553                 }
>              if (subflow->send_mp_fail)
>                              goto fallback;
>  554 
> ...
> '''

I don't know: it doesn't feel right to check this field there. Sending
the MP_FAIL reply and the infinite mapping in the same ACK, as you
suggested, seems better.

> Or, check msk->fully_established in pm_fail_received like this:
> '''
> @@ -901,6 +898,12 @@  void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  		subflow->send_mp_fail = 1;
>  		subflow->send_infinite_map = 1;
>  		tcp_send_ack(sk);
> +
> +		if (!msk->fully_established && !mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +			mptcp_subflow_reset(sk);
> +		}
> ''' 

Paolo noticed (in another email from this thread) this will not cover
the case we are trying to fix as we were already in fully_established.

But maybe we could try to fallback if that's possible, and if checksum
was not being used? I didn't check if it would be a good solution.

> Because the MP_FAIL specified in the RFC does not seem to actively trigger a fallback
> on its own; instead, it is triggered via the infinite mapping. If we modify the
> behavior of MP_FAIL in the regular path, I think it might be over-design and could
> introduce additional risks. What do you think?

Yes, but here, I'm only proposing doing a fallback for the cases not
covered by the RFC, i.e. single subflow, no checksum.

I think the simplest solution should be picked for this use-case that
shouldn't happen. Bounding MP_FAIL reply and infinite mapping in the
same ack seems interesting, and not just for this case, but it might be
"hacky" as you don't have an mpext in this case, no? Maybe a fallback is
"cleaner"?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

