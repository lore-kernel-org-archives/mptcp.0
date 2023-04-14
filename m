Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956CA45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:57:53 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id bd13-20020a05600c1f0d00b003f14c42cc99so265904wmb.2
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681466272; x=1684058272;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9MuZF60H267Q8DimFW/rMAi8yN1WXwI1dsAfJ/P17A=;
        b=IVVarKsljqCRw4frO7mfuUJTHYNlIBLCReKetC0oBvH4+pwehD+hvscEe+hnO9CxMB
         VrRPJTx+Pzk++URQ8tNq46lemc3+OC6o8ZDlBggGetSenUjKSE275Eg6Y1I+JD6mmD1i
         4VYYAeMjkTCbJlwMt8cWQnohBcmMTX1G+dFNeaXf818WUzFkCa5822Qq7tS467BGwhBq
         kpgiDClsPa2SLdy9K57sC7hJ1oWwoybyObUBUUY6Jpz0gBfZPZlPeYYZc65kK7hP6yKa
         ZgEQhVKWFnhsFdPczzD9gSp85i4ujGDqXKV1IBTlqXweFTpmfKzHq3arCCoRjIdq5U2U
         kk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681466272; x=1684058272;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9MuZF60H267Q8DimFW/rMAi8yN1WXwI1dsAfJ/P17A=;
        b=EpzrccBfkph9ovjUdXbYdPlCFSJ5NPvAKOq1D9moX0vVLgj5HhPsdymfTe0Fjt40Dj
         4ONitK2W+rtr6YaoxgHcQcYlrrrGRSPJEw7rY5sRXC1yiMnfL3cGp/NDhBNS7EDz57CT
         pP8Ztfphtm4SDSfCHPUklEg1VrJe0ExCTuSUywFWw713SpJVdGgZBOXgi7yN0plFaSqD
         C2TwU/CmComC2K++su4LosaHP62lSR2Y3x3E2lMz13F3gf/7afkbKnqsgKnpvmyhPSyw
         uyZun6pLKlsSKx83MZx0PAxxJ9j0VDMN1zBYLMcOY7qVR4DJZzfLDIcf+tlawvoT6AJ6
         aleA==
X-Gm-Message-State: AAQBX9c5vdJh/kfCE2T8/C0vwWsW7+siGnM+/bWK6WfOEYJq6++nWQno
	4FoNhMF3fEkXtjCyleGcuofDhkYRtg1dYeBAWY4HS0Gp
X-Google-Smtp-Source: AKy350ZBmX9u/cS//cchePk3ESKasbsq+i3XoOICe8WwjLI/ozbhexNI2xWfoF3oicmpN+4Lg4G7BA==
X-Received: by 2002:a7b:cb06:0:b0:3ed:af6b:7fb3 with SMTP id u6-20020a7bcb06000000b003edaf6b7fb3mr4480299wmj.2.1681466271637;
        Fri, 14 Apr 2023 02:57:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d0dc:bfd7:530d:5db6? ([2a02:578:8593:1200:d0dc:bfd7:530d:5db6])
        by smtp.gmail.com with ESMTPSA id z1-20020a056000110100b002efb5ef9f07sm3182890wrw.82.2023.04.14.02.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 02:57:51 -0700 (PDT)
Message-ID: <13532682-8116-1b7b-74a1-baba9d6fbf98@tessares.net>
Date: Fri, 14 Apr 2023 11:57:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: mptcp: bpf: Remove unused arguments from btf_struct_access():
 Build Failure
Content-Language: en-GB
To: mptcp@lists.linux.dev
References: <20230414092934.4065227-3-matthieu.baerts@tessares.net>
 <f0bba04c-2f0b-4919-8227-0821b04932bc@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f0bba04c-2f0b-4919-8227-0821b04932bc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 14/04/2023 11:50, MPTCP CI wrote:
> Hi Matthieu,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/20230414092934.4065227-3-matthieu.baerts@tessares.net/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/4698487727

I didn't think about that but the failure is normal. That's because each
individual commit is tested and the fix is done in the second one.

The first patch fails with:

>     CC      net/mptcp/bpf.o
>   net/mptcp/bpf.c:73:35: error: initialization of 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, int,  int)' from incompatible pointer type 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, int,  int,  enum bpf_access_type,  u32 *, enum bpf_type_flag *)' {aka 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, int,  int,  enum bpf_access_type,  unsigned int *, enum bpf_type_flag *)'} [-Werror=incompatible-pointer-types]
>      73 |         .btf_struct_access      = bpf_mptcp_sched_btf_struct_access,
>         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   net/mptcp/bpf.c:73:35: note: (near initialization for 'bpf_mptcp_sched_verifier_ops.btf_struct_access')
>   cc1: all warnings being treated as errors

But the second one is OK:

>     CC      net/mptcp/bpf.o
>     AR      net/mptcp/built-in.a

I'm going to apply these two patches then.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
