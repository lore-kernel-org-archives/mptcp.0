Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BBA20E3
	for <mptcp@lists.linux.dev>; Thu,  5 Oct 2023 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares.net header.i=@tessares.net header.b="bG94rYxB"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tessares.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tessares.net
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso426665866b.0
        for <mptcp@lists.linux.dev>; Thu, 05 Oct 2023 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1696499383; x=1697104183; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPaCDvEeF7faxiQpPSpKWGN+JkJ1Mq/jhRqLWO/fbXw=;
        b=bG94rYxBKtjy15wPP3iNgnqIwRym8CrZHl8nfAmC205kMjLWRANR1atFkgT5IO9ri0
         soNqHbg4nXdCPgL8C7jHvuCWwOWsNhfRGCGL1kNfywYnolP3LtCyah60HiHwFNV9aHu3
         9QBbsHyBDWnT+xXCLZKrY+hZeibCaiNumZEFNG/4wea2F0EfdHX6fbOVyRwF5um4Rizf
         CbOeYbl6zj5O2JmawvzQXh5vSmIXXj2C/VO9L2TE+kwhvJhLfjrrTnIOaeIKeRRHQrdm
         rYh6yAsUGg/XO1j/QbK2DXetKGTk11TD9frQzzz0REEdQuoI2Mg/WNIyuEi6mnFoOtDj
         t+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499383; x=1697104183;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPaCDvEeF7faxiQpPSpKWGN+JkJ1Mq/jhRqLWO/fbXw=;
        b=KUnX6nIqwd89RcdewgQmgeBKyXrkxHE2PbYVh/FDL1c0GpJOVoBxI5xPXwONu2JEJZ
         BOE7cfctkHTHKP8bVcsjWTVKrHIj/055MvFRb9wyppdtN9QEtf3VdQpJzqDOuccwvg5m
         S3PZW1d9MXYYCzs4iIlQQM5dLYmGT8wCocOmeS2d/cIcfXBft3fTRwB7L2xM11zqLFv2
         hguY7unTXHZQzFkQvFoPDr+CdBWJEUClHddCoNV6Z1fQn0friw/GHajMzaC8+EjnO6ad
         9YYAa2akqCfHU18gsC2OicShtr7sIC26lYQ1O/DSNmi+QhMJu/+fK21/pgygwUp/7kT1
         Q7FQ==
X-Gm-Message-State: AOJu0YyCRTTPEJGL4wpkBZted8U6TyWpB6Nezes2yw0hmohGLWI1V4gE
	1faAMVyYnbzyFoqz+MEGQywhBA==
X-Google-Smtp-Source: AGHT+IES8Dvr/dXn0+z+gvfeaCjSADExgRge4y5E9mP12ZLQNM7Rhne6zv6IgK4RH5vl1zsvjARI/g==
X-Received: by 2002:a17:907:96ab:b0:9aa:1dc9:1474 with SMTP id hd43-20020a17090796ab00b009aa1dc91474mr744262ejc.33.1696499383181;
        Thu, 05 Oct 2023 02:49:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:283b:178b:80b:7b6c? ([2a02:578:8593:1200:283b:178b:80b:7b6c])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b0098d2d219649sm892713ejq.174.2023.10.05.02.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 02:49:42 -0700 (PDT)
Message-ID: <1af5cfe3-ce8c-4d96-a616-ad65d0ae28db@tessares.net>
Date: Thu, 5 Oct 2023 11:49:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 15/29] mptcp: userspace pm remove id 0
 address
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <1119bff10cfc3c6b3fe4afc410f7803f27f49f1b.1695631132.git.geliang.tang@suse.com>
 <6c6bff5e-56fb-49f7-af25-d5cb1347bc63@tessares.net>
 <20231005083547.GB23632@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20231005083547.GB23632@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/10/2023 10:35, Geliang Tang wrote:
> On Thu, Sep 28, 2023 at 11:00:55PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 25/09/2023 10:41, Geliang Tang wrote:
>>> This patch adds the ability to send RM_ADDR for local ID 0. Check
>>> whether id 0 address is removed, if not, put id 0 into a removing
>>> list, pass it to mptcp_pm_remove_addr() to remove id 0 address.
>>>
>>> There is no reason not to allow the userspace to remove the initial
>>> address (ID 0). This special case was not taken into account not
>>> letting the userspace to delete all addresses as announced.
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
>>> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>  net/mptcp/pm_userspace.c | 35 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 35 insertions(+)
>>>
>>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>>> index 6b8083650bc1..8d97cf475cac 100644
>>> --- a/net/mptcp/pm_userspace.c
>>> +++ b/net/mptcp/pm_userspace.c
>>> @@ -211,6 +211,38 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>>>  	return err;
>>>  }
>>>  
>>> +static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
>>> +						  struct genl_info *info)
>>> +{
>>> +	struct mptcp_rm_list list = { .nr = 0 };
>>> +	struct mptcp_subflow_context *subflow;
>>> +	struct sock *sk = (struct sock *)msk;
>>> +	bool has_id_0 = false;
>>> +	int err = -EINVAL;
>>> +
>>> +	lock_sock(sk);
>>> +	spin_lock_bh(&msk->pm.lock);
>>
>> Why do you need to lock the 'pm' structure? mptcp_pm_remove_addr() will
>> modify the 'pm' structure but it will also do the lock, no?
> 
> mptcp_pm_remove_addrs will do the lock but mptcp_pm_remove_addr does need
> the locks.

Ah yes, the names are confusing :)

Why not moving the PM lock just around mptcp_pm_remove_addr() then?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
