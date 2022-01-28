Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CF2C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 17:32:06 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso8695768wma.1
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=srT6d7BIGOB96xKngps7eujILKcSPmgG4zdt41+waW0=;
        b=rvjGOWVEsTRsX89NYopMgj8sGjT3y7hLr+l8tQZ6JLzmo/hQcFbw7EjTNTj+s3zU3R
         +BYKdZQ1uA+vTuyBaaFoB9/1GxXFxH3G5aYaNCw3Wvc+lZmukpjvayZBGYeELYITZQub
         Owls4dxuq3wSZz/P4ill++Yo99sa/D9TPd/rWdAnIFJdIJyq9bEYKxnJRGE/wxnlO4Il
         qiJ5JaRd5USaZq9HJGMFXCpYL6xvlXbVwcAhWweuzQ2014/6M3DGsxTl3UBgps3fZ6OU
         E9roSgZ+um/LaKlz1nwz1CBmxzWqVwAvMQb7JI79PI7LpNG8SaLC9qbyOQ89PlhxcYRm
         CF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=srT6d7BIGOB96xKngps7eujILKcSPmgG4zdt41+waW0=;
        b=EQich5XmWYnbCZoWBVzTLU4P84EknublzUxVr7Iag3Bw/rtC0TTWGoFAKRYIhse1WI
         9T4brrn41Ot7G6fpzPz0GHD6Uiw7lLReJdhhR3vqg1dEqCmBzyowpMKDjR0VyPPPXhf/
         3eY4bSeXxz7qv2sOh6B9Gyr5gBO5ASwk9dbHCu57v+pELMw4LRcX4afGfSICrlz5Kxbe
         W3S1sUaN1k1mxNDPdtg3EN1JmLgdmUSVBiRAISnyFNXb2An2MJNkY5a+nRr4brMDJNv2
         6vsA7UrS/daUohsOLDvd/97dDMt0q667WLlohPlWJZHZlZVFTXciO67WZ/AL4SRfPycE
         +Fbw==
X-Gm-Message-State: AOAM533M6/iUwQsxyBH6NeOshXEr6Z6yWZJ8JRwx4PfaqiQRIasoUHnA
	TH7lzEIodm0N6BAkGOexLa5Scg==
X-Google-Smtp-Source: ABdhPJyshQTDrsHPv8A9P3iddfOcatlE2VfPi/sCK0GO3r5p7Rnk4D97TuKkUtamSZKjbOtRH0UAOw==
X-Received: by 2002:a7b:cbd2:: with SMTP id n18mr8175246wmi.189.1643391125146;
        Fri, 28 Jan 2022 09:32:05 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 6sm6366594wry.69.2022.01.28.09.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:32:04 -0800 (PST)
Message-ID: <99fde322-a735-863a-5d84-9783c1a210c1@tessares.net>
Date: Fri, 28 Jan 2022 18:32:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next] mptcp: use MPTCP_SUBFLOW_NODATA
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <c360d83acc0aec3cabfc37d84a81b159cb185a68.1643360139.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c360d83acc0aec3cabfc37d84a81b159cb185a68.1643360139.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/01/2022 09:55, Geliang Tang wrote:
> Set subflow->data_avail with the enum value MPTCP_SUBFLOW_NODATA, instead
> of using 0 directly.

Good idea, we always use subflow->data_avail with
MPTCP_SUBFLOW_DATA_AVAIL but not MPTCP_SUBFLOW_NODATA, clearer like that.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Now in our tree (feat. for net-next) with my RvB tag:

- 9de43eb5284c: mptcp: use MPTCP_SUBFLOW_NODATA
- Results: 90d554d19337..1227baa78365

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220128T173045
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
