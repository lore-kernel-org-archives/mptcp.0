Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B0320B
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 16:49:11 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-325d21f7afaso249615ab.1
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680799751; x=1683391751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dcRW4cznRuuVpkSa4JtvG2ynNPWMlAN993xuYHDgw8=;
        b=M+FxqiPiUJSvrSl6U59WLWbid3iEyTYJbUjGhJUr5MonYejbkZw/yA98ioyvBeWwyw
         jIoiDAsyILNtthV3PKIGiN2YoJfyy3gxnKyVtROrRQY4uNpodvYVhe1LNm6iP89mJTRi
         doqIwVOsQH9GRVeEQpvr5azvbJgOI7/jqcTj3SMgYgGcSdv65UNEr6+f7j3tPb75SJob
         bB4d6K2VvvmfDVtctzDHpTlwydRr31g1I4Sb1GZDsvPXiciX6U/xhN/7LaiuoLP5QA8U
         MtXY6xRDEtjEQng1q0UDf5bLbbzlK4W172+BskZdDMUqPfHJ6Nf3851uyFmYRxhOneAD
         v4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799751; x=1683391751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dcRW4cznRuuVpkSa4JtvG2ynNPWMlAN993xuYHDgw8=;
        b=pAVcQBYPAL9Kf8QOW4O94iU8Kmgt+z41GLokaPtq1/4Ema5Y7dXKqVH/HDcJ73FBja
         FO+HDMjlQN7Hr00Qs8DoUWuydZU1m4jMbWVANZHhBTVvk5zdz0MyCYMg0wXh6+W7yLPW
         35+pVteDAAiCXfCUKZe+Dqy0551e4Zsn6QPBSG9EbbkjErKOLLLW8eeyV3RDv0sxs8pu
         q2j2Wn8j4y/nxD+SaykX7xWSN/nh3Yf3lsXWrmUem96J0hgRGvejMStR9dWFix68Sj7m
         GcO92+aVA4K8BGKQy7pwDsqp3vF79GEW/5ciTbay8dIk7IJbsCF/OekAbsM1Kp5qMwiG
         J6JA==
X-Gm-Message-State: AAQBX9fJE4si0B47mRwyxVWWpr0K/Ngje6wiwac7ca3GfKuX8vfGBWi4
	D3yEPwXUEYmX+AaP3XSgZEMNbA==
X-Google-Smtp-Source: AKy350ZIZX1Ar8icMLnLUnfyx3SqXK4JeI1mnobKQyuOkftxckVlTBQKSIReEi+ecx+bYEc+nDJlzQ==
X-Received: by 2002:a05:6e02:492:b0:325:e46f:a028 with SMTP id b18-20020a056e02049200b00325e46fa028mr3034999ils.3.1680799751004;
        Thu, 06 Apr 2023 09:49:11 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e020c6400b00315327197d4sm448768ilj.23.2023.04.06.09.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:49:10 -0700 (PDT)
Message-ID: <99c064d2-652a-8e3c-eacb-23cb46b3e3a6@kernel.dk>
Date: Thu, 6 Apr 2023 10:49:09 -0600
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 asml.silence@gmail.com, leit@fb.com, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, dccp@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, matthieu.baerts@tessares.net,
 marcelo.leitner@gmail.com
References: <20230406144330.1932798-1-leitao@debian.org>
 <ZC72UKx/sA4syPfK@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZC72UKx/sA4syPfK@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/23 10:41?AM, Keith Busch wrote:
> On Thu, Apr 06, 2023 at 07:43:26AM -0700, Breno Leitao wrote:
>> This patchset creates the initial plumbing for a io_uring command for
>> sockets.
>>
>> For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCOUTQ
>> and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
>> SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself is
>> heavily based on the ioctl operations.
> 
> Do you have asynchronous operations in mind for a future patch? The
> io_uring command infrastructure makes more sense for operations that
> return EIOCBQUEUED, otherwise it doesn't have much benefit over ioctl.

Basically nothing returns EIOCBQUEUED, it's mostly sync/poll driven on
the networking side. The primary use case for this is with direct
descriptors, as you can't do get/setsockopt with those. And that means
you'd then need to instantiate a regular descriptor first and then
register it, rather than keep it all direct from the start.

-- 
Jens Axboe

