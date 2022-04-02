Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4D7C
	for <mptcp@lists.linux.dev>; Sat,  2 Apr 2022 11:42:24 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id z92so5738055ede.13
        for <mptcp@lists.linux.dev>; Sat, 02 Apr 2022 04:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1U40PQiQ+N3n5iVT2LnR3C8P0Si9dyR/ewFZeprZxJ0=;
        b=8C7JYobKc5hWvsMrS8Skr8696K4ZaLQ9kTwivSfINNi1nSj3nJP/tCs+Tt2oXA8gfm
         REsR8kujnEjXQjIqbKZFTkSYTYTq1Lrb4kt8U8sNF9iuadfhgD9nDXY9IOpdpa6++0oj
         MAwyWyZIb2OfqRnFV9WIJ5F0a7nOce41BB+PixXujBSTJOhCoX6D5mSehbdbHlaWjE8T
         HnY+W/9i49j/dkcoEWPYI4vP8e+CEPt2P67OvnZPPLnbH2Zpj3IMfgmX+sfmhXTvCda5
         Ok17oQ8pXqbw46mfAX6x4IqBLeYTLbMgOjwAplGR4oeDr1IftF/Ig34EiStyrE06A/NR
         tMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1U40PQiQ+N3n5iVT2LnR3C8P0Si9dyR/ewFZeprZxJ0=;
        b=UkgLdeXIweGnlv7B6AIDfxwg8rcF7PwwbXA6cCur+7BfpwiUZZ71J8U2qpHxqAO7xL
         Q1AM56C09AAQ7jh6PUx4pbxIJPFmTcAD87x8KDlJ7+RJEsMYPXaXzfwdek+2iPb0Mgv8
         rV9U3mMpMrANFwK1OROYQrHWZ0BDt8/kl4euCmsIWJ8VFQjEFEeVZi1CmNQAN2GPZ5h4
         WHT4YucMavUZ4vnGNs/ky5rCGgCITvi8gORtjNU2s+67mktqgVSM5auYDMWTS3/n6GzI
         clKWfBycX01LXjdRRUMPvCEIwdoGqE0WDvI74YbemRP8ke8adXpxZ8TMMd7Bn6kOymJH
         iB6w==
X-Gm-Message-State: AOAM530zYTFI/a3Rc4MgEoqULSbWHw3q8t+3QJqANDaSliQec5ehzVNk
	QZoXTt1AorNJtb0fK4U+Xybw5tKpa6nWHg==
X-Google-Smtp-Source: ABdhPJz99+EDtZnKhepry1hTIwNnMu90Y4IY77XpxqR+ULp+jfM8UkaAesJgRkdiKiIUq3lLNsA08A==
X-Received: by 2002:aa7:d9d1:0:b0:41c:bd61:b076 with SMTP id v17-20020aa7d9d1000000b0041cbd61b076mr8557eds.41.1648899742505;
        Sat, 02 Apr 2022 04:42:22 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f7:3798:a3d0:a7c? ([2a02:578:8593:1200:f7f7:3798:a3d0:a7c])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906644e00b006e4dae79576sm1549570ejn.14.2022.04.02.04.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 04:42:22 -0700 (PDT)
Message-ID: <4dca06b7-14fe-01fd-ada5-676ba11a4e26@tessares.net>
Date: Sat, 2 Apr 2022 13:42:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v8 0/8] BPF packet scheduler
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1648537203.git.geliang.tang@suse.com>
 <bf2b415d-a5f8-907c-9a55-d8b6d2c317b6@linux.intel.com>
 <20220330141211.GA345@localhost>
 <326dd1ea-98f6-fa43-1f44-e66fadd6d9c8@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <326dd1ea-98f6-fa43-1f44-e66fadd6d9c8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Geliang,

On 02/04/2022 02:40, Mat Martineau wrote:
> On Wed, 30 Mar 2022, Geliang Tang wrote:
>> 1. Get the subflow data from BPF, maybe iterate over the subflows
>> from mptcp_sock.
>>
> 
> Like we discussed in the meeting, I think a helper function that's
> callable from the BPF code could gather the necessary information from
> the subflows in a safe way.

Yes, similar to what is done in TCP CA, e.g. bpf_tcp_send_ack(), etc.

>> 2. Make same members of struct mptcp_sock writable in BPF, say
>> last_snd, then we can set it like this:
>>
>>        msk->last_snd = ssk.
> 
> The kernel C code can record which subflow was used last based on the
> previous value returned by the scheduler, or a BPF scheduler could track
> data in a BPF map (I think - I'm not a BPF expert).

msk->last_snd seems quite specific to the current in-kernel packet
scheduler, no?

It will be useful to store this last ssk for a RR scheduler but I think
that's just a coincidence. I mean: it would probably be helpful to store
everything needed for the current in-kernel packet scheduler in a
dedicated structure in the msk. Then any packet scheduler can decide
what to store in this dedicated memory and we can also easily clear stuff.

> For something like last_snd to work, I think we need some way to
> identify subflows that's not the raw ssk pointer. Are there rules about
> pointer usage in BPF that we need to consider?

Yes, for BPF we might store info in a MAP linked to the msk. It would be
interesting to see what is done in BPF Cubic code for example.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
