Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48070
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 15:43:03 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id r7so3287609edv.12
        for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mmRyIxITFoJv3LEUvZ4ksYYQ4EhCQY2QTlKqSKID7vY=;
        b=VLt44TCy1tQBk7zybKnFGNWKh5emEMSluX0EdgvJmFdRdn3By+fW/1Dd6HnXQFSqka
         z9srC8tCyAox6py9e4u/afgaJh4Z4vO33CWSja6zYuKwG1nZLyBFx3emGiezjdX6y7hl
         Iir8U3TMBGZBsQTEKQlh+zin36avD+SZDh/WTRvW4KZE91a5ylbfRmjcoQwoL9OAWR9F
         dUc6E1PgEkD659dbkkVpQMzzzCbxYD0TTsdpx61nQvn5OJlnsZknpzpIfbop0OuAOsNC
         K8joQAP1Xgfk7iY4RBuWQOmApXNq1QN5iBUXz6M3ZKbC9+Q0Cq9GHR3NF2L/pkMIoKc2
         kwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mmRyIxITFoJv3LEUvZ4ksYYQ4EhCQY2QTlKqSKID7vY=;
        b=hQlnFWkmlzwp/VQwWKLyVOMCzBgyTOB9fiBLPGG0BrGzS/o3GorDvHhnpZGezFadIz
         ArFE456Iqs66gHgXKvg4MZ0rKs46bTU9rLK9F/eIbfbjpXqb8SvVEvH4INWpm+shE8P3
         9J1i2mtBbMuzdvQKNZniG0jYoCMBq5t02p0ppdeO73gMwMHcyMXjOWYiGL8Su5qxgS39
         wBPa7WbXHZIJiHIKF7OtZS7cY7NBSRwqATlbWsQXaBeNZZ3EoU+zixrbl64mOHRa9kzE
         10IiWodqaYn4qJeRIjIpYtUIxQXYA9yzf9aD3xWFbbGDt6wX3yfxWrrpbE3TeOyVl86w
         av9A==
X-Gm-Message-State: AOAM530NMuyNjhzeBVVm0srneo/YJy68Nlxr8JN3ACJBmLAkJpyZhHu6
	GaWgBh9AFp+aFar3NJThC3SKDCrCp2yh86ZH
X-Google-Smtp-Source: ABdhPJxe1TO+5Hh7ZYq+3LIvF3Bkn2S12hOF/L0nEIIwYW0bntSXanYYoSiROCEAWaMnstgUsb0qhQ==
X-Received: by 2002:aa7:c7cd:: with SMTP id o13mr271138eds.269.1623858181988;
        Wed, 16 Jun 2021 08:43:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([72.11.157.83])
        by smtp.gmail.com with ESMTPSA id y15sm2004326edd.55.2021.06.16.08.43.01
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:43:01 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 17 June 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <73a718a8-697d-5b22-b300-2225956180a7@tessares.net>
Date: Wed, 16 Jun 2021 17:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210617

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
