Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B618296BBC
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697020; cv=none; b=sda6JWohhve0Z6eFXDWvJbvW6WVYgMToHqYlIEc8dVStQR3fpA/tHkVn/iimzlYsYnfUCgjgM89eDbzs567v4N8mq7L5DzJ1UMVTtZjz8NGi7Hl/juToPnlvw9MdxlLXu+nLK+60AOQbm4yhBihYYXALTjcwsYgePZPVKYcsSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697020; c=relaxed/simple;
	bh=RbB7FAPSPw78GnduUkMavqnXRtg5PUeU+EfUAgiTVgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYyZRhczOYNRLionhhqyqSHepbsErwHDO9CTi1Dz6xYRDD57tX6XjHZ4d0+QCrm17s4gjIo53/WpSTTOex42zORpR3cP+GlPebm2wglOCczgDi/1L2qFczozXRSCXHe7MoZfK+t763PMUjRw6r5w7MHbkWUTvrvajrCNS1pAg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LybZe6y+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LybZe6y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786697014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csqBPbWTydWprTHrOJsU75P5NUCC31Pg/DaVYG9ciHA=;
	b=LybZe6y+0nT8CAhB4jrx29qTE+9LVTUrKb+mDDLFR0rMOblNyhWZQ1DI2sMXmsVRQmfZV0
	v/A0ZsQGVHLpLM1wlEJqS4TQmj6EaMwVsnTl08al0qZioV8XZ23G9LK/cq/YMfl9NIp5z+
	SGhGPjky6+YZYFBcjkVnNDVOoTwgEus=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aRvH5zPyPkuhGBDvtOXfdA-1; Fri, 14 Aug 2026 04:43:27 -0400
X-MC-Unique: aRvH5zPyPkuhGBDvtOXfdA-1
X-Mimecast-MFC-AGG-ID: aRvH5zPyPkuhGBDvtOXfdA_1786697007
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47faa02f707so478274f8f.1
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 01:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786697006; x=1787301806;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=csqBPbWTydWprTHrOJsU75P5NUCC31Pg/DaVYG9ciHA=;
        b=Iu9CH1vO3aA8U5edsY478CkTbf0kkvuIC5HlWynv3Mle6Akx+kTfy1GLH7LtyJdOwk
         m5NUtqcn4jf4EJfE2xXgNRvHyVGoriH73LUjJXtcQWQni2Bd6oGEZL6sJcAqlrz99EvT
         i1Px+Wc0+SNhouMjcVComlPw3NImsy5x0Jf+o3Z4YsBBBVxt4NQoI/xixgiwm5SX+MkK
         lprcrJ1ilNdsrhVv3i7xkijOBaGLyNRwMC0P65le11JU9siYaUGg0QAl62q4LklXLnZ6
         H+FizoVt9y7tq+C4n6Zls/uXaIlj3qOl1pedk3rn2H5Gq6V5I1xhtFKDSIx2xQ9ExvQ6
         EHRw==
X-Forwarded-Encrypted: i=1; AHgh+RpanmpQC7884kJc141KheT5ZHrQ8ApDEIEe9PXaAMUTg/ympv1J/HjfP0BGggHj1IuDjVDaZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/1IVBIts/UNavjLXOuLaS7PLs55iLaCRVmVrZnwXKy4FzsZug
	oGciPazFkUy+OF/kh3jKm1lAcJwIR80wf8DmsqO+FNfebZ2yVjTgJM0cYEUHRYkloEGuMMNcrbn
	dq6O27eo/wQNX6lnWpFxlYGnhQfpUV+gyualcN8YFzG3Rd8pbkmEMPvbA9ABTIdV5
X-Gm-Gg: AR+sD12GnoOmaGIZqmoVZmyuW4q1HFNEXpdBs0yNRMTL1OyMvkPloJtWi4FJP6G+PXv
	b4DEUU+Z2Td2/thHApJJv+3Us4+T1Sz0uY8jlgLzkHf0AhvrsSUe5W+jKcLHXA6NVZCik0i0w/A
	H0Q7LxJC44u0zh1uI8t8C184v8Q62o8EcGcPFZ2dTqLXz59SqXdTUGCbbDbw0fhf3I2mqn37d/u
	pvEQfyLu/Lbvwg4guQi8+DAE62iys25q/IRUariMs0RFSVcLU26KF7JuWCLLG/oSy5mOwAMoraE
	Xwess6ixDPE8rwojp9vuQY4A3pqquCDN55OYFLTboz2WYMdB4pfXExOGEEE1cjtMOSydDeKy4Fd
	zRgsI9wM22G1YqkKtOGWUSbm2tE4C8Ld9+9zYhy/zNoI6y8a/ZyG/EKNYfNHYLqSNVp57LfjH8O
	M=
X-Received: by 2002:a05:6000:4006:b0:47f:8fda:1af0 with SMTP id ffacd0b85a97d-4815a4e7281mr16710408f8f.4.1786697006580;
        Fri, 14 Aug 2026 01:43:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4006:b0:47f:8fda:1af0 with SMTP id ffacd0b85a97d-4815a4e7281mr16710338f8f.4.1786697006112;
        Fri, 14 Aug 2026 01:43:26 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c1307sm6513373f8f.27.2026.08.14.01.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 01:43:25 -0700 (PDT)
Message-ID: <643936d9-5da2-45cc-b108-f7c2e7785044@redhat.com>
Date: Fri, 14 Aug 2026 10:43:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
To: Matthieu Baerts <matttbe@kernel.org>,
 Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HT-zVoqQRIliTq3Cli1Vm9uu_TojPh0qj2_zOw0NjBo_1786697007
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 5:32 PM, Matthieu Baerts wrote:
> Hi Paolo, Chenguang,
> 
> On 12/08/2026 11:45, Paolo Abeni wrote:
>> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>>
>>> After fallback, treat the connection as not fully established so later
>>> MP_JOIN attempts are rejected.
> 
> @Chenguang: please first reply to the questions and comments from the
> previous versions, then only send a new version when the discussions are
> over.
> 
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
>>
>> Does the above improve actually anything? The test is inherently racy,
>> as lack the fallback_lock, and AFAICS all critical paths have already
>> explicit checks under such lock, see i.e.  mptcp_finish_join().
> 
> Indeed, the fallback lock is missing.
> 
> Note: Chenguang is looking at a bug where, when an MP_FAIL is received
> before being in fully_established, the kernel accept going to fully
> established, and creating new subflows, then reject them once done.
> 
> Same when receiving a 4th packet without MPTCP options.

It's not clear to me what actually goes wrong and how. Do you have handy
a event sequence or stack trace demonstrating the critical scenario?

Both the above look like bugs in check_fully_established(), or
incorrect/later check of fallback status/fallback_lock.

i.e. AFAICS active subflows are created and added to the conn_list
without checking the fallback status/fallback_lock, but the later join
correctly rejects the subflow finalization, so there should any real
problems beyond some noise.

/P

