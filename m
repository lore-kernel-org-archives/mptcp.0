Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB56177
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 18:28:05 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id t3so4598632edc.7
        for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VEJT8Har2BPxFhPVcq3cUzCw4esWLwpWafwIL2fgi4M=;
        b=HyqYi2mgLQ2o+8DgEze9IsqM+l6+6aoz5Vu/wFj0mno333xAEihlA7YQNCxLxlqZBV
         /aMGYJ4VpPYCf6yweKBYeQr1u4wUj3UPX+rs7L8KNDSDoK+UqWWF+YW5rllahxYha9w/
         le4n2g2W3Pm0HH5gIpi1VLZoFjCRS1c2Zj6ifFM7KWdzKPC1GwUdqVDPo47NyUKa4afF
         KjYoUZcXGqOubuohG7GQTREXAyauUTkA3AStCtAQKWWki85vqhc4aIu0VmsYAXvShOTf
         w37C2FTlgGIBR+ojY7oi0niJ9XpjNzgUuYO60XwR35MPlScruaaacTz9FWD5MXNp9mYJ
         5OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VEJT8Har2BPxFhPVcq3cUzCw4esWLwpWafwIL2fgi4M=;
        b=ZgugcrYt707krdrecAOYQENA5dh0f3YFoIGxz/rnOXQZWZMdyLuHjp20Q8vM2XWa+x
         siKk9HE6rVbXapxUcLxewq8H95WMt2AvMQgPXvUeki9YCl+Z9SybQMc1NZAMuEc8BnH3
         NTm/jAZXHtQs3Xl8tuBf5ih5pz6WpGsV5Upf/SpMcb9yNwV2NlwZOHcoE4AwZg13VU+n
         s03DUlvjYq4M6vsKKlyWWFD5ddmVOUe/cnY9Yrzm59rD0iiFAHlbRz+7/GLvy7QwF+zy
         DocZ+ix7DcXO3tErwnmSbj0mSXWLKqUm7i22saYTZOFy76Tq13l3KQQvGHMPUab46+A9
         cjPQ==
X-Gm-Message-State: AOAM531OVHZL/epHJ2upXumphIUOalihLHTC7N9IWn0ZRCeseOvoy09E
	kaxtzDabN6XyOEneKSO0HxbG2HQNR+9DEbpZ
X-Google-Smtp-Source: ABdhPJyg28N6Lj3ROQMahYU6/LmxZmPFzDnpjPfZUdagczGme8uFKyf2OtdrodkHvNgdvUveRPWcvA==
X-Received: by 2002:a05:6402:c10:: with SMTP id co16mr3190956edb.192.1625077683701;
        Wed, 30 Jun 2021 11:28:03 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:e96f:4b2a:bc8e:96b9])
        by smtp.gmail.com with ESMTPSA id g3sm187669ejp.2.2021.06.30.11.28.03
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 11:28:03 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 1 July 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <b42594b9-75c7-c8ba-991e-bea1b0ed2b85@tessares.net>
Date: Wed, 30 Jun 2021 20:28:02 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210701

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
