Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0A6D24
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 16:32:03 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id e14so32322766ejz.11
        for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=slhbdRx1cWnEItIxWi9sLnXlLz73EZgWEOhRPpx+cXY=;
        b=k50TgPid0vpdlacjb84dQ07dOZGuWF/xHmerlC3QfP9XfBKaxqWxfn23ZPppjgZ5vl
         DqCe1z6GRt0+67ohF0xcEMB3CQqjWNJFg536HRr4v4kqdv3NYx0aAX72jAS+0gxTHOKv
         23RJJtL6yVG2zbIs0EI8O2UNVETjdS3Hb+ZpKNYE/xghjCE619VXmI3d0LIT+8FdDsaQ
         I9lxLDL8NIgz9l47djkSnjlfRizRDMtA0v++iiIFzjxUA+MM3xbhKxv2K78g0CTWr0OM
         hc8rV1xOH2ILGmZl6hWoiXhofOXBarfrwoHk0K4Dh+j01ALqjDCwQVwqUjauCilbDVXg
         khsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=slhbdRx1cWnEItIxWi9sLnXlLz73EZgWEOhRPpx+cXY=;
        b=J9ZeAtDzqON9Ij07mRmt+MI+rG5low1Ua2VZzy+NZNX+0Kv7zF4DnlOURVbsluxCgg
         DHfEcI/iVOf2OR/Gh+X+E4f/KFCzdRx4R34EnghCBJ3Tzik4BPiyagYkhp9p/dgUCKaJ
         b00SR1l7Z/r4OjEZiyMiuJshhhLaZjnUAPSmREMg2lKUKc2hU5gtdAwUh3yw/jA3NRAI
         lyka9mlSFvWS5jODj8AHzz4MijpsIq91MI0vjmUuWroEOc5FLLWpEGjV2NxDJ/IK2hwc
         OrYXaGnd+YT+FqjYHBjZKFn7UksrY999UgGf5ToAkK9YxTYD6Va4Y4v74bdHNhwr2M3i
         k4+w==
X-Gm-Message-State: AOAM532Tx2F4RFnLSs9NdXqlvoYveZ5Y01nOff4gg4XNxCLDFlOsNya5
	bFVC0f+9N/4ydC+RGOE2Du1fTp0ANOLMwQ==
X-Google-Smtp-Source: ABdhPJxBtC27pcIzG9IirIgVYbY7TS1sag0X5DNklwEPL1P0IhHWUATHoy+kUqt+EoPsWp84otYXLw==
X-Received: by 2002:a17:906:b28c:: with SMTP id q12mr24198843ejz.284.1618417921887;
        Wed, 14 Apr 2021 09:32:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:29e9:f851:10c:9912])
        by smtp.gmail.com with ESMTPSA id t7sm6712ejo.120.2021.04.14.09.31.49
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 09:31:54 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 15 April 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <e1d0b3b9-eed8-06dc-b26f-a3ad9ead93c4@tessares.net>
Date: Wed, 14 Apr 2021 18:31:48 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210415

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
