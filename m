Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5A2568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 09:12:49 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id u18so27902875edt.6
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fQCAGe6u9L02gQfJoT6mOlTy27QIe71t+e0HrUEPr+I=;
        b=zFW8+CPNIzMkE3xjn2NKjfRoJ28iZZKVIxGVdkFnTv57HKHF9KWTTKku2pG24ZG7+J
         T6rmE8safLKsLNYVgN9D0G9vd8oHYLCd1RLAhCb2uBTRQ+DWthK2TxZnXFZKdlPsLfnO
         AwgbghrWiCS8lyF0u0nzagvfMmrm2q1HljmebETtifbNhkpWEXmvu3bfuCjVnZeciQiR
         N2KzeLEq1ZY8G+6clwZmpV718VWwaA25lPWAbw744uAudQWZIv0/uhFl03/1CP96wiXm
         l25zWLf0HUskm9o3Y1WIuS80O7J436zcRkrxKx4scvYDuI8E1I+xlPJeAnfuxcFy+Jll
         twxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fQCAGe6u9L02gQfJoT6mOlTy27QIe71t+e0HrUEPr+I=;
        b=xWlWrm197u2z4hswwDQMnykJk3ZpRffYniAur7sG8DmSqkgcvuZ1v7Cnano7VMMuIC
         FBeUqK7MFBNBLS49yLEANTnPtHREyVE5lq14FdzeyhIGhjq1m2Xz7gxNZhvVkCBIKSfp
         kvj8qG5bAUDiRVu0+EfN8d1MzA4cR6ornnsnj4eYjvuVcpmOho3ztnny2/+u21NpOE4D
         1uU+6bJA21Sj5ErukEl4842sAiKKHrAUrbeyKZ716ft3wiuam9uIoJkHBVIqc1C89oCf
         5867P0wuCWbWWiIGZjKMZqUCL0tqcwJfKKFe+8crHp8VAqNPYK9jKrG7GAXCan8vCH1w
         5Cmg==
X-Gm-Message-State: AOAM532GpVEfhQCJUL+PDtGHqr7ACXnolI7ZvuM0gPAywBjuqY7qDAPW
	j/7mV2nbDt/l96YoX9zYNWy/ow==
X-Google-Smtp-Source: ABdhPJwMHT1KLNsmzBLr5S6hkJqs1dTKQeJav7JBp5HPDPqO+byRWkBtggpcdTmiMZg4nnDCbAfArg==
X-Received: by 2002:a50:aadc:0:b0:40f:5c06:ebb7 with SMTP id r28-20020a50aadc000000b0040f5c06ebb7mr20146383edc.387.1645434767643;
        Mon, 21 Feb 2022 01:12:47 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c96c:6bee:7423:6c0d? ([2a02:578:8593:1200:c96c:6bee:7423:6c0d])
        by smtp.gmail.com with ESMTPSA id 17sm4903753eja.57.2022.02.21.01.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:12:47 -0800 (PST)
Message-ID: <426e80c2-781e-7968-cb07-90bb4e4e10bc@tessares.net>
Date: Mon, 21 Feb 2022 10:12:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add 'bpf_mptcp_sock' structure
 and helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <8b35b6817474d6b5ea0a3e5c8be617af6d130867.1644491001.git.geliang.tang@suse.com>
 <1f8efee6-d9db-8779-14ca-65d744b5991b@tessares.net>
 <20220221090554.GA4912@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220221090554.GA4912@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/02/2022 10:05, Geliang Tang wrote:
> On Thu, Feb 10, 2022 at 01:01:43PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 10/02/2022 12:03, Geliang Tang wrote:
>>> This patch addressed to the comments in [1] from BPF maintainer Alexei
>>> Starovoitov:
>>
>> Thank you for looking at that!
>>
>>> '''
>>> On Fri, Sep 18, 2020 at 02:10:42PM +0200, Nicolas Rybowski wrote:
>>>> +
>>>> +BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
>>>> +{
>>>> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
>>>> +		struct mptcp_subflow_context *mptcp_sfc = mptcp_subflow_ctx(sk);
>>>
>>> Could you add !sk check here as well?
>>> See commit 8c33dadc3e0e ("bpf: Bpf_skc_to_* casting helpers require a NULL check on sk")
>>> It's not strictly necessary yet, but see below.
>>> '''
>>>
>>> I added this !sk check as he suggested.
>>>
>>> '''
>>> I think we shouldn't extend the verifier with PTR_TO_MPTCP_SOCK and similar concept anymore.
>>> This approach doesn't scale and we have better way to handle such field access with BTF.
>>>
>>>> +     }
>>>> +     return (unsigned long)NULL;
>>>> +}
>>>> +
>>>> +const struct bpf_func_proto bpf_mptcp_sock_proto = {
>>>> +     .func           = bpf_mptcp_sock,
>>>> +     .gpl_only       = false,
>>>> +     .ret_type       = RET_PTR_TO_MPTCP_SOCK_OR_NULL,
>>>
>>> In this particular case you can do:
>>> +       .ret_type       = RET_PTR_TO_BTF_ID_OR_NULL,
>>>
>>> Then bpf_mptcp_sock_convert_ctx_access() will no longer be necessary
>>> and bpf prog will be able to access all mptcp_sock fields right away.
>>> Will that work for your use case?
>>> '''
>>>
>>> I dropped RET_PTR_TO_MPTCP_SOCK_OR_NULL, use RET_PTR_TO_BTF_ID_OR_NULL
>>> instead as he suggested. Drop bpf_mptcp_sock_is_valid_access() and
>>> bpf_mptcp_sock_convert_ctx_access() too. I tested our case, it works.
>>
>> Is it OK to let access to all mptcp_sock fields?
>> e.g. local/remote keys?
>>
>> I guess it is fine because not everybody can access them but it is
>> certainly impotant to check :)
>>
>>> Now only one comment from him I don't know how to implement:
>>>
>>> '''
>>> Also this new helper is not exercised from C test. Only from asm.
>>> Could you update patch 4 with such additional logic?
>>> '''
>>>
>>> Please give me some suggestions?
>>
>> Is there no other selftests looking at tcp/udp socks?
>>
>> Also, do mind looking at the "userspace" tests Nicolas developed to
>> check nothing has been broked there too? He pushed everything there with
>> a README:
>>
>> https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples
> 
> Hi Matt,
> 
> Sorry for the late reply. It took me some time to run this userspace
> tests. These tests still work, although there're several building warnings.

No hurry :)

> We can't drop RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, it will
> break this userspace tests.

I don't remember what these userspace tests were doing but for me, it is
fine to modify them. Because the corresponding kernel patches have not
been upstreamed, it is fine to adapt them and "break the uAPI" if we are
still able to do the same things.

Or do you mean if we drop RET_PTR_TO_MPTCP_SOCK_OR_NULL, we can no
longer adapt these scripts to do what was done before?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
