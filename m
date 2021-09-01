Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758203FC3
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630493529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lm4mR3JYlL5ip2He+sEf0zphXUTsvwT6BkT7jCH1eyc=;
	b=ZGVYoHmBsTYdlDbrUdJjEQNfL0+FMnTEaJ/rUTjrxrO5he+3J/tfaDsKwJXSqaq/hsLIj6
	AvzohNT1vQEcbN0GWEec/AQl2EAVuFa+LT5lE1cSo0tXXuZIjC12DqEWq61stgTxqbHMrh
	bo+7HBtr9ip712BjNkDxcv9I3QoVgL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Yl_7F96SMg2KpG6RuMM5Pw-1; Wed, 01 Sep 2021 06:52:08 -0400
X-MC-Unique: Yl_7F96SMg2KpG6RuMM5Pw-1
Received: by mail-wm1-f72.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so2639294wml.5
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 03:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lm4mR3JYlL5ip2He+sEf0zphXUTsvwT6BkT7jCH1eyc=;
        b=Qtg2mN7XszSYdYpR3obqDiGx9eiYaHAlDuzFRsrK03tS1+QOCk6S8gJGFy22z+UT/M
         MoSkM2qaRFMPgWEAaEi556JwB/XaD/UfNzOFNmeaVquy4sR9v6dphKv0d1FKxhbR+aJW
         HEPJylbyCCJ5yiyN08Uls+oTyIdrB3R7A867yAmNxbcEu51kJCpJxL0hRhRpLFBjFVfK
         XFZuR5f//nS/LViMu4SZjqHCsqZToXzp/g916YXBh54+TiBeL1PeDjdTnUbROB9LwDyT
         ny1OYoI9/FHTKgj8V68TDz0xQWXe67ZsS97IQeS9AHy5chBgHreQO907Up70XrTbqirH
         dzOg==
X-Gm-Message-State: AOAM532CLO3KEq/eDsIKqOJpSxhDg47ScClms19EyLxv/ww3X35CtaWi
	HeLxvHtrkl00UalQP6yT9cup/bPkMP3CcMV6bs58elQxkuZ2dEvaFhuD3wdgCt1bMW7my3SZdsd
	D+AXXdqBguXTaE9U=
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr35464988wrw.415.1630493526918;
        Wed, 01 Sep 2021 03:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyAY00ddiyzLDaqJY4HYxreDLtYrqdI7O3mR8VxvpDttJ01uAFBJixyKRBDKpoz3ljAanyXg==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr35464967wrw.415.1630493526747;
        Wed, 01 Sep 2021 03:52:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id a10sm4932882wmj.44.2021.09.01.03.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 03:52:06 -0700 (PDT)
Message-ID: <9c9ef2228dfcb950b5c75382bd421c6169e547a0.camel@redhat.com>
Subject: Re: [PATCH net-next] tcp: add tcp_tx_skb_cache_key checking in
 sk_stream_alloc_skb()
From: Paolo Abeni <pabeni@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  MPTCP Upstream <mptcp@lists.linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@openeuler.org, edumazet@google.com, yoshfuji@linux-ipv6.org, 
	dsahern@kernel.org
Date: Wed, 01 Sep 2021 12:52:05 +0200
In-Reply-To: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
References: <1630492744-60396-1-git-send-email-linyunsheng@huawei.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-09-01 at 18:39 +0800, Yunsheng Lin wrote:
> Since tcp_tx_skb_cache is disabled by default in:
> commit 0b7d7f6b2208 ("tcp: add tcp_tx_skb_cache sysctl")
> 
> Add tcp_tx_skb_cache_key checking in sk_stream_alloc_skb() to
> avoid possible branch-misses.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Note that MPTCP is currently exploiting sk->sk_tx_skb_cache. If we get
this patch goes in as-is, it will break mptcp.

One possible solution would be to let mptcp usage enable sk-
>sk_tx_skb_cache, but that has relevant side effects on plain TCP. 

Another options would be re-work once again the mptcp xmit path to
avoid using sk->sk_tx_skb_cache.

Cheers,

Paolo



