Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86272
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 17:41:23 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id oz7so847633ejc.2
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CPipwAVothKkQOlFboK+ceEU43SRp3PO9YZiBOBTVNo=;
        b=QA6PJ7rrfM22GaB6glhTfcMDKDD4vq37viyiZqMAthB38S3DC6ql7JsD++eiO70UPC
         ppM/rzOU3gSm59R9QvWqh9PYS2WVZ1dc8lfR5TFZQHrhkCDSOVHFUfrfy4jWsIKR8iMi
         2G0UZLI8xJJiSSXWcQjmsYJlzN3wxqxlVN2K55wCgUWiWJF73LKFnoOpcmjFbdu7xKo0
         zAJtsdtI8RUQFM0oUqjAQVI0Eq/bIbyLDPqyaAFbzBCQqZBTKuzaPsh7KMe3B+fHC/vr
         /Ujg9TEHV928mLhlqp3WVH32KS5TTnvncQ5oardALt8Li/gxfjc+/V7wSr81tN1Ozjuj
         kLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CPipwAVothKkQOlFboK+ceEU43SRp3PO9YZiBOBTVNo=;
        b=gdD7yCAg3be1c7aVsC0ycQO6wujuhGFd2Hn6zrytZ903J9H/NNlf+20xseK6ZdEdO6
         kdmFuC+dl02GLztrkUCJY8L/3N5MB1/yYLrrSsK2ZaStPuqkvdijilhCz8xUJjcjYRtg
         ONYFHlL0wQNXyUa60jSLlgeQT7yPSa6HdV06la9dk7lIEqRrtOTCD1G+ft7q10BjDT0U
         JulxZjVm9GTx6FyHk72AhKxWKM8MlCJCye3zl4L7ylUcTrnJb7Fij25/Wt7sRIRRDgD/
         M6h/E9kryUxMn/NHga+KdI1LFJvg/4rHDNUHh7CoxBRPKIVaHdPRZYDKqCLoyrUltkeZ
         gpug==
X-Gm-Message-State: AOAM530fIohe9dhLbjAyeSYtGlXSbTGtRrv3uPfm1qOWxRkD9PbQ17Zp
	MjfkbYHJPmPdvPhO76wCIPWxzfTMU5NLFw==
X-Google-Smtp-Source: ABdhPJwRolUBTiJR9pD5c45Y71PILojGT6QuCGDOMjijKFgMlcrnYcYJsoK8GFAKnMqKfB9M51jfFg==
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr13378353eji.385.1626284481562;
        Wed, 14 Jul 2021 10:41:21 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:19ab:ba02:6bfa:8cec])
        by smtp.gmail.com with ESMTPSA id hq9sm979760ejc.0.2021.07.14.10.41.20
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 10:41:21 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 15 July 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <e6a042df-754c-74ef-070f-3c6f30919097@tessares.net>
Date: Wed, 14 Jul 2021 19:41:20 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210715

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
