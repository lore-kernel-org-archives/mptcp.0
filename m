Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815921102
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:42:36 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id z97so8456030ede.8
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zZGeTdMOnKafkKav5aYL2YjVubyuXU6aMK+rSIzui+0=;
        b=tcIIRG5aOL7LJkMqGgPpEjNlP/y+iB+pacF4/jTkGn5aTGJQkXl/BDk1RcRzNAs/qh
         GzHbmjzYzua8YOrppQ+iWj0FN/aWjitkCVsFGqemgO2Jzm+p3dPmGmBFtwyy5gVqYx+3
         5lzcnCwZwqVs0uIWBB1Y3wG/d+Ut9cKfmdaS1VJ8pymDg9ziSzQ0KrnioASSYFInkM4Z
         f2pCU3sm+3aTRkuiRf1WC3EjaX8qu8Ow6cnUJHpYh4uJmZFeZgLZwR4OyYy6SQymFsBt
         O/SrAQTyv+2FyeXis398MIEeu+9kw7TJ3Giq+b0v3OpMmmiT3QSbbKTdPc0HMqS53Pr9
         CtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zZGeTdMOnKafkKav5aYL2YjVubyuXU6aMK+rSIzui+0=;
        b=SuncTWjtXAAc3ghlejrnJXjfZeXlwrNnUoKISzhUK6wrD7pXTkZMDg444kkctWMpo0
         QPD9of3UH6NlRegRFENfWZYsDqZERuvZDM+SbasOR7MJBqWlkmIQtkhco3BjR0bPrtyc
         fZsX31xT8uplqBzIHWFxvxQCrxZdkjU73uBIut7O7KdW818TN4UcYIVZgdWaiSN2KsWo
         wEjA5McprkQ6ynz8NAMTOPtbEXm4dm0AYw06c2yFLBX9S/mj/4dA+Vl/G5ma/Aqf7xHH
         TPN3YTKuYPqFNZ/ZhWo5+dG/yuwEzhDmqm1QmTFgRZl356UDLFE4I4l0DihTX0rhBcpx
         +7pw==
X-Gm-Message-State: ACrzQf1AdwhRTp0kDXV7z4Z3xxscqgQjotM0IZ2AKgT50CzHg8Lkfc2G
	SiY2A0H6DgG5LYyzn1xF4Ndjzg==
X-Google-Smtp-Source: AMsMyM72cC3JJ99thC93NzLGCFjJLUw+KfTzHxqNkuDu+nFgnd3wxjX+jEplnRF3IWJ22mOo6a3H/w==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr24588881edb.102.1663764154549;
        Wed, 21 Sep 2022 05:42:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e650:9a94:d180:442c? ([2a02:578:8593:1200:e650:9a94:d180:442c])
        by smtp.gmail.com with ESMTPSA id k22-20020a50ce56000000b0044e9a3690e0sm1780665edj.9.2022.09.21.05.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 05:42:33 -0700 (PDT)
Message-ID: <1f5efd69-3507-1086-1499-c2014c75c673@tessares.net>
Date: Wed, 21 Sep 2022 14:42:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20220921120442.320727-1-imagedong@tencent.com>
 <20220921120442.320727-3-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220921120442.320727-3-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong,

On 21/09/2022 14:04, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> Therefore, we can get the count of used mptcp socket from
> /proc/net/protocols:

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c0b5b4628f65..675de024de10 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -116,6 +116,7 @@
>  #define MPTCP_WORK_EOF		3
>  #define MPTCP_FALLBACK_DONE	4
>  #define MPTCP_WORK_CLOSE_SUBFLOW 5
> +#define MPTCP_DESTROIED		6

I'm only reacting here about the name (I didn't check the rest in
details) but do you mind using MPTCP_DESTROYED with a Y instead of I please
When it is written using capital letters, it is better to avoid such
typos :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
