Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEF71
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 09:31:12 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id w3so67809086ejc.4
        for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hijwQmTzdc1za8S1JlfLT78F8uouu1TRIZOW25ZUHDY=;
        b=RQjlsaUmcEGqNhYrluNp88BPj9VP8Y9R+3Vplam42KLLLxhLrI7BUQtFbiuDYJQ8FB
         5j0TevrRkTOTjZBs+XQlYJv6J6bzcRixy0mgHux+pDYuujdwBuY/te6rvRyfZsq4Z5Z5
         JJtmI4h5Rc/KFtMxM1yS/cjVD20e29zjH646Kp4LjbHD3Tgr/UqkVT+o1h8Rq6sst8l/
         dWusOLfeTvcqtvsCUDi2Q4A9asgm4Yt/7sGQce/mRuV1/OeGFIDQJGGWJEFhqTQS2zql
         jk4xWhIHYpfBY6PO2fyG3XsI14nGiPkJaHeRRZl+bCimMZjtowOEGgPz5nPdc0LATYuq
         kNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hijwQmTzdc1za8S1JlfLT78F8uouu1TRIZOW25ZUHDY=;
        b=qIgZx+sQlwW2Vf8FpcLKjt/z0zy0qrcKhY0aAqnS6Usrp1FTDgVlcNpQZ/hL1fuTNP
         HVFhF+8Y10nXXfdCvXJOB/BLaM+1qcSlexizFzpdsslTbKtMZxeuUDA7NJFXSrAlS8D/
         XRJC1ziBsR6It0HT2M/KHRakvv3r9i76u4RNF0I/FOL+fc+zHWxx87f4YLCUnN+HpPKk
         j96WRk01jxg52e2oJp+wJeJt5vsq9Lfw80HpLAH/SrkvnzVmLg4FvuF9EbSmAq3iCEcV
         qmOGsNYt+Y+FQDzp8xcGcl591it5re2ycEtJAtFpB67XhcGzobdyiaFHMJv23Y3D4ss2
         RuHg==
X-Gm-Message-State: AOAM533t8o9QfMbTTf8/JnTvl5+GVi/pu02MiIdhlJZwIxspgrLtLv1E
	0f6YXgQn/R/pcaVE9LdF/MlW4VaefLiTYHyK
X-Google-Smtp-Source: ABdhPJxgSF6zUqv7ShbCL8S4Q+4gQJk7XaIqPpka6X9H/7tY1L1MdBNmvncZww/4g16OEO6x8ryDBg==
X-Received: by 2002:a17:906:a103:: with SMTP id t3mr2450396ejy.334.1619083871414;
        Thu, 22 Apr 2021 02:31:11 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:12ce:5892:37b1:5a39])
        by smtp.gmail.com with ESMTPSA id w13sm1567624edc.81.2021.04.22.02.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:31:11 -0700 (PDT)
Subject: Re: [PATCH] mptcp: remove redundant couters reset in pm_nl_init_net()
To: Jianguo Wu <wujianguo106@163.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <1fc15c8b-ba1c-a1d9-d204-8087d93b73e3@163.com>
 <ee6e9dfea82040c3ae0dfec28bde6dfa5e5c72a5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <34674124-e9f2-9466-4b8d-6238ef761802@tessares.net>
Date: Thu, 22 Apr 2021 11:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ee6e9dfea82040c3ae0dfec28bde6dfa5e5c72a5.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jianguo,

Thank you for the patch!

On 22/04/2021 11:20, Paolo Abeni wrote:
> On Thu, 2021-04-22 at 15:03 +0800, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> Memory of struct pm_nl_pernet{} is allocated by kzalloc()
>> in setup_net()->ops_init(), so it's no need to reset counters
>> in pm_nl_init_net().
>>
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>>  net/mptcp/pm_netlink.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 6ba0408..99bb9be 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1913,7 +1913,6 @@ static int __net_init pm_nl_init_net(struct net *net)
>>  	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
>>
>>  	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
>> -	__reset_counters(pernet);
>>  	pernet->next_id = 1;
>>  	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
>>  	spin_lock_init(&pernet->lock);
> 
> LGTM.
> 
> I guess we could drop also bitmap_zero() and add a comment that all
> fields are already initialized to 0 at allocation time.

If you don't mind, please send a v2 including these two other modifications

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
