Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04670
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 15:29:49 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id r19so1019288eds.13
        for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HId+RTntnOwsfgR2ItS3jTYbo6bsszZtni1UqoqMOWE=;
        b=mtEK2wzQhupE8Yy0bLf97gWX2J5ILO7rXWeUt7X9XM4+/D22o09OKXONmfBkPr6w96
         3bQskUR8JqAMgH0aWh9YKA2GjVQZkpEFetLCvxZo9z4OFQoxFzOpHhLcCeh1TdEcCC4O
         vzz3Y/lLFAsFXCmScAKQcx5wPkwdJ3l44NxUulehayyRllW+LR9kDBJu35JYWitJOv/R
         /0IMneU5ErLG1E32RRqnuFhnOdpIjcwoYWN3fHis20rOMCUvvUtAAwi9MTwwimW4AMrF
         qJrU4dfcR+VO2Dsw3aMfTgvGoR1cIY5wGqxWqyu/+SV6QJzO5Q8K6mlOR+swnk+ohG/W
         KjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HId+RTntnOwsfgR2ItS3jTYbo6bsszZtni1UqoqMOWE=;
        b=ThtOFf6vogHiVpEqhy86Bnh1T7B5xo8vqwNdHzY5zcuOoDaO2JJBc51A6UeOupZP7A
         yWcloEf/ckUvyt6WgCaqQEznKhXeLP0cWoLZZI7SP87Zc5cixpzHZqHn5ozYh8vkAWCo
         drcZsOz7hL5aODUnH060dtR3jLLRVqTB/Aepg7OaKoheUX3piCk0YV9jnWUpne0opQGC
         la62isj7VvpKMQR3PU9mB1BA5QC7d0Mm4HrDTrfxEYnPJIqOdonuDj8A8gXTJWysVBoF
         V81lI2c4EkF4ZdjAPI8H4vSBw6RLU5uLWtSudjveOgh6j3yxEhaKNIxkKl5Lc82dkAKR
         HJ9A==
X-Gm-Message-State: AOAM5339SFnPuMguGW3qwvjEUKG4ywG/l/35rFyfTQddTkVDjY6KM3c0
	+W3vm6ihvXfoizrDIkXivjs1LNk4lyspkfas
X-Google-Smtp-Source: ABdhPJxxPz+Ff+jv4Yki4dzvmbXwYTvzp5RR3SEv4Vd1eDmKJNZmQ/CQ6Vt5+2kO8fvtGPjsW+Wjjg==
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr11806797edr.9.1628695787180;
        Wed, 11 Aug 2021 08:29:47 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.139])
        by smtp.gmail.com with ESMTPSA id ee11sm8742908edb.26.2021.08.11.08.29.46
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 08:29:46 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 12 August 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <865a943d-3e7b-817e-3bf4-2531d9ff574e@tessares.net>
Date: Wed, 11 Aug 2021 17:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello everybody!

Our public MPTCP upstreaming weekly web conference is scheduled for
tomorrow.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210812

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
