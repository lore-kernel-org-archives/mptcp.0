Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF02F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 10:46:26 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id fj5so19095379ejc.4
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=Y1asHRWiUVWWTwkDN+nYz25GuZD4cDtw1UFiqQnFEqU=;
        b=heC3zxCpGYdRu/bWxm8JSrnexh7gb0BwHzOIo6ojwaWk/ZH6ZyGhT7L31yeWWCWTKS
         sTR80rOHjj0g/tr+H+tj1Gh79HqmrP+/pJK5Ej9VMX9WRm7p0EhzTgDKaKtQxl+TZvTP
         lMXRPwAJ4E+c7JU/LGCvV6VMAos0NhEj81XKnffJ6mRG/TsT448UWC1eCe3jrYQIH8Yg
         ZuxBii+O8NdZI/+TahVuATbfSUvRdesf8TjJFBllxw0zyDTWUkHiHGICW+CUn1yI8Kfp
         t/AQPlIk4wGMkpJJKdnNJhHJzMMIlhW7AZ6rtYXeglOsaDgLMzRmezLq86C/MdK5VzbE
         y4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=Y1asHRWiUVWWTwkDN+nYz25GuZD4cDtw1UFiqQnFEqU=;
        b=aBppbd44u/CArH9D6IfU3/g5oT6hpWibdbbY0hNrUN5x0W4Zv1lHcsp3//mWxpfgLA
         mg+GVFZSy1JZePVsWczyR5FiaQnwqQ6F7OP2xBvDuTZwLtmcdVYDx2G1PPiLHsbSMeEb
         7FmxkBLwXEuNXQABdAGLXmCshahoLkytGRPvFcgen0V9j1BSXHeopd4HO0E/5NkG56US
         UzVA5FevmCeJOYB1C/4zE0JsNfaNYFd4CniRhMMY+qRScDsgZJC/kreer2Des6pp1krk
         veK5ln2S1bCTKHHFWfWkUlJcbssioQaAkzHa/7GoaNWgCXMj2kD2qNXTDybylyIj1Nhs
         gDWQ==
X-Gm-Message-State: AOAM5331ud/Sbd3AoTcDK2ypzugWxxBNq8Q+p14lc3yn5TJDcXOlgv8E
	eXL0OhFLjL/c0qSp7l8C+R1sSG5LsdnvLQ==
X-Google-Smtp-Source: ABdhPJwFmUvaDvEXbkGECdey+iSdfrOEX6jGKblEBbUhGKY7AOPXGWxXupq+bow5k+rA2w322s6SoA==
X-Received: by 2002:a17:907:3ea9:: with SMTP id hs41mr853414ejc.727.1644576385212;
        Fri, 11 Feb 2022 02:46:25 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fea5:b1fd:66cc:fe97? ([2a02:578:8593:1200:fea5:b1fd:66cc:fe97])
        by smtp.gmail.com with ESMTPSA id q4sm7804265ejb.109.2022.02.11.02.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 02:46:24 -0800 (PST)
Message-ID: <066da38c-507d-a35e-4c7d-419e578ce0a1@tessares.net>
Date: Fri, 11 Feb 2022 11:46:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 mptcp-next] mptcp: don't save tcp data_ready and write
 space callbacks
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20220210144839.26742-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220210144839.26742-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 10/02/2022 15:48, Florian Westphal wrote:
> Assign the helpers directly rather than save/restore in the context
> structure.

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- 6889b3fb6405: mptcp: don't save tcp data_ready and write space callbacks
- Results: c999932bd32c..7f0a980be1a6

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220211T104450
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
