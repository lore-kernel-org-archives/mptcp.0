Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB635DDBE
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 12:58:36 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51dd1e5a621so5782833a12.0
        for <mptcp@lists.linux.dev>; Mon, 03 Jul 2023 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688389114; x=1690981114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1GvmXvk70zLLAU38pJ9xZyOnpSvmxUVbuMvEuAjArU=;
        b=YGFqnm92fIbwKhQw7wCUxbXD5rPHFynFqVCHafr84dyMiyLWumTyyriD1fLsrRhizy
         qDomCaMxzNcqLs/b5L/t+f4t7XmGsoPUgXuWR4d+/01vXUKAnowxldpXOhZVJ8IplHjE
         JIxEAm2asku23R0hh37DD+0h3LV6Ut4aK3tvuZNtNB40N4OUGKM8tE61qv+Hrf8MdBpQ
         PCjLyEbj/hDkiL+dgs6eiMu/SlUl+YIn7osnqh90K+E+NtLZHigm85aCt8IrQ4iwrwDc
         xTRhGlNAkvRgfXti/PNdyAI+ahzYl/cb2h/YQ7cgLkEEXQF5Hf0FUUA3HGjp22/YgN3E
         Fhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389114; x=1690981114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1GvmXvk70zLLAU38pJ9xZyOnpSvmxUVbuMvEuAjArU=;
        b=EW2g3zMCD2UboAIJoi6bIYAKFueb0LanHxeSVTpnNjA+wMHGWi5JRIgs1QD2H+HmYZ
         mwmoWJkYBv/IUyq8lDhIFCZgNKabDtXqHSEa2h+Plx+PHrHPU97Yfhtb9GuP7Sj0nyS6
         2325TR5YLrtHcgujiqT5wTMHKyBTKi/rgKzla/aFDY1fszPzZDlK5P6qMQDCJwSG0J8D
         reIG7gMytVjEHSFVK7gj3wd1RNWLrBOv0Sl1naNnzIfXu2K8lH5kSYXuMBf6DtwOqqFc
         y3jiDiALc4I51wEWcGUhwWysaMGKzyGM0fmkbg/QT4jZ2ea9eMKJBHzajWKaGg0VuS3t
         Dy3Q==
X-Gm-Message-State: ABy/qLaWkVHMvH9SuYQdb0HTqGAMVF3NvXOXUqMDLs6KhWiCYNFXYxmq
	tL5/W/5rxNbiegRsD2xpUR00dlUNGHEPbfMlzao=
X-Google-Smtp-Source: APBJJlH2CL5IgMpr1SvNdpTNILn4ND16G5CkxgMhe2ISnYBHGiCYh6T7tTgGXhazKX7smqhzefXGrg==
X-Received: by 2002:aa7:da51:0:b0:51d:8835:90a1 with SMTP id w17-20020aa7da51000000b0051d883590a1mr7820784eds.30.1688389114320;
        Mon, 03 Jul 2023 05:58:34 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dy12-20020a05640231ec00b0051e0f21c43fsm1454453edb.31.2023.07.03.05.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 05:58:34 -0700 (PDT)
Message-ID: <75889293-09ec-a3e6-877d-c67154e36b74@tessares.net>
Date: Mon, 3 Jul 2023 14:58:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1688004307.git.geliang.tang@suse.com>
 <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
 <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
 <20230703065411.GA22455@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230703065411.GA22455@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/07/2023 08:54, Geliang Tang wrote:
> On Thu, Jun 29, 2023 at 07:43:50PM +0200, Matthieu Baerts wrote:
>> On 29/06/2023 04:12, Geliang Tang wrote:
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 968139f4a1ac..e439f8b5f203 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
>>>  	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
>>>  };
>>>  
>>> +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
>>> +{
>>> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
>>> +		sk->sk_protocol = IPPROTO_MPTCP;
>>> +		return (unsigned long)sk;
>>> +	}
>>
>> How do we ensure such modifications are done at the right moment? I
>> mean: we can only change the protocol ID in very few places, before even
>> creating the socket (__sock_create()?). If we change it after, we will
>> break stuff: tcp ops, security labels, etc.
> 
> You're right, Matt, we need to do the modifications at the very beginning
> of sys_socket(). In v3, a new wrapper socket_create() is added, it's the
> right place to do the modifications.

Thank you for this v3 and for your replies: it is clearer with your replies!

I hope such wrapper can be accepted upstream :)

It is then important to fail if bpf_mptcpify() is not executed at the
beginning of this new "socket_create()" wrapper. Will it be the case?

I guess the verifier will make sure bpf_mptcpify() is only called with a
function having "struct socket_args" as first argument so "by accident",
it will only be bpf_mptcpify(), right? Maybe there is a way to clearly
mark that bpf_mptcpify() cannot be called elsewhere? Or make sure it
fails if the socket has already been created? (maybe that's something we
need to ask to BPF devs)

One last thing: in your v3, I think you restrict the conversion to IPv4
only sockets, no?

  (args->family == AF_INET || args->family == AF_INET6)

(and I guess you saw that the kernel test robot complained about one of
the patch because the new wrapper is not declared in the "include" dir)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
