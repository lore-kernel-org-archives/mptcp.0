Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6726218ADD;
	Mon, 31 Mar 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457793; cv=none; b=pTmtsdEuDBoyElYV0bWROe43C7JE3vH0mH9uOyyHVh7mdzXCjLPpp/gGeJd4XJHT+xMuyE74Mxh0sY9BcuXJF/4VGGK9mONrggIvM5bl/n6XvglrlhF5KTxYNzcaGnT8RpjYUyY0q5BHKwBBPmdlehKqVuXIsRRZK24RvUMsXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457793; c=relaxed/simple;
	bh=AWpak+pu550+V4KBVwcURhmwvApWhG8AaMXUc5d76HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGtx4Z7Z1sXkWDKLN6A6yHfzshyp7z0hpydEKH0Is4CY8pLTotMlPfNBMKjb4O8SdAxnrDFjpGAfvXAAzOjrqjll84u93efWd4+dJkLTrA+K419sEoY5LWxibW5pxkCLsW/j45T0tsSPSfk2oBRObu9Nl+sJr0szUfjJvTwaAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4/gluOw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4/gluOw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3965c995151so2642413f8f.1;
        Mon, 31 Mar 2025 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743457790; x=1744062590; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdstssp5d3ULMv78iW5ykH4+Ki4j9LIskO4UfhbPQIo=;
        b=c4/gluOw0di80mouD/HCuYS+VjkhrhTab5EVfpr0qACEZkelrrPvJpiE8N6mWY32jp
         hmyo6Hy8dddI34QQRfa93ncad1BQc+EPKTGxOzj9CfhIZmhUr1Od0G8Wpw7XeG96abRb
         ZzatfY4GMpq4BhyFhCvGDDJ4ABZ7GKYGwWuCwKCGTzwH5rKYr6ti/Lkfbdu1jEWI0sDB
         xK+Pt3ulLr/ocn1Bv5wh3CaaVXBTZ+bkMcOAjRjaVkvlMXmGCehpPjv2+ubRcYBomnC8
         /P+jZ5RcLf4jdb2DcSULujXAzFTCraGDUuF7qOrqRwEa/pK2sj9oeV+CnDOQpFL63l88
         I4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457790; x=1744062590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vdstssp5d3ULMv78iW5ykH4+Ki4j9LIskO4UfhbPQIo=;
        b=shvmDkMlDFnfMi/7Y4kDLTrBUiFBvhoYWOgnojD8A+nkgISvWL3iSSi3WQQuJ24oLD
         U5h8nkQmzqOItjaW3ZkUaBP1mjGxRB5TYI080bNi9ClRP36fktDmrdoHKERaW9I+7HzV
         MEUdo09wz4EuYfRCP+7ZtcVhOn8lQO2asEHaLJeCzJL1D0HYLHLgyFJVCiVWhMuGohVu
         iOu9uow21HL1yPU9On4SVcj8hmDpdxVNgTKSAWNXmcvCF99B9wh1w0or04H7kO4Jrbi9
         YPwefEXabQbNkdgVvlflfY9OaogklIZFsqvYorq+bEEKdVku2yndNsG21b5SR9TikXuw
         z53g==
X-Forwarded-Encrypted: i=1; AJvYcCVfbvS1MJb42z9LF9yCa96oxnpi6DNTrW3TBJgP5oEi5iax0Y3zfNkaQRym19P2XTCSZ7k5V05PKALCgdC5TGU=@lists.linux.dev, AJvYcCWiNdnog6Ih7pLtfX+CQ7FYQDS5Nzm6G7NYsTqpjtmKcBWGuz8KD+nPQXSYRDGVEAU4MdUIwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5qwljpZRc1BdKtCygUM7qhlVJ0avbLNzjYh3vH62KkKHzw1oS
	jJ/LbgyS1TOUha7SIU0Rqd8xNrf1xMDHynm7tiqt9F33kSn17PFi
