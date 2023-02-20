Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6E6D39
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:05:18 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id h16so6752580edz.10
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NBHqEGzmo+/ZrL6liJCPszmeXo0DptivWSVBFgUP2w=;
        b=r5XdN2eTF7/lOTB7gcnBVC93aIBx6QJBcfXGvo3GuvmVnGLBZpTVaFH/EuqYsr7xI+
         R/cBVJTzQigTlHNNk7x+vrjHqCInRTFFSYySiLKxM00JXREf/2DjoIN6ZRoBBDIIp25p
         sg2DkePDiAt5whMfT4ee28+e6QHwuHQpu7+kTiFm/iO0Ts25a5XqDE1IPI8ybQEgHZL5
         b3flt9HlpEpNFFyk5u4bgEzCCJ1jdlW5N/o+2SDgf8aS3vFu8yZyhZkmj1Fwm0E3Dm5b
         XkVoITFJczGeo9/brl78FMT3ib7+zRuoF131uFLNOCVOGXjh2HSkyFq7fiwZt0yekEpZ
         RfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NBHqEGzmo+/ZrL6liJCPszmeXo0DptivWSVBFgUP2w=;
        b=0ZTMmsqqYqN8DdyFEGkJcpWG+5aa+ft2D68NgHvcJrpb6Uoh171XUXOm8QUCEjfHOA
         huufUL4WS6rlU8S8W0w2hD5B+1ln18dsrCJafCPkxkiVOO+EWe36UwQcehx6sNk4O70v
         isztjmxgk/7i0uLIFi5+9jiD02Rbrs5eAHgy2nr4UXIHzqFgd91oyVVBMdHn7/U5bOk3
         V0lpxJ5aAFO6I6tJOBU2Dhb/XobseVZSjVl4gmQOkbv9tmVlY4Z5ECasSi+UE49w5Umy
         EiWg0ttiB1XABzE1lbnfj/sadTp2YAwg5GxYtzlUnaLJ5uBs3fH0U7Ij41g3rExM5qt2
         omYw==
X-Gm-Message-State: AO0yUKUbKj6A8vyXxK2aOgVYodQIo+anu8q6EWn7S6l41AU+s+JnvVwt
	X0a9MC82gr1kl2tHHWUaMm9GCQ==
X-Google-Smtp-Source: AK7set81QsHVDm7xcm6NCzKn1uUdoGIYj2GS5nBZwxcKrS95MAxlSophnh2R1tVfhOef9SsiSmOzzQ==
X-Received: by 2002:a17:906:374d:b0:878:7189:a457 with SMTP id e13-20020a170906374d00b008787189a457mr10382444ejc.51.1676909117054;
        Mon, 20 Feb 2023 08:05:17 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id dk14-20020a170906f0ce00b0087bd2924e74sm5923840ejb.205.2023.02.20.08.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 08:05:16 -0800 (PST)
Message-ID: <2c4d50d5-6f03-f2bf-20cc-c165db83939e@tessares.net>
Date: Mon, 20 Feb 2023 17:05:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net] mptcp: fix possible deadlock in
 subflow_error_report
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <c2265383cb2190247f7dec66fb67182e558bf5a1.1676889543.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c2265383cb2190247f7dec66fb67182e558bf5a1.1676889543.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/02/2023 15:27, Paolo Abeni wrote:
> Christoph reported a possible deadlock while the TCP stack
> destroys an unaccepted subflow due to an incoming reset: the
> MPTCP socket error path tries to acquire the msk-level socket
> lock while TCP still owns the listener socket accept queue
> spinlock, and the reverse dependency already exists in the
> TCP stack.
> 
> Note that the above is actually a lockdep false positive, as
> the chain involves two separate sockets. A different per-socket
> lockdep key will address the issue, but such a change will be
> quite invasive.
> 
> Instead, we can simply stop earlier the socket error handling
> for orphaned or unaccepted subflows, breaking the critical
> lockdep chain. Error handling in such a scenario is a no-op.
> 
> Reported-and-tested-by: Christoph Paasch <cpaasch@apple.com>
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/355
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that the fixes tag above is different from the bisected, much
> more recent, commit pointed by syzkaller, but I believe (code
> inspection shows) that the DL scenario is present since it.

Thank you for the patch and the note here!

Just applied in our tree (fixes for -net) with my RvB tag:

New patches for t/upstream-net:
- b06fdd2ba8a7: mptcp: fix possible deadlock in subflow_error_report
- Results: 1231bdd38564..275b1fab043a (export-net)
- Results: 1e2b17c72708..ce3a45c82f32 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230220T160207
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230220T160207

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
