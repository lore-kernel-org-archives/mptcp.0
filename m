Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABD72
	for <mptcp@lists.linux.dev>; Wed,  4 Aug 2021 16:17:56 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id d6so4245799edt.7
        for <mptcp@lists.linux.dev>; Wed, 04 Aug 2021 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=abshqfyqskHRR5kikMQR+NFjmqbP6T5BZlqzuDfOAdg=;
        b=mssqqDggrqlZaiX7EP70Yb8SypaXB7328JjIXWQhA67tycgcUJsxgi5q4jhWoLuYhH
         TNx+rN+kk3tTYoMCXOL4hsjMt1/iHdp/WbIjQUGflJbs/NlPmULxg7/icJQBa9BS78aN
         cgoRM7b6sqOghYnOzbXH0WXG4qjxz5SSE7mDIJoGs4wFNrzyf2jFGU9vmKbxW/LqPEWQ
         XMPF8yPu/fgHGLDpjJ4iYzvjjF4UD4VdpCfqt6kia6j6xBFjF0t+gs6CEs5HRkRIyJ45
         teZ24ArglMSoShsatqoXMd6RaiWE/eor2VhjkZduviHs5wrHfsyNLjRexvRffVp6RcvF
         2ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=abshqfyqskHRR5kikMQR+NFjmqbP6T5BZlqzuDfOAdg=;
        b=un5ski9hdLS8LtUpG9n5cPjTcOolzfF9KEzsAADoV0wCW+B3Xe6ylKP6VYWCbamk7C
         5ZDX5+mLFU3kRMAxQX3WoqNRY1nVQgJpkNd18wdkC29Fnq6HXKmbc0KwjjDpl5vcnFn0
         2tUMYidQg85iBwK7/lYlochXYA8DYDVveC4DZoLqluUklG8lLfssC/sOfz9vFVYIcC3Q
         C4rV1o20g/+nR7zXbzpjdUNCCZIukXs+lb/1twu1FhnjOdARwWl6oGQ4WibTGsg1KA0e
         zs2cLs/hapSJoOA2gggz7dQgvX6hp168cxEzLJkPQ2vUhBDKPCzTds+xrlZnT0EkJtcc
         wlvw==
X-Gm-Message-State: AOAM532lJTzElpY34tvIYsh5fpnb/zBMy85RCRh5NWbNJjNx1Pl0W9Fn
	wJStTPKW/uFGKepEtcDb8u9fM9sCwgvZnlwT
X-Google-Smtp-Source: ABdhPJyeQGYHgVEaWzg+Y/zdNcCfEfyUySRKrO3p/2O3o9Qg3W83r0tccBWH6s9jElLDxsokxdQk3Q==
X-Received: by 2002:a50:ed14:: with SMTP id j20mr589703eds.323.1628093874541;
        Wed, 04 Aug 2021 09:17:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id r16sm1128312edt.15.2021.08.04.09.17.54
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 09:17:54 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 5 August 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <9703ca72-26e8-6ac3-9508-8f2f301fbf80@tessares.net>
Date: Wed, 4 Aug 2021 18:17:53 +0200
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
tomorrow.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210805

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
