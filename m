Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947342A87
	for <mptcp@lists.linux.dev>; Wed,  2 Apr 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628435; cv=none; b=NAqOLkGKQgHYnVv2eY9GHbVNCx/ViYjFug2iIm9Pd3SY0jOcCBqY0wbW9WnDCQXleKzK3lDWm2qxhphLaRbL+T9sD2MQeBQOJHORmhzWVebDoW0mvWL+6SN4dPccoc1YcDcFMstivEl109Nn5vqnqJQuEdEKnWpTj3YSXc9qnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628435; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0GURSffee7FLl0HNFDpC9NrBA12ksLEWiqTxaRXh2dGup6uG9TQJZGE/5nLAvb+6Zm4VG5khmHEXaFbqV1O4nPcibgXGoEArjfH46mHqAyzO1l+BK7kATH3lJQ84rEhe2+5mVII4PwMf5zg0CNPSdh3LfJisw7T0IJDbiwaAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FQPLYT0C; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FQPLYT0C"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so469062a12.3
        for <mptcp@lists.linux.dev>; Wed, 02 Apr 2025 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628432; x=1744233232; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=FQPLYT0CasBSfuX/YCuhXnsjxd5cTbbh4DqB6U6ItV3BaKealpIRZnIUwSPqah9dqr
         ZyOSARhGpksLAwKZeYtlXlZ7DOSuvB7lHM9jxQ1Ysfg5ikEc3Yoh/FN5Y9MHdC6QakX5
         RVDNMNdFeYOTCmXNxJxcXn6A6H3gQHkXcjxtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628432; x=1744233232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=nfv3xtPDtZpHOUY9LOOq9rxff2fhslm6wmLapd0gbQfHUQlkHG2jhMSsVLuvFlM8mM
         D0EmJc4FriNRNXaMAEg76wYZ8TxAjS2+sHIRWPt6Bx/CKCvxwrUmRC+9FTKxX8+rFImr
         IJR/unLZRLPci/svhEre5ehZcrudxpBbROMJxTgrIwZPq/X3NOE8eRQh8jgzaY3nrnUj
         s1zojHmhQmhYTCGr4BypbP7F0Ab720j8VVU4UbLS9qtrUcU2UJezGPIpTtLsQDZjT2Ry
         csHuWDffVfDZbsRUG9x65alp7/NFu9vzXd4PwZyoAi5kOt656UAkOR5sEkRohzjOtsCV
         f5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+FCanOZzOtvcFhonjeiDqDRnmbbtaaeCvzU204sywT2otxO9ClQe9zQo6GxV5VsX64iXZ+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqiM4z+JdnLY4gK8/WLS2EETC/j9vvNCUGsPSA7jL1qaH6OmFl
	eHxqR1WU05m82tM4JapU34GCj28dE73CbiwuV+qbB1a2Ovnuf3dfMDPSqSg7pLZBCHKjv2uLYwG
	aQgIAgQ==
X-Gm-Gg: ASbGncvTxyqQIsZfYAWKJV88FYeTvzDTnJBi7V1v25Iha+rwhGzNlcFqpJzCPlgvwgd
	2eTZAjMn7yGgl+FCBoz7hcUJe6sPYfNTIcONAy++N7HwrVnP5GsEXVTbBPKtxzDqW5UobmjMTLa
	dsyZqDHS2fpzBqgyZcLS9I9kTmCl4MA2PYgyAZ2BIQ0L9ACx0T/RLiFnkwutL4JXJUERpWO/hD4
	m6qfr7qvtUhT4QzRdKH5vkxZ/+J/HEe6NgRdEjhVgEh16gxwSjGubblkRp7tKIGJOQnB4+rJGkd
	9J1SnQC1g+5LltaDNm0bVXgadY5SFb9D9dLccxbFVq68gjiRBaiMSQ6+Eg88cnl02jR8pEt6n3T
	DcukzDlsV8DD+7tPh6cY=
X-Google-Smtp-Source: AGHT+IGawIUVeQ9EfoAoN3k9jsM0iAQqFozr8+3NJZ/HtT19W4L0V7m4luMDjk5JmNc4h6S1U+ae7A==
X-Received: by 2002:a17:907:3da9:b0:aaf:103a:e6e3 with SMTP id a640c23a62f3a-ac7bc235cb8mr19719666b.43.1743628432124;
        Wed, 02 Apr 2025 14:13:52 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192e7d6dsm959021266b.74.2025.04.02.14.13.51
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:13:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso337552a12.2
        for <mptcp@lists.linux.dev>; Wed, 02 Apr 2025 14:13:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKPU1wVU8HYxUFM4wS4Xv5RyTF+k/MokSLf+2XmoXelOzCCl84fKezmah3etrYnaytlnY4KQ==@lists.linux.dev
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus
