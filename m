Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03207B
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 09:40:09 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 21so9406681edv.1
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=VTmlyrZGmqw5i+QEBLXKjhQz7AVj262QMar+f4rClmo=;
        b=xeSsYtwWacl59rdkK6XqRpOZBNnRn90QQKo/lwak+EF0JsS/odhKHExXUzMVnpH9rb
         3RdAJSsdG80m6j/SaLjR4cuDvHP8cUv3jnEGB4PyUyVf6yGaiwyr7rVIm6o43yy4LGZv
         hPYe4ffs/zIPbuy4wIjCKldGC5eXuQzLP2SSnIVMSyhKZpIAoQHEpTMNNl+NXfI96xlJ
         Kp5cLQWlA5rIjBGi493VuuqeXzJA2/3a6S9f2pJ397sqLk+l4s/JwquFHwM9ZlsvA5Q1
         QekAfXBrnxwN+fcYcVhqhaMm22MOwldIbLTn0lDbEkGfMvRQ8N/ckApuJZy4bbFmhIoH
         G+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=VTmlyrZGmqw5i+QEBLXKjhQz7AVj262QMar+f4rClmo=;
        b=tn21+XX4shX1NvBWPJzea/2b3mVC2BFvjBN0RnIkna2CyypqSrNc3TeB0Y19RhYFTt
         VNGWRQQaQzFy9XXp6Bm0JA7rHjQlW4wi4UlVH7IkhnoS9MA9sc/uTYigYXLaCjqUk/oF
         1wx8xuWWBhULR46I/1XOtufH1r+ICTFV7JkeYjhNUwgdELCU06D5BwMgfU7sdHtH4Kdf
         kiAO6Qgs4X5RjDL3dR1o4KBi27W3uYo7g51QC3Lm9twTPa6AmgD1dKF9BBpauzywzXUR
         nnEF1yGorNAQtH1cJaJHFLG57XhBewyYMJ1QMcVIO2E87apYUGan9UHGFSWa5ERpJRTY
         IABg==
X-Gm-Message-State: AOAM532+FwwP43ItFnih52o695LIMAx3rq0MgEzDnG2bKF/1O6xbsDQ3
	O/7Xoe7ynkc1VAG9DZSnfYJV4g==
X-Google-Smtp-Source: ABdhPJyms1EumO0E683cZBm4delaQAaKiZcaEHAvqWoN83GQIDPDNFw8aPHfYLPNKtFEZGKNl5OTIA==
X-Received: by 2002:a05:6402:514:b0:41d:787f:b99d with SMTP id m20-20020a056402051400b0041d787fb99dmr7238403edv.76.1650015607652;
        Fri, 15 Apr 2022 02:40:07 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8ba4:ab5d:8b2a:caa? ([2a02:578:8593:1200:8ba4:ab5d:8b2a:caa])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2460852edj.0.2022.04.15.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 02:40:07 -0700 (PDT)
Message-ID: <4768830e-35c0-2da2-290e-38177f01ee8e@tessares.net>
Date: Fri, 15 Apr 2022 11:40:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>
References: <20220414211920.1987961-15-kishen.maloor@intel.com>
 <63d24556-9155-ad7a-7054-c2cbe97c500d@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
In-Reply-To: <63d24556-9155-ad7a-7054-c2cbe97c500d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

On 14/04/2022 23:31, MPTCP CI wrote:
> Hi Kishen,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/20220414211920.1987961-15-kishen.maloor@intel.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2169678716

From what I see, the error is:

  error: 'struct mptcp_pm_addr_entry' declared inside parameter list
will not be visible outside of this definition or declaration

And introduced with commit:

  mptcp: handle local addrs announced by userspace PMs

I guess that's because in this patch exports a new function in
protocol.h with 'struct mptcp_pm_addr_entry' in parameter but 'struct
mptcp_pm_addr_entry' only appears in protocol.h 3 commits later.

I hope you don't mind if I move 'struct mptcp_pm_addr_entry' to
protocol.h otherwise the CI will complain if I don't add an exception.

Or was there something else blocking you from doing that to avoid all
these reports from the CI?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
