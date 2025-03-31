Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6538218EB1;
	Mon, 31 Mar 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455095; cv=none; b=o3N5r+pdHx1Zx9rSIYMdV+nHTXECaNykZ1aHwZRBNbYsr07QmUylL9/RaWzwj/T/QMeAaHOM+nsIVFtVgH6FyR+vX1iG3L2geBox9nu31qf4H5KDXIoWkyQGygfvwo0Ldbwfvl7d/Bsd/xrzCsy+V645vZwEfGebD7HV8xzP880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455095; c=relaxed/simple;
	bh=U+1yEEOZzVsnuUOy+RsFKoOt/F2YbfNHQ5QjEgiuuAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3CAKiAFtgMoY3GonZUqi+4KfYCFXkKJidi51oIFzOlyoDeN9hVTYF7JAzHpsCUvtxesmEu2+1ewmXSgYAlVMithJjbB/IcZAh7ImNiFKHbRNzOBTcfx8sEz7LMdbt5+qyYsLlkkzJB/dTNmqvwA/Qgyc8cwKSh6tJj9dYulZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQjNOW7i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQjNOW7i"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22580c9ee0aso97925535ad.2;
        Mon, 31 Mar 2025 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743455093; x=1744059893; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYhYk9y2DXMVeKQttY/EQvcE7aZgDZ1TAkVyVBo9hSY=;
        b=DQjNOW7inlXN1c9rDX3T6bFlDfn1roOn75nVeESZ6KviqXVIZWEbJWem6Fx+pTw3FR
         AgBbCoUr/kC+4Xk4zL2DXpa+LeT7ACfvvhI8GQm/tfuBFVyk2+jEIwI34fLllGpvt917
         rP9gJJ6WsNZ7DzqWo0K2IEGu+SCbWSDPG4CXzq4fnWzJf7XTx5HlJvuPtA7mrCAp6/yA
         KWjDEABVEYgWIgoU+IGHV3lvan+qO1aYFOGj2KIJIkZNWUT08za6LQuXUAXBKcIDS2+Y
         yfJ95/1HWt0NiAAiDSi4v1+wcMe/UthB5nRQI/yO6+0TdA7vhfJJ7ZbnAuvjgfRUF8d6
         xLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743455093; x=1744059893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYhYk9y2DXMVeKQttY/EQvcE7aZgDZ1TAkVyVBo9hSY=;
        b=Z+pSUB6rsFmumHRQC7yaHvLMfXGd0dqz3IvjxVhT3IviOha4lxtmk9z+97eDShzIO2
         D2cepH0NG/jTEd4OKOjDM5Z6t/UD3RtNdJ7DyLFhL2G//TFtsowziAMs0q1S8wd+SVAZ
         Ro39HndOlNfI8u5nRvCMGV4BTncV7wgaArenvPZLCrW+wU8qEMBy3n8sISGENF1/Kqz3
         TmltTX/iXdnHCtKP51nMs9wxoX3VwW/Er4rbCUS9MVI8h4WtKgtc45HfV4R73kfASbH0
         5HnGeU5CtiEPP53lRcCWlQLWu6M91+GEnIYyM7ZhxlYmtwIdBa0BRrpn1bqDLWQgTJAV
         MecQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnBmvj8IrJFPLC56fVyX9wGapDzDGgbmpfXqgZ7J8jFyZB1Awn248+bh8HZLOa5K6K1IerEg==@lists.linux.dev, AJvYcCXiB/njbBgH0NgvxLLg+lJ42VFfLJCWhtiseE4fladjdeFDr4YZoUNJhSuRIGdq2D6itvRugNDzgBLhiGUqlLA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2lY28HLK3RJfqEI8SfYwnPEEWSV+P1wFxUDlSubRmDt2GOT40
	bw3ekbtQk0zPNqgkODBOubZIfSgcdY96RsEeGwtvKLurkFns17k=
X-Gm-Gg: ASbGnctn38E4bcU+uZhRmBy9/EvR0tIYBwl+Y//C+Y6UBuzeKG8mf2bfVP8XmYWPLhz
	E+Uh6Goprz00i00UL8ScKDjHF1MAasjycl9uZI7uuSSMiD0fBvU1xEb2/gS9nHtxCax5nPiTPGY
	58RjG3A3afK7iHOSwl8K/oaa9L+IfbYRSo/FJ1FpgI7aT+mH0GsMGAVAIBXYbynPhXsfgZ7PWY7
	x3YAiNhEL4sJlB3qIrNPg2f5I6E3kI1UeSvw3raZdIqZJAfYY6LVkiAbKIkyb/2NWwQPpNP0nLe
	BfoYg3+D8YffQhbvaOxn0GFwH36x6FttDzuCB5oX82arxsFVg2J2X8o=
X-Google-Smtp-Source: AGHT+IFXBij7YY6OTj5GMzGgIwp1/yPImE6Pq87f1IxAZ8AzDKSftLkrfp99lNthyITIW+quB0Qxkw==
X-Received: by 2002:a05:6a00:1412:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-739803bc866mr12795498b3a.13.1743455092825;
        Mon, 31 Mar 2025 14:04:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93ba10126sm6811351a12.75.2025.03.31.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:04:52 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:04:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Karsten Keil <isdn@linux-pingi.de>,
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
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
Message-ID: <Z-sDc-0qyfPZz9lv@mini-arch>
References: <cover.1743449872.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1743449872.git.metze@samba.org>

On 03/31, Stefan Metzmacher wrote:
> The motivation for this is to remove the SOL_SOCKET limitation
> from io_uring_cmd_getsockopt().
> 
> The reason for this limitation is that io_uring_cmd_getsockopt()
> passes a kernel pointer as optlen to do_sock_getsockopt()
> and can't reach the ops->getsockopt() path.
> 
> The first idea would be to change the optval and optlen arguments
> to the protocol specific hooks also to sockptr_t, as that
> is already used for setsockopt() and also by do_sock_getsockopt()
> sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> 
> But as Linus don't like 'sockptr_t' I used a different approach.
> 
> @Linus, would that optlen_t approach fit better for you?

[..]

> Instead of passing the optlen as user or kernel pointer,
> we only ever pass a kernel pointer and do the
> translation from/to userspace in do_sock_getsockopt().

At this point why not just fully embrace iov_iter? You have the size
now + the user (or kernel) pointer. Might as well do
s/sockptr_t/iov_iter/ conversion?
