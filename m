Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A181539D
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 10:18:10 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id v3so1001832wml.0
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681985888; x=1684577888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqVS9VVy7eYz0wbKAI5Os6BSDSomA8ZlIRBCJqmIhek=;
        b=hT4O4BQP3qQxWkoNFdrc19Kv2o79nxo/eyfP4zHNM6oGq8CqCg7DSCnVQBMILtAcEW
         BRk/+Lxl986AFZDfETH3OM4ajq4Si0WP5lfohu+FQAfGSOSJW9rlPP+iPH1B+8OkIp2C
         pXSXJjdKCq7ItOtMSfQhXfCA3O8UOZCNEVVcRDiUe96Kc0MJT0huve6kXp7GWwHaRaNg
         DA2qD1594eztxmzbxBFSAaE/tv3tkMcylGQUwhS/lY0lHA7rP/bzIsSh/b2ldUv7zg2p
         xgTditDWJquCjF9cpATcQKZ3J9z4zXCd176vomV/ISBZZnQJdkdYU5WpHron205Tuu/4
         rfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985888; x=1684577888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqVS9VVy7eYz0wbKAI5Os6BSDSomA8ZlIRBCJqmIhek=;
        b=S0CAvHMdh5ySJICiIlm9pBBhCthfisuwWFW9+F3ganhOqQ9ivQShVX/h0VZiRvbl0Y
         62yq/5hpV2i0k/ri8WEEY0hyNU+NGFWZ2f7Wnx+5mj771oFpcL3kyknNqWRipFkoAksp
         URniuUkO4iff4C550FiykNI1xuhC/JEaiKLDqjP3mvgo1PBOxy0geoxXVNgSr7YA9dQW
         pbKdkD3zvql7fngvH4zlY4IzNgeYIEaHPdLI3eOgXeHkDJ6sf2MmLZuO6S9uHx5bbiWS
         0x1cVx3acb3g3gcPWgayusLPtNWnL0DHbNwRgcQDcvWAdXTNi8/yrOE2LU1j2yIB6du+
         v0Xg==
X-Gm-Message-State: AAQBX9dKI5Ka1DFx+cqWITW1N8KrN7hRufdU3JGgpITy74RhIyDEUG67
	QetO3sjK4JijIlwAf8byvURdN+bel9LQ7+M4XsooiWYG
X-Google-Smtp-Source: AKy350Y26c0ZFIX+Ui4WIwxMcN+v/54rUsZ576Q3y5GGrlitd8+Yd8skxgEtdUlLtbGa91VrL+pj5Q==
X-Received: by 2002:a1c:f30a:0:b0:3ed:3268:5f35 with SMTP id q10-20020a1cf30a000000b003ed32685f35mr952138wmq.18.1681985888244;
        Thu, 20 Apr 2023 03:18:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4d8f:e9b5:dea0:5307? ([2a02:578:8593:1200:4d8f:e9b5:dea0:5307])
        by smtp.gmail.com with ESMTPSA id jb12-20020a05600c54ec00b003f17003e26esm4940332wmb.15.2023.04.20.03.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:18:07 -0700 (PDT)
Message-ID: <8e358d6e-933e-2254-933b-564bf83cb1a8@tessares.net>
Date: Thu, 20 Apr 2023 12:18:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 mptcp-next 1/3] mptcp: introduces more address related
 mibs
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1681481877.git.pabeni@redhat.com>
 <57449d46a6d254446a227aa22597dd0837dfe331.1681481877.git.pabeni@redhat.com>
 <CA+WQbwtkNZTMKsuAwN3oroB5MBkSXwLw3eCoKr5agP15yWgzvA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwtkNZTMKsuAwN3oroB5MBkSXwLw3eCoKr5agP15yWgzvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2023 05:57, Geliang Tang wrote:
> Hi Paolo,
> 
> How about also renaming AddAddr to AddAddrRx, and EchoAdd to
> EchoAddRx, RmAddr to RmAddrRx, RmAddrDrop to RmAddrRxDrop?

I agree that it would be better but I don't think we can change the name.

To me, it looks like we would break the user API: imagine apps/scripts
relying on them, they would need to be adapted depending on the kernel
version, not great.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
