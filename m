Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A7168
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 20:46:37 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id hr1so5490051ejc.1
        for <mptcp@lists.linux.dev>; Wed, 07 Jul 2021 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oRnzPqo1PoRlwpHJEVOUcvRbEfHX3ENigW5t2zA8Lsw=;
        b=V84vk99u26vxR8ZxrFFGCNOnLNTPTnssJxJM+hrcpVeUj35Pcv+g5OEhG4cXp0xW8d
         D8xr739KHR7NOCXNuepdbYWQaIH4OT7UlaLJeDn4S+bxLyGMMuFiH4DZgI2MHl2au7E8
         6O0Yng0nT7Nlmx3Vf2aPmfUo+oL/8zLRtU8ybWjxfTe6ik5XKTgm8Y+PASYBMwkGZcNp
         iYCXAuMQ5QiAANOYONqOSMoOQFOjBeFjcRwAkvzDJVFgMILHSbKOoxtKsz3cGQiHIvRn
         htNlC1n3ZkuxxQeBScVZvEHnzyiIddwOLjSXu00aI22WYTo0TpGFklWK97/RvXCbC96d
         2MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oRnzPqo1PoRlwpHJEVOUcvRbEfHX3ENigW5t2zA8Lsw=;
        b=ccQUfi/jyR/YpbvXhiv8AKtC3dstEBVJLbO7CNBpMGPqHQToHWqCJfqBmFguHAfDLe
         cENo/SAeWsGuwjXnq0Wsd1nyLGOCB9EjsNQeddXFRQ+OREZePlgqLQ+rDxe5yomVhogR
         pSx5tsHXagwHqjVhdCYHn5FLQciBpx4SBEzrO4rDOgRcvpi9gyzvUvmvLtQl6L82UXWm
         YjFrbY5GT9Kxui1Oi3s1YGxA30zGZCKLtgNymNtqB+O5hz62JDQ2c40bQiXoDX+r2XgP
         J+11ZXlL77J7WC6STIR6pt/AaKIAgARjEh/zXCQ5qnubIgAutIowBKpD/iMNsLNVhftW
         lDRg==
X-Gm-Message-State: AOAM530tluPPCwxc4TYcoR9iyGcKzS3epOKUgeZ/aZHBAjDN57nkytJd
	TW/xxIH/8agLLL/G6Q8vblmdWQfXdPoNxg==
X-Google-Smtp-Source: ABdhPJwjuPlDwgJyW8Go4V3Gkb3W7zgr3KPlFL4NmVGuer/0LLTQH6zLhVwoAsbtgmdk6+s5DoIPkg==
X-Received: by 2002:a17:906:6bcd:: with SMTP id t13mr26914427ejs.551.1625690796123;
        Wed, 07 Jul 2021 13:46:36 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5a8f:f0b3:83fa:8d98])
        by smtp.gmail.com with ESMTPSA id p18sm94777edu.8.2021.07.07.13.46.35
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 13:46:35 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 8 July 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <1648a5b0-d1cb-82d9-0cfd-d57b5bd05a47@tessares.net>
Date: Wed, 7 Jul 2021 22:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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

https://annuel2.framapad.org/p/mptcp_upstreaming_202107018


Feel free to add/modify topics!



Anybody can join the meeting using Google Meet website/app/phone:

https://meet.google.com/edk-rkrk-vaj



See/Speak to you tomorrow!

Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
