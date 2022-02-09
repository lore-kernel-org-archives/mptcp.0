Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAD29CA
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:45:43 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id y3so10925403ejf.2
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=otef2taW6CR6NjWz/i4FPq4EGOf5QU6qaOHEBBdteCs=;
        b=ZYQFomlvpN+fhn7cBBjYn+zbS97EyY6jmYZcD1MYpm4tjoPVaIIbOubu3W+KJUT9z/
         44drKKfW8K27sRjT7scFiNCqljnVUv0h4DRFcRTcSMs7pN/SjbJ+xvfNg0IapAyuLg2N
         QDR1pH51QeM9ewuBLioUJxx5VYbvIveF3sdnsLpO4Os2BuzyP9IoaVt4K8qXextE1+CN
         7Z2rjHUp7j74bJAiPl53gGvOJ5hQf8CfdOGRKJotAgTLwVdR1E4xsdntz/fgoxx1ySvS
         DWgpxb35TMgZxhQXViYMfZaIY4knfUUVNWehbXileEhkTs7b+VeE/uW8eQFBho/FeB/d
         pvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=otef2taW6CR6NjWz/i4FPq4EGOf5QU6qaOHEBBdteCs=;
        b=peI0lMNn8HVvGS3N8fKqClYDbCYses2mRJDMvfHXgCjrkXMdh2Ha6b0IoHtPFhNqLR
         /d55OKu+c78FkWby86p44ZBAmi1d9HABCU6s1tUoQEwVtTjWAhfQyT+jEQMGnK9oRvlG
         nKQs5G3mHc5JEg6tGvtDu7rwpeQvBCEVKA3Qh8bdgbPuBZGli9EbT52nMt3NYJJoFZav
         gQ0ZB6VmlFMco5r0UH6czccZuRLr4bkcK/cCX4LB8rxxHng0OM+H8t8wWxaihONFlWkm
         D1CfNsJNLCeT4Ju51evIkVNJNnCxuzp20W6i2PaJllw9de5PxwuNkLFLcb8mhjRlEAC+
         p4OQ==
X-Gm-Message-State: AOAM533SkgLwRBbM02a3veiwm1zN80MskDNGm4tj6bbvvFXNAufm6vio
	ykjIU5fv4dwtCzl1abrWkjEPbQ==
X-Google-Smtp-Source: ABdhPJy4hRFl/8kr3JGVoffj/x4CGjwqFLXWYWk8ACId44iqiMjaK3UMsyauauW4k6fb89v5iuD/IQ==
X-Received: by 2002:a17:907:7f87:: with SMTP id qk7mr3875348ejc.746.1644443141648;
        Wed, 09 Feb 2022 13:45:41 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:322f:b8fb:20d6:51a7? ([2a02:578:8593:1200:322f:b8fb:20d6:51a7])
        by smtp.gmail.com with ESMTPSA id da9sm5623728edb.1.2022.02.09.13.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 13:45:41 -0800 (PST)
Message-ID: <ca5619e7-8676-bfa2-f4a9-314b4af79482@tessares.net>
Date: Wed, 9 Feb 2022 22:45:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add mp_fail
 testcases v5"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <d7ae1690ad1da5e0614e239a429e91e4dbc52155.1644414480.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d7ae1690ad1da5e0614e239a429e91e4dbc52155.1644414480.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/02/2022 14:48, Geliang Tang wrote:
> We will get this failure in v5 in rare cases, about one percent
> probability:

May you give more details about these rare cases?
Are you talking about having the same hash for two different packets or
something else?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
