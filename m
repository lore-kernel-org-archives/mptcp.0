Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F670
	for <mptcp@lists.linux.dev>; Wed,  2 Jun 2021 17:02:37 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id h24so4930699ejy.2
        for <mptcp@lists.linux.dev>; Wed, 02 Jun 2021 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=l42GfwtIohTN307WgEBVoPqDdlAGpquuDdA4DaAydXU=;
        b=hg9xVpu9HZFq1C2bL2nlY7qStj/66Z6NkwJ5EHOvnB3emi4c+mePZEqb8pBLOtxzA2
         hkk+JcNXpho1mm9JU3G5otHBTk61bVD56LcstUzZXdv0xpSbegymGMiSwnfTm9PjqCR6
         LKNAjyGXEOzfiV38GCPBsULTunmzjT951NgN+QalGvDOzBdpRON8y+aGvnWZ0q+hOLq9
         hMDEMWZsqj+jjGpmpduyU0OZk6OeKk6946cLeYWRJmHV9E3Q32dzpaIXN1enHk34OMnZ
         +bpzJNbzMvVPGM1IDNN5UaJ4n9f/FmRmJhmlA9ZAOP54AM/2fP57f3pH1H6jjfIG8UO/
         Cchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=l42GfwtIohTN307WgEBVoPqDdlAGpquuDdA4DaAydXU=;
        b=Jizp1OAZoZ2Ejfw4EOkVzxrNhhB4s/gxwA/shfxasfW02Dqjr7sXgKEGKIU7Xo8XUJ
         0enZ4ugjDz5hQwPze9xf9vpw6Zoinu8PJKv7pQAN6IPJPQ/0A00IiXe7fgNdl+BL81+i
         zNowLWy8G27jVtZTo2yAQfEBMJxqRY1jJ7u8Yd47TJ1jAPgO6BwyMDJNpLAX0Yaku9Ip
         /xveYo1NAR24DwhNRfDz36CsRovdzL0HtqBvbBmSV627Aks+mTkitAJehRIdP9gk27kH
         Na2ro/XMCCw8T0NxBW5xPo39ybkKatgLVCbgzuwHMhcXQaWiLC5DYYlpL4hf98BZDejH
         GKpA==
X-Gm-Message-State: AOAM530JXYYRBSViZneGHbNIAKA46QeYSyMAWiw+Z1e/qttinc/j7YtV
	texpQdRuyB9g8lu8sRast60x7kNu4qTlXozxfCA=
X-Google-Smtp-Source: ABdhPJy3naMMMREIgReszBQJWYmJZ/vKgtR+qEfDIFhsnLjmVu1cG3J070d2O5XJee+Lg2oM1cxu9g==
X-Received: by 2002:a17:906:bfc8:: with SMTP id us8mr22810222ejb.217.1622653355935;
        Wed, 02 Jun 2021 10:02:35 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([185.212.171.140])
        by smtp.gmail.com with ESMTPSA id dk9sm278926ejb.91.2021.06.02.10.02.35
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 10:02:35 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 3 June 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <63504f40-5832-1d71-8f6e-4b56725c687c@tessares.net>
Date: Wed, 2 Jun 2021 19:02:34 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210603

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
