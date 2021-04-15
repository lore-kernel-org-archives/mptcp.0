Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949F6D32
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 10:20:54 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id e7so27317146edu.10
        for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kdbugGze6MxRdjVLzAadtDwXLCJKWrHv0T2EAQLJd3A=;
        b=hPTATHYAcOlxzow20BPGbPvZzBOXK1CQFcPQrDC9bOuJE4/FNXE+ehO2LDP9UDRTWq
         +oEltLeDJR54bfF77GfH6E4+8PCBkOwXaK4KTaOX0bbln1jQp3IidNBCF5jMIIwj8ohb
         PzI1cJGy5yKkhGnw9Qpe7DRBYpHvtLjWLhhZ4aUugkcafbCQ2plTtaxf2LPSAdy6yyLI
         JXqz7cMmbyf/npwVO/Zop7kG4gwPpmHU0PkVOa4p2+mP5STmku/tfeC4PYyqqjD7mIha
         UVdT+7IiYM3S59kTXA2zmuwE9ZJFhKzkwwluAr6YlUiSwxxrGQVpi1dFTjfPPWWNU0VQ
         HsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kdbugGze6MxRdjVLzAadtDwXLCJKWrHv0T2EAQLJd3A=;
        b=We8z7Ufu6uXY+DMqGjfjxcqc2JkOB5yCPRsPvkH3DzhlCj1QdE7Siu2rJrcn8EIYk7
         75gR2DcoTFX4SCq5R4jhkGTHqHN8cze3C4DORtFFz6ZF3985B6+H7dESHitys9R+PX+0
         ju4JyrPAZ+XHb5KAiBDMufPdgw2r5Ae9q9UOHQwfCjKFvkTJQAvkWZtlcsRgXq/yRwif
         VgIJiVN2Ukgw6G2GRuWyGwYEHM6mWK9EGJPCUmbcuvaxqwrdIkaz3Hq8STGLRlGTCKag
         HEC+AV2tZMo85F0GX8M6tly2thnzbGosnScThzpJPlP/PaGNNRfKE25MQeMGKDG61sA0
         hAwg==
X-Gm-Message-State: AOAM532XqPUIQtkb9nmCBRm4G8VwaKGPUwNcxYXcwkV1iZmQYYWUGqEr
	iYsxXuNq2A4WujQ3HnbW3hcSNPFkD5bpFA==
X-Google-Smtp-Source: ABdhPJzkZVIBQNUELN3yajxW8B6bkiQ+b3pdiBT9d9IJ6AI4Kl5vWPG/ZuzPmHC75hcOHLniTyDlwA==
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr3263589edd.6.1618482053340;
        Thu, 15 Apr 2021 03:20:53 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:4aaf:625b:29ae:a5])
        by smtp.gmail.com with ESMTPSA id nd36sm1560345ejc.21.2021.04.15.03.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 03:20:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] selftests: mptcp: add a test case for MSG_PEEK
To: Paolo Abeni <pabeni@redhat.com>, Yonglong Li
 <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, fw@strlen.de,
 wujianguo@chinatelecom.cn
References: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
 <1618456752-139032-2-git-send-email-liyonglong@chinatelecom.cn>
 <f646a6a219589e55b98085adfd88094f418cc54c.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <e33f0087-11b8-2d5f-7a27-329436e420d9@tessares.net>
Date: Thu, 15 Apr 2021 12:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f646a6a219589e55b98085adfd88094f418cc54c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the patches and the review!

On 15/04/2021 11:42, Paolo Abeni wrote:
> On Thu, 2021-04-15 at 11:19 +0800, Yonglong Li wrote:
>> Extend mptcp_connect tool with MSG_PEEK support and add a test case in
>> mptcp_connect.sh that checks the data recvived from/after recv() with
>> MSG_PEEK.
>>
>> eg: sh mptcp_connect.sh -4 -m poll -P
> 
> The code LGTM overall. I would prever having the peek test enabled by
> default, and I think that covering all the netns matrix is a bit
> overkill.
> 
> What about running a single saveWithPeek and a single saveAfterPeek on
> loopback before the main loop?

Yes, good idea otherwise I'm not sure it will be tested often.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
