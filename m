Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4751A601
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 17:07:35 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id v1so3173301wrt.11
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1E1MxV4I5WpxWFQ3kHcqZaocXG7RWKvhLtXqJcn9wQ=;
        b=XrrUK42p9FelZtaPAS7tNjNmH2HyJvqiTlV/ZPvNN8nz+s9UnSxyuB/lAmhmBkzP+e
         OEIzjvbN3UoGGeayz9lMj50Cyq1+c8HTApXEPo0j2NwoBarPv98ja9mnO8XRJ2zVMcFg
         ccoOIbOYa9cJtEh++hixIy2a/FEuoXQrmPGRrlZwsVmKSKvreMirj0pdZNcsXr4pbZdE
         J8QqV21wWQDGcN1gvf+gylL5e8XfPBL4ysG1HJc6K5mwE0wjGk2GaF3oZPOWwjlPNLmL
         OpmAQ2pyyUD+bB/SLbZgbqERihb7HXZttTMUfNcruvBdxNa6qhX1jX8ydRuiw4otrIOm
         d/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1E1MxV4I5WpxWFQ3kHcqZaocXG7RWKvhLtXqJcn9wQ=;
        b=8OVOywzK57gSwBQdA9Njmbef/gEbmTlrUFCaV90e5whUO+7zZ4e1HJXB3xQiRaQy6I
         Diw3ZtK+CCou+TuGu8yn1d28wopshAmrO0+gSf1MqGQmmZcmiRLeKedHHEGMjL1lV/df
         /Rf46eKXfYp0aJDmw+Yn1YYpN43bivLBVOfXHvEWiEk3VApYZF5CobOCo0gnnGtVobgN
         Q9VZW0jOBO3awtE4RwRevbx6Cu+9QTNtK26vEYUJ7JfwCvznB8c34/Z0IIpTFz4xHOL4
         V9MKyo1jLqr7qVs1rZiTLRdykhgREMqU89J+KSEE93SBiNUux3PJ/0Wowr9gEorJ1EpN
         oCtA==
X-Gm-Message-State: ACrzQf0zbsTg3/QihLBg8usHuWZOyCvMA2lvEqkAljUERMBkdK4hDhKX
	pJ4RxUyksl+ldpfPpinW/viSyQ==
X-Google-Smtp-Source: AMsMyM6Dzv65CcbWxYvRl3kJA9t3m+s3PtRDMr4A6K4vl8Uipl2KP0jgJKC5W2M+H2owlYuJ9Ll/MA==
X-Received: by 2002:adf:c601:0:b0:230:7cfa:b3fe with SMTP id n1-20020adfc601000000b002307cfab3femr42305674wrg.344.1668100053818;
        Thu, 10 Nov 2022 09:07:33 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:a69e:b302:f965:8831? ([2a02:578:8593:1200:a69e:b302:f965:8831])
        by smtp.gmail.com with ESMTPSA id f63-20020a1c3842000000b003b31c560a0csm157266wma.12.2022.11.10.09.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 09:07:33 -0800 (PST)
Message-ID: <e6f250a5-acef-26d7-5d44-302a10912dd6@tessares.net>
Date: Thu, 10 Nov 2022 18:07:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 1/2] mptcp: deduplicate error paths on endpoint
 creation
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <13fc62c6a047dbd043be5131567c0f3a6c46267e.1667586266.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/11/2022 19:25, Paolo Abeni wrote:
> When endpoint creation fails, we need to free the newly allocated
> entry and eventually destroy the paired mptcp listener socket.
> 
> Consolidate such action in a single point let all the errors path
> reach it.

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 497665201aac: mptcp: deduplicate error paths on endpoint creation
- afc4856d2507: mptcp: more detailed error reporting on endpoint creation
- Results: 9c6870ffc219..d33b3e9215cd (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221110T170554

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
