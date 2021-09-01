Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555E72
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 09:41:35 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id me10so5216626ejb.11
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QNJXitcweH7oQYVKbK2KzSkQd4hQGMiQs1s35KzNSzw=;
        b=csTOZEbUByRfSIZ8JhLwxDnvH8/Pix62gbVgEWeghs1tyi5zkbVcaiRYKFAaI2n7pI
         Y+RbOYUsaXuQZzTKC4VhSCsGqiM7hKrZxRh/nGOqdn3Kt/nzrV4Z4aRpd4IdCAxN4OrW
         BNRWkkKAR3GC0y91EX/Dr8XEOiINRJ19Wn20wVvnIL7gvV4B15DdSHmCDy1cyTF5ngGo
         aA2MJUpNi91LzUJHkY2eb5HNwu60Zquw9rPyk0A8aup42uD7I6p1efto97w80D0t13ly
         1A0Pq87NsSd9qhqTBDSuIS0CUmEVD3JeHL6YWR30NMxsUsA9Sy6gktYR6hKUW0RDzxem
         +rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QNJXitcweH7oQYVKbK2KzSkQd4hQGMiQs1s35KzNSzw=;
        b=B6zz/zIJ9xgcoULAzERMJc77GzqQUgSGoCoz8bwD2718qbcsyXBN8U6empfubXXFMA
         SAVpQ7synYrDSZrMYgzMcjoWC0oo8tx+yCB2HDg1yALF+CpGmbIZzS1CeiLTzztCqHrc
         2TtWXhWegbnO7OIrtZ0IpEXtcVV217EwQG71P+2Ipb+4AdCsd5/PoVf2btfkVFJSPnRH
         gebalsfoofMXxjruKcOvb8ohtdLYD0SlFRxy23KbT0Fl+xaal/wQIqzvNBpndVruNSEx
         NUpw9mtC27X4ELut/wYZ0gKCLxWsCRT2UO834PtHdGnjvI+zkuVDL4KUIXYhEX8k9Qvr
         Sz1A==
X-Gm-Message-State: AOAM531nlGK1ySJjtdY5vDNLuJ7khZ/g5gvTOlzIrsOhEr7YYfr+YB+K
	pV3YP1w1qbwKTt26s8BRh0lioT69N0BqTw==
X-Google-Smtp-Source: ABdhPJz8r74MHa/bNKHk5koHfcuKz27cibnOVLjhmoxJScLpCpDvztCUdpzmSUB8nbSJVPnQrO8AtQ==
X-Received: by 2002:a17:907:2677:: with SMTP id ci23mr35770641ejc.429.1630489293680;
        Wed, 01 Sep 2021 02:41:33 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id r18sm2456254edd.69.2021.09.01.02.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:41:33 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next] mptcp: do not shrink snd_nxt when
 recovering
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20210830111742.23904-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <5fcd8b63-9b6c-41c5-e6af-c1d2c7c9d199@tessares.net>
Date: Wed, 1 Sep 2021 11:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210830111742.23904-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 30/08/2021 13:17, Florian Westphal wrote:
> When recovering after a link failure, snd_nxt should not be set to a
> lower value.  Else, update of snd_nxt is broken because:
> 
>   msk->snd_nxt += ret; (where ret is number of bytes sent)
> 
> assumes that snd_nxt always moves forward.
> After reduction, its possible that snd_nxt update gets out of sync:
> dfrag we just sent might have had a data sequence number even past
> recovery_snd_nxt.
> 
> This change factors the common msk state update to a helper
> and updates snd_nxt based on the current dfrag data sequence number.
> 
> The conditional is required for the recovery phase where we may
> re-transmit old dfrags that are before current snd_nxt.
> 
> After this change, snd_nxt only moves forward and covers all in-sequence
> data that was transmitted.
> 
> recovery_snd_nxt is retained to detect when recovery has completed.
> 
> Fixes: 1e1d9d6f119c5 ("mptcp: handle pending data on closed subflow")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Thank you for the patch and the review!

Now in our tree with Mat's RvB tag:

- cb36f7808f0a: mptcp: do not shrink snd_nxt when recovering
- Results: dc0af50f378d..e1015c28d860

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210901T094059
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210901T094059

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
