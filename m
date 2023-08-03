Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9224188
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 16:32:31 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-997c4107d62so166860766b.0
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080350; x=1691685150;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZ4hM/q0HPwTItwRxcoCHVMnPlLGYXjnVrDNi3oJPwE=;
        b=PJIfwjnPcq5K/eieK0jYsUg2wrAfml1/zyNkdsiMpk1rPDmxMtUCn7dwsENu/dqBW3
         FoJLxM41Q9oW1PUyBKo2jG8xbpeZnvhLUTgDgb5DiUni2T0PZkqIKSYgWxQi/T83nl+t
         pXIj8Gs+zAaxvvcc7Na8cryb/+eiYqbsOrlOoJVeASeEMfPnrW8kGcmCAT2GGsLY20xL
         4hG9PxGQDlE5UhBvMESKsvNSZJGXRl0RdmLWgDgh7Sz8WL80tV22LoCaOvaB+82V+PnM
         d3l4SWzwU1jKUZ8cOzQBr8bJBAZsSyGuXY4DTYtSakRmcSycNP11ZBTIar8nnEiN9fTU
         OcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080350; x=1691685150;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ4hM/q0HPwTItwRxcoCHVMnPlLGYXjnVrDNi3oJPwE=;
        b=FvWewQEouT99zR5mdeXXwNaUq071x/Q9zyyl4spLMHo1jowGyZ66e0jXYuttBMlW9E
         EsgFxAoYZxuucoJyCa5XI33QSHWjcDabIrbS6kkXY3TrMDNOuEKWNrg9BrdqxQhAwZyx
         48hppAf/HG/UQfJNp9lVFwtBQNFOnckTV0htresOUT4cGad9W+4q/S+GHP6bfMTFFyMD
         whvSFIKJ1rl1vr/71RLUT8SJABIDSQjweZXNRqHa4hDTlzJyfZDmaca6JBPeVgpxfNLu
         9uPnAIG4ifsRi/IUZRMi8CyH2nET37jVI2Nn4ClsFdFqj+epksEUREceerVHfcNfWECM
         QAzg==
X-Gm-Message-State: ABy/qLbpS4QRHgV6hZhXvO0VCK1BUmRJTCakP9F4B7uPlhfBCiZFF2iK
	HSMUcGn5APHFWfAmtOWuh9DJ/A==
X-Google-Smtp-Source: APBJJlETHyKda7hW2GukYxbJ55rLLHE6UsKThSzEkBMfo1K5a1Rljp9JtErcdrxLF+jpDxF6Hhxk4A==
X-Received: by 2002:a17:906:109e:b0:99b:cf7a:c8d4 with SMTP id u30-20020a170906109e00b0099bcf7ac8d4mr9009697eju.18.1691080350169;
        Thu, 03 Aug 2023 09:32:30 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ace8:eb44:12a0:888? ([2a02:578:8593:1200:ace8:eb44:12a0:888])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709066b8700b0099c53c4407dsm51247ejr.78.2023.08.03.09.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 09:32:29 -0700 (PDT)
Message-ID: <d3fa9b41-078b-4bb5-9f5c-d8768b787f4d@tessares.net>
Date: Thu, 3 Aug 2023 18:32:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] mptcp: fix the incorrect judgment for msk->cb_flags
Content-Language: en-GB
To: Xiang Yang <xiangyang3@huawei.com>, martineau@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <20230803072438.1847500-1-xiangyang3@huawei.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230803072438.1847500-1-xiangyang3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Xiang Yang

On 03/08/2023 09:24, Xiang Yang wrote:
> Coccicheck reports the error below:
> net/mptcp/protocol.c:3330:15-28: ERROR: test of a variable/field address
> 
> Since the address of msk->cb_flags is used in __test_and_clear_bit, the
> address should not be NULL. The judgment for if (unlikely(msk->cb_flags))
> will always be true, we should check the real value of msk->cb_flags here.
> 
> Fixes: 65a569b03ca8 ("mptcp: optimize release_cb for the common case")
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>

This Coccicheck report was useful, the optimisation in place was not
working. But there was no impact apart from testing more conditions
where there were no reasons to.

The fix is then good to me but it should land in -net, not in net-next.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I don't know if it is needed to have a re-send just to change the subject.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
