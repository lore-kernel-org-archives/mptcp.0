Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3F86FA1
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 18:13:34 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id k16so14420433wms.2
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 10:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udcgsmiKKtBplWFS5NbBQYJ1zNwKdVphhSpvjq5m1d8=;
        b=mRmfT+dn9dqtE+b0ly9zvEOCdlr3WqFT1F/JGrfAiMoVcbUWEfeIxC0nnfW/YVyo03
         oOzWZg+UsrN5g9Ts1+iB7SdqrYhfNo60bsM8FyYscJ1hV3wEOf+OWMYc02Zsl9a940lp
         LwwBhObYslfLY9SXImVyTV/IxP07BbrMr9SVYVT6GmGb5EcJJuM4m5hZ8mUwAg6pWVra
         I4gVnde2sPMU1YCZ9i/aJXkmaK/URCR7ANPP5Yzmd/usso5NxRZim7K+7s1jOSOYSAkU
         8pPKJD0JqjXXBY9pztFcnl0vvlTyZZeklwP0NzUfDJ0C5Dj5wNbuTwWOX833GB5Nrh0J
         UsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udcgsmiKKtBplWFS5NbBQYJ1zNwKdVphhSpvjq5m1d8=;
        b=LnakDWdz3+tRl65yreI2P0RjTPUMUn85rUwUvSi/DOKDj7rLKxxlRBh4L+NWn4Y7Tk
         l9DZ5WDjuDSO/Rr4zVuSMOmHsA2PeKYhARArk4yGcB03w74dgTa0VyqvmgZi9e3WJM1D
         da1HcRa5BNrHqjXFD8kv/SuNP3coFqyIi5JQcngfPSV3joHddmoambPMuOmOnztXjoPt
         pu20waARmjgvP+kJSHNdo7s9fAv58WobySRhZ9vq6uzS5CpdWkGllEV4OqO3PTT5Lo6M
         U9bXfMCNHb7SxrUZ7Zm6UfUaXx/pJTueN89YVeHN54Op9Jof6/mchjMH56rOANwHn8uC
         mflA==
X-Gm-Message-State: AFqh2koRybhcI+7t4Ij+TMbPCt5lwE8sG4vh/2Sq78UaJxsedyZkokD6
	u88gU5/WmLeSPyEXFnHIrKZLY3ZaOsgpBe5Qvz0=
X-Google-Smtp-Source: AMrXdXt5gwUwr2tW2AXyP0WzQP2RTZRonic7+vZlXlPduuBCXxM5xiS87QurhKC8ShlzwptScylnsQ==
X-Received: by 2002:a05:600c:4f83:b0:3db:eab:a600 with SMTP id n3-20020a05600c4f8300b003db0eaba600mr29274153wmq.7.1674670412752;
        Wed, 25 Jan 2023 10:13:32 -0800 (PST)
Received: from [192.168.3.222] (213.211.137.183.static.edpnet.net. [213.211.137.183])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003d237d60318sm2449479wmi.2.2023.01.25.10.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:13:32 -0800 (PST)
Message-ID: <5d756f95-0a7e-fd18-ccf8-4c206b5621d6@tessares.net>
Date: Wed, 25 Jan 2023 19:13:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next v2] mptcp: update userspace pm subflows info
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/01/2023 09:45, Geliang Tang wrote:
> Increase pm subflows counter when userspace pm creates a new subflow,
> and decrease the counter when it closes a subflow.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329

(sorry for the delay)

Thank you, the patch looks good to me! But I don't think it is enough to
close the ticket 329.

I think there are other fields visible in `MPTCP_INFO` but only updated
by the in-kernel PM. e.g.

- add_addr_signaled
- add_addr_accepted
- local_addr_used

I guess these counters should be modified as well (in different
commits), no?

Also, I don't know if we should consider this as a "new feature" for
net-next: to me, it looks like we forgot to update the counters and it
is not really a new feature to update them but more a bug-fix. So maybe
we can target -net? I'm open to suggestions on that point :)

Not directly related but for the issue #330 -- 'subflows' counters not
incremented for the server side -- it could be considered as a bug fix
as well depending on how it is implemented: if it is backported, we
would have the same behaviour with all kernels. Or we add new field(s)
in MPTCP_INFO but this is maybe not needed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
