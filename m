Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD211A5BB0;
	Tue,  1 Apr 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522344; cv=none; b=E9lcTbCTcqaiA4XaY6sps4A+q3h+5hfyxoVmvrOTpP821Sd09ESWKp2/8mUreIMG1JeiY/b43seV8T5Kyf9rwysnswNeG0MAPHYY22cYRt4kPdpsAV7IpMTZfJsU4chWK0lJrcqnQK6sZjaynF5J2mwGgTNj7jbugdiNR6D0WjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522344; c=relaxed/simple;
	bh=WBy7/6zN4feM/TeCGcXiAJPz1NiTYo51RtnynhTaOM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF4xALAKLO67GBmk/VUPSJ8wmnooPp56jgV5GpUW3dS344/HFTuHr12e/PYFe3pO//uyV8fmUVA07RDnrn963/tQ4N6I6qWl/QcsaAmpov01DE/R6m1m6guNhxE19Q+jWEzBMJyoK61b9cjoW0PKgDnu3cfJV/ZxNXq0bZZldag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQQkp6Rk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQQkp6Rk"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so41144765ad.0;
        Tue, 01 Apr 2025 08:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743522341; x=1744127141; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kzegyg8cpGoKhVLZCKUfoTEzY8SEhsuSorY4Wg6W7wk=;
        b=YQQkp6RkObMrvWCq/2zfkqOG+23vkkL5FLM+J6ZHZg1nz3sbWPztszD6Ibb947Ci5o
         GmaNoNH22r+g7d6aAUsSoE521wl9U1x/fYJ87YoXNEPh6i/MAhM/YejFnHYkIxFM6g5i
         tgJHZ3IBBHm5gUXtey95m2gfwFMB+j81kgjuPw56PmnHBerQ/tcxX4b2p6j4YXx5O3nQ
         c7DiUiZKTOvAwVEBbT8uV5vLt4URy6OicEBBL//fCsuonZwWigZcU0QXqp+Vgm11u2GP
         7nvuHrsiReezXOWqx1OsTDUYWRyb4C7aLb9R1Y4PumczFdWZ4aWW1FclkP8dGjUNR02K
         SPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743522341; x=1744127141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kzegyg8cpGoKhVLZCKUfoTEzY8SEhsuSorY4Wg6W7wk=;
        b=RqZAKXK9rg/kpUqIWXDEBdcFP5wD2/3NnG3SoWB5JNrXMFkd9lG95reXmi46TYtf1n
         zoan3FagBF6IokfBXzWWp8vNKgtue7xDgxsdD+QpWoWkIOZjQgS1fJcm8RGMQfpHWRoV
         botMzAHR1sO2v4Ywiw5ze+7bNABNgAZYDRlW0IVYYYaX3n7vWGXISM/Br876j9Xs+G91
         W6U+ubAdX6qSlCRnfOQX7JOoA6Jf22CibdNaJocX+YapsJ9gE2Pznev/+ftMGSRJ3VOs
         9EBAo2syNeNudQlr8b1sta0mAIIk74BMY6tGSY7XhS4WNI3C0FeY+URavh5oyn5Esfp2
         rQvg==
X-Forwarded-Encrypted: i=1; AJvYcCWG9UIr714XLyTrA8k6RH5sDOsAEj9VFvaJXZSc5tfFJEUdZQZz9jais7qp6zi/znZZOlUDAA==@lists.linux.dev, AJvYcCXbL8RfQ2Kqw6BnwJJnlG6UcVXKHwh9KH7a00eIyJ1nT7Bnax/mdsSnD97wJ/sjmuxx3rp4EqK+0g0Bf5mMWck=@lists.linux.dev
X-Gm-Message-State: AOJu0YxfwykFPbrsXx7RniPyyezROFWUfwDjwpWzCXfpGRCZ4EI/nDCZ
	yV+ok6fbiVz4PMHgaWgpTKtTlwHH4LKV7coFnD90hqEtPs3HH80=
X-Gm-Gg: ASbGncu8H0+SQnPS34HA01oGXwoT1X4+Vo+l45quaD9/4Hz5S4WxphhbTJAsoHJjyY4
	CWZ/7dIX2EAoZXfdkNAWg35IFvY2oPdR2ADY75Ib/PnGAo5y06ED2Sm5DcDprjSPKyHDj8dBwYS
	HO7UtMy7LobIQNHjrE1Q5SuZ0bZl0/Fkazjd9+Cv5QQmEYUE2itO2cXzuSqPWTZrstDsQUjBL/b
	JfNp/M1bhh0PnuTC2U4M8K/pjFgX1hOolO/vyGOKpVu6oUO2yAnzdyRkj7bgUGkFNuMZAymSoS5
	nMgVmjlbp+D7YZucLlE8a4tvoGtz7UdInz3aDD+2bt5S
X-Google-Smtp-Source: AGHT+IF8/7u5sPPUnxUKs7/1U46BgrbqaNr+VNf0UHTBb569zkxnb+rV1+QWTbUu5Xora+LmVv4FIA==
X-Received: by 2002:a17:902:d54f:b0:224:1074:63a0 with SMTP id d9443c01a7336-2292f9e62bfmr264543585ad.34.1743522341280;
        Tue, 01 Apr 2025 08:45:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eec6f91sm90062555ad.17.2025.04.01.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:45:40 -0700 (PDT)
