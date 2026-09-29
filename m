Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA795514751
	for <mptcp@lists.linux.dev>; Tue, 29 Sep 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688972; cv=none; b=P4QsobVur7t5b+FWoZp38EN+3KwKx1H54KPRRhEvNGUqtq5HsSUvTNDqRlKUL8DvfpW65MQFd1cptpiabtsFPxHf2o8qwbTtoSBNl9/yNGyZTrKiIKPCw6fnvyiYAcwiET5/22sPr4WMo5tKpHPVqNFu0uRF7iCAmKF/iF4rGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688972; c=relaxed/simple;
	bh=MALsIQkWBc8oYjqtYr61DybGua6MQV6D+0TTQi5Zuik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGo3+39En2lFECd2sEdj+KyyjqFtWRFkawPVsnUmVeqkRI8Kqg6CP30Ky49Pht/qh7OmgjiAcW70qG4uh2vYwqdWV0A0TRV8UxKe+YECZEM9Xv6jy1VozLbndGTgINFFEKsAc6HOG87mQW9VHHspAHbuMt1tcEvp65kZMQ0gy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=aH2dAAAa; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="aH2dAAAa"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf8415866so5400396a12.0
        for <mptcp@lists.linux.dev>; Tue, 29 Sep 2026 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790688969; x=1791293769; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=aH2dAAAakxtdNp6MHdtsYUB9IM8Z5OFRRL5NOx9Q1nDAGLke1fxKkCplPq13eVOreu
         qdZCmS08LlWJ+hrmqBkPFVT2vyAwHipNZzYqWlbjb01BRf8t7cDgf18G9sQxA/UzEPnA
         v3IJbirGRwh2Qsa/hfNgV/HSJscjANcbkGP3G4zf0YRoao+OHQeofTQwYcFaEJMADNDw
         ZG3k5yF1RbfFZX7uHXFy3IIVohJDNy9LMc9Nj7wa4tDXf9FefIKH5xioXim2Qi2hPoz3
         mGBp36zDEcKrtH3V4W1BFj/O7M3LGmQDylk0LR8CcKDQrwXApfT5g5BfdGmQiWVnP5jY
         VsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688969; x=1791293769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+tOBR8m32zYZZOoraKtqO3ebIcizY6A4dWIJE00zfvo=;
        b=Z1HYqlmbOraY8jI6EeTomVSr2jHo2tNn02ZFIskUmLuq2HGTK6fWgnM3QaVne37/6Q
         /4YDOvwocAerJ3QKAq9z0L5ym7FqP1kDssXCdlJSl9/IGGHRDsFdCEiqwPk09vgMaKV1
         Arw6lKtsw/4FXWZMMLKtbjVl+Q3i8z0HiENCaRdP/k1pk7HW4pJXkOQxYxJLGWXcB+/J
         KYDOi6OCbU0Y4lCpy0CWjK5LAa8Tpszm+d20ctW+EXcoGXEj8bUoJbpW/YMnmQI2fGqU
         nEa2gWclWsBYYyJZE0KAfBmz3Kn0cHi9YiWMFazrM3K1UYnHXU73TtT10Mx/jVXLoUpV
         2Tug==
X-Forwarded-Encrypted: i=1; AKwUvBwjauZE3glP0PyILzjruTL5HDrCgHTZtl/CEEPuiYkKMhFTWY44MSG6ZPoUnYYOzp3g9jsXTA==@lists.linux.dev
X-Gm-Message-State: AFuF++lnPGFYSL6JQPjkM9/YAlDoSs2fvqPewSuFB0tj4ptGTUMhUJ2V
	JyTOXrUsgAgKpZVYLnxDLn6abndbTdYzW1ITbraP5pde1FRgytFH42xNRcTmJ6He4tM=
X-Gm-Gg: AYBFou0IJaKAjzorYofZo+uTvM5gd51A64NbFL4+Mdmr8HZ9xyHtUBZBiWsPq21GzFO
	tIk8fC3N1YLiha5z/rkqSwx5myD68hRHr7Wz1h5V8rRgb/pP6fQbtx1MTiDVSCNO+UpiDjtaoQt
	zuuln1qRS81JaTp0mzHgx5dg0Kb2g7+wS+RavZoDdz1+XBeBcHz5eUuARIwDgDyOSfCmZJ61/n7
	WopJU9KnRfL7qGlC+hdO/r3bTeTISjg/TqFdRGjDZhtyTmvREPOaYRlp92u1wdC1Azc73eMDCWW
	SuShee9YaVO8PH6YBeXp47og0oHsrWflYbnJqDaUOW2qRs6jhgqGJCIYYkZoFXt9uzV0dO5OH3i
	dUw7MlHJGzFU8OzR69UJO473dD5QSBFWQ0hE36Cb8lYXrqEmen69mGyVuldo0Q7DRBq9/kj2yQF
	4UPo/LtuymPEk6ddg46tkARzXFSwbNs3ypQw3Gvj9V8VeCRCbeEVMOFzXM71rpyNeFjn2KVdvk1
	HxCo3ItB5KartZgoSf83o8bYLXatyGuw0dIKo3agsiAkckJmErCawrk1O59J6exIQpK2mu62Q==
X-Received: by 2002:a17:906:6a14:b0:c2d:ca78:ea83 with SMTP id a640c23a62f3a-c2dca78ed66mr642618166b.38.1790688968778;
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Received: from [192.168.40.198] (093111099180.atmpu0044.highway.a1.net. [93.111.99.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2df76fad17sm107201466b.60.2026.09.29.06.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:36:08 -0700 (PDT)
Message-ID: <3c683f06-4214-4e0c-b568-a2458fba0cd3@linbit.com>
Date: Tue, 29 Sep 2026 15:36:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 6/9] drbd: use sk_set_nospace()
To: Eric Dumazet <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Aring <aahringo@redhat.com>,
 David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 mptcp@lists.linux.dev, Wen Gu <guwen@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, Allison Henderson <achender@kernel.org>,
 rds-devel@oss.oracle.com, Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260929071743.23624-1-edumazet@kernel.org>
 <20260929071743.23624-7-edumazet@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260929071743.23624-7-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/26 09:17, Eric Dumazet wrote:
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
> 
> No functional change intended.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>   drivers/block/drbd/drbd_worker.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
