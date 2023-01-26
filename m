Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A724C8B
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 18:27:29 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id q5so2716659wrv.0
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcGOtGKPorID4j+0WxkxUmj98dVp1rE3El6V8HFQBUs=;
        b=G0xh+AQ1bYgCZzjITWYF4H578LYntcCqJVLngppAYPvMD7qgwEZagat/8HYse8Fw0T
         +zVyOYJwUSWr+7ykZNa0p229Gh9N9G8EvWOT8sIjosQgvbNkLruWHyGClsoiUhkf/OeZ
         fvatmWjwB12Q2OzPOqtZb0/XfoXHoeu1avdjTsRRfnQzkk8/C7MsjgxW81EoCskUqeNX
         SuR8TgtHa/23R5HqvmMRJAAjAGFhXbb9ZFcL7GRLXJhoBn4bV9yJz1YIddWf42E9giEp
         CsJGUy24pL5Sggsw/slktNvU7nqwoSKgTxUgvcEmk+obJB7VOmSe94V3auo0ld8FS2hX
         BCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcGOtGKPorID4j+0WxkxUmj98dVp1rE3El6V8HFQBUs=;
        b=3sg+c123wmC+MVPi3RdL0xRk81aK0bmE6tpFte9ETgBBXxWFzoms/g1BvR3StRFRSL
         GWM/BOUFdqS9D4tdhwjOcROVIFkO2728jjiwa9ayIoHNJnoEw2f893N/CZ+KtrQIwjUv
         4ndr+RpSNUQN1iXLlbPaYTYyMgmKoVno1wVGYn9wdgQpAXJzaZRFEY1KoUYg0GwCz8Sk
         IYgx8qvfx4eOzSRCPKek8lXZ+kZrAN+41c73IK16eQz8PTiTfRFJjA/5hmdPWsBd7Tc5
         Dlj2yi5k2mbO3uJUm61TH2pil/5K4+l9pjtuLbS61QA7YXwRe+uRBPwzjEnZd2j1ZyKE
         x0qA==
X-Gm-Message-State: AFqh2kojXU7BtY47y81lQs8ySZo6WjbDc/Bcp5SIWGmGO3X0LHbHz5ez
	NJFoQajcHuglantDU2oE/1HU6g==
X-Google-Smtp-Source: AMrXdXsoS5OcK+mPbxA8BqC60aqEnvQ60hmNFvHoWMFvAOJpBgQsuUDRix7o3AqkaqxOqCJPCwlG4Q==
X-Received: by 2002:a05:6000:a03:b0:244:48b3:d138 with SMTP id co3-20020a0560000a0300b0024448b3d138mr36155746wrb.54.1674757647400;
        Thu, 26 Jan 2023 10:27:27 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9734:4fc3:798b:7157? ([2a02:578:8593:1200:9734:4fc3:798b:7157])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b002425be3c9e2sm1983961wro.60.2023.01.26.10.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:27:27 -0800 (PST)
Message-ID: <b21f2991-c404-0efb-69fb-f9c6343d8ce2@tessares.net>
Date: Thu, 26 Jan 2023 19:27:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next v2 11/13] mptcp: refactor mptcp_stream_accept()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1673940640.git.pabeni@redhat.com>
 <afe5ec8c5d1e4b7c72839c9ed9c153c18ff97935.1673940640.git.pabeni@redhat.com>
 <7abea9a1-9f31-7a52-41df-c6199671c4ec@tessares.net>
 <d43a5e4c7238b0bd4cb886c321a2597d03d9e544.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d43a5e4c7238b0bd4cb886c321a2597d03d9e544.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/01/2023 18:53, Paolo Abeni wrote:
> On Wed, 2023-01-25 at 18:47 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 17/01/2023 08:36, Paolo Abeni wrote:
>>> Rewrite the mptcp socket accept op, partially open-codying
>>> inet_accept(), instead of indirectly calling it.
>>>
>>> This way we can avoid acquiring the new socket lock twice
>>> and we can avoid a couple of indirect calls.
>>
>> Maybe a stupid idea but could we eventually split inet_accept() to have
>> a __inet_accept() version with what has to be done while holding the
>> lock and reusable in MPTCP?
> 
> I thought about the above but in the end that would be a very small
> helper:
> 
> 
>         sock_rps_record_flow(sk2);
>         WARN_ON(!((1 << sk2->sk_state) &
>                   (TCPF_ESTABLISHED | TCPF_SYN_RECV |
>                   TCPF_CLOSE_WAIT | TCPF_CLOSE)));
> 
>         if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
>                 set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
>         sock_graft(sk2, newsock);
> 
>         newsock->state = SS_CONNECTED;
> 
> with the larger part  - the WARN_ON - being likely obsoleted. 
> 
> I can do that, if you prefer.

I would prefer but please tell me if you think we should not.

I'm maybe a bit too paranoiac because we had some nasty bugs in the past
with mptcp.org due to modifications on TCP side. (But I know the
situation is different here: MPTCP is upstream, people might now think
about it when changing the core and a great net maintainer is super
aware of MPTCP :-D )

If the chunk is "duplicated", it would be nice to at least add a comment
in the code :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
