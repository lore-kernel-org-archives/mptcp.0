Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C57472
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:36:17 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id w3so2853384edu.8
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dtwbbQs9B59jr1u572fKw8krq7NbnUcfcrYf3N459YM=;
        b=Cln1HLMqNloMYpyLu21rN/bOyoMdqJKg7f1r8EkGcqnDzgN1g20F8+uc3kbOX4nCIR
         2wr9qODI9kKbKCn8xZwugfZDs1bfue0QwCN+RzglDQteWMBGRlJ2CblwB2dnmniR5S9R
         NTTTvq0JKPm9u+FJ1vbhkX24dtn01AIRN70nRVQGhQaeVNTrQrtvfVEyZuatb9y1Owfo
         60JgbL1R6Fbg26LVHvoCcImqsFiIj+U0/kKRd+dS+w2AeDQrioIt7UP4beOD+dfW8+Ti
         Ja3RgYr3rqmPOlMgVQQRGbeNhY6qqwvglPSRKjv5T755dCl6I329uw09uSbHLfRj5stW
         ulhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dtwbbQs9B59jr1u572fKw8krq7NbnUcfcrYf3N459YM=;
        b=8GRxbK9fd2/TjSsiazJM9lCfC7YfqwtNOOb5GKFdjzjzinN72C3bBrhKhe1LmN7z6x
         4zBS5JciIynHC4EJEZHBtUcEjBgptjRKhAbKQN7hJcATV//keq7Cfmrthf+BTFlWXR23
         Gg+OqqyU9v5krvZDV/k+t0Kjg4vcRkGzlAguoG3iIz624wGQL9KdKD6r/8u4SSQtWlkG
         nfhdrx0aavIHenxH1wm6Q4/HkbcK+s+dYNlykPWPdU0BUijL6mhI8emSjvhORSTjIU+D
         aY3ljXqFAWV+QT7P3oFf9UxqEgP29BiRvO5RM37X6gZddcdjrwTbHMa1H5GATBVX2vNu
         Nbwg==
X-Gm-Message-State: AOAM531H6kVLCtGqiE/eQTLLLKFgbKqaAX2LPZwUkV22n/euZACiBz2X
	Gqre91JY7Y5PIHSsdB2SVcfnItdDD+TvVpFe
X-Google-Smtp-Source: ABdhPJwUymJrl/ORL4aykccgf2eJiSGb/0rq/uLSuXGyrJHqqYPp3uSCZOdv19znpDY3SxEN+769xg==
X-Received: by 2002:aa7:cf06:0:b0:405:e0c8:8b5d with SMTP id a6-20020aa7cf06000000b00405e0c88b5dmr2264745edy.367.1645709775300;
        Thu, 24 Feb 2022 05:36:15 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z22sm1403691edd.45.2022.02.24.05.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 05:36:14 -0800 (PST)
Message-ID: <dacfb400-0d9d-eb6a-25e2-0d952ba58bf9@tessares.net>
Date: Thu, 24 Feb 2022 14:36:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RESEND mptcp-next v2 00/12] fclose and mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1645325178.git.geliang.tang@suse.com>
 <95c31835-f6e9-ff75-0f9b-2edb78d8e455@tessares.net>
 <20220223225611.GA9540@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220223225611.GA9540@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/02/2022 23:56, Geliang Tang wrote:
> Hi Matt,
> 
> Thank you so much for applying all these patches. I have two extra
> requests about the order of these patches here.
> 
> 1. Move the commit "selftests: mptcp: adjust output alignment for more
> tests" before "mptcp: add the mibs for MP_FASTCLOSE". Otherwise, it'll
> break the output alignment. Since 'nr_blank' is defined in the former,
> and used in the fastclose series.

Good point. With TopGit, it is not as easy as moving commits with a 'git
rebase -i', just easier to have something wrong when doing these
manipulation. But that's not impossible and at the end, I'm used to.

- bd41af654d7f: selftests: mptcp: adjust output alignment for more tests
- Results: 4bbd9add0797..369cbca2200f → empty: good!

> 2. Move the commit "selftests: mptcp: add infinite map mibs check" before
> "selftests: mptcp: add invert check in check_transfer". Since the former
> is more related to the previous commit "mptcp: add mib for infinite map
> sending" than the latter.

- 259143ec3e7f: selftests: mptcp: add infinite map mibs check
- Results: 369cbca2200f..287a6bb7ec08 → empty: good!

> No conflicts occurred. And the order of them all is like this:

Same, no conflicts. Should be better now!

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220224T133344
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
