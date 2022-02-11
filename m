Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19E2F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 11:12:20 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a8so22137566ejc.8
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HvHjww7oyhuqo/ckAI3elottH8/FkgdgQSbPu9bamBQ=;
        b=cGqQbkDEJ4ivC61DPimRumbiSrIo6XGKx8+ETtNhxjIXsQ8q8IEbXy+QGa68f5w5ng
         dz/jOkwbaX7k4O6D2Vtu2cr5EVKTpWtUvMnX3Oizze3USxm1CB9r67vqVE8wP0g+OTyR
         IbIyI1vbvMtsk13i0i3sOlRqjiEQIuh4P5+kZYrN9IdjjYvfF7cywweXWzvKf/T8vv6e
         J0qc7JM37545BNG+ukXB07OhZQCaboa8l8+pHBZAkW7n9vS/1d/Btcypmu8+Ml53WNcQ
         jcndOBpQ9OpAJ6KNuAwB81jVZ/Rcx0Tb1o/zMA3VtYig5EELslRU/wyX9jXruUvzNJnR
         Zs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvHjww7oyhuqo/ckAI3elottH8/FkgdgQSbPu9bamBQ=;
        b=QqjfFMV5Jtygzu3NODz1c8INfWlhHbUCW9B5tQN1WFgI/S3mx9QoBl0XrkKz11Q6mD
         MFLjTtFG5RdiJSTXbrcfKG2XoZI1N1Uf+lyCJgej4KXLgvAnXf07lbhM/54iI1eSNnu0
         2BGwZcgVnx/2EDUVEZK2hRzxOR7hS11TktxRHYVCwX3Xm6NI+r5vSvyiL+E5wfGaQTRY
         f4chEmwByHmSPoMfhOlsaaeCDPZ8qImAwZMNAfqL8faNnlKZE627C2lgGDCAYfMXOae6
         FACUj8dL7gsv5sM2zCbpSd3GaXjjdtC8d0CDmQSX8trCbruvD78rF7CJb1hqkBroBpAd
         Rr1Q==
X-Gm-Message-State: AOAM533JiwPdJqmupTBctG5UCJb48tKsCv+34evs7b6dCAuvCXjstvUA
	+cHDEPMkfERSKBbJsxA6WPsct7s0l4y0cg==
X-Google-Smtp-Source: ABdhPJz/hBI8PdSHWuTMhh+0pOoruYU5wWnXhE0T9W6cdWlHQg8DLKmIMInXHdhOzbJ2eRfVtxz6dA==
X-Received: by 2002:a17:907:60cb:: with SMTP id hv11mr936688ejc.122.1644577938603;
        Fri, 11 Feb 2022 03:12:18 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fea5:b1fd:66cc:fe97? ([2a02:578:8593:1200:fea5:b1fd:66cc:fe97])
        by smtp.gmail.com with ESMTPSA id f23sm3480480ejl.36.2022.02.11.03.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:12:18 -0800 (PST)
Message-ID: <422ec600-3bc4-9f38-d2b1-060311ec3c40@tessares.net>
Date: Fri, 11 Feb 2022 12:12:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20220210152949.19572-1-fw@strlen.de>
 <20220210152949.19572-4-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220210152949.19572-4-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian

On 10/02/2022 16:29, Florian Westphal wrote:
> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
> 
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.

Thank you for working on that!

> RFC 8664 says:

Very minor nit: s/8664/8684/

Cheers
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
