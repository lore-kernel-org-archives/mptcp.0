Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BC23A5
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 09:10:28 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id p26so8063530wmc.4
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 01:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+tteiROWbHoKeTcbOH2kJE1FTzFWXotRNbqUrx/UCU=;
        b=jMxn/ZYgVeZe/U5modcSpflEAw7x+bfRrHKR3W41ofWnTAsWKFgC6EHj9e4gj9AN8v
         DWWT2YV0/4T569yCyE5ClOQNxEtpkxJU/gLOuGUmUkJUhXb+lYgd9F+7ZwITpdr72Z+c
         82eu0fYWj9VNAlAG12GI7gnzspraia4C7mrqXEl9VUAoaoNpZ7J0QPQiM4K3q/cPUSZ5
         itCupXbQ/FHDwt+T35SLRbB3bAVs6vFoCrPK8pGedx6PpcKVLAJLbUjCY/s59aF4HuJA
         jb9zdPGQoCe9cbDnGy5yiR1GpK3EteHCaTkJmX4x1Fkk+RRiL5oNoGBgOX6FIvQcoWGw
         YKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+tteiROWbHoKeTcbOH2kJE1FTzFWXotRNbqUrx/UCU=;
        b=J4PmsqnBUf1OXeojlJ2fe43mbTUqVNmwBxOVkZS4acwNOJxhTt5uP0V20y2PswFuwN
         nj8D6+/xBv9LER1Y9H4Y7a03qeFDzuOvYiF27BfvTsfCnEfHggw9muPIynUhp9oVXvEd
         iXat2dC5IOilkZ9zPizQKW66tJIG533zErHi9NOE4n3lTwjpvEIhp6fGpmNKmpy9GzDA
         QJspLu1kC9Jfeg52cwUmLxEFuH6cQ8JRVfg1bbdb9Rq2xQAmXzrTwFvA+CYTQ9E9n9ts
         vtVRIeEJSeIylJ1GaWhMaKHvyr2ul81lsCIbzGEiNF3BvVVVv9ibVF0y8k913yUxq0R4
         NEDQ==
X-Gm-Message-State: AO0yUKWR5mVorsMX+7DAyfNcrgQxafZXMimYOEc+tpsjIus3GtXfkfSh
	+MN8b1ro+/31STKPW33+BZUgATIGmzEen1KhRms=
X-Google-Smtp-Source: AK7set9NMwvft2nWj/TAU0ipXNOmWslYWFXuog4fRecL5MTkP1LzlXdMMPOL4z4jj3jc/BTzBodnZA==
X-Received: by 2002:a05:600c:4495:b0:3df:b5ae:5289 with SMTP id e21-20020a05600c449500b003dfb5ae5289mr8378543wmo.8.1677143426723;
        Thu, 23 Feb 2023 01:10:26 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b003e204fdb160sm5077021wms.3.2023.02.23.01.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:10:26 -0800 (PST)
Message-ID: <db64d10e-3887-fc95-a91c-33408e3670f9@tessares.net>
Date: Thu, 23 Feb 2023 10:10:25 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] mptcp: add ro_after_init for
 tcp{,v6}_prot_override
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this patch!

On 23/02/2023 04:37, Geliang Tang wrote:
> Add __ro_after_init labels for the variables tcp_prot_override and
> tcpv6_prot_override, just like other variables adjacent to them, to
> indicate that they are initialised from the init hoos and no writes

(Do you mean s/hoos/hook/?)

> occur afterwards.

Good catch!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Do you mind if I change the target to mptcp-net and add a Fixes tag when
applying this patch?

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
