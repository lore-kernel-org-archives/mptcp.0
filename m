Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70036D0E
	for <mptcp@lists.linux.dev>; Wed,  7 Apr 2021 15:27:56 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id s21so3595500eju.8
        for <mptcp@lists.linux.dev>; Wed, 07 Apr 2021 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+Eu35afXUfq1SwQQ0TLwOcBDTpPMsGNWhdRf/xMdNoQ=;
        b=eBSSuXsxMteLgshYHlm0cH0S2sd52m3GM77VjaJ6ycyiJDzRnBk0KX73NNR9nKuKli
         T4Jv0vGCzauOd06Ml4RvJ/2QDIXOt5SUurrEIwfx0RC2clqD7W2yAiPSjPr6oOQ9ooYr
         IakQDcWYQ+XkMbCHR4u5i6ZDZwmubKaWhSbziBktgB/qrMFU9+ZMrs1mdE6opwmFRkly
         suA4zph6XSPMbAfXC9sw4r2fO6cTeIh5ONj5xM1lzSMg+qFZheDgTNz4SxMwMgBlsIyo
         0SQBT1aRkJSiJDwbGVHyLCHADxp1CD6tZbN/nfc+u2g7W+6ALxJHCUgX1GFMdKUjZ+eY
         T2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+Eu35afXUfq1SwQQ0TLwOcBDTpPMsGNWhdRf/xMdNoQ=;
        b=lCPxDPUufqm8SwRxSWwJT/7tJVMWmU18xz6peBwkiBlAo8ymsIPTpX3i9BMyHL4Q3w
         nISSt39s+CpzU0x6Q5T3XhTtq8NxHBT2J6aQWBI+yDh61CxmcfMjPIBgsHJLQsqYrszG
         R6/HArd6ruqG/aKNZkmzQLqm2bVtddm7Lh+M9XKvKhHoHLg3nw7n0nORWeDsz9pxwYF3
         xo/mW5wI9WQd3L7scn/5TaeCfGGQooUn0ZgMHCfAbOHJ/CvXo8DieW3cIpc9HSlKmK/1
         6gm6dlkn2wcr0hXA9Q7ndZrVYB1/4hA219Bsqle1bgkzUqRJCyMAOygGHswneXRax8e6
         f64g==
X-Gm-Message-State: AOAM531fNWBAriWRaqH8W4HUcMFvNbP4ukrUM6wmGOKyB5rZ0ylraNv/
	MZPrhwyTZu+WY8smKjVm2qG39KziO3/AFg==
X-Google-Smtp-Source: ABdhPJy9v7aewKs4JGSSk5iftpKA90hnypp23cgSgwtGgKX+NF6EZu0fbeGmg0SBy4kifREvkkTx8g==
X-Received: by 2002:a17:906:552:: with SMTP id k18mr4213509eja.508.1617809274991;
        Wed, 07 Apr 2021 08:27:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:1164:2c6f:d233:7afd])
        by smtp.gmail.com with ESMTPSA id u1sm15570128edv.90.2021.04.07.08.27.54
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 08:27:54 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 8 April 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <f916e3e3-468d-f171-3c3c-12f3fa827539@tessares.net>
Date: Wed, 7 Apr 2021 17:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello everybody!

Our public MPTCP upstreaming weekly web conference is scheduled for
tomorrow.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210408

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
