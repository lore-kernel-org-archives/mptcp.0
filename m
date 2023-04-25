Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A96ADC
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 15:25:20 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-2fddb442d47so5409576f8f.2
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682436319; x=1685028319;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYVUhA9xVc6QTWZE5Rfgd5ZYE6G9iGXKyrDDLHoPch4=;
        b=0xNh9sDF4arBW8rLSncEpwOJ7f73lR53SdAQHVBysBl4HFd848A26H7C8+DdpC9QBt
         exGYYleQDtshxNRFNqRxUY1hwmCplZBreDfTZbvDigIbSe3qVlnVwRMdFjoZZ7/3Sl5K
         epGagkPrRaWlXt8BNdMFcm7RegPhBGEmKyCNeN/jsu9TKP5s/8y88JosS8CNGsOu92FE
         L9zOtdiHwKgIqs1rW1ghaSm2g1JNEe/8ZiDuzbIaH2iPm9CcRxXFCCMqCK1Xs6h6LjEA
         V/hVW/T95eJVs50duuqUH3bSkxV0UO2uvpkzdzqUM5BvGnWKxlL+QESN0yS+4nrrOWdQ
         CIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436319; x=1685028319;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYVUhA9xVc6QTWZE5Rfgd5ZYE6G9iGXKyrDDLHoPch4=;
        b=VGJg7xt8lcp9HVxO4GkFUvwN3kBHyS8dL3Lk8duolALdvQHQOJXwhLCxwUYfo2GXKH
         nnRWcRMe9DQoK19ptT6IeU8tolcisEFUhSEQDYsYv37mmWER+MxbgMJBtSno9TVdeHY+
         YZikTiX6Vp8bZDgboZVCeKBz0gwK6pZKrumwXcixs3B6d3ythyBxdIHqvdER/CPJz40N
         tfUym8BUSAKHBNJvSZD6HeMAhMrockRqY35o0t9iC0e9bnTcclBqCMkd4tm9SrLJy37M
         Kc4MS9a3mrrkxyGiSHzraHdVwlL4/mjrjOCWS+yj+prlcPAf6rIwmWBJmExbje7teyn5
         RLQA==
X-Gm-Message-State: AAQBX9d2Ziok5oD1+AjKbIGPCEPpbtwuAQ2a776R5wQf0OHFLvGOWFYg
	oVNtXZJCI5Aj7gBu5chu4f8FDK/XS7I0PqVzvCBDpg==
X-Google-Smtp-Source: AKy350aVTeaxTBboQWbs6DD94eSrraZHqqAeBD7VzVB/eUyoRRX6JXk+/fplo6DRakTB+JGUWyFw1A==
X-Received: by 2002:adf:eb0d:0:b0:2f4:62cc:922b with SMTP id s13-20020adfeb0d000000b002f462cc922bmr12202910wrn.16.1682436318873;
        Tue, 25 Apr 2023 08:25:18 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d474c000000b002f4c2ea66absm13353998wrs.85.2023.04.25.08.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:25:18 -0700 (PDT)
Message-ID: <62242600-e201-024b-5f64-9360910c0fab@tessares.net>
Date: Tue, 25 Apr 2023 17:25:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v9 4/6] mptcp: export remove_anno_list_by_saddr
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682409247.git.geliang.tang@suse.com>
 <1b782af3035e0c727ad25e9a51488b25729f099a.1682409247.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1b782af3035e0c727ad25e9a51488b25729f099a.1682409247.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/04/2023 09:55, Geliang Tang wrote:
> Rename remove_anno_list_by_saddr() with "mptcp_pm_" prefix and export it
> in protocol.h.

Please always add a reason explaining why this commit is needed, even if
it is obvious when looking at the series (but less when looking at the
individual commit).

Here it can be very short, e.g. This function will be re-used in the
userspace PM code in the following commit.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