Date: Tue, 1 Apr 2025 08:45:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Stefan Metzmacher <metze@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <Z-wKI1rQGSgrsjbl@mini-arch>
References: <cover.1743449872.git.metze@samba.org>
 <Z-sDc-0qyfPZz9lv@mini-arch>
 <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org>
 <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+wH1oYOr1dlKeyN@gmail.com>

On 04/01, Breno Leitao wrote:
> On Tue, Apr 01, 2025 at 03:48:58PM +0200, Stefan Metzmacher wrote:
> > Am 01.04.25 um 15:37 schrieb Stefan Metzmacher:
> > > Am 01.04.25 um 10:19 schrieb Stefan Metzmacher:
> > > > Am 31.03.25 um 23:04 schrieb Stanislav Fomichev:
> > > > > On 03/31, Stefan Metzmacher wrote:
> > > > > > The motivation for this is to remove the SOL_SOCKET limitation
> > > > > > from io_uring_cmd_getsockopt().
> > > > > > 
> > > > > > The reason for this limitation is that io_uring_cmd_getsockopt()
> > > > > > passes a kernel pointer as optlen to do_sock_getsockopt()
> > > > > > and can't reach the ops->getsockopt() path.
> > > > > > 
> > > > > > The first idea would be to change the optval and optlen arguments
> > > > > > to the protocol specific hooks also to sockptr_t, as that
> > > > > > is already used for setsockopt() and also by do_sock_getsockopt()
> > > > > > sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> > > > > > 
> > > > > > But as Linus don't like 'sockptr_t' I used a different approach.
> > > > > > 
> > > > > > @Linus, would that optlen_t approach fit better for you?
> > > > > 
> > > > > [..]
> > > > > 
> > > > > > Instead of passing the optlen as user or kernel pointer,
> > > > > > we only ever pass a kernel pointer and do the
> > > > > > translation from/to userspace in do_sock_getsockopt().
> > > > > 
> > > > > At this point why not just fully embrace iov_iter? You have the size
> > > > > now + the user (or kernel) pointer. Might as well do
> > > > > s/sockptr_t/iov_iter/ conversion?
> > > > 
> > > > I think that would only be possible if we introduce
> > > > proto[_ops].getsockopt_iter() and then convert the implementations
> > > > step by step. Doing it all in one go has a lot of potential to break
> > > > the uapi. I could try to convert things like socket, ip and tcp myself, but
> > > > the rest needs to be converted by the maintainer of the specific protocol,
> > > > as it needs to be tested. As there are crazy things happening in the existing
> > > > implementations, e.g. some getsockopt() implementations use optval as in and out
> > > > buffer.
> > > > 
> > > > I first tried to convert both optval and optlen of getsockopt to sockptr_t,
> > > > and that showed that touching the optval part starts to get complex very soon,
> > > > see https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=141912166473bf8843ec6ace76dc9c6945adafd1
> > > > (note it didn't converted everything, I gave up after hitting
> > > > sctp_getsockopt_peer_addrs and sctp_getsockopt_local_addrs.
> > > > sctp_getsockopt_context, sctp_getsockopt_maxseg, sctp_getsockopt_associnfo and maybe
> > > > more are the ones also doing both copy_from_user and copy_to_user on optval)
> > > > 
> > > > I come also across one implementation that returned -ERANGE because *optlen was
> > > > too short and put the required length into *optlen, which means the returned
> > > > *optlen is larger than the optval buffer given from userspace.
> > > > 
> > > > Because of all these strange things I tried to do a minimal change
> > > > in order to get rid of the io_uring limitation and only converted
> > > > optlen and leave optval as is.
> > > > 
> > > > In order to have a patchset that has a low risk to cause regressions.
> > > > 
> > > > But as alternative introducing a prototype like this:
> > > > 
> > > >          int (*getsockopt_iter)(struct socket *sock, int level, int optname,
> > > >                                 struct iov_iter *optval_iter);
> > > > 
> > > > That returns a non-negative value which can be placed into *optlen
> > > > or negative value as error and *optlen will not be changed on error.
> > > > optval_iter will get direction ITER_DEST, so it can only be written to.
> > > > 
> > > > Implementations could then opt in for the new interface and
> > > > allow do_sock_getsockopt() work also for the io_uring case,
> > > > while all others would still get -EOPNOTSUPP.
> > > > 
> > > > So what should be the way to go?
> > > 
> > > Ok, I've added the infrastructure for getsockopt_iter, see below,
> > > but the first part I wanted to convert was
> > > tcp_ao_copy_mkts_to_user() and that also reads from userspace before
> > > writing.
> > > 
> > > So we could go with the optlen_t approach, or we need
> > > logic for ITER_BOTH or pass two iov_iters one with ITER_SRC and one
> > > with ITER_DEST...
> > > 
> > > So who wants to decide?
> > 
> > I just noticed that it's even possible in same cases
> > to pass in a short buffer to optval, but have a longer value in optlen,
> > hci_sock_getsockopt() with SOL_BLUETOOTH completely ignores optlen.
> > 
> > This makes it really hard to believe that trying to use iov_iter for this
> > is a good idea :-(
> 
> That was my finding as well a while ago, when I was planning to get the
> __user pointers converted to iov_iter. There are some weird ways of
> using optlen and optval, which makes them non-trivial to covert to
> iov_iter.

Can we ignore all non-ip/tcp/udp cases for now? This should cover +90%
of useful socket opts. See if there are any obvious problems with them
and if not, try converting. The rest we can cover separately when/if
needed.
