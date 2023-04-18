Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EAC1C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:09 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f173af6712so16237905e9.1
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681831988; x=1684423988;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxusbDQp41kNM4kNhFSkLWCSNUfiFFVCagpvx40Ti6g=;
        b=kGSKpmj7ctlwnHSgBGg/PH+vfBlQfFFfHhzHK/6DP9T18m56DEMAQv22vOPhoF1nEH
         xpPOLU8Rv96s0pU/It6HKp/R2F7qMbBY5n2b0ZXKVIYXIVH5OzEvo3zu6YOkAeg8ElY8
         /PhCijqLWL/35mb92cQWd1CFi5Gu3MmGcj9hGt4Z05XWgr7suhDWGYLz/rWS76PjiKb3
         0DEiLLkB5yxljJAUuAYRc+7ss015vvlYfq982ICqdEzmGJMxes5kF7ADUHyBWBKaiTva
         AbcIJO15uTiCZHaOw29mLd+OrHn1rUPuLbmEDpYZkQ55hNBIsd3SMwh5kCD4Mm310bKN
         dY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831988; x=1684423988;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxusbDQp41kNM4kNhFSkLWCSNUfiFFVCagpvx40Ti6g=;
        b=G7H60wEjKqYC9hdviFY825eLqDA2KNcijitTXV7fmpyF4H6Ez6Oz4B3Wqyl8Ii7dEP
         GRmqtDmLlfYynkHAxejla2OolIEINlcoPJzCN/wuK4IlHZ4E4evSKUbsBI6CywO1pSL6
         olqbQgjXSbtWVZqwwTRXH3NmQHUBno9TwGdJ6axYvKi/TlrosBkGR5lRzfDi0VhTNdRy
         7UEnqm44tSL0TriHND/2Kf553UAKR24/p9QHlczPpWhRsOiX/MWRlfSuxyEuWOHf02Xm
         YXvsuyIKvDuOuScClBzYwgCCGXO+Cgatm2cjLoEwxzJtlqS5r7Grv/ZVDBuX5vbOcIGN
         prQw==
X-Gm-Message-State: AAQBX9epNWwCaU1WKt/Lj1+Ig2CQBvtxzofIfajMEc0NC4EKy2QX7lbY
	CeL9RxteByD6z+aY9t4AxqNkcPbewxWloYuzjydq0A==
X-Google-Smtp-Source: AKy350ar388bSbO52Sv/zelUvODipBiNR63Ehrc6ZNcysZWiNjxk6WTICyckr3PZlejrBYkP2iNFDg==
X-Received: by 2002:a5d:6943:0:b0:2ef:eb54:4dc0 with SMTP id r3-20020a5d6943000000b002efeb544dc0mr2090223wrw.51.1681831987868;
        Tue, 18 Apr 2023 08:33:07 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id r8-20020adfda48000000b002efacde3fc7sm13378428wrl.35.2023.04.18.08.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:07 -0700 (PDT)
Message-ID: <cd8b2e24-9cd6-fa7d-1dc6-48182b8c36c5@tessares.net>
Date: Tue, 18 Apr 2023 17:33:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 0/7] mptcp: update userspace pm mptcp_info
 fields
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/04/2023 11:11, Geliang Tang wrote:
> v7:
>  - fix userspace_pm.sh errors reported by CI.
>  - only remove addrs in mptcp_nl_cmd_remove().
> 
> v6:
>  - send a RM ADDR from userspace.

Thank you for this new version!

I have a few comments, some from v5 and some new ones.

Sorry to insist about the reason in the commit messages but I think it
is best to have them clear :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
