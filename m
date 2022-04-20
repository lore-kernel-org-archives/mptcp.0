Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD101867
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 16:40:04 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id y20so4698881eju.7
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=REoJQXaR4ZPCfJjNlzUk3Y2yHafWckIDgtbtMpmxDWI=;
        b=uY+If7PrDHa4Z1xtaZSAFzBAlOKHi5s/wVQcIlySYdioNhZCh/FyMHdNOCwmTqvQYC
         jV8uKIZY+cM0MfOfbQB3BIZWWMEHSIYASCkMg9PpY5DuI6hjvAkDSqsT4t9wdXLU6ljZ
         mEESN2pKwQ0SMYZW3pLOf3TEf0HcsRmGwqbNEGdjCAd+9PGh5js0okxoSLzP6DqOnT7o
         A1aeSP75DEk96gisNPhF8brhT01ZSlwD5YVUI6xzjrSzful63lAqHrjbIpWYwNd1FMgg
         /wZJjnbEYjklVCD/QgYEGxUo/9V7/1G5MHk94zr2D28htDKnDCJ+Jok/hfR0YirIq7xg
         s4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=REoJQXaR4ZPCfJjNlzUk3Y2yHafWckIDgtbtMpmxDWI=;
        b=MAIDUqAeBHDrMtIMB47A2ql1vif6RIo2k1/hoZh6sbVDD5cw6Fe6qGCvZxN3sGl7Qg
         Z2JmmILjcVhBLL8Q1nimQ2wotF/Qd0iFTwQ+kAO+RPGuRHFYtTuO5qymTEQBkywUmgrv
         objFnkGPLBifbepGL6Y8jtTqto6Cnvh3XEuPIDLiZD3Eqp2UhiQUHwPcxAVGEp7Ba449
         GKv1AhdmwkLzWx+BDZknFzJlguek3LIh11XG5FEheYssRCaolAU1kJWkvn8kQKsAkSh6
         BZT1fAUgkUvN6IwtrGXhGy8J0Ur66uFy8EUM7dx/fJBRiP7f5RLSBjPYPPv+RKhnqOau
         k7Wg==
X-Gm-Message-State: AOAM533LW6mAASB9Jw5nW3AP+aHsavZIM5AO9K0EidEOQkwD9AoPMlAP
	rwepFe3bWxiw4MROPWMGBhJ06WyPYIRXOw==
X-Google-Smtp-Source: ABdhPJw8mxvhep/CRnkQk6UYQA/tEOPaBVJvo2DHEQ3SV6K0OHnCNFlhKeSlPHQZ2LTfboUVl0+McA==
X-Received: by 2002:a17:907:7b84:b0:6e8:b8c2:6fe2 with SMTP id ne4-20020a1709077b8400b006e8b8c26fe2mr20058922ejc.401.1650472802985;
        Wed, 20 Apr 2022 09:40:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a8ef:af16:f14e:5d01? ([2a02:578:8593:1200:a8ef:af16:f14e:5d01])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm6865482ejc.197.2022.04.20.09.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:40:01 -0700 (PDT)
Message-ID: <dd161bcd-2107-ed55-34cf-ce8d7936467b@tessares.net>
Date: Wed, 20 Apr 2022 18:40:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v12 08/10] mptcp: add call_me_again flag
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1650430388.git.geliang.tang@suse.com>
 <68fa62e5d0ba5fe88f89f6be7923eb952fe3b817.1650430389.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <68fa62e5d0ba5fe88f89f6be7923eb952fe3b817.1650430389.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2022 06:57, Geliang Tang wrote:
> For supporting a "redundant" packet scheduler in the future, this patch
> adds a flag named call_me_again to indicate that get_subflow() function
> needs to be called again.

If I'm not mistaken, in mptcp.org, there are two functions that can be
modified by a packets scheduler:

  - get_subflow(): return an ssk to where an skb passed in argument will
be sent. A boolean is also passed to inform if it is a zero window test

  - next_segment(): return the next skb to be sent. A parameter called
"reinject" can be set to 3 values: from reinject queue (1), from sent
queue (0), meta-level retransmission for optimisations purposes (-1).

In short, a redundant scheduler will then make sure the same skb is
returned multiple times in next_segment(). (After the first time,
'reinject' is set to -1.)

I understand it is quite different from what we currently have here in
upstream where we don't really have a "next_segment()" that can be
modified by the different schedulers. Having this 'call_me_again'
variable should do the job and it is quite "flexible". At least more
than setting a function parameter. But I don't know if it is a proper
way and if it will fix all situations. I didn't follow the development
on all different packet schedulers in mptcp.org. Maybe we can check with
Christoph if we need to "fix an API".

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
