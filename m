Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883982F80
	for <mptcp@lists.linux.dev>; Sat, 11 Sep 2021 05:56:45 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id h9so8719932ejs.4
        for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zSBMnT4Nj8oe5zsUdQBWt4MVT9lqEAEw6jIdSDOUhHM=;
        b=1MTpqtnkvu6dxv5Y02a94+JG9Yx/V1Al/mz+ySufMJa7G/LHZilyVMj4CQaieZSd57
         K2nyEQRPZ1sopUEdRybsODFUxPOYdYmtzpVC9KIPxq4LW8zeGGyUSRWUyNKAjYGQwWgx
         SSZ1j+YOfbcMtA3C2WW/3Gw3Ton/W2lt4lSUzuUNeDZF/1Sl06SfAAbkD/DIp7raWiaz
         RwWswWLtqQYBkcWmltQnRSpJ967Z6gAjZQiJntR1wAY33BH/c5rEB+SmGwAzbr5rh1kS
         /DdfnfCKalySgxk6+jEjGK+9RATzzMqGBHhz4bRCYK7GFHFb35TGzv1BGOJi3gnYGJgD
         NatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSBMnT4Nj8oe5zsUdQBWt4MVT9lqEAEw6jIdSDOUhHM=;
        b=4vAGX2n/JPBFiLGzLL86zbRJKw2L5570fRwnt534/O2n/nbVEZpAYLfSg3CTwI+DUc
         lRb6MiADWNnrf4PyilZRGfCVygOoc5lq8qZA5wxlPlY/kNPWwYKdLulbW3iOqAESdrKS
         XZpGIjOY7pw/RwIK5aqOKMb3j2SSWJxXePfz3CJGCrPk8erhZncqnSbnvXi0EauqfXPP
         xHtxBH5deVu9HP0MM89M+qId/c2bmAQW0ljPPOwc2zlE+igTb4pvvO0Al5BDN5BXGr5L
         4HOxK5+gLr23l+lPntJRfU7asw7abgoAED1ApL2lA0Dt4mWB97xihoqufYmQCp0858Ws
         yeQg==
X-Gm-Message-State: AOAM533RFaWnbn1zChhvZ9XSCjtYGT0BRWy8HjAVweArMdrxGkkEIW5H
	O6qeoqE0/S4DhylqnYANBNm0qy6j35Tr6Ab8
X-Google-Smtp-Source: ABdhPJxLJu9Q2YWXm7gPs7w5K/cH1nImP4TptixWrF9HhX+bTxt0KYcFhpHi1KRXkSmo2u/+84dHRQ==
X-Received: by 2002:a17:906:2acc:: with SMTP id m12mr1331731eje.231.1631339803488;
        Fri, 10 Sep 2021 22:56:43 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.201.dyn.edpnet.net. [94.105.103.201])
        by smtp.gmail.com with ESMTPSA id hz15sm300038ejc.119.2021.09.10.22.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 22:56:43 -0700 (PDT)
Subject: Re: [mptcp-next 0/2] Fix mptcp connection hangs after link failover
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20210906131045.18513-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <d0644d80-b9c5-ad76-c588-1e09297bc173@tessares.net>
Date: Sat, 11 Sep 2021 07:56:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210906131045.18513-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Florian, Paolo, Mat,

On 06/09/2021 15:10, Florian Westphal wrote:
> First patch is preparation work: tx_pending_data counter is unreliable.
> Second patch fixes premature stop of the retransmit timer.
> 
> Florian Westphal (2):
>   mptcp: remove tx_pending_data
>   mptcp: re-set push-pending bit on retransmit failure

Thank you for the patches, reviews and testing!

It is now in our tree (net-next features) with Paolo's Ack and Mat's RvB
tag:

- 4c18199dfdd0: mptcp: remove tx_pending_data
- 7fdafa1b84f9: mptcp: re-arm retransmit timer if data is pending
- Results: 84da6403b775..fecd1f9bf19f

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210911T055615
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210911T055615

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
