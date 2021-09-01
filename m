Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608B2FAF
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 16:28:26 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id g21so4678985edw.4
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nPQQPEgL76Uexxt1Tobxe86d35qoW1sOIbL+zD1M8Jk=;
        b=V0SxpQoe8kzjw15bjrTAP90BvkN9HvzHQ8+/Wy1j2vgK69Y7L2fGJGObPSWccyg/pl
         WHSeBcLyPBOEWnu5PXcbel0C0GZKFEOM2vcBlVdyO9Ye7X++ny09DZqTNLPwi4XOwbK4
         nlzR+Rz4TyMh1kewNW/8evx3jBv/nFCcqKZ720WyqTRnrJ8g9q9dt0GjVR8VnxSr2IwR
         r1AHsk1cAGv64e1sLPxHuasJa3wdxhNl7zYaxwmAhC7emZN2j3gxFbYIXi4K+Bl85D1c
         aBce+wYqBe2/cKcdgksDK/rgJ1EUZirbpD1pePQmU13+INn9jxIxPcvcRdy2VoyKKyLl
         oHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nPQQPEgL76Uexxt1Tobxe86d35qoW1sOIbL+zD1M8Jk=;
        b=ZjEzkAI20Mpc8oLyD+v1LZCKEP8ViY3lEcvSPCcqZXZiBJoq5Q5Pz3npiAgLuGg807
         NQLjGZ66rY9IWXrH0lGldNMHbFX5mqVo5zROfCV/CoZc/0Em0fpRvvJFijaB6+o+9fBq
         L0ZRxYir2RezazUNNJwzGWb57Us/kzflSe8LA3+NCEt6LvWUn3Y05A2nNVboNxKu4KJ4
         HSPfaecEsTcbSpnMkj97rTxACrkicqm7vlbOEK5HyIEW8cBXopY9aggv7hcSj22Ir9fj
         OFmdv5vLItE6NfnROPGmOPPjJXfcqO7tE+QE9tuT8jZn9bNBCa/m+M3bgm0cMsg0T4pl
         SUIA==
X-Gm-Message-State: AOAM533gHK51lESpu80z+K1i5LWvS/I0F19ptK8Dp+A+qLcjYKWUTfTK
	Smly7yFczUnFhmKi1O4CvIllKKPJks2t8Q==
X-Google-Smtp-Source: ABdhPJzHM4tu9y28fr8VLR5KY3IaXZLo5slMj7lDk2cYWea7ygnm4FHGxEYzhP2DMirKLrjtzjBg/Q==
X-Received: by 2002:a50:c94d:: with SMTP id p13mr460813edh.246.1630513704435;
        Wed, 01 Sep 2021 09:28:24 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id ee18sm98378edb.62.2021.09.01.09.28.24
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 09:28:24 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 2 September 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <270c3873-d4c0-cd48-dba7-64e58fcd07f7@tessares.net>
Date: Wed, 1 Sep 2021 18:28:23 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210902

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
