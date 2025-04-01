Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFF202C43;
	Tue,  1 Apr 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509840; cv=none; b=hmw15woHNDBTkA2D+fddOw0IOdQPKrsKN5dBAj/+C7PCtdAvblJLrI78PRv2gRL/LBfIgzgHzQdx814p1B07zPcXUZF0zrBetl7bCS2sXtZPO/ET3UuZWG6cTpkXB2Ah1dnewVltEdJGuo8lrACzRTxGs0QM7a9JU6k5S8no4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509840; c=relaxed/simple;
	bh=3mz+zkd+0flPsLy0Ofm1nfq5/fbalcBJT6YtqE7p5ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8zeAEvoysEcIgNohRvdpRKXCNIOGs/ALc1FcAiwmMyEHnzs4WYD7LP16kJwEE2hHWhIWK5wZccMbXRvR063MsQ3cFIWaTIJJCBGxtaIkBhGAm2n9X6YUKNIS/qIXHNAmAFlQkJvcBa224zj37Sam10Oc4Bz2xsPQRPxRfwEHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so8869557a12.0;
        Tue, 01 Apr 2025 05:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743509836; x=1744114636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le/fZ22YF+TB0PY0qqmz1Qiiab5GI/mdQmTFzYxcG4I=;
        b=lGS8cPakR10lPsQP32dBYfw6VCRHwEUppLMrUGjGeuVUFBHhQ2hcxZvrxwjc4dpdxH
         EH282upxF8vxrWG8a8Y+NnHgSiHeR7/2nF1DUbhqkANtmramr71TbDjX1sbMjDyPosDO
         /Al/Py/MMpgp/CK2xVVIy8nvGlYGaGoSjdtfwcqovBotuv46ApZag9TU5AsukAExGVMI
         x1XWc47Ac4WsHrLY/BTFRpilQ5lbFdA/+TPXL4VKyCNlQyf2rHSXQU/l3ZIJ1vWQTEIy
         3WDRmJTG7S0XdpWK2nuuWFhNjIy83f2FVviZZ/QPZuvgETkNivofk0ocZRteX60HxI5y
         DuMA==
X-Forwarded-Encrypted: i=1; AJvYcCUJimNA5ofSI6Br4oJeya4nW4JsFP+U4aLDZn7zvvnNIr1e2VeZg27/JP+7LmCdhCQFHq0YrA==@lists.linux.dev, AJvYcCXDBqzVv4wFxz8sJKrkz4en+LmGRuCI2IfOOm+Ik8kfv9CCmvYi6H/qTOzNquY7c+/aK3/0HoOzjI1jTswSzF8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOVCCSWLk0yL+s506vVf+t3KAi8kpQdgzCq36gX63U5+l9zmem
	gm1iQ2JgYCtngG6VhQFnBiaWs5CL1yVTyMloVKjp+j7YbeRF6pn1
X-Gm-Gg: ASbGncs+vl3zxkVrxq5mIk5swwNunPuYTr775Yq02FZVjeT2BSCKHQ2emskKLC5eq0D
	brBaVaO3hadPMZWKhlJdr0bpVMWvITpTZpYnkdZRs8sEpTNsZ2uD82lFfdPX9vL76Ww7AtDmQpI
	rLFyGHJLyJJPAoyPDEzTrKSjJzPnCnTPdAkTGKeMCG6kCGbohg21euivmonC/y6T8CHd7sykwZP
	TbrfzZiK3mp2zc94p0TWXzlTCjKPwRa9vDrSSe6ha+DZ67powYKEw4zoNCfjha6rarz3phtxFVl
	83xGfhlHHy+hhe1yZiaF8Dx3P0fsDBrPbZM=
X-Google-Smtp-Source: AGHT+IFIWumNmX/1ZXWS3yLA6haOkNuwqHqavN++vEeVvWZeAOABaH1HwDwax0vsW9FqMkDo2Sxlag==
X-Received: by 2002:a05:6402:26c8:b0:5e5:be7f:a1f6 with SMTP id 4fb4d7f45d1cf-5edfcc021a5mr10721198a12.1.1743509836211;
        Tue, 01 Apr 2025 05:17:16 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16eda94sm7144316a12.33.2025.04.01.05.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:17:14 -0700 (PDT)
Date: Tue, 1 Apr 2025 05:17:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Karsten Keil <isdn@linux-pingi.de>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Joerg Reuter <jreuter@yaina.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	James Chapman <jchapman@katalix.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Martin Schiller <ms@dev.tdt.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org,
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
	tipc-discussion@lists.sourceforge.net,
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] net: introduce get_optlen() and put_optlen()
 helpers
Message-ID: <Z+vZRcbvh6r1fnZL@gmail.com>
References: <cover.1743449872.git.metze@samba.org>
 <156e83128747b2cf7c755bffa68f2519bd255f78.1743449872.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156e83128747b2cf7c755bffa68f2519bd255f78.1743449872.git.metze@samba.org>

Hello Stefan,

On Mon, Mar 31, 2025 at 10:10:53PM +0200, Stefan Metzmacher wrote:
> --- a/include/linux/sockptr.h
> +++ b/include/linux/sockptr.h
> @@ -169,4 +169,26 @@ static inline int check_zeroed_sockptr(sockptr_t src, size_t offset,
>  	return memchr_inv(src.kernel + offset, 0, size) == NULL;
>  }
>  
> +#define __check_optlen_t(__optlen)				\
> +({								\
> +	int __user *__ptr __maybe_unused = __optlen; 		\
> +	BUILD_BUG_ON(sizeof(*(__ptr)) != sizeof(int));		\
> +})

I am a bit confused about this macro. I understand that this macro's
goal is to check that __optlen is a pointer to an integer, otherwise
failed to build.

It is unclear to me if that is what it does. Let's suppose that __optlen
is not an integer pointer. Then:

> int __user *__ptr __maybe_unused = __optlen;

This will generate a compile failure/warning due invalid casting,
depending on -Wincompatible-pointer-types.

> BUILD_BUG_ON(sizeof(*(__ptr)) != sizeof(int));

Then this comparison will always false, since __ptr is a pointer to int,
and you are comparing the size of its content with the sizeof(int).
