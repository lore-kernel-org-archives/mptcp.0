Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D782C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 17:26:37 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id w11so12202256wra.4
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=VaBXPgnF+Eeh29s4XhFJXDL4wbHCqZ8Y8fOijOsB6MA=;
        b=oWyTFk41SZDGxPdCZczqeMZUHcmuAIL07aMYVXNHQolJWTg2BAA0eXO3O2gHv5oSvX
         c+krIW95JzAWLOFwHAcGmDUpl/QFIxiMIfMoLawfjgX9UvzTA4cP1TnF9/XckC8YCMlB
         U1qcOTa2lQtje21oDWJuYgirWtn8HsLWo58bJk7TtOZQ5BiKC9zUVhiA+AyT7TQMTqGe
         NrCf8GE7e7kv4YJ4ZtNoUmaylnoe6SNIFuuN3eeaKY8H1ALd0TIqbYwQNB1U/fqIpvPW
         lGHLpFK8eOOmLpurExt6KxBa7vBFvcmt5JEwgPauXuvjbHf1KAMUpMdrFtwjthm7SYZl
         3mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=VaBXPgnF+Eeh29s4XhFJXDL4wbHCqZ8Y8fOijOsB6MA=;
        b=4+//lyP5H8eAaeZqsM4OJ6t03Vbeu2yUpaqV0GYo0jS9rDK9XUGG7RmvmhELyQYgH2
         1ZLRoPxInr7nEEkVslYnPdiqWAj7xiruD50ZIVtrRL3iqCi+t+/NvadjAB8Ee7G4Qtao
         M9HlnY46rPOtQNbll7IcFCjr8+ObaCZazwk9Ky6dffqalLekp86yu7cWFyFIaAGMaDaE
         Jfiu/B4aKxfng74m0eUCc8ppr1OF4TVBy2yviotgaz8x5LZc6yFMxFFBXXp2oe7sUlP7
         pPtOmrHQNf5+4/rGnCKsBfrK5l9gqf5VHWNQXjMVq6+FJoSfWmfCmOWnnC/qJoW0/qrT
         3Tyg==
X-Gm-Message-State: AOAM531z/KM2+/Qu/AgXItEKp0s7ufa6ZsxgyXRULZWDAW70BqALK1Wu
	Xs0RHRzjAnR6ZQnJkRXcWaItvuCwv8Adrg==
X-Google-Smtp-Source: ABdhPJwD3wNiuk2AdZgK5jHi44h9ffepz/p2pClKLWXpHuF2Izm8p9NHmIj0AmQu9H2aEdlfals9BA==
X-Received: by 2002:adf:f9ca:: with SMTP id w10mr8294623wrr.326.1643390795738;
        Fri, 28 Jan 2022 09:26:35 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f2sm5409992wri.49.2022.01.28.09.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:26:35 -0800 (PST)
Message-ID: <f8adf079-e371-d172-bb2a-2530cb74e293@tessares.net>
Date: Fri, 28 Jan 2022 18:26:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next] mptcp: drop unused sk in mptcp_get_options
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <37eb45cba9d5702e2d8ea804216efd433c2d15fa.1643357544.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <37eb45cba9d5702e2d8ea804216efd433c2d15fa.1643357544.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/01/2022 09:13, Geliang Tang wrote:
> The parameter 'sk' became useless since the code using it was dropped
> from mptcp_get_options() in the commit 8d548ea1dd15 ("mptcp: do not set
> unconditionally csum_reqd on incoming opt"). Let's drop it.

Thank you for the clean-up!

Now in our tree (feat. for net-next) with my RvB tag:

- f19228839ec0: mptcp: drop unused sk in mptcp_get_options
- Results: e3f80698163c..90d554d19337

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220128T172620
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
