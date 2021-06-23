Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87992173
	for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 15:54:20 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id r7so4115795edv.12
        for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4bxO0k0m65YA5hh76Lf34S8VirNEVw67a7q8V95d8Bc=;
        b=uFwccyiIYNU9w2rFE2dGiCUygGBLuZZDsfM5kwrXKfYFOHAPtMxgptglDp7HFJd6OG
         61IrlcwbiRmRDh3PnUWnb/rqMxS9JL8l81J6o1ucolc3VUr+lFLWfUXvz6VSdO0FQg/m
         hPUWLEHOrV6/pmC/mh895V0+ZMyGP/BCpytkZNG4YaCajdycZTVmKlMN+gDvCqnwmOIV
         cSyl/+ojva6IgBz86F4tZ5m5KJQC1mfxM0Nnyiml7U//XD7v2hUYQn4pS4zd41Dso6iw
         mOBkJ82MsEA08iKEIHkXO9/XdqmGbO58MuHlrH7fv2InZdY1/PpchSjonp2MJDEj8uL7
         Opog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4bxO0k0m65YA5hh76Lf34S8VirNEVw67a7q8V95d8Bc=;
        b=F/HnqbCr219mtQhAXP1VYa3WiA6oXtCFDnCQ969snV9cD/VZZouVFSJdSxBB9o265p
         TyjAP6M2kLhdyiLxvRDnofzrWjUWv50wi5f0vPzT66RGtWni2/XfWjUJ6LVoRN/qoFF6
         Ic3WwiXFtrI7dugWpEZKOGeu1QqPajyGytGaCXJj9N15BPZyfVx8kfxz6Dk15b04LJRJ
         B424U8KCv8mibbEsbJ5ZP4mFuI+3xjhY7dUoBRlmXaOrAPscol+y//qbvfBnPmGPdPZi
         zRTZ60/vIUH3YhwbmnuQN08jUUOeCJX1psyPTSqIOlUK9AxPmzf3f3+SkhmaRN25zVCX
         xYDQ==
X-Gm-Message-State: AOAM5337iEoJs0EWiJ/BD8XFrjH2q7r1d5Oe7Yc5ia90LuRy/NCs/uCC
	vqEfWnvq0Y+ybwUDLNlWtiZDMOc8cR0Zu3GJ
X-Google-Smtp-Source: ABdhPJxBydJNkHRqgf0kR3+FC6hqZtLOlNNm0s/QMxWn5OAPKCA0hCpS8EJHLV+QJ4bUj1ICa/3WHw==
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr521587eds.143.1624463658656;
        Wed, 23 Jun 2021 08:54:18 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:565a:bb24:983f:7054])
        by smtp.gmail.com with ESMTPSA id q9sm265201edv.31.2021.06.23.08.54.17
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 08:54:18 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 24 June 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <4ba054a5-53a9-806c-0d14-a3b1bd96edcd@tessares.net>
Date: Wed, 23 Jun 2021 17:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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

https://annuel2.framapad.org/p/mptcp_upstreaming_20210624


Feel free to add/modify topics!



Anybody can join the meeting using Google Meet website/app/phone:

https://meet.google.com/edk-rkrk-vaj



See/Speak to you tomorrow!

Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
