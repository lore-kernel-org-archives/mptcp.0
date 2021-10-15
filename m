Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA472
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634298426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mi8B7dUnSXMIVUlo2xUhNo3adrSzMEc/i5kRU+yy11c=;
	b=Uy+EIepyKAK8nndYygb8948naYL/TDp+JG+qaNBu0aBO13aIYycYh8FDhq5UlLNkD9nj8F
	Vr+YSDXS5ib1Um3mjIEPUuDXqaeXp0LCDad0fwhMrFndv+QB6lwCENJBFVjg7WEvi70foc
	H7LxlDw4k88/GT50KHItL10+ESkfu8Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-VhNaRX0eOB-zsmo7upN0nA-1; Fri, 15 Oct 2021 07:47:05 -0400
X-MC-Unique: VhNaRX0eOB-zsmo7upN0nA-1
Received: by mail-wm1-f69.google.com with SMTP id d7-20020a1c7307000000b0030d6982305bso782123wmb.5
        for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 04:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Mi8B7dUnSXMIVUlo2xUhNo3adrSzMEc/i5kRU+yy11c=;
        b=CGZTMiU7VAHF1Ghs/d8CDFrryR8NEpNKrsd7JdNrsTCJPkT+0UNiyTHyIBYFT7yeIv
         EMgqWcqpIUX5i7DcCqfPlsnBAk8ysbZYU7ta57uTT9nKIkBC5wb5yCqKghzg9M2mjhob
         9tDhgy/6tXnK0T37lBkozU/3q+jUchPK4VAwj2ZZVyLUSGMTzEB/xhOSvaB3CJQdClTH
         O/DvujNPqRYiocGcc3AWLH2fMFBNywa2zDi8ahjnitBdTQbnhb150mX2VQizDmrPrd4P
         FzNK13TjC0JktNuez8xRNJCzkHKU9lOJ1O5ZxUfmxwuPxPKKGcMq07UDRmlezioP7Wml
         yp1A==
X-Gm-Message-State: AOAM531wWvWmVf3h6hXLpvad6bxgm7WgzpUBRpKpk0ZPhCohCf3PVJGi
	/CPN0ffANz+x9H4004+yYethmrdNkhMJuRZIhyDx2Jb0iGv5fWGv0nuUt3OZ4qKt6u4vlO7H73/
	9z5BbWRl40eTe8j/SOpeXzbPmGipGIE5GkFHpF7xqgbDyXCrvlde7kU7mDptVa7JE
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr13649110wrz.20.1634298424258;
        Fri, 15 Oct 2021 04:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwXDa5ESSKo5LPltiY/m7+h0FFntfOsWBYvY3Q3E1n95OUvpBfa+3nZn4cG7ktQ944JlQcPA==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr13649084wrz.20.1634298424012;
        Fri, 15 Oct 2021 04:47:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-16.dyn.eolo.it. [146.241.231.16])
        by smtp.gmail.com with ESMTPSA id c77sm4613817wme.48.2021.10.15.04.47.03
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:47:03 -0700 (PDT)
Message-ID: <f747eec30fe0a450bc734dd536bf3552e4ccfd16.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] mptcp: allocate fwd memory separatelly
 on the rx and tx path
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 15 Oct 2021 13:47:02 +0200
In-Reply-To: <7c175c9533f66651a3641830683ce804f3915c3b.1634289695.git.pabeni@redhat.com>
References: <cover.1634289695.git.pabeni@redhat.com>
	 <7c175c9533f66651a3641830683ce804f3915c3b.1634289695.git.pabeni@redhat.com>
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

On Fri, 2021-10-15 at 11:25 +0200, Paolo Abeni wrote:
> @@ -2954,6 +2909,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
>  
>  	/* move to sk_receive_queue, sk_stream_kill_queues will purge it */
>  	skb_queue_splice_tail_init(&msk->receive_queue, &sk->sk_receive_queue);
> +	__skb_queue_purge(&sk->sk_receive_queue);
> +	sk->sk_forward_alloc += msk->rmem_fwd_alloc;
> +	msk->rmem_fwd_alloc = 0;
>  
>  	skb_rbtree_purge(&msk->out_of_order_queue);

whoops, bug above: skb_rbtree_purge() must be called before moving the
fwd rmem into sk_forward_alloc. Another iteration needed ;)

Still addiotional comments more then welcome!

/P

