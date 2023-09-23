Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF563B9
	for <mptcp@lists.linux.dev>; Sat, 23 Sep 2023 08:20:13 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-403012f27e3so36105025e9.3
        for <mptcp@lists.linux.dev>; Sat, 23 Sep 2023 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695457211; x=1696062011; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1VwSS+vdbq2EXjkKzFeLrLRm6rx7Zd9Gy7Tzol3T7g=;
        b=7weKPB1gM45886VgiWguwtmYRTEuB5eyxjqdaZOJquU/uwykzqYp2GzFAPuuhVeDQJ
         Ds1/p0t+JQZlyZ1PoflF2YFg6gQqZV9Qa2acKEY0cDapZDEBifuFIeDStvJa4OCIe94R
         gf4awyb0fXwusUsUmayDkNRrLZdjoBA+6Zkt79DOJpLuoaqCP0T40bmMf1MnMLz4cx2A
         3OcB7MyZY7WRx003UIq2Ipi8i5snOkniVtcz27i9PmXF2W8tf4pGnubZdq6j+x0zyovD
         Yg+Nkfu4tJoRmRNxzIsYgRwrAndG55dT0JkHhzPgGrIqBtfpBKmZBwjhZvDaMMSsUYcT
         gP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695457211; x=1696062011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1VwSS+vdbq2EXjkKzFeLrLRm6rx7Zd9Gy7Tzol3T7g=;
        b=ZpG/TWxD/rXbb5Nrcekojgs2JKacCwQlPrtEBCGMBKrrbSrHuLj3Gz+VNlpsupTo2F
         ND2sNWxaZHqZ4lkdipyyTE/iRfA9euIk5ShHPfdII16IjV4+mDSz9yhuoLVw3Z9LZksW
         +QFr4G2YTm7NNFtT5q/4F4w8lefZGa93ofTHrYdot7HUe5ujjIMdkL7PBeH6bGHQJG7z
         kZEFg5UmcBhIJy6wVySaDgr/lbw2z8pAKwaviPSx4jPYeA8VeUvttvl4Pds2rFADqxsP
         Nx/2mLdTjesgeizPFKgCKvLAQ4pxghs/KCj+SCppuDWim20zU+AM9ooBjCdREUGT0UA0
         HTvQ==
X-Gm-Message-State: AOJu0YwlDBy3AwnlWAImPX+u3RB/zzIQitKKDGGsS8rgf5EQDiyi/9+S
	MhwM2arVU0jCJ9LvLE3CaA/l6cGVsVd2sZaHQXN6ew==
X-Google-Smtp-Source: AGHT+IHkssXNxHGGOKttdY2PRIRuugQ6H9v62onlA3DRF9jpBIRIy4zErntRCTJfUwDPmQRTc9YJRQ==
X-Received: by 2002:a7b:c456:0:b0:402:e68f:8898 with SMTP id l22-20020a7bc456000000b00402e68f8898mr1355730wmi.0.1695457211365;
        Sat, 23 Sep 2023 01:20:11 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1c88:7af9:498d:bb0e? ([2a02:578:8593:1200:1c88:7af9:498d:bb0e])
        by smtp.gmail.com with ESMTPSA id y23-20020a05600c365700b003fefe70ec9csm9378586wmq.10.2023.09.23.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 01:20:11 -0700 (PDT)
Message-ID: <8817b2da-3a3b-4626-ae94-698759b3f026@tessares.net>
Date: Sat, 23 Sep 2023 10:20:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/4] mptcp: performance improvemets
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1695208066.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1695208066.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 20/09/2023 14:45, Paolo Abeni wrote:
> Cool subj just to catch more attention;)
> 
> This is a follow-up the yday mtg and to the discussion started from
> issues/437.
> 
> The first 3 patches implement a working support for rcvlowat, with the
> intended and relevant side effect of avoiding most TCP-level immediate
> acks.
> 
> The existing check in:
> 
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L5534
> 
> newarly always triggers immediate ack, as the any data received
> on the subflow is usually immediately moved into the msk. That is, we
> nearly always have: tp->rcv_nxt == tp->copied_seq.
> 
> That causes an unneeded large amount of (tcp-level) ack. After patch
> 3, MPTCP behaves much more alike plain TCP, compressing/delaying many
> unneeded immediate ack and moving some of them at recvmsg() time.
> 
> Such change has quite a relevant effect on the max tput, ranging
> from -4% to + 40% depending on the specific setup.
> The small regression happens on CPU-bounded bulk transfers, with
> not-so-large write buffer and can be elimitated increasing the write
> buffer size. Even in such scenario, the overall efficency (B/W divided
> by the total CPU cycles consumed) increases.
> My personal take is that overall this for the better.
> 
> The last patch gives some speed-up to the tx path, just by using the
> 'correct' (or better) helper to memcpy the data from the user-space
> into the kernel buffer.

Thank you for this nice patch set!

New patches for t/upstream:
- 0188ee6897bb: mptcp: properly account fastopen data
- ea3f76f3c64b: mptcp: use plain bool instead of custom binary enum
- 03cdb460a417: mptcp: give rcvlowat some love
- 11b40c8da614: mptcp: use copy_from_iter helpers on transmit
- Results: 1c2adc4e573c..f2baa63004ad (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230923T080409

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
