Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BD2C81
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 12:13:07 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id z20so23491980edc.13
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=qPp7dawWtCE91fE6y/9LwXVVvKKPvuK/kP1N/BC4rKU=;
        b=AOZ14t6bcLobdi9xutzV1+lLIETwdLEvze0+gwIl8My+F26gCcaZS4/1BKIgFdfK3G
         A1x8mlG58wuA+1TgxCkY1fJLztIQeMnw3TIE7/XSOrDqxg9Ez49IjusXq7AeuQ8sCVNr
         xtCXVLZMyuy8+jFKsVyi4NF+idnlJuhv5Hoq5TH4+1QIAY2J5wyzHcUBYRfPmQhhJFcw
         qnK4Tg4p4UPHBtAz/KAJC47NPB+sWQa/LF4GlvCoCMS+k1B9II9kRBHqNDwgJ/ZD3X9d
         oTVj7YFHc0yrv39IPmWGo6uMz2z8DhinRScbk36JQSl8fGU1FN6ZICuI6I9IcjWbwepw
         agRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=qPp7dawWtCE91fE6y/9LwXVVvKKPvuK/kP1N/BC4rKU=;
        b=WFr8SdhGRgvzAXxEyKsSno6d7zwiMgfAzWLYMNTCMQviZjaRbVtLjBaksba5es3wr0
         tz3OKF4keo3SJMQ4bdAiW4wCSAcxcSsUl2JeiIQOOYHBDxRBcTL4aMtAs5D33uo+t1yd
         JUp7nWy9dIM9MA6xUAMRRnbYknDs5ap6wZR82GMSkC0pFB+qTIbwNHF4k/ZnDfR1u17o
         ZuObQOnD4VJBTA6EcBwGvv1UMjws/N+Lw+6R/TPqEZ4XyXH+bQxV/HPYoAqrMY16Ddz1
         0TygacS7kgEJ+rpN/iIq643t4Kza9yXEBfqwjyrcLIDNFx/knAeYpFGkJlEjUGHBVplG
         iJew==
X-Gm-Message-State: AOAM531umQ3svFxgei0isHwLQuXoVQV7TmJpzMgTV42l+IoukzSvcY8T
	NJE0S7ppF7g8wwv5DnfgF6xf3u9Y38P2Mg==
X-Google-Smtp-Source: ABdhPJydBmO8D/Qmb8O9ze/tE8GZ5IMsJU9UQFrhg1Pni1hhe1Mnu5XL+fW29q73bJKVCTCZ2A+iUQ==
X-Received: by 2002:a17:906:3715:: with SMTP id d21mr3577456ejc.74.1634213585391;
        Thu, 14 Oct 2021 05:13:05 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id n24sm2279016edb.28.2021.10.14.05.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 05:13:04 -0700 (PDT)
Message-ID: <b58e9b94-dd55-15a6-1d4a-56aeb9b9320e@tessares.net>
Date: Thu, 14 Oct 2021 14:13:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: increase default max additional
 subflows to 2
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 08/10/2021 19:27, Paolo Abeni wrote:
> The current default does not allowing additional subflows, mostly
> as a safety restriction to avoid uncontrolled resource consumption
> on busy servers.
> 
> Still the system admin and/or the application have to opt-in to
> MPTCP explicitly. After that, they need to change (increase) the
> default maximum number of additional subflows.
> 
> Let set that to reasonable default, and make end-users life easier.
> 
> Additionally we need to update some self-tests accordingly.

Thank you for the patch and the review!
Now in our tree (for net-next).

- e941154465d9: mptcp: increase default max additional subflows to 2
- Results: 2f5f8088e247..0c525f1e0da1

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211014T121105

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20211014T121105

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
