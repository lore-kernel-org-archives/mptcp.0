Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5629CA
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 10:42:25 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a25so37580417ejv.6
        for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NlldPDTMTa8i2mK1w4G0b65TnAopBo6VM6P73hj+Yk=;
        b=HtP2iHW1tnRhiU9hVOZhdY+VjDdsaqCa/Webw6thMRfukXx+A8dA/nUWlSy03N4pnl
         6wFSJui//Y4igaHvknOwBvz1HKpzI/VUl6z6UWRB1Lm1g5npGxPx3QbI86JT/iJFboWo
         9WTgbN1BFGmC7yUImuU/GMcjiJ5OytVjPgtfTXs6zqs1ce8j55Ai9C4W0rDjK4K41D11
         dUny+RV6JdjMTlup5fwZ3XTRHzt1lgmVbPmZfMhUdN3kdfhQSGAEtybTW1nOLugGrvtF
         bzdOMYKaOiZgPVYxV7j4zEEF4QsQQ+2LzNbNZUHy7wdWBl8LVD0EtzDNJ/LcVMo0u280
         R5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NlldPDTMTa8i2mK1w4G0b65TnAopBo6VM6P73hj+Yk=;
        b=VgoF82xKFzaI8IcDiaY3IQX5A71a9D+qXFPp5p424U6hkgM5MIAN0K5gB3YEOhqX1w
         p791ldnCOfgWa/7VuO1uGD2ZaVkKDPjDEd1KqjOVnjc7B2fLrZJKpBMeIhTdMXJP4Xl0
         YU2iKuSpAZYVY+Nm70qn9bjZakun2pLelVrB5DaYbmmdbSQ0p8k7O/SByNZFB0y/SBxA
         MpwTRgWEU4VoIpy0/36+27Aywn/3ryent46sQJD048H7I6VQLP65U6RVCGYmiMeWYjxT
         G4b+SwUkASHaIZ6YNDS8yMK3iw9oRUEHzx0xzm13ZBjh+xUDz6h1O8GVZwXjPchra8SY
         qlkA==
X-Gm-Message-State: AOAM533yDKyJttc2S2ZoBIgD5knByI9LkP0DgDDHMi0eIT1+C5mbdQzM
	cGJl8K6LDcMwQIR9AjoCbebDKfgRSC2KfQ9m
X-Google-Smtp-Source: ABdhPJwo1WnnDshkEUrYla6SNfY/ciWl9iCuiZ7ilWngGNxfZG6ng7TxL84mhjphjJQ/I7H14A5zMA==
X-Received: by 2002:a17:907:61b0:: with SMTP id mt48mr30075345ejc.64.1630406543321;
        Tue, 31 Aug 2021 03:42:23 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id c19sm8134043ejs.116.2021.08.31.03.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 03:42:23 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: Only send extra TCP acks in eligible
 socket states
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: geliangtang@gmail.com, mptcp@lists.linux.dev
References: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com>
 <5ea0f310-8798-e436-24ae-2476b16b1813@tessares.net>
 <499c9366e65bc7257ba48c831bf7c28e33503b84.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <1279ccb9-1237-eb82-1129-a9f882fc2c82@tessares.net>
Date: Tue, 31 Aug 2021 12:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <499c9366e65bc7257ba48c831bf7c28e33503b84.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 31/08/2021 11:46, Paolo Abeni wrote:
> On Thu, 2021-08-26 at 20:24 +0200, Matthieu Baerts wrote:
>> Hi Mat, Paolo,
>>
>> On 26/08/2021 02:46, Mat Martineau wrote:
>>> Recent changes exposed a bug where specifically-timed requests to the
>>> path manager netlink API could trigger a divide-by-zero in
>>> __tcp_select_window(), as syzkaller does:
>>
>> (...)
>>
>> Thank you for the patch, the review and the testing!
>>
>> This is now in our tree:
>>
>> - ea8a43942429: mptcp: Only send extra TCP acks in eligible socket states
>> - Results: 99a16463048d..6d52100ab2ab
>>
>>> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/229
>>> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
>>
>> Checkpatch is yelling at me because a SoB is not present here.
>>
>> @Paolo: sorry to ask this question but for the record, is it OK for you
>> if I add it? :)
> 
> To be more formal:
> 
> Signedo-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for this explicit SoB! (I guess it is one and there is just a
typo in the tag name ;) )

- 559fbc74cc30: tg:msg: add missing Paolo's SoB
- Results: 54851c6a542b..1a8852042a9f

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
