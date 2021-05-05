Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAB70
	for <mptcp@lists.linux.dev>; Wed,  5 May 2021 15:58:37 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id zg3so3645641ejb.8
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=o4hYc269H1YL0C9vuY0kSM9N7Uc9YrRGDdjHa8HKU/g=;
        b=kU5A9veQhJ/0rXzX6KvuurXpBdSN+TZwclz6jB/6x2Lq5mi3pZAVPEsL7V6f7mBotD
         HSW1C69O8co2xTaNgtpLZjCxpmxY0tgLhqjZ7q2prEV+ewWFF4rxpZ4NYl/0dbf/fm8W
         VA/LrKPqkQ5ETDp8QV1/gQZLDGMPU3uONsmgAdBkzE8lnNnvUSxL2+n3el7jLNof1IlU
         4T2qhvLESc0FwdWmBj1EaLlA0AcJab9b+yg+Zvdz8C9IAMuFNM8YPvEXBRMY4KAOELX1
         vH9DC4nzBpg5a8+nslLEDxrJitkQPHTsFQX3gD1fKCHEH1gcbc5o8BXfFlEUFZPMMONG
         ltxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=o4hYc269H1YL0C9vuY0kSM9N7Uc9YrRGDdjHa8HKU/g=;
        b=JNSfJSG45M6WClChQAK9F8XZZZXlDA8BuO5JbF9LGCLoA29YLdFmnmG8n1w9GVOxUQ
         O/5RN3U5zsVg0vroAEyEFqHtISpZknMbz7sfLdLlV5A8CStzH7YtTyA8BY7KXn1YQOLk
         X058lBtvI+i4yqh8rgnHg2XqmPYnAaveFs9uXGyycp61dkS5ymHzl7r/t1+E7F7NG0Jm
         okGuvA8yJ4+SZkJsuxDIipmU6v+dxh0Fc0UxXJJwdRVDxdBbJFhDHw36nQAUX1pXtIST
         7lFzYYkQyDOlt3ZXhlJfrn/FRIuen3A0OIZqIiouzGwFohuauOp+YnYZvIDav0JDA+dZ
         1m7Q==
X-Gm-Message-State: AOAM5325oHUSGscnZz5oSBdVP2x+zFMUO48mfN9gjrb//CxlL0CmXnXC
	izT92YLELfm1oT/QosEecWIRCpfxvjTVeZQl
X-Google-Smtp-Source: ABdhPJw9t04MtnC12wwjU6dsAdBwB+cD+7Cz4voKAjxpFyhXC/EfoHOe5oZD6t674k1h+mnnK9eOnw==
X-Received: by 2002:a17:906:31c6:: with SMTP id f6mr28474383ejf.446.1620230315184;
        Wed, 05 May 2021 08:58:35 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:353b:1bad:486a:b5eb])
        by smtp.gmail.com with ESMTPSA id z7sm7400773edi.39.2021.05.05.08.58.34
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 08:58:34 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 6 May 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <a98fbea7-eb76-8c17-f0a8-8e041a8501b6@tessares.net>
Date: Wed, 5 May 2021 17:58:33 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210506

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
