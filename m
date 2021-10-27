Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B072
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 14:31:42 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id g10so11256258edj.1
        for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MGMgmYgQIPx2BODc81oAkcZsISJemnVWwEKbpE9/Qj0=;
        b=BEZcFieeXriVBFHVixWdiGvSXIYfrsKRck42uIKPeWDL40XwetgZ4JvWBBCPZ9Y1Rg
         2XG06TnLD858zczO0mT4YjVmO8B+n4eaqiSYnr+voy1u2JAKgtuH4PPZxKg7uIm05AP8
         mz9NajZJEOYH8MyYwsFxgp8E7A0Pp8ftGrrPaDFafXsHnsctZL2eb2n86TRoxw2dqg1x
         N+mtK343PNJTLfxKNmA+aUdPaPt/+Kmwi2gk8WrafjfV33CGx4LNYWQfgxkj3YCOsssT
         VlDoG0MhA4nSWppAYdySM7vMZOqpRmiFAKYzMC9KEZyIyvqS8tzPXdJnN/oB04g2FIY4
         5Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MGMgmYgQIPx2BODc81oAkcZsISJemnVWwEKbpE9/Qj0=;
        b=25iZiCzHlv0t2k8GzeuPkxtUKJkGgVn/SCOK+kBd7y0zKCvildkM5BpC9lG1Wb4CSM
         mW/MJ0Uta8pJKZvBgbawbq3PPl6w+/6JivJlt9er2nK0XWPBv9Ds3o8G+3WtjhDm5EW0
         BPUjdwxZWMbBF5IGRnM0hZ5MogRWpD5XwSEgFBTvPPfUpj7xetGPimQxo3zE4JCD+wpE
         xnyJWKTj1qrqBDpzK+k/XAk6lFICW2CUBsNWPbYRv8B/UKh53M3XK6q/Nu31gdstiGNM
         UHbWvCYtCLIwbhOHvj5HtSoLW0jcFMz+G70ubTysbPJEqzN8+ToDzMyBjx/mQyjt77Ks
         vOJA==
X-Gm-Message-State: AOAM53120DLz/6qbMAarnTD6zD4XKWzFgdtHbr34TCk91oNYs9dbyYzM
	RhWKARbZaULH0JIWb5Ch2PyVPPYMmljncg==
X-Google-Smtp-Source: ABdhPJwRSjj/H8Tb95PaOz0GMJdylKbqAPgdXK98kUefpXlDEbr72AzNAMKcPrPjUrhrx0SZ2v6fzA==
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr39857974ejb.558.1635345089720;
        Wed, 27 Oct 2021 07:31:29 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id x22sm120360edv.14.2021.10.27.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 07:31:29 -0700 (PDT)
Message-ID: <3c5ff5d8-187c-e97b-b229-8b721c9ec40a@tessares.net>
Date: Wed, 27 Oct 2021 16:31:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: mptcpd and (default) routes
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Othman, Ossama" <ossama.othman@intel.com>
References: <8db4b664f4fe0e102df6da03e57459c3a8c61677.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8db4b664f4fe0e102df6da03e57459c3a8c61677.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/10/2021 18:49, Paolo Abeni wrote:
> Hello,
> 
> I'm still experimenting with mptcpd. It looks like the current
> 'addr_adv' could be improved.
> 
> Currently it creates endpoints as soon as new non-link-local addresses
> are available in the host, and that in turn causes new subflow creation
> using such IP as source.
> 
> In a client system, usually we have this sequence of events:
> 
> 1) <interface X goes up>
> 2) <dhcp start>
> 3) <interface X get new ip>
> 4) <new [default] route is added to X>
> 
> Just after 3) mptcpd creates the new endpoint and the kernel tries to
> create the new subflows. The kernel can try to create the subflows
> before the route (required to reach the server from the relevant
> interface) is available.
> 
> A possible solution would be let mptcp listen even for route-related NL
> events and let the 'addr_adv' plugin create the endpoint only when
> there is a new address and a default route using such address/the
> underlaying interface.
> 
> There are a couple of downside:
> - the above condition is quite restrictive - e.g. a network specific
> route could be enough, but we can't do a generic check for that. Adding
> a configuration flag to enable the above check should suffice/cover
> this point
> - will be quite invasive for mptcpd
> 
> Are there any other options?

Could it be enough to do a route validation after 3) until 4) is done?

I mean: if I understood your problem correctly, what is important is to
make sure that if you send something from the new IP of one interface,
it will go through this interface. Routes are then certainly OK for
MPTCP's PM to create new subflows using this IP. In other words, we
validate the user has configured routes like:

 $ ip rule add from <IP> table <X>
 $ ip route add default via <NEXT HOP> dev <DEV> table <X>

This check can be done with NL.

> Apropos, I don't see any routing related code in mptcpd, so I guess
> even the out-of-tree kernel could be subject to some similar
> race/critical scenario?!?

It would make sense if it is.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
