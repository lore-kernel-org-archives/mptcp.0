Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA124C8E;
	Wed,  2 Apr 2025 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597327; cv=none; b=YgPA445zsrMbvPP6ZLXnG265EtVPDOBBczhIdQhbIRHJXC6wCaPlGf2FKbblkJMwmN+pBAT7k5LAFLrPuAc2Koh/UbATtg6ZAFmfZpcjIvt5O+CLkGIWxszeC/NMu/W2St4keH2EFwK7+6ogsC8hPJIZqmQU6g3witrbGXkIoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597327; c=relaxed/simple;
	bh=5x5voHAbthWztCnJTAxyUPzXr6ODagheOFflvD8Cgow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMA7oZUMCtonaVfpWJxkF+P0OJ7BSsOvWYg+QhSJkZK+hI/WxIvN1zTQQR7g1YfghwIV22VO40xeAgHkqNDHApafGqfZFCwT1Hv/91aD+Rqjj7hca6jJ9eGt6abJElLe4u2nZ6WAlNCmU/BzGqdHEMrwE8HJuLxjYxuNT6f9UeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaNEFnCy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaNEFnCy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3996af42857so578659f8f.0;
        Wed, 02 Apr 2025 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743597324; x=1744202124; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQPuk4z8aXO1/VwBQYL7UU05vvl1F/e5DxjIm3de0nQ=;
        b=LaNEFnCyoTw4wiSjolKrQIrEY2be+wrHYPUQAfOAnj4YWJcdGKyee72D+/mGyhANBk
         YIqf4+NYeCnWTSSFVpvvox9YJIpelnwYRX4ok+Uz9oTXACaGjwJXZzCFF5UPIZ1Rx8g3
         aohY5YGTPgesFzHMtoqF2+8MFP1pgc+HwhR/HhpPNCUgEoa1lzSLuS76zKOtb3hZF7Zi
         Z0IHTRLRy3xnGyWoUgHpzF6ai42furU4lwg3lISgdPlKGhRCxSALYdEpZmtx6sGDorNB
         AYX9NJHY2qeGHdb42hlv5ttaWEgJQRw0hMVdUjL3cyR3mKXfv6UlKbqdgZgFesxi7T2/
         bbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743597324; x=1744202124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQPuk4z8aXO1/VwBQYL7UU05vvl1F/e5DxjIm3de0nQ=;
        b=LDX/CePTWKBRueAUBoHC1mf8qhkkfe8en5AayIWEKFzRO1zvj8eCbrW9mK6HDGMARj
         vUr8X/eNYn7fKbiNYh2eGAPIf4yI/UtNSK1iKP51L7q1aBoL5To3tzOj00tua18XtcEC
         37k39M8qZ2vFgn8HaZPTCu1adPMd5Oto0RjjhtYdrFWPvH8Sqc5JrQn04Q/Mt129WwWO
         hTL11W1dIOAfO2/UC4R/VgXPQJElxreo28fAZU22uRkgvN2kr1UkBn0N1l8cs98gXAgE
         DHOBQhRGbSGriDK4zUWeggk7jS8JNHnn3avMzjYewaUWf+sCXF1Ka7e1zJq0fEo9mD1g
         fm7w==
X-Forwarded-Encrypted: i=1; AJvYcCWTFioysiMpTLM0pg0b9W//Orpp26jznWJpPWMKlOxnaqmPMEN5mBD4EFxYiDn0DtyaSItyhQ==@lists.linux.dev, AJvYcCXc9arCk1ZQp2k+sKPxNYa5HnwUoGVwWi8gGDj2mm2c6iW6slj0uar91EVZVx7Dsek33fHTRtgkG5KYIOP8/SU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt1SVU23snygg0h4RvRk2aciR7OzFWdJ/YZFpgZhSNyy/0CXfM
	wHfWcz2oJnk4yfQ7O0HIn6xVvYfK4EzjGmGLtzsz6p2xG8xMF9RD
X-Gm-Gg: ASbGnctg+EC3BHDOqqhPG81HJ9ZiOhAsrCwOMjM4IDl2Y7rKEHuzYI9ua5Qej6iFUVe
	JgsFes6pAvPXpif9ygX/e+u7btQoL3q5pi5i4ANGlQvRitHBQIKqijXqRx6t2O6zjh7mxDu2qcW
	VtCOXv2qSAFy/Xv2v2IpkK5ATz5iJDkZFmbOrUkihwP7jztMtc/zo4mpxiSuJtJf2cei3MZPM//
	8BHPscyV/0i0rZV6v4frIQBgsDlh2hC/v/tqMQHa2dOI0PmowHMLGBXX9bE79zC1a+9MIEZFLVL
	rXpcEkpYofdRFvqzKhvKNYasEPIj7FIwrsi40qmdB5kUgTtgmeQq5sx+vZCqujPNigqa0q883Im
	bILYYjtc=
X-Google-Smtp-Source: AGHT+IHaPOBKU7A29Yjs98Lc1iT7Oi631s03TvCGaxR6gPTH2ceLJBkQprnFjuTvnVXixjBxLkV5PQ==
X-Received: by 2002:a5d:648b:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-39c2a2c9272mr2009745f8f.0.1743597323750;
        Wed, 02 Apr 2025 05:35:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb613ae24sm19468475e9.40.2025.04.02.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 05:35:23 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:35:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>, Pavel
 Begunkov <asml.silence@gmail.com>, Breno Leitao <leitao@debian.org>, Jakub
 Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, Karsten Keil
 <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de
 Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, Neal Cardwell <ncardwell@google.com>, Joerg Reuter
 <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, Oleksij
 Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Alexandra Winter
 <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, James
 Chapman <jchapman@katalix.com>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Remi Denis-Courmont
 <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan
 Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony
 Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy
 <jmaloy@redhat.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-s390@vger.kernel.org, mptcp@lists.linux.dev,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net,
 virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
 bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
 io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via
 optlen_t to proto[_ops].getsockopt()
Message-ID: <20250402133520.40451468@pumpkin>
In-Reply-To: <CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com>
References: <cover.1743449872.git.metze@samba.org>
	<CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 17:40:19 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> "
> 
> On Mon, 31 Mar 2025 at 13:11, Stefan Metzmacher <metze@samba.org> wrote:
> >
> > But as Linus don't like 'sockptr_t' I used a different approach.  
> 
> So the sockptr_t thing has already happened. I hate it, and I think
> it's ugly as hell, but it is what it is.
> 
> I think it's a complete hack and having that "kernel or user" pointer
> flag is disgusting.

I have proposed a patch which replaced it with a structure.
That showed up some really hacky code in IIRC io_uring.

Using sockptr_t for the buffer was one thing, the generic code
can't copy the buffer to/from user because code lies about the length.

But using for the length is just brain-dead.
That is fixed size and can be copied from/to user by the wrapper.
The code bloat reduction will be significant.

	David

