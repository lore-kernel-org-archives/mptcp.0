Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308E72
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 14:59:08 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id t3so37487302edc.7
        for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cbAXel1e8NTdcOM+zOCrJ4S1l+0l6k6/P+T0IG29wBY=;
        b=j6N2h2DpB7KZJjpM3Ea6izUhfNZARgKHVJpgYyoJi1VB8GvnsAUKdBuusP291xIyVy
         bOZJDEhmS4hmX2s5KJcosQx0HNrAMRWR8dzkjgr6bCA5eSL1s5OqdW/z8LJmblr4LGU6
         5rpBG9lIxPeBaXLnO+GEQl6SQVFA+rMUH367sSeWyCzi/gWfW4M3FLG3BKcF4z1d3uDM
         u9qJGJxfSd6bjnsJJu8ZNwkABqpkSSRg2vatTUXcDPJnCjq2wOEDhcU05n+wryzWBbHB
         RxlVclrmiZgizIjUAm3yHzie/jw0qQnyLo7+PP3VnH9RYa++CiZTy1MWiur8lLXnjJfK
         HPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cbAXel1e8NTdcOM+zOCrJ4S1l+0l6k6/P+T0IG29wBY=;
        b=R4BuRfM/WWdEnxKBo7AsRFBW3+llBrzLcDIroFu4qxycUwgwW6IJyTvcJ2i9CbIRHf
         UZIt+QLJP3JiNekz7K713Yet9K7Gyh/5KkFnTLCOMAJYhIZmbzYAA6fh96gvcnEx3XFU
         fdOmaUw4AGu6GI15rLrl3y1G/GdKg9gub3QpYVbwhBrBLRsZDVnl1OpPIXzT//GT32B/
         jUVDo8f+qaEFHKZPaQCB0+ozp3y05vhHpazyb8RobPyUNwWwLLKqDAAqkF3VClMfQDwE
         pplIVHIR9tsp3zoNgFKYnHMGMsrzHvcX6zM1f3NGqd6wf4oBKBPa2lXgEj1hxlceNzmJ
         TLMg==
X-Gm-Message-State: AOAM530JZAp5++Ogl7eq9k45E1VuJZZc2U4ozckqWICuYRiBzt0Hauh/
	jyhm2mNS5nGuW98ASRxalZjU5r+0WIa3xT/bUtk=
X-Google-Smtp-Source: ABdhPJyW0j/yG5GRfWV/6BIbOU+wZe+S2tFxmNd5aJkOqFYmM9VBEQZyBkpwLaGrcERlrYmLn3QVTQ==
X-Received: by 2002:a50:fb8a:: with SMTP id e10mr4342791edq.330.1623423547363;
        Fri, 11 Jun 2021 07:59:07 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:26d4:4bdb:59fd:ed42])
        by smtp.gmail.com with ESMTPSA id q9sm2672684edw.51.2021.06.11.07.59.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:59:07 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Checksum support: default behaviour
Message-ID: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
Date: Fri, 11 Jun 2021 16:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello,

With the current checksum support series from Geliang and Paolo
available in our tree, the default behaviour is not to use this checksum
feature.

Should we eventually do the opposite and have it enabled by default?

I do understand this has a cost in terms of performances but this could
help detecting nasty middleboxes, i.e. the ones that modify the TCP
packets without modifying MPTCP options if needed.

On the other hand, I don't have numbers showing if these middleboxes are
rare or not.

But also, the main issue I see if we enable the checksum support by
default is that we are no longer able to talk to servers not supporting
it (<5.13), no?

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
