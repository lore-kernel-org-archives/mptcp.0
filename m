Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587212FAD
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 06:48:45 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id z20so36557477ejf.5
        for <mptcp@lists.linux.dev>; Mon, 16 Aug 2021 23:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8crh5OynK9tEkmKfe4qkzZ8EjEWwwgeoeW8Gd34hi4s=;
        b=Fi6HGz3gtL3USqjNS1sHYKpa8zTL7dPu31zCdpcw2bMmx4WVCu5t30f6VzwX25XEgp
         monzlocnFGcLCjHLKJNMdOl4yTAte6w3df7DJhjmaNQC3IZxtFryWkXfDfuygN01Tql9
         t1uid34lpT5KXf9V3VeO7pf3kZWeikWB9FBDtPeo+rFUGe2kig1KrQzfC6Daq+2MtdF7
         BCVv0bl2pZY8XCakEQYdFznvpYs5gLE7Wp1xtUiXh5GggO9HqYiOJs+jKPGH75mITJ2E
         IEBzJM+m6RCEcUQmy3MXJ8b0TwsqGAY9MhsQbBTnBOcuW+0y+yhur6lsoCM3yW0XH802
         UMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8crh5OynK9tEkmKfe4qkzZ8EjEWwwgeoeW8Gd34hi4s=;
        b=Zgf8Hu2uDxq3vDjupacJkFaDGi/D6nqeSqhCjXye4mfrW2zTQj6GRM3vEYenGx8FSU
         og0pa8EzuwhkjLjTGQZMaf+prmkooNtmyS7Z3LE6i31DVqEcZDQfoAFqu3n6uWg+rT4k
         lJukYtaQ8in2wEcowcxDzTUBwFK34MIvTYmGNF7DUSXE60Ts57Sa9lkz3rOt7vPGt1Rg
         Sii75pL5odS/+9iaNcdcs26F2z+w4VvHg8FFW0fhgUZoERXWygQ8SDDR+K0F2QhWYDek
         Q2h7z0NS8asEcEQyzjjzeOt/3jdpaBxGip1gb/WF0XP/kHSaF+OuIxq4pP+Sl4tQZTbj
         eQ6Q==
X-Gm-Message-State: AOAM530Duf5xlg9qdpeXixO83PtGe3V9vJIAjH2GzmcmgQl+7FK/EtwW
	asn7E3m/qclD7adi61O11noOVfi5tvrtgia8+xY=
X-Google-Smtp-Source: ABdhPJw9EVaEoHHayVOpN99rv2STrqrrdnitICO1YP8untHehJlk4JV/N42IH3AECWdOLyb1WVdnzA==
X-Received: by 2002:a17:906:f8c2:: with SMTP id lh2mr2265076ejb.302.1629182923381;
        Mon, 16 Aug 2021 23:48:43 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id a25sm337196ejv.91.2021.08.16.23.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 23:48:43 -0700 (PDT)
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: ADD_ADDR and fully_estab
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20210816172548.2339984-1-matthieu.baerts@tessares.net>
 <4c6a722-d7c6-64d8-ddf-cb8d869c342c@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <98e667a4-3b48-cb22-cd48-56e319daa514@tessares.net>
Date: Tue, 17 Aug 2021 08:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4c6a722-d7c6-64d8-ddf-cb8d869c342c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 17/08/2021 01:53, Mat Martineau wrote:
> On Mon, 16 Aug 2021, Matthieu Baerts wrote:
> 
>> This is the v2 of "mptcp: full fully established support after ADD_ADDR"
>> but now we also make sure the HMAC bit is present (patch 1/2, as
>> suggested by Mat, thanks!).
>>
>> Matthieu Baerts (2):
>>  mptcp: check for HMAC presence in ADD_ADDR
>>  mptcp: full fully established support after ADD_ADDR
>>
>> net/mptcp/options.c | 10 +++-------
>> 1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> -- 
>> 2.32.0
> 
> Thanks for the v2.

Thank you for the review!

> I'd prefer that these are squashed, I don't think it's important to
> change the single line in patch 1 that just gets deleted in patch 2. It
> wasn't my intent to ask for two patches in my previous review, if that
> was a factor.

Sure I can squash them. I initially had one single patch but I decided
to split it in two to avoid adding something like "oh and BTW, an
additional check has been added" in the commit message.
But fine to do that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
