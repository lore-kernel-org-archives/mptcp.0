Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156F2C9C
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 12:01:45 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id s18so9115479wrv.7
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tOQD3zooK52kf69k6tALW4XrIJF4YbCrGG0DRjSAtyA=;
        b=yKnc4DcFrfEgoeazj7zijDUqJ1/LVeetwbj8Vz1MNJOwBZhkmB8VblOXHmM28fUyrx
         WGZrxLLxaZ2IM5UDamfA9eoCMs4FxQ4R3tVWXZrEZZqCPWvXYDvQ3Mc1V6NxqUVBE9Yb
         LOho9gxd5R+onuKBRA1s08Xpp0ldFboSb1lHmeqcEHWP8apS8Qa8uXqEsHaUA3ISqIwE
         ewMrAyep3QeBd6pCIXtdqs3etH7cFJiDJi9LDURfmzvzHsKo/BmpWF9pTk/nBqp/AB3c
         P7liJr2txzAl2UDLeVJvT5AebUKPdygnINdzjht1F0zgf4T0A11Em8ArRLSpBBhYsLsx
         L1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tOQD3zooK52kf69k6tALW4XrIJF4YbCrGG0DRjSAtyA=;
        b=StSNlxdORXCyHwC8mOAC5+Ka01kR7SiAMH2AgeV+p54V5JFdej9HQxNjbd6q03IGiT
         Qlvza15UsQ8H0AQd5JGkqJ8TgleO7Nnb6d0LTtSdpVLR6sVFLyeF441tFHotdmbbzKGk
         BJQN1Cm/SjvHNKAsw4bBk7zwaYcJJ5rxaMcA19ZwC7/Z2/BdyNc/Az9F5wVRkVabZ7uC
         j7C/XO0Z0Xkyx3YxdV+YW3yByLAyJhv7q1xZhReOfKP0yKG/EdlgkrckDC8W2/cfmzhA
         IfounqPeeKBRFFTJjkSAlzZkcxMnL0ut9SItZxZVx6aOq07XVmutTx1anxuCBvH1zeTL
         PsnA==
X-Gm-Message-State: AOAM530G8gV6wqoSVG+SB/VhXWiDNxpd0ePiRSRkxrk1FaPG/HnVOBtY
	pdFvviUe5nbzuO+zZymveJgSylTe9Yw1lUQm
X-Google-Smtp-Source: ABdhPJyFQrduSER/WmOzO6sfu4ahqhx5OuWyzqQZ1S/2ZQg2ZoyWEpUlk0w9cdaQRp6FZUNAVZkYFw==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr6093094wrq.61.1644494504016;
        Thu, 10 Feb 2022 04:01:44 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id az2sm2132515wmb.2.2022.02.10.04.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 04:01:43 -0800 (PST)
Message-ID: <1f8efee6-d9db-8779-14ca-65d744b5991b@tessares.net>
Date: Thu, 10 Feb 2022 13:01:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add 'bpf_mptcp_sock' structure
 and helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <8b35b6817474d6b5ea0a3e5c8be617af6d130867.1644491001.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8b35b6817474d6b5ea0a3e5c8be617af6d130867.1644491001.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/02/2022 12:03, Geliang Tang wrote:
> This patch addressed to the comments in [1] from BPF maintainer Alexei
> Starovoitov:

Thank you for looking at that!

> '''
> On Fri, Sep 18, 2020 at 02:10:42PM +0200, Nicolas Rybowski wrote:
>> +
>> +BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
>> +{
>> +	if (sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
>> +		struct mptcp_subflow_context *mptcp_sfc = mptcp_subflow_ctx(sk);
> 
> Could you add !sk check here as well?
> See commit 8c33dadc3e0e ("bpf: Bpf_skc_to_* casting helpers require a NULL check on sk")
> It's not strictly necessary yet, but see below.
> '''
> 
> I added this !sk check as he suggested.
> 
> '''
> I think we shouldn't extend the verifier with PTR_TO_MPTCP_SOCK and similar concept anymore.
> This approach doesn't scale and we have better way to handle such field access with BTF.
> 
>> +     }
>> +     return (unsigned long)NULL;
>> +}
>> +
>> +const struct bpf_func_proto bpf_mptcp_sock_proto = {
>> +     .func           = bpf_mptcp_sock,
>> +     .gpl_only       = false,
>> +     .ret_type       = RET_PTR_TO_MPTCP_SOCK_OR_NULL,
> 
> In this particular case you can do:
> +       .ret_type       = RET_PTR_TO_BTF_ID_OR_NULL,
> 
> Then bpf_mptcp_sock_convert_ctx_access() will no longer be necessary
> and bpf prog will be able to access all mptcp_sock fields right away.
> Will that work for your use case?
> '''
> 
> I dropped RET_PTR_TO_MPTCP_SOCK_OR_NULL, use RET_PTR_TO_BTF_ID_OR_NULL
> instead as he suggested. Drop bpf_mptcp_sock_is_valid_access() and
> bpf_mptcp_sock_convert_ctx_access() too. I tested our case, it works.

Is it OK to let access to all mptcp_sock fields?
e.g. local/remote keys?

I guess it is fine because not everybody can access them but it is
certainly impotant to check :)

> Now only one comment from him I don't know how to implement:
> 
> '''
> Also this new helper is not exercised from C test. Only from asm.
> Could you update patch 4 with such additional logic?
> '''
> 
> Please give me some suggestions?

Is there no other selftests looking at tcp/udp socks?

Also, do mind looking at the "userspace" tests Nicolas developed to
check nothing has been broked there too? He pushed everything there with
a README:

https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
