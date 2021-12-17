Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68049173
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 16:34:16 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id y13so9814212edd.13
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 08:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6WU9a3Dku50jPjo+MdjBxQsRlWc3CDj8yyRI+sNcoGw=;
        b=mR1zD6a967c13MgnekA8YWFd6XwLqUoGVCSlpjythn1EwsDyeGc1PQyolRVdJMuXK1
         SRbBcOUhlaFE76OmWrrisVsF6MftIyh3TSpZLH/1oAvpXOI5NEcy/FlRk8XYFbQiQfZL
         NhbTd1OAsyrLYSEzdT4vSLzdYOFAhK630zJzd0a0GxjV0xYPWDUErZ3A88IjcRRTe9R0
         /f1o422760YTOb4a7tMBk/YVH+CDhu0FEhPtFog/Ciz/zLymzzBuxrGDyg4lUcT7cBAY
         X2SVTrElHAp03dsqqAeOfa1RdcqzYNVqY8HWu6gfJF8NTsbiSmr5gbLXFtJUWTOZ7Mmn
         +8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6WU9a3Dku50jPjo+MdjBxQsRlWc3CDj8yyRI+sNcoGw=;
        b=VOzZCV57tvZEaC4YK5dF/OgK7EQewydooXHc0FS0pC7ndXWo/RD6NPr/ndVkctevaY
         hB7CFzn1bIV8w8fs8ZslRCh5osm+7VncysMXcug9Xl2GCVnetEkwUPo5s4OR9VHcXBRH
         D5+4ouTuH8p3PzSXhHqCyNF/Die0Z48YBgexxkROp66pAS2Elma88AGBaazXHnTVjByS
         QzgGSZthzlUrROunRqn57UCfpZo7p8JClGwW+kHz/RXyyzRa7Bm+LMN0WlbgdZ6ES3vN
         ZNzljjYlgCZTnM1SUNdBc5DSWYV8PbdMPBljJQMYgCTXX0zzYbWAl3yJAwGUylXAQVF4
         XLmg==
X-Gm-Message-State: AOAM531wLqa/sgMC9+/pnpAdMU+zSSw2ft8QMxMcimvveHjDpzKEDB36
	xJ+ybV5rQ/mOn1AMrqmUiduU1Q==
X-Google-Smtp-Source: ABdhPJzpxDySeLO/zr8GesieqgSxpYNrHIYetP1fo+PBfVogEjK/xw6bjUpr4gui4uMIAOUROaq2uA==
X-Received: by 2002:a05:6402:4243:: with SMTP id g3mr3653234edb.49.1639758854695;
        Fri, 17 Dec 2021 08:34:14 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id r3sm3008255ejr.79.2021.12.17.08.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:34:14 -0800 (PST)
Message-ID: <7be3ba91-232d-1357-dcb7-b55b01d46f3f@tessares.net>
Date: Fri, 17 Dec 2021 17:34:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-9-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211216222314.1244708-9-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

On 16/12/2021 23:23, Kishen Maloor wrote:
> When ADD_ADDR announcements use the port associated with an
> active subflow, this change ensures that a listening socket is
> bound to the announced address and port for subsequently
> receiving MP_JOINs from the remote end. In case there's
> a recorded lsk bound to that address+port, it is reused.
> But if a listening socket for this address is already held by the
> application then no further action is taken.

Do you think we should add an option not to do that?

Or maybe we can see that later. I don't know if there are use-cases
where you would like to restrict the MPJ to the same restriction applied
to the first one.

Also, I guess we can add:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203

Thanks for looking at that, I think it will be useful, especially for
apps that are used with mptcpize.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
