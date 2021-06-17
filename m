Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE35C71
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 13:22:08 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id d7so4073471edx.0
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KUOoNZLVpmgKszGywXVU2TcRlYo75RXiUhSheX/vWGc=;
        b=btTr6QgbWcCKJfkYuEO7q4ezxrdPzSzI9K5OVIjU0AiECgu4ZdDW/5aouaNhvC9fsp
         Yy/xGqGC+9ie9a6BueyAxd8etH7TNV5L16v0nw4HrpNaL4Y0+d68QSYU4boIRrznyff4
         fVijdq/x6Gf7UaGJ4xjpw+ZhJD5izodkjZUHGaRpgXy/7hMzVTgr0jyWnoUELorNj2K5
         X7Dnw6cPel7PJASotHMdFhKaL6XfJdaUKUwfnjFf2ZIyI41y5d5qejzSk6P9s8eNPkcr
         sqz4oVPFDmInoK/5008JSwS5qTRkxmnToLyVnuJYRlqK3TUmL5m9F28IoJgDNL0M+TXX
         tx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KUOoNZLVpmgKszGywXVU2TcRlYo75RXiUhSheX/vWGc=;
        b=Mvj2BE0EfvmhSIkylRgUjqISD+qL0o8kkMqVFG9Yt5EfTVbvj6A5d7d6x4kxPrZbZL
         vUo+OInatuThbghS0xeBzmA12/JTmPBk7tQMQ9Isyzo/1gE30MtcAT1V34/mCJZp0wkw
         l3NuB2xjR2TKih4xa0PvZUCHPHF1Kcsocet5cPVRDLSHU0RxiTn6gIYE9SpJX7h99miJ
         4XGmfLJhfVlNn2YymgQRw4FnDCh34uSr5S1V+/9Jp4l4clD+/x+WxVrJd0UH/iXzYPoJ
         +nvoo8iEPvivCPeyclwos5OfgftkaKi/GqJuMxTQnizvmqR0RuWXYGZcDppFckJ2p5xM
         0bsg==
X-Gm-Message-State: AOAM5312+uUgffn91KbHd5Fvg5/onBzK/syrY32NbmeLrYqJyHLPY3AK
	ZW0FuQEw36pCDxvImDlK7yXrff9/PjN7zCP84HI=
X-Google-Smtp-Source: ABdhPJy0GZrIe5zNLaUVWvpkQEhdSE5SyRuNy3xLo+mBgeLkzoe9GqWYeCwKlWOWRF03TD5UiExW0g==
X-Received: by 2002:aa7:c753:: with SMTP id c19mr6499661eds.33.1623936127113;
        Thu, 17 Jun 2021 06:22:07 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7d63:1645:b739:5196])
        by smtp.gmail.com with ESMTPSA id e22sm4340401edu.35.2021.06.17.06.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:22:06 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix bad handling of 32 bit ack
 wrap-around.
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <140f8561f1ba22d171c1acc35812b571b63c8836.1623831447.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <4184691c-684a-e188-b829-07667694756a@tessares.net>
Date: Thu, 17 Jun 2021 15:22:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <140f8561f1ba22d171c1acc35812b571b63c8836.1623831447.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/06/2021 10:19, Paolo Abeni wrote:
> When receiving 32 bits DSS ack from the peer, the MPTCP need
> to expand them to 64 bits value. The current code is buggy
> WRT detecting 32 bits ack wrap-around: when the wrap-around
> happens the current unsigned 32 bit ack value is lower than
> the previous one.
> 
> Additionally check for possible reverse wrap and make the helper
> visible, so that we could re-use it for the next patch.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
> Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

Now in the tree with Mat's RvB tag and without a dot at the end of the
commit title ;)

- 5345fa174b03: mptcp: fix bad handling of 32 bit ack wrap-around
- Results: 8c0eaeab091c..035a752fa93d

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210617T132140
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210617T132140

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
