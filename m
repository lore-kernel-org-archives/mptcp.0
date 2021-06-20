Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379571
	for <mptcp@lists.linux.dev>; Sun, 20 Jun 2021 06:51:05 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id ho18so23048238ejc.8
        for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TX8taZxY3Q4NmTCHrjOUPPmpsJfsZCqguQQi1ssVqQE=;
        b=xDBTkK06w2KYnJ92mpTIUrTPMIhtnt0W/WDtfEi8WCDg9AFJ30sVjP4r7vvBy0i9hA
         wsHt/6mtU+PZnpNEMr9ZB8xmMOErUVCO1pjp4lx5nfxxhwzjG86QM89jpOrPRo6CC+jV
         6xiASfgJuMxY5SKRAt3ly645LzPAAxq9LHpe68kVsnkXJdzLpoQn2vDB4+gLpB7jxwdw
         nUmuIkc9tSKQWy9wySuba/Fgbf7OtTWxzMZoWsRKtaWg3ec6OrbjTGM192ceQK1MQpdJ
         wHe9buCpTUZZTHVVbcbWALwEEVQUaQMMLXOPdAXU6w15wW4a/aoWJJSo4b7gZTM75btN
         FtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TX8taZxY3Q4NmTCHrjOUPPmpsJfsZCqguQQi1ssVqQE=;
        b=CYiNeDlMSv/fZWpxbxl2S6lklcRkoMMu0/aSyhxPPTeYIZeU/zp1lK9cpOa9BturCL
         219cS6lD2NyjIKU+8Ml6lyMsZB4a7c2Bx12x1EEjqCZ+US576BRMQDNm3W+pWAOtjZgd
         gPZSpvKu/OZo5gXJwO10LaCNC8bKZjnctOUtyepVEdI5XLsWpNWI9p9XhSF2vhNW+VTt
         1l0jyZM6QxFGWlyQY8E2HZDCnayOT/ANKaBnVJWDFrNNWr9u9M68rYOyfeHms0ZmNP72
         bbYxhjLP5ph369ZSwkaRlDPHQzuhjmyxPVYaa3rR8uIMYgJW5oLqaGM7BF/uyQAWrzi6
         lH4g==
X-Gm-Message-State: AOAM533pGglqhQ50xaa6KPXIFm+mjRFA8Z33a6kcGJb33j8ABVUa+OjA
	Dn1JNQwqR3OsRyLNBL7Lh+gXqdJJAur+/yBsb0w=
X-Google-Smtp-Source: ABdhPJyYGH6Y+IN9Ur0qy/BQ43gYQszdJSRk0N2UzeLu7WbyJDsoeioDYeN8RHK1z5y/hMmTd7TyGA==
X-Received: by 2002:a17:906:b2c1:: with SMTP id cf1mr18280067ejb.544.1624171864171;
        Sat, 19 Jun 2021 23:51:04 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:efe0:92f0:2541:3733])
        by smtp.gmail.com with ESMTPSA id ck2sm103734edb.72.2021.06.19.23.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 23:51:03 -0700 (PDT)
Subject: Re: The commit "mptcp: add csum_reqd in mptcp_out_options" is changed
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <CA+WQbwsyZe=yzLsC6tAonfoOx382ktTOugui30vB4wnTmgh08A@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c8332fd6-176a-b9cb-bbba-3db6d90d7f1f@tessares.net>
Date: Sun, 20 Jun 2021 08:51:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsyZe=yzLsC6tAonfoOx382ktTOugui30vB4wnTmgh08A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/06/2021 15:29, Geliang Tang wrote:
> I found that in today's export tree, export/20210619T070741, these two
> commits, c05843b6d4d0ac6b66d5e9f151b3140a015ba2d8 (mptcp: add csum_reqd in
> mptcp_out_options) and 64f0cb0f3851436973c145a05e9ada89baeb562f (mptcp: add
> allow_join_id0 in mptcp_out_options) should be merged into one commit.

Good catch! Thank you for checking that!

It looks like the auto-resolution of these conflicts didn't go as
expected and I didn't see the issue when looking at "mptcp: add
allow_join_id0 in mptcp_out_options". Fixed now!

- 6a02cef3835d: tg: empty t/mptcp-add-csum_reqd-in-mptcp_out_options
- 2c9eddf98b75: conflict in t/mptcp-add-allow_join_id0-in-mptcp_out_options
- Results: eb9ae196ed3a..4affd9122ce7

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210620T065037
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210620T065037

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
