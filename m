Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03084290D
	for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 14:04:27 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id ud5so14003721ejc.4
        for <mptcp@lists.linux.dev>; Fri, 27 Jan 2023 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFoxX7vsje/lQFOTe6KzuqAqhiAfqa7wTWXyH5FdonE=;
        b=T1jLejasHKvI9lfOKQEtrKgsuNg8zDbwip7Y49PUw/UuMiTdDkbMz27V9cjw1xMAK4
         Fr+CWfw5i0zOx+7zHL0Bbx7cvTClo05+fxokMxxg14nfChxK6f3nXBFehTnoCqcE82hk
         PNhXdOAQ9HO9oQvmDz34CzkOkMk9XiOpO+OcJF8FoOTxGsZ/3xaCDvzCV3KVV1BVkwkG
         d5cpikr7hfqqtcydEeT+t5w7+dzopDRORBqHSnBNJEVxjrljeJ0mQEA/wKE6fV7NDOBt
         cDxFjGQMjl3Q5Md4kyjYW1cYwZDehVyWStDnMYFPEZphw7rAoYeUJoLyJPTtNYXe57wS
         JMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFoxX7vsje/lQFOTe6KzuqAqhiAfqa7wTWXyH5FdonE=;
        b=y31iqFOxqgJAoGosj7S4CVErwQeP7ZeabcMZ2PgTBqBsBdlgeXJLGroRm3SX/VNVBe
         wE+qHLaN/s+EA6DLacNkZ4C+uhtAlb4dq7VYLUHBZCLOKXh8cSOr5cDCYGX4BN82wcpW
         79sk8KJOx9QZzIzGON5MjIpR53nDyL6/TNwAGK8Xb5RSQivd+RJ6DAwKufJMC3pMxzwV
         EhDGG23w9nRVRrmZ2AmbuYSBbrLVhd/Y5McdFr/HTvuIdGiSygkdYxiVvyUER5xKG+Yy
         5jFZzucT+q/W6z10rjVmiuS4FUBBDa5a9Okpv0ReE95P5q4JTuAFPO9C5ACdert1WUoZ
         r/oQ==
X-Gm-Message-State: AFqh2kqkC4cZk4GF6ZvNf7uG6psmHn1daOKa4eBS4bFB+SWAB+yDuLhZ
	Daq7J7s+6gG2aEbW4D4/6jkM4A==
X-Google-Smtp-Source: AMrXdXsq/jBMExcQH5fPdCx7XSx/CFaN2LNWoK/m6BH2EWPK8yNTQCyEbWA2AW0Wi8jMp5Lo78j4ew==
X-Received: by 2002:a17:907:cb86:b0:7b9:f9d8:9554 with SMTP id un6-20020a170907cb8600b007b9f9d89554mr45317482ejc.40.1674828265783;
        Fri, 27 Jan 2023 06:04:25 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b0085fc3dec567sm2295560ejn.175.2023.01.27.06.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 06:04:25 -0800 (PST)
Message-ID: <39af32d0-67ac-dddb-3482-db9229db2e4f@tessares.net>
Date: Fri, 27 Jan 2023 15:04:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 mptcp-next 00/15] mptcp: refactor first subflow init
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1674767058.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1674767058.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/01/2023 22:05, Paolo Abeni wrote:
> This is the needed refactor for the selinux fixes, as discussed on
> the ML.

Thank you for the new version!

> Compared to v2 this revision introduces 2 additional patches:
> 1/15, just another cleanup found while addressing the recent bugs

I guess this patch 1/15 is for net-next, like the rest except patches
2-3/15 for -net and 14-15/15 for "features for other trees", OK with
that? :)

> 12/15 factoring out a __inet_listener() helper, as suggested by Mat.
> 
> The only other patches with some change is 9/15, adding more
> comments and consistently reporting the newly introduced error code
> (a bit different from what discussed on the ML, for consistency's sake).

That's fine for me!

I just have a small comment in patch 9/12 but I can do it when applying
the patch.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

> Paolo Abeni (15):
>   mptcp: use mptcp_schedule_work() instead of open-codying it

(small detail: I'm not sure "open-codying" is correct, maybe "open coding"?)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