X-Gm-Gg: ASbGncsW9vova7labb+XhUPyewVKf/OZoZR90TX+pmZR5VDdXzjTdim8hMyymcfln7K
	L368h0oFtu0mKo2ieRhOOcCiJgycw19eCMbnSH6zSlLHpci8X4cqyhGiHG/u1uU7hJ5oMFe63wQ
	1mLx1V9X8hB+M+tTfsdbpJs+MlMQtr0VI3IAh3fA59xybvl2/MxtmEFFRJH/PlJtegPdTtok+TM
	mmYMLB0pges7uDY1i0JnIEMQdAZhQommp4CoJxRZIEs8r1JFH6eZ9S0sVfGQHE6nFB66DTr0eOM
	ngHgxvKbv6wrXIQ7M1WF1sqotk83QNbUCVfIMuG8iUaIKtewhUCVxDvwDYX6+sdA6czuaq7vLJO
	mpRRWJuk=
X-Google-Smtp-Source: AGHT+IHDaz6qc5K6SYy9jlhEIozUCY4N2JwSt3T6Lks7AZ/C8EYmlUGrPLhFAhoyTSOCg3hYOLXzSQ==
X-Received: by 2002:a05:6000:18a8:b0:399:6d53:68d9 with SMTP id ffacd0b85a97d-39c12118aedmr9281669f8f.38.1743457789764;
        Mon, 31 Mar 2025 14:49:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4200sm12490080f8f.96.2025.03.31.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:49:48 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:49:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe
 <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Breno Leitao
 <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal
 <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David
 Ahern <dsahern@kernel.org>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Neal Cardwell
 <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp
 <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Robin van
 der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>,
 kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman
 <jchapman@katalix.com>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
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
Subject: Re: [RFC PATCH 3/4] net: pass a kernel pointer via 'optlen_t' to
 proto[ops].getsockopt() hooks
Message-ID: <20250331224946.13899fcf@pumpkin>
In-Reply-To: <d482e207223f434f0d306d3158b2142dceac4631.1743449872.git.metze@samba.org>
References: <cover.1743449872.git.metze@samba.org>
	<d482e207223f434f0d306d3158b2142dceac4631.1743449872.git.metze@samba.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 22:10:55 +0200
Stefan Metzmacher <metze@samba.org> wrote:

> The motivation for this is to remove the SOL_SOCKET limitation
> from io_uring_cmd_getsockopt().
> 
> The reason for this limitation is that io_uring_cmd_getsockopt()
> passes a kernel pointer.
> 
> The first idea would be to change the optval and optlen arguments
> to the protocol specific hooks also to sockptr_t, as that
> is already used for setsockopt() and also by do_sock_getsockopt()
> sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> 
> But as Linus don't like 'sockptr_t' I used a different approach.
> 
> Instead of passing the optlen as user or kernel pointer,
> we only ever pass a kernel pointer and do the
> translation from/to userspace in do_sock_getsockopt().
> 
> The simple solution would be to just remove the
> '__user' from the int *optlen argument, but it
> seems the compiler doesn't complain about
> '__user' vs. without it, so instead I used
> a helper struct in order to make sure everything
> compiles with a typesafe change.
> 
> That together with get_optlen() and put_optlen() helper
> macros make it relatively easy to review and check the
> behaviour is most likely unchanged.

I've looked into this before (and fallen down the patch rabbit hole).

I think the best (final) solution is to pass a validated non-negative
'optlen' into all getsockopt() functions and to have them usually return
either -errno or the modified length.
This simplifies 99% of the functions.

The problem case is functions that want to update the length and return
an error.
By best solution is to support return values of -errno << 20 | length
(as well as -errno and length).

There end up being some slight behaviour changes.
- Some code tries to 'undo' actions if the length can't be updated.
  I'm sure this is unnecessary and the recovery path is untested and
  could be buggy. Provided the kernel data is consistent there is
  no point trying to get code to recover from EFAULT.
  The 'length' has been read - so would also need to be readonly
  or unmapped by a second thread!
- A lot of getsockopt functions actually treat a negative length as 4.
  I think this 'bug' needs to preserved to avoid breaking applications.

The changes are mechanical but very widespread.

They also give the option of not writing back the length if unchanged.

	David
 
