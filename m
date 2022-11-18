Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2F320D
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 10:25:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id p16so3320632wmc.3
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qF+pue4B+54MawKksGbZHv0aShuWLm/6V9Vn0w+0E4I=;
        b=iv4aRg/yEdyvoUdMia7UfLZLRBxbIN8ViUHBnmMJMvRVA4zXjvnw8FJvSdegSpxLtF
         1oYqHz35Qihsbua6hjekXIxByymtjh4i2a3JqUwSWhfQWBB+WFfSBk+1R1oGe+o9Y0wX
         k1RxavLb3MB/HOi8HuzKrezhg+Sryv0TZQ9eo/5G9wtD6Fu15F6jjySiq8H9aofzBHSx
         uLlOtLkBP4E2jnUmoM5EPzqkdAafi73Q6OjFpIzRTmfsS/mi26BaeZjTgObLij7rauLI
         d0xdU5hGOV/lEaJG2xPCQGXF2YKMHZ73m+1uOettot142hcTmyOCR05HgAlgk1Z2nSu8
         GArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF+pue4B+54MawKksGbZHv0aShuWLm/6V9Vn0w+0E4I=;
        b=mvQ/jTVJVqVPw1sPpEzk8CD4Pr14FU00rjv4zlARrVZHCCUfLBP2DTMZ7SP532/pw3
         E+y4Cs2aLZFlWrxdUdr3SKNyiZ+Xd/jqGPoZ8JaRLiGfPlAbH/1idx8Gy4Cyq3fS6A4o
         Y+UkFmdjbAOCkaZGS2qnww45TJFDsvXQyU9+yCX20quj1GZVIT+cMXxusACwhvUSC7fL
         FCW6YZjgn5N7jL2BNqwqUEbeALENH5ttIK0ba+862L8dnKrOPegnvztLeBMWWbHmW2G7
         P4H1BBKBX8/Z1ZDPs4ekjXrcAwULctqCvayhoFHj3atn+K1aiC8ChEbWba8nIbde4iAg
         hETw==
X-Gm-Message-State: ANoB5pnAMIBC+quIJ27Gal12wmMq2jlql4jZa9pmEGdG8shjvd2V1pgc
	qt71U7yZ6lG9RnCfkJX0qrSQAq94Eoize6m6
X-Google-Smtp-Source: AA0mqf5FXS8nNzU/EwTGOcYS76HZNU+M0tNzevm5PjWKJT4VnUbHmA9w7auMiYJPCjGs7MrMWDUcwQ==
X-Received: by 2002:a05:600c:35c8:b0:3cf:cf89:2f02 with SMTP id r8-20020a05600c35c800b003cfcf892f02mr4467498wmq.2.1668767150494;
        Fri, 18 Nov 2022 02:25:50 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9464975wmg.46.2022.11.18.02.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:25:50 -0800 (PST)
Message-ID: <c0005211-4ff4-b9a4-31fd-fe4445f8a5f4@tessares.net>
Date: Fri, 18 Nov 2022 11:25:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v5 0/4] add pm listener events
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1668662624.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 17/11/2022 06:31, Geliang Tang wrote:
> v5:
> - use GFP_KERNEL instead of GFP_ATOMIC in patch 1.
> - add the listener event checking in the existing test in patch 4.
> - update subjects and commit logs.
> 
> v4:
> - split the selftests into two patches.
> - do some cleanups.
> 
> v3:
> - add selftests.
> 
> v2:
> - send created event from mptcp_listen.
> - add a new patch, use entry->lsk directly.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313
> 
> Geliang Tang (4):
>   mptcp: add pm listener events
>   selftests: mptcp: enhance userspace pm tests
>   selftests: mptcp: listener test for userspace PM
>   selftests: mptcp: listener test for in-kernel PM

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next)

New patches for t/upstream:
- a6871c7e014a: mptcp: add pm listener events
- 4aabc20960d4: selftests: mptcp: enhance userspace pm tests
- 83027c9e1d0c: selftests: mptcp: listener test for userspace PM
- e33052bbf56f: selftests: mptcp: listener test for in-kernel PM
- Results: 48478f54612d..077c54d47661 (export)

- e9fa9c5f6951: tg:msg: events are for any MPTCP listener socket
- Results: 077c54d47661..69720c6cd168 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221118T102434

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
