Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FA7B
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 15:56:53 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id a17so28692345edm.9
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L/QCchjFroQSAK5G7JWwPR4z+RPOzmKgqFBuFFazdIg=;
        b=y0Rk+VxgtqvL/vIsfTSw1JEzQeO/GN8rmR7p6H7inJTFzNcJi81t+D2lKRie5UHHMz
         CHpxEqpAmGGAi1bZnhls0mzv/z+gXLt2MpbG7WPM7OrAWXxkV3+kJaQcHkVYi6/9M58U
         moNJ/+WPtcI0nwa+bU54XsgPC1Vx95JvoNMKMp2h70AM8GWd8gOvg8JJdRdaWlVS+Wt+
         q5vr8CwQ2RsP+eDONrOIm8wemw2YSkruAzZ3NF1yynaMReEPoXXp9RzANLwmxLYJk5+V
         Xs/2dXz6vHXmnLvz+O/20JlpRt5zF84ApkM62VK4ag3DQLHJir1RByEtfyKNDIlDB4yY
         P8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L/QCchjFroQSAK5G7JWwPR4z+RPOzmKgqFBuFFazdIg=;
        b=OWcflnDcJ1UOPo+Xu365/KLWCTcTdj6L6u4agQQiHZf9xX1tgRYjGPs+tv3tIs3jWL
         1l+CcrFClDLInk8IvTmzO2wGpBgn58p+Pqnqda2QaANJfXwNTLpnoNnV2ehNsXwBKN2Q
         aqhfcQ0T3bh26rcY7ZbzVB6WTOWb8/hlD4uGCeXp+VANJUnv0/pFKLHMIhCw8+1O6NPK
         6VbMqK9ZXxEtPiW6JS3WyisfWqgrebzw5WmfTpiWUwxeLCNo4RKG7+UQXjmd4MFc9/9F
         5OJVj3wZ2bW6kkfAPE3KOZyEyi05TIrM0JEcYw/ZXNV5EXCvqAoNLcVJ/pfBMrPMGTE6
         yPMQ==
X-Gm-Message-State: AOAM530ejvjhHCKUnAlOoZ3EzGr3EiKOG9+LkQGyiAKmr30RAMYY/IZv
	uy8I5Gr6m8Os+sPGaVFbYU/c2iGY71aKYg==
X-Google-Smtp-Source: ABdhPJxKRQb6dNlLXm+A+P5o0NarYuiWyRA+wSQ4sZZHsclneRvQJstId5ObcG1p7/jPhT2jqmaXRA==
X-Received: by 2002:a05:6402:5cb:b0:419:14d8:4106 with SMTP id n11-20020a05640205cb00b0041914d84106mr17359519edx.140.1648742211977;
        Thu, 31 Mar 2022 08:56:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id ge13-20020a170907908d00b006e09a005d73sm7920237ejb.31.2022.03.31.08.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 08:56:51 -0700 (PDT)
Message-ID: <8bf4ccea-7095-0183-66b7-40e19af72dfc@tessares.net>
Date: Thu, 31 Mar 2022 17:56:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Commit logs update request
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
References: <HE1PR0402MB34974081CB4E91797BF80DE1F8E19@HE1PR0402MB3497.eurprd04.prod.outlook.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <HE1PR0402MB34974081CB4E91797BF80DE1F8E19@HE1PR0402MB3497.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2022 17:46, Geliang Tang wrote:
> Hi Matt,
> 
> As I mentioned in the weekly meeting, I noticed some of the commit logs
> of my patches on the export branch became mismatch since changes have
> squashed to them.
> 
> Here I send a list of new commit logs. Please help me to update them.

Thank you for noticing that!

@Mat: because your RvB tag is on some of them, are you also OK with the
modification?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
