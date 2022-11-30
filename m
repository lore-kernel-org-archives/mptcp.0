Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04731A42
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 09:44:26 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id e27so39937571ejc.12
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZE3qnUXVtRwKoFjhzuLTqQTuV81EdvomO0rbX6jpXc=;
        b=f4HaSQYSaq78rEnR8UXhLwlPP8TpK2pD4G3Psq/aB7YOT92i3T1CAMKCV1YG8c/3dG
         d2SoqMsRTkm3915krDnDVjQ9YdHuSSUJDa7LkUbhM9Fzw7CVZgxT2U+RiS7u59kZuuha
         BN68C3v5dVatWTkvverto82z++9MahmAQCxo7HhdsbSLAbH95NxrawRTiN1KD5WYlBVB
         K8WUmEFd0PyooZD7fM3CPDIFFcROP2/OWtCLEbYhwxU9hwset7PsW5GKHlK6QqOymg7b
         W1eBBZrl9UWPYNJWGJNVuJqof6I5TNc4Xy95vsN/XpEy7IyMjMYZb86mYSEJiZ9s2/KJ
         xnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZE3qnUXVtRwKoFjhzuLTqQTuV81EdvomO0rbX6jpXc=;
        b=DbBa/fpZM5+te0r0f/w3RLs6EnFxvOFPQWUuNTPmLxAsaHHYdDic7CgDt4CKsqfIxI
         FUzTsbDargw85NPkbyPIGnEUWW1syVE6oSzduz8jn5/jMCVZWLwuyj88hyjh2zMq3Jzu
         8Gzi4ly+nAfXw0G+Gxv6buyv4iKlUs5xVdHPtAO5fuJpItlYB/wQI108ih2sUgWevcjv
         W4mAP5JgwoT1OOQFDtv9hE4NEFhbKrhKh59rg1PjJucY5IKCRQVqqHoPYuYPoN7nlQQQ
         w67+peikQi1GQ0TdAr1b/u2vP6cjItGn5jYQO6y8a6AeRsu5MntxGAOeDuWFTmwLDvgj
         hCTg==
X-Gm-Message-State: ANoB5pknQ/BkVCKovr0v4maI0aR0K6017bg2PiBFeg3mWXKyMbwp5bJR
	x3gii2kiwNazP07S9JGcP0hdEw==
X-Google-Smtp-Source: AA0mqf4Ui0SldEecAPVl1nPWWkzSKKeN5vTTdl0mv2DzBKh6pKSWzZwYTGhDxfwHK/FoimI3ts/gOA==
X-Received: by 2002:a17:906:844:b0:78c:2c03:804c with SMTP id f4-20020a170906084400b0078c2c03804cmr38756642ejd.107.1669801464961;
        Wed, 30 Nov 2022 01:44:24 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9f2e:bf78:6a2f:7403? ([2a02:578:8593:1200:9f2e:bf78:6a2f:7403])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906314a00b007bfc5cbaee8sm457967eje.17.2022.11.30.01.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:44:24 -0800 (PST)
Message-ID: <2b373f0f-21b3-abbe-523e-8f6cb4a1af5e@tessares.net>
Date: Wed, 30 Nov 2022 10:44:23 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Menglong Dong <imagedong@tencent.com>, mptcp@lists.linux.dev,
 mathew.j.martineau@linux.intel.com, Paolo Abeni <pabeni@redhat.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
 <9a04313e-9874-ff64-64a5-d1d367125dc7@tessares.net>
 <CADxym3YeaTuXQUdoacMRqfkZPL6EjV2av3qdaXENUthA1bVprQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CADxym3YeaTuXQUdoacMRqfkZPL6EjV2av3qdaXENUthA1bVprQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 30/11/2022 03:11, Menglong Dong wrote:
> Hello,
> 
> On Tue, Nov 29, 2022 at 12:05 AM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Menglong Dong,
>>
>> On 22/11/2022 04:49, menglong8.dong@gmail.com wrote:
>>> From: Menglong Dong <imagedong@tencent.com>
>>>
>>> In the 1th patch, we do some code cleanup with replease 'sock->sk'
>>> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
>>> use. In the 3th patch, we make mptcp_connect can exit when receive
>>> 'SIGUSR1' with '-r' flag. And in the 4th patch, we add the testing
>>> for this commit.
>>>
>>> With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
>>> I belive that the testing of diag.sh can pass now. In fallback and
>>> simultaneous close case, the msk can't release normal (sometimes?) without
>>> that commit, and makes the testing fail. Enn...let's just see that the
>>> CI is saying~
>>>
>>>
>>> Changes since v6:
>>> - check all processes exit in flush_pids() in the 4th patch
>>
>> Thank you for the new version!
>>
>> We discussed about this series at the last weekly meeting we had and
>> globally, it looks good.
>>
>> However, Paolo mentioned that it is a bit of a shame we need to increase
>> the complexity of the code for the stats. I agree with you but during
>> the meeting, we didn't find obvious better ways to avoid having to add a
>> new flag. I will let a bit more time for Paolo just in case he has
>> another brilliant idea :)
>>
> 
> Thanks for your discussion on this topic! It is indeed not a good
> idea to add a new flag for such a case. Looking forward to having
> a better solution from Paolo.
> 
> (BTW, it's all right to reject this series if it's not good enough :/ )

These stats can be very useful to monitor and debug stuffs around MPTCP!
But yes, if there is a "cleaner" way to do so, that would be better.

Let's not rush things and think a bit more about how this could be done.

>> Other than that, I have some small suggestions for the patch 4/4 but I
>> can do the modifications when applying the patches later if no other
>> modifications are needed.
>>
> 
> Yeah, thanks! I can send a v8 too if you prefer :/

Thank you but for the moment, that's fine. We will probably talk about
this series at the meeting tomorrow.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
