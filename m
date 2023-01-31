Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351008C04
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 14:51:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso4619866wmp.3
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEjdWBMDsElnIfRNgqVk7/jjC9GtvGWAIDD/yitmupM=;
        b=SfQ0aKAs3bxkGkp42ljoZv1sL6p4ogY9i12XpGC2sxbzyKN0EM4QizrQIYZ6QgFvul
         ayJwMqYxHB25FFksMqdV/cJ1T/LI5u+lsqVh9NPnWy4MD0v2UvpMk2bInyFOItyQfBgn
         2U0H/v9thvvO7oKVTuC+c8wuoXEwzEnzKqODaUX20JUnuqak9yNbS9t83tpF1CFNaEzu
         zmA63khOmDf131ueTj+Xbtfs26uCsQZJI1JSvpFLsIw4sYC7YDGtNeuFLHIix6hJk0T+
         Jz1Z3Q8R8s6GCLKSf8HKmnMEAnUuOG8U7LCeLJ3nUWbs6dQeq0EOmKHxoMiAONZdPsaK
         APCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CEjdWBMDsElnIfRNgqVk7/jjC9GtvGWAIDD/yitmupM=;
        b=JXRAENlkA92KeIoEUnoe0zlv23K2HHP/W/iRwg0CDeZ+o8bvHcWGeuXT4gwVSt8PSi
         RF4ZKcxZ888YqpC9DmEiW27cQWlDQOjcdOnl2aIm8Aro6N79yPuo1oB+zUszctAYJwdj
         RiUENNzzOInM3EpOr3x/9IbiGUOXZyZKC5OQawk/DLud0K/EoXQgvB4A1hDFH62lgFYt
         UxeI5T7AebpyN1ToApzcZAhpS5Vv2LipjK0NWRRuMNtpqT/0Jv6YDY7HYsSscZOiV/sX
         JQGd7zN1Q3cSnUDz0s8ntYyBlhbhvRyHlqpD1WY4x7Lh1wW5ts7ij5rOrXwEq4RKcDxA
         z8/A==
X-Gm-Message-State: AFqh2kpHli7S785EOQQPCR4K1VW9n67QdzoMAbD3rp0m8WtyuQZpkZcc
	pd+LWq7Ogv4cLE+Nk4BWqz2qr0yRqjgxweV/XSDcsQ==
X-Google-Smtp-Source: AMrXdXstEFtHd0ZcrhuABS4SmTpSpwuPE2yOcVAL9pOT2NyL7LQWuoXoSekWhccDR2pFygZCYwqAZQ==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5b:5f6a with SMTP id c12-20020a05600c0a4c00b003dc0d5b5f6amr29247056wmq.30.1675176683690;
        Tue, 31 Jan 2023 06:51:23 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:3c4:638a:a912:cba5? ([2a02:578:8593:1200:3c4:638a:a912:cba5])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003ddf2865aeasm61639wms.41.2023.01.31.06.51.23
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:51:23 -0800 (PST)
Message-ID: <084d9396-e867-330e-0542-0d0e6ea2ea1a@tessares.net>
Date: Tue, 31 Jan 2023 15:51:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: b4: config file now in our Git tree
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

FYI, I just added a b4[1] config file in our Git tree to help those
using this nice tool to send patches to our ML.

The config file simply contains two entries:
- to automatically fill the 'to'
- to set the correct prefix (mptcp-next or mptcp-net)[2][3].

Cheers,
Matt

[1] https://b4.docs.kernel.org/en/latest/contributor/overview.html
[2] https://github.com/multipath-tcp/mptcp_net-next/blob/export/.b4-config
[3]
https://github.com/multipath-tcp/mptcp_net-next/blob/export-net/.b4-config
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
