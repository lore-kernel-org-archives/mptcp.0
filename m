Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BA5580
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 17:37:06 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id d10so22447493eje.10
        for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fOzsJh9TqSyFFfn7/5Nchy5c3TStfqSz4OzUytkn7KY=;
        b=pyBjiPqahvv8a9UeyKDxR7SE8S1HlGZ4u7mMTGcmKXhj5NOKV4hEF1cYj66Ntp4kMK
         1mhjs9q4XITn7tcRIoKFwtxy5LbFuLR/6/8+Hnedhzbagx8OHK4p+IihXOeu13pOmyjC
         XMLAi043+BKFg6/ktOL/mQHcqrAe6WOYIZgcr/8EWNuejQjlH23uByNT3CUvcplcsnk6
         jLHsBBUya+m+pRFjaxm4u+a0CLiV2RJMyRuamqxorqWZbP5AsXEzzR35T6p1cebe3WNv
         ioVpquogMycFwsasABUKFiMmIOzfDPQ+AxmZBeFm0lte/2s1s+QMPyNLinxySyaQpizT
         Uo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fOzsJh9TqSyFFfn7/5Nchy5c3TStfqSz4OzUytkn7KY=;
        b=oEQ7nocAs40hpdtOWpatjeHuSxCH1c8LKGN656q3OC4qTXWDEqmy5A8qu9lMEzOIrS
         T70ubJC7I6y5Rb/3S0BNr+xHgtThCxg9nSK0XEG+3B6JiyIZ+Lv/YdopUbwOcDlHTFp9
         ZIqQ+WqkzIcx0L8GFAy4PBK+wloGPk6SWbvYZi+WeCv1ivZW9ZuyCngnv1MqsXXN92Oe
         XOeTiTWYGUK2Q7RpO8gB/Ww7eGD2LW3DTVF7mQLbw4XtV0BaIvxnST0DsXw7XtaRezqE
         MCUHTDhWNlbUcoJsX9PHRZPn58uLzdyGKFySOjtGMklkCug6XYziwyo8txDevD6k8DWq
         vCKw==
X-Gm-Message-State: AOAM533R8pu4I4hhopS0rjjXfysWW8wrMp6tw6TRL22W+mGx0aHB9VGb
	xRdGeTIe4FxEEyxfBFRaICKycg==
X-Google-Smtp-Source: ABdhPJze8Vn8FBmZAqamGD/nEFjdYT+WcJ5zyO9Gjas54bisQA4yU6GMlTglvMq8Htf/PWkLErLgcA==
X-Received: by 2002:a17:906:1603:b0:6ce:362:c938 with SMTP id m3-20020a170906160300b006ce0362c938mr10518575ejd.253.1645292224487;
        Sat, 19 Feb 2022 09:37:04 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e864:9933:3026:4675? ([2a02:578:8593:1200:e864:9933:3026:4675])
        by smtp.gmail.com with ESMTPSA id a16sm3410518eds.35.2022.02.19.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 09:37:04 -0800 (PST)
Message-ID: <412146ab-3f12-78c0-0698-7ea35adbdfc7@tessares.net>
Date: Sat, 19 Feb 2022 18:37:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-net] mptcp: Correctly set DATA_FIN timeout when
 number of retransmits is large
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <20220212010447.119486-1-mathew.j.martineau@linux.intel.com>
 <4301e70ec02a98f657caf32590773e789d117f21.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4301e70ec02a98f657caf32590773e789d117f21.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Paolo,

On 17/02/2022 22:37, Paolo Abeni wrote:
> On Fri, 2022-02-11 at 17:04 -0800, Mat Martineau wrote:
>> Syzkaller with UBSAN uncovered a scenario where a large number of
>> DATA_FIN retransmits caused a shift-out-of-bounds in the DATA_FIN
>> timeout calculation:

Thank you for the patch and the review!

Now in our tree (fixes for -net) with Paolo's ACK:

- 99aa4cb37fa4: mptcp: Correctly set DATA_FIN timeout when number of
retransmits is large
- Results: 4496c31e7f0d..52f48b4dbde0

> LGTM!
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> 
> (I think the the suggested-by tag could be dropped here)

I left it there, I guess we can have the two, no?
But Mat, feel free to remove it if you think it would be better without
it :)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220219T173647
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
