Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B661E70
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 07:36:42 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id qk33so2306541ejc.12
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zhuYUEY+e4Nby/3NYLPFiLpPSXqaoH419twcVE6j294=;
        b=y3ajjTtmevFl4mEzpaUC+UqZWM/bFUI2w6jhh4khFRIID+4nrB2nQ60RapTNM97+ht
         6P7RM77GbT9UdEufJUQ+DWXekghbu1e4QWpq2Y29eVazBpjO5k7u4ZQFkVNZwvOlOa8L
         KoUPEXHXmsRl89Cd6ygoLjHxcgYyo9GazgveZhwo3Ho7hOLXDw0VArqqp4H+Tz0XAxRP
         26oTzPPrVVHgdriXEzp4jIEUoynk/iq6cBKKSdqsGnE5lLM0YTH+nTz3IykuduoZSagW
         l910VGMPmBPlQjoRfAxhahZ1SrDIPL3folcl46mb7bG+WsORLLXRv4At7Yk1KmZE3Q96
         H6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhuYUEY+e4Nby/3NYLPFiLpPSXqaoH419twcVE6j294=;
        b=qSL3aXc7HPS44Co07JTZSUGAi9RTek3DugnQz+PBZohWv6AdVx2hmOGPj1WDXnUH5F
         88tJwEkGvg3S30bnRJTaCUdmv1G/61/ZIft6QQ+aJjVksA9Q5V/ALYr/D0DTaq0L7k6d
         gRhxdCP55j8CGlJ6aKxHbitcye9/tUiiiStcMCiceM09yZbDswNyJOPfDQfBZDtrAA3T
         eH6SMK+LAXHhWKg2pcrwpABBqNy9J66D6aACkKSdXLatBYN8AaztYXu0BwJjhx/UZTgk
         3jVC4WL0vVqM2/kUcvoDDsUX0qwcVT95Tt65mxXejv4fxEta5/OBTrTAahDwlZeMq2yn
         biOA==
X-Gm-Message-State: AOAM532T9GehtD4JzbD4dqWfvq/g/X+tDaenkBz5gk2HVBPqwGfVIaBa
	/fxPLU2C2nG3XMKOgkk2OBKjFw==
X-Google-Smtp-Source: ABdhPJyHXqW5iXSAq/xtB8F4e3liCDDJPEHQ3a7/MO/8yZRVm4K6auxvK3q0TyxBjCISouq885EMKQ==
X-Received: by 2002:a17:906:dfe5:: with SMTP id lc5mr24174576ejc.20.1628062601077;
        Wed, 04 Aug 2021 00:36:41 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id m17sm400708eji.92.2021.08.04.00.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 00:36:40 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add fullmesh
 testcases"
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20210804072556.664287-1-matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <7655f9a1-df47-cfc8-3281-cd5fbd1e3c1b@tessares.net>
Date: Wed, 4 Aug 2021 09:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210804072556.664287-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello,

On 04/08/2021 09:25, Matthieu Baerts wrote:
> To avoid using the >10 numbers for the fullmesh test cases and comments
> around to make it a bit more clear this is a workaround, we can pass
> 'fullmesh_X' where 'X' is the number of addresses we want to add with
> the 'fullmesh' flag.
> 
> If we detect that the parameter is starting with 'fullmesh_X', we add
> the flag and set the corresponding variable to 'X'. Then we continue
> like before.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     to be squashed in "selftests: mptcp: add fullmesh testcases"

I forgot to mention that we also need to update the corresponding commit
message to remove this line:

  Reuse the above 10 address numbers for the fullmesh test.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
