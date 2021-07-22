Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F223173
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 08:01:39 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id qa36so7065343ejc.10
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2sG0Q4LSJRXpxx+SuKm+AOI0VNbGWf8OhAvbEp8x59Y=;
        b=X1jIamDMOW8rJGSlDmbLTZ9D2M4IjVGOidJ7AOpwi6GiSWpoi0cD6dbS4N7dW1Kgtg
         rxtQsMMYd8Ocg/Nowu4eyDE1a9ILhdxpZylcN50oXSFcOkLesiN1FZEOgyNPU0L8dmY9
         BCMdzBONj3eAee/t2nvVD4bCj+uGeRKk6TOIh4AjcfQnucJKGKFzKmE3ZccHFh9q7b5r
         mXz6uKa+anmV5aZiqH5QxCrN1kIPQxiaqqR0vNIsZMPpWuWD6NV6AeCkTwzo3JCOz3NC
         GZFEXqpSJOkTMklXtu/QQWvZj94yHUw7reB+RbEYsrTfRoxrqrqoZg5xTGfxBx5x8G3q
         r+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2sG0Q4LSJRXpxx+SuKm+AOI0VNbGWf8OhAvbEp8x59Y=;
        b=sNgjXnO93WiUnnQiiw6A6fCC/J2sVHmATdpEiY5Y7MAv4iTB/dDYT280hdLnMRuBPn
         9Ej+DQOtYMDBEvRSIk4j9vKeu5m7W/dRRQ7LCnbnr+cBmaBQ8Bypyb8Z1Nj7nV/z75fG
         +/hHdsIeymX9/WfCsg57EzK+OIzCKU09QPWbgXPkBHP+j/YtKrFI4GvkPwvusqs4Sw9b
         5IuPnyskOLcAFx/MAWb1Vmpb2GIuw/CzCuHDmkPzNN7aUndqrPYtW/2TScZfekNvHwzF
         staIWm+k6Cir3ylDluQty/2msx9/2skTlVQZe9wcpogwQiYrsutus2TrZbgSkJUaXKUV
         mg9w==
X-Gm-Message-State: AOAM531gO9wBsIISN1DXtR6bW375nOsJOUjkKtix/MgTD9oQuiBgQQj6
	eovSNfejeTEXqwiHb92D7MLPrITRB2VKynK8fhY=
X-Google-Smtp-Source: ABdhPJxsmW/rArvRIY+yrlsk2ese9Tzc6uAqzrbnMgttPCksrKQGbhdtq8wnN2QCQZcJ2ej9z/3H+Q==
X-Received: by 2002:a17:906:ee9:: with SMTP id x9mr42059978eji.44.1626940898244;
        Thu, 22 Jul 2021 01:01:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8391:ca7f:9c1b:4236])
        by smtp.gmail.com with ESMTPSA id a23sm11999413edt.42.2021.07.22.01.01.37
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 01:01:37 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 22 July 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <f5599f56-d65b-a207-1e8d-74f3be8d6709@tessares.net>
Date: Thu, 22 Jul 2021 10:01:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
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
later today.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210722

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
