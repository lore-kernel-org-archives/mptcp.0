Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3546F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 17:22:36 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a7so34173101ejs.3
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nEYtIK0kmiDUYpjZhZKCYsCgmB7wMJ3b+yLu/dzBmxU=;
        b=ywYz+aiJa7aJd7WDiO7CgsVozkIUW4g8oOKhhM1dC//aCp1vw1JEqaX+0OYdxm3T2f
         0rWMDOrjj7l8m0oBcmj2pvOpvAXRm6adp0923F5mFth5W0QglpuzqCdrLUUf2h6CsohW
         eRNeqShNSfgDRDO3gQFnesMRMQADl2QFV4PZXSaPotPsjf6QG0vdvCAjBhTIrQjLZF8q
         n7Pzy6FBkLAeU2FSwc1lhQnE5wXEeMpWT/JJYGNScDcWvrwLE7+iD+nfNen73lhTXI8A
         TuGOOqnSLFfrVMM9Lwu3RWlsuUVRN/qa9ONpz3Do42fx0VHDXH5XZJqWFypp6UWcL4Eo
         pXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nEYtIK0kmiDUYpjZhZKCYsCgmB7wMJ3b+yLu/dzBmxU=;
        b=RFaRjhVhre61zy4F8nKE/w023FnVXjAGCWagwgA13vPYqsa29TQq+FKyQB7Owfg1Y8
         aMXklEzA7O4ok/wStI/ZndCYOqmhrLYYVUGFCD8yldKNdQhjvn6zvgeweJ10AKGYTM90
         POcY8jsGBd9l5ZR07RSa++Y/ZFTjy7yOIOuulYQz4riEzhasgFIf8XUVQrl58o2xsNs4
         eRl+M53Ffjb2dB75XkvTmoPbAoKDX4CyjFw5dTSOq4neZHqRsJXhEaRH+JgAXszBGXcB
         GfkdTsKosaahrcoDhSauQ6I4VjERsF+N16w3NFCkVuj7pkreuvc1935mdFTp1JD7VZjA
         dAEA==
X-Gm-Message-State: AOAM530K2cPeiTQiRdlTVWpD6ZLG7j2qV+c5+mFGlnuX/aBz8O67Hjd4
	7FNGhV8gytEalb6s+Le9u8tp/ejGnJb7BIjo
X-Google-Smtp-Source: ABdhPJzlgy7uhBSIs/4N24YAP3JFeTqT7vPlviVhPuI0A0i+nx4zqfIJyfOsVdBF7GcvP45GrgJohQ==
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr4778662ejy.394.1616606555407;
        Wed, 24 Mar 2021 10:22:35 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([84.17.46.26])
        by smtp.gmail.com with ESMTPSA id w24sm1439722edt.44.2021.03.24.10.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:22:35 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: MPTCP Upstream <mptcp@lists.01.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 25 March 2021 15:00 UTC (8am PDT, 4pm CET, 11pm CST)
Message-ID: <5db38a16-3c59-0a9c-63ab-2ad6c94a0983@tessares.net>
Date: Wed, 24 Mar 2021 18:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210325

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
