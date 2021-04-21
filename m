Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AA2F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 15:42:29 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id l4so64150964ejc.10
        for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=K7DGGwOrOWiSIwwBFKCCvXfCW/D9rg4xOJz3UHeb1So=;
        b=nvMWRjAzPW9MWdf0t7InWTGjIcYVxwBKQuC/jura4rzO9y2FW/c49qc0Rh+8m96bJQ
         YTnVevBxBOKyIosjAPaBzw6xOBFOUKVltL88NtEQrAI2PJyM09rBP70PmeYFlZhCb+rY
         qpo23M99ZfWdGliznA3v8gjCiYFI6sayFKPhX4OHUcv+LXMfmey4EaTAWhK/lktIcoRP
         rs9O1K6taemX+vtZ6URGnZ1TNRrWdS+viHinqitQwp4F2N5v/JWfqPitvHNA8Qzb+nje
         YeTK4Apwu4ZytmyXU6Jf+eBIOZkrN2EZ+PkaiHS4Kr9GjH1I3z5jc8GKKTyRYJ3l91Ec
         nJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=K7DGGwOrOWiSIwwBFKCCvXfCW/D9rg4xOJz3UHeb1So=;
        b=aH5xR4CJYXazghSpdoy8k8BMGkesKfX5RP+R8u25+DCmPg1C7bnH63cE0tKgHgHXLO
         j05sfrmxeVnIdTdYeP0mxcA4aozk5z2m/PwJG4kYGsn4ms43NQBAIKHhqWfEQTTSKNvC
         07zEZ4O91bD4CjK4TqnFZ/T2gzmm6nDRvK1ym5wAGZjdyDIfB3+96yYz3Wm1tGTC7WOK
         iig3olnAVBnAuUBD11YVQopHjBLKqR33CsP7FdqPdZFdcoCHlaZHvj/5INEvcVHz46nX
         zFFz8O7884pJTonT2BBVk+9GC31zKL0bjPBvqAqKYxPbFy/YghsDjupK9RimtRAbTQNs
         0lDw==
X-Gm-Message-State: AOAM530j1RrTzfnwaD0j5LXrxGo9fuiuRvXUadDN6LaG++qAVWc14Pu4
	l0AQwmqIIZ/K8uhaxhTobHREJuANK4CKWDuR
X-Google-Smtp-Source: ABdhPJx+yAwWyCXWd6I6V5AeA/CYFcuM/w2t99fx4IR+YbRqvQfeAEnF9CQVy1j2EiOUbmgpyxs+ig==
X-Received: by 2002:a17:907:f93:: with SMTP id kb19mr33071571ejc.207.1619019747878;
        Wed, 21 Apr 2021 08:42:27 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:708a:41af:f01e:2dd])
        by smtp.gmail.com with ESMTPSA id g10sm4314542edf.82.2021.04.21.08.42.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 08:42:27 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 22 April 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <65aba7d7-c7d9-a317-f9df-91b19889bbd0@tessares.net>
Date: Wed, 21 Apr 2021 17:42:26 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210422

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
