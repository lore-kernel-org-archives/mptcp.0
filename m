Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8629CA
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 15:24:26 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id my49so22377995ejc.7
        for <mptcp@lists.linux.dev>; Wed, 09 Jun 2021 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=uu7xmAxzO5byP35taNS0IFvGzOcfvLriGgdm5yt1gH8=;
        b=C/Uet09Lgz7BU4mUQHa/O3lwj9d9SFl978RGP6IhJjxST6O5Aw+yiFaODUDW7W4O1E
         iod4/5i+ved6A5KqVSg4xAjOkmF9UI/1q//sTvtmzPI0e1HyR1g9SjNmYuXKhY6fyjwL
         fr+qg1Uq8FnYZBDvNm3XCq1bjUMDBKk2tjj2VBrscLaVEjTS58PsvBwd6YNrQd/1AEa9
         CIjr014c8DCO5lvQSLbpVawcIWqcsSNZNUzX4w3tY7W3s2f0Xh8zH0G+083UY7dtb3/P
         Ec5+yTxEWrilCM1P1b/vMf2ZPWoj+GxB2/nljAuVCgE1cLnLnl/KG3+ZbfQbmvBBwRM2
         lNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=uu7xmAxzO5byP35taNS0IFvGzOcfvLriGgdm5yt1gH8=;
        b=Bnn4HiDThdGAkpGXrK6dRjFsFBej3T6sMMXD+9DjfQZtzQKZIqGZqXelcAEd+flVOv
         fBGxF3rm6UknioThPisTk9tONfG7B/SE86p2NK2MYtPOoimwA/i06gfivzvxz71MZmxm
         Z+pQYFSS+Ye0nia/dN6tgr87GEGenb+V6VInYZ/Od6BozNn1PwXihhGd+CPUdIjRl8S5
         OjDUgjPRPjb6pZsMnj7pKH2wRreT5nEVXzCZndLJ70LWxlKysXbbLwKuSF1dbnHroExd
         kzJ1gpFEUrrl+O86dZXWrLZRBzPkUODMLwUw4QAbpz6GxaVkXwfoFcNnVaqG+l28OCeI
         KuUg==
X-Gm-Message-State: AOAM5304RWeSWnva3Hlqddnuk/dLbT3AKiLxDp47dfzwqUztjOZOgNeb
	GSMk2lufDOsNk3uUtHAxVaJFhjN+/jISGw==
X-Google-Smtp-Source: ABdhPJwDSgcgbCNlGeZJ9xhLyBPaOxDJE2mDvwwXdBxXEZ3Uia05QIS7QLiwTqqWMPYR/wz3ZcOi2A==
X-Received: by 2002:a17:906:988a:: with SMTP id zc10mr443476ejb.62.1623252264667;
        Wed, 09 Jun 2021 08:24:24 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id g11sm28406edt.85.2021.06.09.08.24.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:24:24 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 10 June 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <e9110522-ee7a-35e4-80d7-a3177e889471@tessares.net>
Date: Wed, 9 Jun 2021 17:24:24 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210610

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
