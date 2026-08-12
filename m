Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22F41A565
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527959; cv=none; b=rDmyq94vvsMMxMdDRC63NumOCBi+zY+AZVSU8ke93QOGCntwPyikzPdH4IUcM+llzkTMxMS0i/IgXcdZb3Bb2zRUDmkly//aY2dPSDGD1lR1Lwe45zhyB/IfsqILL+HEdu5ZdINjx9TrdZMNy8CdBFkPWBO4v6DD/Z3S2FujP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527959; c=relaxed/simple;
	bh=SxbLFldciBYNC/g0Rk6xIuBuXqAfJK2TSp3gjngAw1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI6cd82/z5uMwSZTjFXC1BCIjee9iimiArLAsYoDy1a6xQk7vpRq74LfUhTZfcoaxCoJm1+RwnV3o9fuMCJZynMq/dIC2PQg/UK8RXwOJVUdwzHnsGDqbVFPeB3Ajo1XjU4XbIw3KMfFuOYp+LHY0U6yIfFCuhsrBNrgHzkyoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/AyGbnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/AyGbnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786527956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xU9amcRH7SL8EF/JA8C/TSvBOmJwdOnoT+QqDhCCEjg=;
	b=d/AyGbnPtCPynQgN7SnIsGnqbmF2ZxmWcndYkItTQnhQZcFLjFc9UCYkqtr0KLBLavmwtA
	hhdH2FwDieyQNxPhFELZCX08UCgGE2mZmvKe+nbTJAfyp3MOh408zSNkykhtrNa2yrxXP7
	n6W4uZfvmzV3hGGcEmt1SfEUBKxlxHw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-9kode9ZxP_W_9rCKq5zHuQ-1; Wed, 12 Aug 2026 05:45:49 -0400
X-MC-Unique: 9kode9ZxP_W_9rCKq5zHuQ-1
X-Mimecast-MFC-AGG-ID: 9kode9ZxP_W_9rCKq5zHuQ_1786527948
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so422779f8f.3
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 02:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527948; x=1787132748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xU9amcRH7SL8EF/JA8C/TSvBOmJwdOnoT+QqDhCCEjg=;
        b=LmLYedjX1o3J8lWfIYwTIIhy6Jer0qqo43xcUkp7BQJdjTVM+khEzjVA7s6gsLA5Fy
         7AexMNLuY5xQqsvoQh9AQE9tfylBgKTUVFeHpmwRBHMDXZDMqEJ5fU5uTx0LBDDpNgCn
         w7qjTzlcomQfVMMj3hJ20IQRHfMKCD+jVc/oLFhugwZH2EbKAUsJPVs82moWJ6nYxYZ6
         w8jmkSnfE8Dfa7+PiQvJ+v/XDTb8XUTG3ttwuh88C8cKlblhOlmLTO3NfBgazV9RDKGf
         muEw8uU0jC3LdXvfeI4F9YFvCbmRcP9oGNuz6/i7puPY7Gtw+T7Gja8YNJZ2dF+atBqZ
         VQrw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0W/owKzxcK1VqDx1NImjPIU3B0ZRM6MLdcESS1FcbB/IDs+OvnJh4MDCX1ZILzHu4/gIAzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE+bWBv2793dRL4Qka53yO3zAYVBoaW7u+3k9VFn5Dz5UUXPJi
	rOhj2jdog7LWyWtoZSYfgxGFBBlTvT4GgR4NNufiek/KxNnlDp1kOevzxFRLpY77GLwlfVvgdEv
	KWN64FH5SSjQAlmluNJGahM/kLxmoPbFZChUUbPwNiG+54fhsz0cD9tLhcuno5h1R
X-Gm-Gg: AR+sD13b0+xrUhc6Ffsfxni75YwztP+uykWQwJAajFbvkym8u2LP1ZPDnOIKOgWEF9v
	1RVuWzgORECjW6qf5NftiomfP8y/FR1EQwWcMacxYKTtrEjC2ikBpR3AYcbWD6BmN7se4yGp6V/
	+XGY+BtKJkp6gOGaud/ui47okja7czlp4wWXiccm6nSEu1AMzWa9+8sHtOfe/XLzEFISGftawO2
	UT5KM2afsstQ+IVL7Uk1cj6ARjCA2vzKT1TMu4zI3BgbmUFVdF5sqOhULeGekQ6NpXjXiYDtD5U
	E5eeXFRxSV7Ejnl94dul3+Fo7Uwm+0T0a3nOV2sDt1iOhC+oSrrJsJTQMRc3EomZ4zlmZv/Qr+U
	gaQ+D1/4J7saP3vFFjli1D5+kbNlfAJ2b2mNCbAvQ7wdO0/H9UOlI6AMRbtTZ0znQIV06H45STu
	I=
X-Received: by 2002:a05:6000:220e:b0:481:5276:7c16 with SMTP id ffacd0b85a97d-48152c3f474mr4623620f8f.16.1786527948424;
        Wed, 12 Aug 2026 02:45:48 -0700 (PDT)
X-Received: by 2002:a05:6000:220e:b0:481:5276:7c16 with SMTP id ffacd0b85a97d-48152c3f474mr4623552f8f.16.1786527948006;
        Wed, 12 Aug 2026 02:45:48 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150bf7767sm5492114f8f.5.2026.08.12.02.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:45:47 -0700 (PDT)
Message-ID: <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
Date: Wed, 12 Aug 2026 11:45:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260812054653.43799-3-chenguang.zhao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NFKJo9U-cIc9at3l_mPfVPFe_Mt3IIX7eKT4FIToTrg_1786527948
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 7:46 AM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> After fallback, treat the connection as not fully established so later
> MP_JOIN attempts are rejected.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/mptcp/protocol.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7e168e450fb0..bf2483a7ed92 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -957,8 +957,11 @@ static inline void mptcp_start_tout_timer(struct sock *sk)
>  
>  static inline bool mptcp_is_fully_established(struct sock *sk)
>  {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
>  	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
> -	       READ_ONCE(mptcp_sk(sk)->fully_established);
> +	       READ_ONCE(msk->fully_established) &&
> +	       !test_bit(MPTCP_FALLBACK_DONE, &msk->flags);

Does the above improve actually anything? The test is inherently racy,
as lack the fallback_lock, and AFAICS all critical paths have already
explicit checks under such lock, see i.e.  mptcp_finish_join().

I would prefer avoiding additional conditionals, if not well reasoned.

/P

