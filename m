Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079D9CA76
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 20:54:30 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99bdcade7fbso1698998966b.1
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695934468; x=1696539268; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuOaPpVrG6q1kYsL4e2bd/bG8/Hv7nlP3G0r8YGaklU=;
        b=WZGFMQuKLLKqa2Xi8a1QZXllY+W7IbKEuilx8c014Ot83cRp9CizM4OevDEGxsldUM
         5EKj5UEs7t6ZJ4x6OgcAViUxsoMExF25j8JSQyN7VwNE2BagxDogCsJsFC6HvV0x5aj4
         g5vBNLoWYrmutmfQ7QiZKcJS6SzWZxMZ25KoA+vdYK18elefo12M4ZJ2LHts48BGwg9X
         b6QSKY1f8BmIRLdM18phMbNy7mxv/tgX10wlSCw1N+7W3hiWx+YNFZsamvcq8GQUPLnm
         R6ubI8ZPqW/LwGFTQOrU0WzqCOG8peIOIlL2P08utM4R/ZLMgYOe9+WjcTPA0NauKioC
         2NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934468; x=1696539268;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuOaPpVrG6q1kYsL4e2bd/bG8/Hv7nlP3G0r8YGaklU=;
        b=hOnRmXCqslgOAXthgdcVPDi0mEG+1gj22dwchpBjjh0sA77HXPLFwEDd84pO1Jqmqb
         VdVYQDgG/4GkBmFg3hRWKGF0SKNRsWm63d7GS9QVXRlpm6hV6qmOur6sy+YxA8iZ94tE
         JF6IXZOCNmVi4hIbTgWeEcO+7WF/Q9y8t3TJV9QPR37uBy4E8JNwhSdh7+rzculH0z5E
         gLpFKGx/hZX/IuGQLuKDQf82CzFml7HkCPNCgLRkE126lSSaUXtAqqW1SnO/NLeZCfGK
         G4LdCTSHoAl5V6PnPvewZKnk27kp7Y6vFU7jNpFLrRKKGKnf3DKWo6a/bPb8Ihwj4ms4
         MdVw==
X-Gm-Message-State: AOJu0YxRZ3Wlk3Qu1wfYHooAxSdxrQXR9ajNPzsbi0h1gjxh/t9/odCt
	Ex321c1NTlbe3qTF6QX19EUVWgCAOzwEiTrgF+mcDw==
X-Google-Smtp-Source: AGHT+IHjI4NuR8lYxUrbQL2TEVqqSzmCwuBPC1+QudblYaJfD1OMAEhCUXJCojZ06A14LdF0RJ28BA==
X-Received: by 2002:a17:907:b1a:b0:9a9:f14a:22dc with SMTP id h26-20020a1709070b1a00b009a9f14a22dcmr2380666ejl.8.1695934468388;
        Thu, 28 Sep 2023 13:54:28 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b0099bd453357esm11333547eju.41.2023.09.28.13.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 13:54:28 -0700 (PDT)
Message-ID: <4faab698-f464-43b4-91aa-19177a0ee77b@tessares.net>
Date: Thu, 28 Sep 2023 22:54:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 00/29] userspace pm enhancements
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> v3:
>  - drop patch 4 in v2
>  - invert patch 10 and 11 in v2
>  - rebased

Thank you for the v3! And again, sorry for the delays!

I think patches 1-11 + 13-14 are OK to be applied (with two small
modifications for patch 7 and 11 that I can do when applying these patches):

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Please note that patch 13 will go to "Fixes for -net". Patch 14 can stay
in "Features for net-next" due to other dependences.

I have some comments about patch 12 and 16: on the wire, sending a
remove address for ID 0 or actually removing the subflow(s) with ID 0
should not trigger any RST (+MP_TCPRST). I guess the kernel is not
behaving correctly if you observe them during the test (that's good you
added that in the verification!). It means we will need more patches for
the kernel side not to send these RST in these cases.

If you send a v4, please move patch 15 (mptcp: userspace pm remove id 0
address) to the top as this one is for -net. It is fine to keep patch 16
where it is if it depends on other features.

> 1-7: some small cleanups, v3
> 8-9: address #428, add mptcpi_subflows_total
> 10-16: address #379, #391, userspace pm remove id 0 subflow & address, v11
> 17-19: address #403, add refcont for address entry
> 20: add userspace fullmesh tests
> 21-29: seltests cleanups

Note: I didn't review patches 17-29 yet. I will try to do that ASAP (but
very likely, not before the end of next week :-/ ).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
