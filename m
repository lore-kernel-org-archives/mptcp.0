Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B92FAF
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 16:44:40 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id bq25so6275755ejb.11
        for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=m7HNqVO1OytpBqC+xz2VMmr6S1pDEHMfy/egelPtj+Q=;
        b=XhnhF5/UBydYXWjthrwkX/Vkxs+ClauiIE3Jjq/MV0EFPO/cU5efbEB5R7ZEzYfdr4
         4/oxyGgRJwF0IoOOxrthU80xKxRJp/gq5Vxz1xrGRUJVc5zQUh71cwMKhsr+BUTzXWAD
         e69Hz87Z7aKZnRUUHAATxcQNhYO0A8hSkF9tpLaBwVZti2DsJEDG34IpyJlOu5XuzdZP
         3ju34sdeI/uVYFP1pdZ4nECze43e82XDZ3hHZ8hRGdFVa6p//R9DLRlpuUaN2fkMzYkN
         uDr8ri6AJqdJ4X3CAsw+8xdfOR1agALZg94a6s2ye92WAvPlGKAFpI4gajE92Lrtrl6v
         UvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=m7HNqVO1OytpBqC+xz2VMmr6S1pDEHMfy/egelPtj+Q=;
        b=qGbeGa3Jjs50hxBw0ceUuDSlgiUbaOVCV1QA/xaA5Q3tPcNk4wjSIPlq06em//XC/L
         LN9Ab1X90B/tTo8I7TQ0yAVGQgiJ7iX0/NuCYSZV9rFlwcIdQ1xPGeuji3zgJOw2FUk1
         1y7a/bXi9uq75It3AZqcEIRyYJyG0hN91UW6/mHS/GbHF+51NyNk4jMAj15l12ZDtm6+
         3tNJpbinmYs7vS99gP0vW7lGkrEb3bLUSmWUlOXXgFImzJV5ElpKWRmblBfMZyzfPP9/
         vbIbjAxfY9o3rIuk4KHqpPbiqunH+/f9VMfI4UWzjmzuAvs80SFw7klkkgXF/I8CB+29
         n1+w==
X-Gm-Message-State: AOAM532lKnLE1SlPtzFZOl8YUH/ouuJplhKH8gIFhZHFz50/+BtAhlP9
	7YVIEzMGtL8wrmi3Q90avUC85sWKkQp2Fcyn
X-Google-Smtp-Source: ABdhPJwAs2lEJWswJQcfRYr9559kXRcyXWeFGqyhPa5+wtaym0OxKclsqYHMAx1AYZqQVUT4KnN6hw==
X-Received: by 2002:a17:906:199b:: with SMTP id g27mr10696863ejd.517.1629305078683;
        Wed, 18 Aug 2021 09:44:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.156.192])
        by smtp.gmail.com with ESMTPSA id z10sm131454ejg.3.2021.08.18.09.44.38
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 09:44:38 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 19 August 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
Message-ID: <c6248578-56cf-cd50-cb05-db1059b3b042@tessares.net>
Date: Wed, 18 Aug 2021 18:44:37 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210819

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
