Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506F2F83
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:02:52 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id y3so21306351eds.5
        for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BhaOLF1Wv+X0XbcNhTwgzbvTafL6JOpg0OaUPKim7aY=;
        b=k+aKgA9vYONVIrjJDcw3KXccfP2FQVucXT8/87k2aKcBVjZTIvjgwqvKFPj3VcUhUY
         ltRRjgwPzHHANNzvx62iOxABo83nJsf5OgF9jrn0JfeLIXmHMgjepimucQ6grSUjvtV8
         idTXlezTXCXgokYdYw2DMiwfiIJYtH3r9DsJCHeLXdtl16/Vpo8D6h4evwQfEtUM37aM
         yNLVGTk7aZtGAfQneFBEb7iZdaOufeYFeZpFEnTf/Q2ulTaqWtnsKWtjNgO9H5VpZ3PA
         DEkHjqmNOh051nXHI8dvexLDtuenRtN1mRcpvC9mkReuXIzv1I/xxEEEGVnmwP5hgXsD
         +Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhaOLF1Wv+X0XbcNhTwgzbvTafL6JOpg0OaUPKim7aY=;
        b=WxcA0308u7xcYCQVYeOZ4KHEhmJl1QeeO6e6oROcrbkMTjiXKZ14FAJ/9UfauEHLoo
         UaFt2mlf3ti5eET5r7owF+KdHriOeY/h3kfwh+P3SqUv/rGW90cklbt3fWSGCIJaFeqN
         YgFwYPCGxPOxb74iSeUAamtwKtit0g88GMQZddhvnUzFpM/zHw6pyXTXdXwyTL5X2WvT
         mgnDh1XCFj4UN57LpyqCxFiwVwTEAo23DDB1IxOX7dMOg63jWJDqqjRZoQ9kWHdeJLX2
         BzWvocqKZupP8bnjaEyii/veNZsq6fveqE9IDv2zgi8/LPDeB46UFZa33KGobSjlQoXq
         tPzw==
X-Gm-Message-State: AOAM5308FUff88CitKx2wwgkhHzz9YbNHVifd4OoeHPGP59ifdqSbOp9
	H0shNTnR7Q2fZ7kha5d980gj8/AO+Z68wQ==
X-Google-Smtp-Source: ABdhPJytChR2x7O/JOu2k19+sjJkR8zrMvWny0wXzv5khgFmEeOFSf37HdYgL/0wl4s+ABYL+S8K7A==
X-Received: by 2002:a05:6402:57:: with SMTP id f23mr4591626edu.323.1619186571426;
        Fri, 23 Apr 2021 07:02:51 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:d068:c16e:598a:1275])
        by smtp.gmail.com with ESMTPSA id e11sm3967477ejl.115.2021.04.23.07.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:02:51 -0700 (PDT)
Subject: Re: [PATCH] mptcp: create listening socket only if signal flag is set
 on
To: Jianguo Wu <wujianguo106@163.com>, Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
 <CA+WQbwvpviu3FAE06bO3CO2azAegzMi8YUXcQPPMBYM8nW7_cg@mail.gmail.com>
 <1b50d699-45ec-e747-983a-1966f64f8e1c@163.com>
 <CA+WQbwvzabuhsbKKHeWwa3raOfCh270sccdg6=18ytgPjjkaVw@mail.gmail.com>
 <CA+WQbwuSDvyJH+MT00Qvi73MhGoWcrg-AkZfPR56Zfaks2s1uQ@mail.gmail.com>
 <681e0810-fbbc-daaf-054a-0e83038b4d12@163.com>
 <3c3cf25d-aa4c-d522-102b-ebdd3b767cc0@tessares.net>
 <4b4f4935-138d-a6fc-dfdc-3ef059a33c3e@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <f222b5b1-a2a9-5d10-ef22-5db67940daa3@tessares.net>
Date: Fri, 23 Apr 2021 16:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4b4f4935-138d-a6fc-dfdc-3ef059a33c3e@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jianguo,

On 23/04/2021 10:38, Jianguo Wu wrote:
> On 2021/4/23 16:21, Matthieu Baerts wrote:
>> On 23/04/2021 09:41, Jianguo Wu wrote:
>>> I think this is better, we can't assume that all user-space tools works correctly.
>>
>> I was thinking a bit about that. With the proposed modifications, it
>> means that a server will have to send an ADD_ADDR if it wants to accept
>> subflows on another port. I guess there will be use-cases where we will
>> not want to send ADD_ADDR because we are in a controlled environment or
>> we don't want to announce a public ADD_ADDR+port on a specific network.
>>
> 
> Hi Matt, do you mean there will be use-cases where using ADD_ADDR+port as local address to initiate
> a outgoing subflow join, but not send ADD_ADDR?

That would definitively not be a common use-case but we will see if some
people are interested by that.

Anyhow, I think it is better to start by well covering requested
use-cases and avoid "strange" behaviours, e.g. not announcing the
address but doing bind.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
