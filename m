Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CC6FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 18:25:15 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id z21so11238821edb.4
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678991114;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9FSrMfiacwweoe6LXKBZZpHtAyBQFF7jYeNLzIW2cA=;
        b=H1zofDzIpbjeR2GD8rN5So1y+6vH5Nv9P5RQI0W1XExP/nk928ZdrwR3XS0Rmc87zp
         pVOsmK3wDLq3/lYdPLCuUpoiMgNmTXLT4yt9dl9/2zkRaM0OUSghf7qm40PYwpQSqQCt
         XPi5aLO4/MNXR4xK3Yrx1i36sSu+5bJilUrdOC4r1dqzZe6gHI5TuNed6pOcE2dupB3+
         xnNW5Tmy6PMYRlwEy08gtd/X13tfWUri+j3tcMChVMIuXrOl+GIcR92Gj1dJo55P8hv0
         x1eqy4a+iNZSRMwYaUWN9044zDR9zGtVCq9rAs2Hb8NKHEEWhhlWXW/lUfAYTXZE7woM
         hGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991114;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9FSrMfiacwweoe6LXKBZZpHtAyBQFF7jYeNLzIW2cA=;
        b=Lz3pFQJwBYdBTqYB1siDN/o/JiSPLXC5+WfGGIVcrp6QoljK9i2PGqx9nZy66PC6Wy
         r+GCJQJ0+xctoLarhOUfrlPw9u/hi8BmxwcYxEVlO1J4984BIpZ91E7dlcLH2CkG61d5
         EP6YFuC/jUmsSeEvetoXoV+G8gSjIRA4OjAYRGZQX5L5jYwRDohac2iEa2+iXw3tSJBn
         QwnB03bH94F4wU55MwTTFTMW5I/8Q/aVIJ7Sz4q2/eHzCYnompgJde/42OchIEL64jXR
         XN+CxsTTomsm4J5008BTTB5bIEOt0MrIui9+JWIyjN+JncpdZuIAtSBBCy22/1vNvbx6
         Ag5A==
X-Gm-Message-State: AO0yUKV8AP1FrIPnVTwtAm5kc2iY69AQssVVVxrH8lLvaNfVULhOfOsB
	HbZettfpCp7ENhal7LvojgRQ+wU7Y2Yomw0TOagKoSLQ
X-Google-Smtp-Source: AK7set/n8YIVt/R73jBvfh6hMAi5aU+zFwEIOXHyqv4whUneryAVqoAGdrLgI01inpyl7Ikq0DiWMA==
X-Received: by 2002:a17:907:20c1:b0:930:604d:5891 with SMTP id qq1-20020a17090720c100b00930604d5891mr3294538ejb.37.1678991113797;
        Thu, 16 Mar 2023 11:25:13 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id o15-20020a170906600f00b0092b5384d6desm4114030ejj.153.2023.03.16.11.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:25:13 -0700 (PDT)
Message-ID: <baa5ca02-6f86-b473-763b-1b3a8e185688@tessares.net>
Date: Thu, 16 Mar 2023 19:25:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v5 2/7] mptcp: add addr into userspace pm list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <7f59cf86d68c27fb9785d4a8d84cbf9ae1437d3d.1678778977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7f59cf86d68c27fb9785d4a8d84cbf9ae1437d3d.1678778977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/03/2023 08:31, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created.

Do you mind explaining (in the commit message or here if that's the only
modification needed) why it is needed? It is difficult to find the
reason when only looking at this patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
