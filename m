Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80D2C8B
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 06:43:57 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so634136wme.0
        for <mptcp@lists.linux.dev>; Wed, 20 Oct 2021 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=prx/aRbrP5RsATfxqgrRBvFqnTyVywAozpyC6SHaVuw=;
        b=oJqIjzgKBrD2FZeCf27C0HSWjaIOrfQqzTvrYDvikGkI1FD8e2O2JgC88VZRXroUBG
         AV6dwOrLQetsWLHryn7cO9b4OOJrmTD3cEFXTRYawqSTXzkKWv3HVPD/mEFh9o8dHCm5
         5LFmr97OoXWZYm6IgmcJTp6hLgXaUXPbT3PQTBPGSP51JA9FkaT8HF2qbWXQWKmRT78N
         fNwxkWEGrUZy1PMKUwYr+5qV2ZcW0x1r1rgV/XzN08PXPHyn2qxFskG1zYeM+hXfcBnw
         guBlKKzLxEtWhXi1GPN39t7jEeRUHW6YDY5lLcM52BVO1VUgXLqJ/24E94H99hXoqRKk
         GO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=prx/aRbrP5RsATfxqgrRBvFqnTyVywAozpyC6SHaVuw=;
        b=s0n4wAnsl2h3UF8JGzzFBeJ5i81gGXmolnUU/rFd+LAArEzhJcWAELYR2vfSA5N9c0
         nJ4fSqwrINme1VrcKRjlqruvRo5AMElod8GngtninGdidSCqhqwW4PLumHBgRPF9Us3r
         YEypyQVCyjUoJgqKnPiBFY+zGj+JRU4d1+EbPcxMadp03Msw5VDLi4lrmSFl3MZ6OBYu
         2ONvYDmXUNAHPaCpnW/ooAh20OSKQcyR0ycEfnh1wyI1QjJDxSpO9A29KVLZl8Uyztu/
         fvvVRvREm+WX5uctVgNyzhBp57hUmeWR/4qutDgf/mdwEx3ZC8gBp9AmBuUghP+odGeL
         Vuhw==
X-Gm-Message-State: AOAM530ojMFjAqv4+VL6HeGSTLbfta3zAQaT3GpeDuoZqTVdzI8sOghr
	bzkmKZPVk9EVM531M7+seJCsbDcjdfBCXmhwqQU=
X-Google-Smtp-Source: ABdhPJyEV82YD3xv0S7CL1OqtIlAqbRyZqBS/Z6hxmF0tmUj4vw2oME944jzRkqBlAXOIIYI4+yscA==
X-Received: by 2002:a05:600c:2c4a:: with SMTP id r10mr18862321wmg.166.1634798635967;
        Wed, 20 Oct 2021 23:43:55 -0700 (PDT)
Received: from [10.115.214.32] ([185.232.21.142])
        by smtp.gmail.com with ESMTPSA id u16sm6190666wmc.21.2021.10.20.23.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 23:43:55 -0700 (PDT)
Message-ID: <61f650a3-196c-b4f7-ca81-7500e3480d67@tessares.net>
Date: Thu, 21 Oct 2021 08:43:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Squash to "mptcp: infinite mapping receiving": Build Failure
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <39044f0b1da24b4228ed186a751b893a94e9d56b.1634796076.git.geliang.tang@suse.com>
 <d4f7f2e7-c837-c5bd-a6b9-da4a74ead0a8@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d4f7f2e7-c837-c5bd-a6b9-da4a74ead0a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 21/10/2021 08:16, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.

That's expected as Patchew applied this patch on top of the export
branch -- and surprisingly, there was no conflict! -- not on top of
Geliang's "Infinite mapping" series.

So please ignore this report from the CI ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
