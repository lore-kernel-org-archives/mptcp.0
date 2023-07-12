Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548DDDBC
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 08:14:34 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9891c73e0fbso104798866b.1
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689149672; x=1691741672;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmjKmbaPVnc0dDtUyitYGqsImWU9n+/7r4KQZfOWc4M=;
        b=E6nuo1enCmQB35v2nUqNRy+k9zlvOb0YubNrMaIGmfubpe5bzD2kTeOnxp0piwuwqA
         mFX6EELUWPBM5nnvZr5gBqCjj5wpJwJRn65ID8vncrndBTqjDH65lmMY0JVu6IY8Lqgy
         Pud3Y5K0T3RT9CxeYGM4/uUd+lQ/ZTANUVtxZ8ncbB4cqifkHtL49UPJLeVIOKRkhnzw
         8avQyBkcjNQzXvO00b+G7Ep4ZowVyoeCfLoECSHJIWPkSDOIbfJRLyH/TyFApnlNkQRw
         KAq++OakhUfWu2qiAAbQPcpvRj56TE/R1MX1k4VNEy91uXFBaTZQWzyNkddV4EA062fk
         eq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689149672; x=1691741672;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmjKmbaPVnc0dDtUyitYGqsImWU9n+/7r4KQZfOWc4M=;
        b=hnCLLcGSiH5x58azxyNIvAvtV6iw38iH6TpWGpy1V1St9y385OLZ/m/tAdzWtdB/7m
         /vhmD+rYCD4RKs0v/sIZCIWFnufR4VkUn+qoCWnajLkbdch+wk/hi94JqjSeMk0HeVht
         UfRenzgflRUHyjmV+Fsb/OaOY3PyTupvr/4BjjuJz332rEtbI/RlS7b+ZgYTrMiZx7U/
         sK2VI+lwso53Y3uv+E1rFslTycoNld2JHXSBWfjpiThybsHSom3VJy1mIuQhJpcF7FUh
         Rd6d1aSN6Xweunh8tcVBORXf+0Uf7myC+4Qbe9c6+84KuwrtphLsznt+WQKAGgMtHKtX
         G4Lg==
X-Gm-Message-State: ABy/qLaXS4PvrOEuJEIR51U225jqxIIwdKlG1vaRPfLyBOtNE/vd5XJe
	90924K/GsyKihF8UohqyTud22LjtJ8HcZn3MzO1jBg==
X-Google-Smtp-Source: APBJJlE/VEZNOkNm1IV0dlogIHYzJcnbXItOeUU2LejxXa8AODfsqaeyNdwlEKTLNmb/penuq+jxAw==
X-Received: by 2002:a17:907:3e27:b0:994:fec:e1b7 with SMTP id hp39-20020a1709073e2700b009940fece1b7mr1712097ejc.0.1689149672242;
        Wed, 12 Jul 2023 01:14:32 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e63d:32df:2bec:83e9? ([2a02:578:8593:1200:e63d:32df:2bec:83e9])
        by smtp.gmail.com with ESMTPSA id lc16-20020a170906f91000b0096f6a131b9fsm2214639ejb.23.2023.07.12.01.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:14:31 -0700 (PDT)
Message-ID: <8c868c93-86a0-39ab-57d6-e621c833f8bd@tessares.net>
Date: Wed, 12 Jul 2023 10:14:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH iperf3] add MPTCPv1 support
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
 <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net>
In-Reply-To: <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/06/2023 18:03, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for this, that would be helpful!
> 
> The code looks good to me, I just have one suggestion for the commit
> message, one "typo" with the alignment and one small suggestion in the
> code. Please see below.
> 
> I think you can create a new PR on esnet/iperf repo (and mention it
> replaces the one of Paolo).

What do you plan to do with this patch?

There is no hurry at all to suggest it upstream (esnet/iperf) but it is
mainly to know if you are expecting something from one of us, just to
avoid a deadlock :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
