Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5768
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 16:09:17 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id r25so57368923edq.7
        for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nWFavH5B1lfHIVrhPimeng9aeLrPRUMJCK9jgZwuUH0=;
        b=19qlr/f2r+3ZSJx/mv5za8Tmn60DDaz3cj/mjpz36Uq4nO2CpsCIG/u9LaSTG0/iKV
         K30G4Mp50yJyYlAGQxf3JM6/jLfjTkcNqHRz2q5g2hBTDcHOKDQhPwsXyhsLbLECNGdC
         M7fxPR1UHfozC2BVRm7o33BLQBTeNIjds/h6aQtAXaELmM3ixFLsR0KfEdDYbF3frJkq
         uVNykQncqLXzYiuCTD6RvG1dZVhlWEn8NRdl55+PL3wJQYVHgp86FR8pfAMYYP0MuwdG
         wslx/2T9jTaRS+jYOsbXb4mKV2rCdchEPNLyYSY/fJpSIa75GKlqCqaitxzz+lz3wCSG
         xraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWFavH5B1lfHIVrhPimeng9aeLrPRUMJCK9jgZwuUH0=;
        b=IG0reYNh7P3TFO0MOPXQiFHmGCii5RsmidqpH8NBtokqnYis0FQkta7S1fI///qqo9
         v4QIXADa5yLZg1sDfLLa7nXIOLhe/fZLeqTPBgKhBj15zsQGN1apCYdP6/a9ajcrCp7X
         9RX/8awv5QsDbUR2sPgTfjCtFr9L2q4xEYRJ+io7YKhjTQHnYtNXZks8yI6gNAbp1PBN
         t3DtEdvRMM+poK6dI8IjC7YYVOc5YE0iDEZQRkplL397YdEQ+t4F3fPNi6RdPp7h+U5G
         nrqvrJtE7DdP3v1gTwAH/AXznVE6rw3AP4s3C+jYpbAeuRH9f4tmRxrrCaGS4XhF//wW
         E5Tg==
X-Gm-Message-State: AOAM530ScUEaHzg94aAVE+Q9H6iIB6moiz+TtwN9yTyu+XzQ9QDDirmL
	ChePtt222JIryNaPf0G8s/of+w==
X-Google-Smtp-Source: ABdhPJyq8Je2TvtNUTm5/98+t/pBAuxRaBsfCsGTj5njv4e9UboQTqvsfWvG2x9fWAyvhSpW4577BQ==
X-Received: by 2002:a05:6402:170a:: with SMTP id y10mr10978763edu.324.1637683755443;
        Tue, 23 Nov 2021 08:09:15 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id bd12sm6006653edb.11.2021.11.23.08.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:09:14 -0800 (PST)
Message-ID: <50e883b0-9776-c440-8b8d-1f9024c50a31@tessares.net>
Date: Tue, 23 Nov 2021 17:09:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 3/3] mptcp: support TCP_CORK and TCP_NODELAY
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Maxim Galaganov <max@internet.ru>,
 mptcp@lists.linux.dev
References: <20211123070708.2897469-1-max@internet.ru>
 <20211123070708.2897469-4-max@internet.ru>
 <65424687fe3f108285b6b42669d28e61254349f1.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <65424687fe3f108285b6b42669d28e61254349f1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Max, Paolo,

On 23/11/2021 13:21, Paolo Abeni wrote:
> On Tue, 2021-11-23 at 10:07 +0300, Maxim Galaganov wrote:
>> First, add cork and nodelay fields to the mptcp_sock structure
>> so they can be used in sync_socket_options(), and fill them on setsockopt
>> while holding the msk socket lock.
>>
>> Then, on setsockopt set proper tcp_sk(ssk)->nonagle values for subflows
>> by calling __tcp_sock_set_cork() or __tcp_sock_set_nodelay() on the ssk
>> while holding the ssk socket lock.
>>
>> tcp_push_pending_frames() will be invoked on the ssk if a cork was cleared
>> or nodelay was set. Also set MPTCP_PUSH_PENDING bit by calling
>> mptcp_check_and_set_pending(). This will lead to __mptcp_push_pending()
>> being called inside mptcp_release_cb() with new tcp_sk(ssk)->nonagle.
>>
>> Also add getsockopt support for TCP_CORK and TCP_NODELAY.

Thank you for looking at that!

>> Signed-off-by: Maxim Galaganov <max@internet.ru>
>> ---
>> I've tested this by doing single-byte writes and looking at the length
>> of packets in tcpdump, also this is now running on my tproxy setup.
>> Enabling nodelay on a tproxy gave a decrease in latency to first byte
>> and lead to improved user experience in web browsing and voip
>> applications. Existing selftests run passed on a debug config, I'll add
>> coverage for new sockopts once I grasp how to do it.
> 
> self-tests should be doable with pktdrill, see:
> 
> https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gtests/net/mptcp/sockopts/sockopt_set_ip_tos_valid_v4.pkt

You can also imitate what is done with the Packetdrill upstream's TCP
Nagle tests:

https://github.com/multipath-tcp/packetdrill/tree/mptcp-net-next/gtests/net/tcp/nagle

Testing with packetdrill might be more reliable than with an E2E test in
selftests if your test needs to look at expected time to get data from
the other side. Indeed, some CI environments might be quite slow or busy
with parallel tasks.

Do you mind if we wait a bit to have these tests before applying your
patches?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
