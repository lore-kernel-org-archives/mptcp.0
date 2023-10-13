Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C8101FD
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuXk3ZF8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697189116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fjn1YV4eLF+7JWF9dlwWrMJB0WcDm1Pdq0sVQRaGc5A=;
	b=SuXk3ZF8OQnS5jK8xD218puQY2peS9JxPg0amEbyaGnjAmd5EZu87FRwhc5nKZ6FwnTY8Q
	PMyyARMY2vRs+pTeYQ07JvCbB+WNtpKWPCJ1rMsuNnc2a3ZEff4O0HYJVHkr6wS29ZemSF
	K+9VI0yMHlRA0bdJ3nh4Bz5JpVzuMk0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-jDljjX25NtClz0dViU-8Gg-1; Fri, 13 Oct 2023 05:25:14 -0400
X-MC-Unique: jDljjX25NtClz0dViU-8Gg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae56805c41so37058366b.0
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189113; x=1697793913;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjn1YV4eLF+7JWF9dlwWrMJB0WcDm1Pdq0sVQRaGc5A=;
        b=Mo5CaGInDCj8Vb9C6erYOgn7c4G8vASejS0oqi13VxD1WLjbVMzuMoF7bF09qPkb8A
         /txfUDuDI745LCDIJ/LdGSKjBdbs7NyvB6mzn4nOtsuswso8L9hMzu3Q6QUGHQnQFscc
         u9cMRCBEFMa6FlR7PXugOgcy2Bhg+5u/GLTOLk9x529k/CpNQEpq+aORhW12ivsDJMpZ
         QDb/i2IlnWMfLmKhK01L/Wp71AICeASp+qICv++dKHF7XjoNkGpJq93iissn5fSK1IFd
         gZsm/7FI0mJYYUoWbo71pwKVOL0dpWZPx7dx9AP+Hw73YKfD0JnAuY0lMaYwj3EPrfbp
         VfGw==
X-Gm-Message-State: AOJu0YxoyuYQHTGiaBSgnZ/xGfYUdMnBM0q3EjV7ZLIHzYy7+pYPaidw
	ptIUNkYhmY8Eqwq6sUy/AxTABWVLUfB7q9iOMCoxrPjG6MCInzRcCm1DnV7o89j8Lv5XaAuaG67
	HFgjx/9U9H47QxGc9kgf9v5M=
X-Received: by 2002:a17:906:ce:b0:9b2:bf2d:6b66 with SMTP id 14-20020a17090600ce00b009b2bf2d6b66mr18193334eji.7.1697189113494;
        Fri, 13 Oct 2023 02:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr+837x+kVjqot8JEkZBODUszPSIhc19ogZqkkNL0o9Wua7mSF4xzNk4myf/cU55dU3/8I2Q==
X-Received: by 2002:a17:906:ce:b0:9b2:bf2d:6b66 with SMTP id 14-20020a17090600ce00b009b2bf2d6b66mr18193324eji.7.1697189113148;
        Fri, 13 Oct 2023 02:25:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-54.dyn.eolo.it. [146.241.235.54])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709066bd800b009b29668fce7sm12072519ejs.113.2023.10.13.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:25:12 -0700 (PDT)
Message-ID: <8918fc5c5d112b6cbfd0ac28345a1c33afcb09b9.camel@redhat.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads
 are waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Xin Guo <guoxin0309@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>,  mptcp@lists.linux.dev, Boris Pismenny
 <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Date: Fri, 13 Oct 2023 11:25:11 +0200
In-Reply-To: <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com>
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
	 <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
	 <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2023-10-13 at 12:42 +0800, Xin Guo wrote:
> In my view, this patch is NOT so good, and it seems that trying to fix
> a problem temporarily without knowing its root cause,

First thing first, please avoid top posting when replying to the ML.

I don't follow the above statement. The root case of the problem
addressed here is stated in the commit message: the blamed commit
explicitly disables a functionality used by the user-space. We must
avoid breaking the user-space.

> because sk_wait_event function should know nothing about the other
> functions were called or not,
> but now this patch added a logic to let sk_wait_event know the
> specific tcp_dissconnect function was called by other threads or NOT,
> honestly speaking, it is NOT a good designation,

Why?

> so what is root cause about the problem which [0] commit want to fix?

The mentioned commit changelog is quite descriptive about the problem,
please read it.

> can we have a way to fix it directly instead of denying
> tcp_disconnect() when threads are waiting?

Yes, this patch.


Cheers,

Paolo

