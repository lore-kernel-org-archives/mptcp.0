Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F21F5852;
	Wed,  2 Apr 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637161; cv=none; b=JXZH5gISWXLU5UjUmqKqiEHqubpLR67Chx6NJj1kOnnUtqMgUz72/XijwD5mHfeOwb8kLJolvBLu4TIlm9JsbRydJ4+J+g4Cju3UKWBzg97GGy6yWo9DBZ0PmId5yJbiICn3sDH7ZPC0S7VAq4LL4cr12mi++B0GLEgmKGG+rQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637161; c=relaxed/simple;
	bh=ujCIppBBlXsu7jSBx6FdFc2PcSlazzqsZZLrsbMuQZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYgW9cjXcKPa+6647YMdOZRaxY/tl6JZd2PgVpjlP1QPnBivGzYJatIMprRvoLz2p6cMbiK04mGXxCv9+NfgvdL1VM6jCnQOqY+mLutpB5yJhv48MI52AvAov64Nxh9mRWyuXeLiupWxj5+/t4DbH98FmEU1ylQQCk6A+wlKiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt6awWHB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt6awWHB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22580c9ee0aso3671805ad.2;
        Wed, 02 Apr 2025 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743637159; x=1744241959; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wuxalq7LD9or9m6/ZAmPE3itU8gj0v3bHb/TuqhHJM4=;
        b=Wt6awWHBRfhLzdA/0FME5Q/rs78GbOZk3HOrqmHx7d5Kt9yU9Y/Wmfmy6qtdeTOzU9
         /pbPOW5P/B9V6oR7isg2fnu260Vwy62dorKZiHsO3oBS7WoVvlkAaoqJlpPWpUK7NlgC
         kEkGSB2xTLuEB5pKIzw9G0VSkOJrCD0bFgXjXkTiuv2EiDKS+nxA91+ZBJMe7+PyC9Uw
         /5i5P2ssMX15fMvyCEqFzlQpS9J65aCWBnPPUr8EcGKP0zWYsuNgXf8nOdj9bM48siyv
         u4OCiGDH8bVnVqIclXDrW2SwRL3zgDowUWtKBADMtahG6HhEw+Xgqrn+98WjBMEeU0L3
         7IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743637159; x=1744241959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuxalq7LD9or9m6/ZAmPE3itU8gj0v3bHb/TuqhHJM4=;
        b=G69rgGXDmMmboR4aUiTtv/bwEDp8ZZ0RsfGBceOG13ZwBBzEm1I/fheJcwHNi5uz6Z
         0EwfTx5MRYo0ddATxC2BNdTIYGPhS2H3KkYIFOIuol0DiRi2TjcEPaLMGAJMu7QRy+4M
         V57JblO+/ot7lyX6giCkHlxzgpBNHJl8eVl3PCQ/c7n4ER4TYx18JZHH32l+6sGI0QCf
         h+DWmChfwEo0YAU07CHnro7sZm/3QlART2DFw1s2M+VYFNKipZ18wwb+M+T30udrBthJ
         XxQ4FLNVS5M8zaFMYAhgn33WC387juf4su2cuoQSe6eDeDVkQUb7hd4Vfbi+isvWIrNl
         c/bw==
X-Forwarded-Encrypted: i=1; AJvYcCWEbEBH6BPacg6Bs/Ki8LtJAsKT54bhfkEoOyFVr5F0OQVgbLxqRaYYSIm1YUQD0r2vZhumCBucMEA+eK1A5p4=@lists.linux.dev, AJvYcCWPziPsCk5SiAilFyymcQLvIUT6UwUFxWWhxOUw35gHHR4wNoyAhS5YtX96ydYgCcl5tIodIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydE3nyLSfNS+CxYYrDsOxqzWL1HUd0NQx6mhfwjTjXlQIeX4Y7
	XDBPopWDq9+hTxSzm5JoP+0LJ+FMu5Q0drTL+tek4FDFK/QQ50s=
X-Gm-Gg: ASbGncvB5jBcYaYZF7ndV6Yvl7x59mqku06VNc4gwmo+M5+QB8L+DtgyiVjJwpBjqb1
	K0fjRIzZFjTHSsFP2nB5WHiBn817I5vHVzRYzg0jR25Z3H132Ry6TyWm2bhYlMT6NtSQzGG9xa7
	0+gLAyi6Lle543qu0Ij/Xu6PU2YUF4vp6rhxEoJECXvHcHhgow0yEWbhyFUt1s5v1OrOeraS7Yd
	LSG0/cd56dIO7URMsF6faZrFpxTz2LYp6TqelEgQkHC9s+lbvZBaLr2PtfzURCmmEyZzaNlMkV/
	ydpuPmRoPS9eqLlsf+X86VpxGLnERAd/7D2OUOT87mf3bTslWTEGE1Q=
X-Google-Smtp-Source: AGHT+IGG/TFPoWNV9I3kMq0+usNFgbE2FuVu+B/nK4F1+FP+s/9qCE6mMl4/SZTNOtLxIZ6YGlagIg==
X-Received: by 2002:a17:903:8c6:b0:224:a74:28d2 with SMTP id d9443c01a7336-2292f9754b7mr292367295ad.26.1743637158577;
        Wed, 02 Apr 2025 16:39:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d9ea14f3sm99380b3a.98.2025.04.02.16.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:39:17 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:39:17 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Stefan Metzmacher <metze@samba.org>, Breno Leitao <leitao@debian.org>,
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
Message-ID: <Z-3KpXR_nJQ4X76F@mini-arch>
References: <Z+wH1oYOr1dlKeyN@gmail.com>
 <Z-wKI1rQGSgrsjbl@mini-arch>
 <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch>
 <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin>
 <Z-1Hgv4ImjWOW8X2@mini-arch>
 <20250402214638.0b5eed55@pumpkin>
 <Z-2qX_N2-jpMYSIy@mini-arch>
 <20250402233805.464ed70e@pumpkin>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402233805.464ed70e@pumpkin>

On 04/02, David Laight wrote:
> On Wed, 2 Apr 2025 14:21:35 -0700
> Stanislav Fomichev <stfomichev@gmail.com> wrote:
> 
> > On 04/02, David Laight wrote:
> > > On Wed, 2 Apr 2025 07:19:46 -0700
> > > Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > >   
> > > > On 04/02, David Laight wrote:  
> > > > > On Wed, 2 Apr 2025 00:53:58 +0200
> > > > > Stefan Metzmacher <metze@samba.org> wrote:
> > > > >     
> > > > > > Am 02.04.25 um 00:04 schrieb Stanislav Fomichev:    
> > > > > > > On 04/01, Stefan Metzmacher wrote:      
> > > > > > >> Am 01.04.25 um 17:45 schrieb Stanislav Fomichev:      
> > > > > > >>> On 04/01, Breno Leitao wrote:      
> > > > > > >>>> On Tue, Apr 01, 2025 at 03:48:58PM +0200, Stefan Metzmacher wrote:      
> > > > > > >>>>> Am 01.04.25 um 15:37 schrieb Stefan Metzmacher:      
> > > > > > >>>>>> Am 01.04.25 um 10:19 schrieb Stefan Metzmacher:      
> > > > > > >>>>>>> Am 31.03.25 um 23:04 schrieb Stanislav Fomichev:      
> > > > > > >>>>>>>> On 03/31, Stefan Metzmacher wrote:      
> > > > > > >>>>>>>>> The motivation for this is to remove the SOL_SOCKET limitation
> > > > > > >>>>>>>>> from io_uring_cmd_getsockopt().
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> The reason for this limitation is that io_uring_cmd_getsockopt()
> > > > > > >>>>>>>>> passes a kernel pointer as optlen to do_sock_getsockopt()
> > > > > > >>>>>>>>> and can't reach the ops->getsockopt() path.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> The first idea would be to change the optval and optlen arguments
> > > > > > >>>>>>>>> to the protocol specific hooks also to sockptr_t, as that
> > > > > > >>>>>>>>> is already used for setsockopt() and also by do_sock_getsockopt()
> > > > > > >>>>>>>>> sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> But as Linus don't like 'sockptr_t' I used a different approach.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> @Linus, would that optlen_t approach fit better for you?      
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> [..]
> > > > > > >>>>>>>>      
> > > > > > >>>>>>>>> Instead of passing the optlen as user or kernel pointer,
> > > > > > >>>>>>>>> we only ever pass a kernel pointer and do the
> > > > > > >>>>>>>>> translation from/to userspace in do_sock_getsockopt().      
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> At this point why not just fully embrace iov_iter? You have the size
> > > > > > >>>>>>>> now + the user (or kernel) pointer. Might as well do
> > > > > > >>>>>>>> s/sockptr_t/iov_iter/ conversion?      
> > > > > > >>>>>>>
> > > > > > >>>>>>> I think that would only be possible if we introduce
> > > > > > >>>>>>> proto[_ops].getsockopt_iter() and then convert the implementations
> > > > > > >>>>>>> step by step. Doing it all in one go has a lot of potential to break
> > > > > > >>>>>>> the uapi. I could try to convert things like socket, ip and tcp myself, but
> > > > > > >>>>>>> the rest needs to be converted by the maintainer of the specific protocol,
> > > > > > >>>>>>> as it needs to be tested. As there are crazy things happening in the existing
> > > > > > >>>>>>> implementations, e.g. some getsockopt() implementations use optval as in and out
> > > > > > >>>>>>> buffer.
> > > > > > >>>>>>>
> > > > > > >>>>>>> I first tried to convert both optval and optlen of getsockopt to sockptr_t,
> > > > > > >>>>>>> and that showed that touching the optval part starts to get complex very soon,
> > > > > > >>>>>>> see https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=141912166473bf8843ec6ace76dc9c6945adafd1
> > > > > > >>>>>>> (note it didn't converted everything, I gave up after hitting
> > > > > > >>>>>>> sctp_getsockopt_peer_addrs and sctp_getsockopt_local_addrs.
> > > > > > >>>>>>> sctp_getsockopt_context, sctp_getsockopt_maxseg, sctp_getsockopt_associnfo and maybe
> > > > > > >>>>>>> more are the ones also doing both copy_from_user and copy_to_user on optval)
> > > > > > >>>>>>>
> > > > > > >>>>>>> I come also across one implementation that returned -ERANGE because *optlen was
> > > > > > >>>>>>> too short and put the required length into *optlen, which means the returned
> > > > > > >>>>>>> *optlen is larger than the optval buffer given from userspace.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Because of all these strange things I tried to do a minimal change
> > > > > > >>>>>>> in order to get rid of the io_uring limitation and only converted
> > > > > > >>>>>>> optlen and leave optval as is.
> > > > > > >>>>>>>
> > > > > > >>>>>>> In order to have a patchset that has a low risk to cause regressions.
> > > > > > >>>>>>>
> > > > > > >>>>>>> But as alternative introducing a prototype like this:
> > > > > > >>>>>>>
> > > > > > >>>>>>>            int (*getsockopt_iter)(struct socket *sock, int level, int optname,
> > > > > > >>>>>>>                                   struct iov_iter *optval_iter);
> > > > > > >>>>>>>
> > > > > > >>>>>>> That returns a non-negative value which can be placed into *optlen
> > > > > > >>>>>>> or negative value as error and *optlen will not be changed on error.
> > > > > > >>>>>>> optval_iter will get direction ITER_DEST, so it can only be written to.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Implementations could then opt in for the new interface and
> > > > > > >>>>>>> allow do_sock_getsockopt() work also for the io_uring case,
> > > > > > >>>>>>> while all others would still get -EOPNOTSUPP.
> > > > > > >>>>>>>
> > > > > > >>>>>>> So what should be the way to go?      
> > > > > > >>>>>>
> > > > > > >>>>>> Ok, I've added the infrastructure for getsockopt_iter, see below,
> > > > > > >>>>>> but the first part I wanted to convert was
> > > > > > >>>>>> tcp_ao_copy_mkts_to_user() and that also reads from userspace before
> > > > > > >>>>>> writing.
> > > > > > >>>>>>
> > > > > > >>>>>> So we could go with the optlen_t approach, or we need
> > > > > > >>>>>> logic for ITER_BOTH or pass two iov_iters one with ITER_SRC and one
> > > > > > >>>>>> with ITER_DEST...
> > > > > > >>>>>>
> > > > > > >>>>>> So who wants to decide?      
> > > > > > >>>>>
> > > > > > >>>>> I just noticed that it's even possible in same cases
> > > > > > >>>>> to pass in a short buffer to optval, but have a longer value in optlen,
> > > > > > >>>>> hci_sock_getsockopt() with SOL_BLUETOOTH completely ignores optlen.
> > > > > > >>>>>
> > > > > > >>>>> This makes it really hard to believe that trying to use iov_iter for this
> > > > > > >>>>> is a good idea :-(      
> > > > > > >>>>
> > > > > > >>>> That was my finding as well a while ago, when I was planning to get the
> > > > > > >>>> __user pointers converted to iov_iter. There are some weird ways of
> > > > > > >>>> using optlen and optval, which makes them non-trivial to covert to
> > > > > > >>>> iov_iter.      
> > > > > > >>>
> > > > > > >>> Can we ignore all non-ip/tcp/udp cases for now? This should cover +90%
> > > > > > >>> of useful socket opts. See if there are any obvious problems with them
> > > > > > >>> and if not, try converting. The rest we can cover separately when/if
> > > > > > >>> needed.      
> > > > > > >>
> > > > > > >> That's what I tried, but it fails with
> > > > > > >> tcp_getsockopt ->
> > > > > > >>     do_tcp_getsockopt ->
> > > > > > >>       tcp_ao_get_mkts ->
> > > > > > >>          tcp_ao_copy_mkts_to_user ->
> > > > > > >>             copy_struct_from_sockptr
> > > > > > >>       tcp_ao_get_sock_info ->
> > > > > > >>          copy_struct_from_sockptr
> > > > > > >>
> > > > > > >> That's not possible with a ITER_DEST iov_iter.
> > > > > > >>
> > > > > > >> metze      
> > > > > > > 
> > > > > > > Can we create two iterators over the same memory? One for ITER_SOURCE and
> > > > > > > another for ITER_DEST. And then make getsockopt_iter accept optval_in and
> > > > > > > optval_out. We can also use optval_out position (iov_offset) as optlen output
> > > > > > > value. Don't see why it won't work, but I agree that's gonna be a messy
> > > > > > > conversion so let's see if someone else has better suggestions.      
> > > > > > 
> > > > > > Yes, that might work, but it would be good to get some feedback
> > > > > > if this would be the way to go:
> > > > > > 
> > > > > >            int (*getsockopt_iter)(struct socket *sock,
> > > > > > 				 int level, int optname,
> > > > > > 				 struct iov_iter *optval_in,
> > > > > > 				 struct iov_iter *optval_out);
> > > > > > 
> > > > > > And *optlen = optval_out->iov_offset;
> > > > > > 
> > > > > > Any objection or better ideas? Linus would that be what you had in mind?    
> > > > > 
> > > > > I'd worry about performance - yes I know 'iter' are used elsewhere but...
> > > > > Also look at the SCTP code.    
> > > > 
> > > > Performance usually does not matter for set/getsockopts, there
> > > > are a few exceptions that I know (TCP_ZEROCOPY_RECEIVE)  
> > > 
> > > That might be the one that is really horrid and completely abuses
> > > the 'length' parameter.  
> > 
> > It is reading and writing, yes, but it's not a huge problem. And it
> > does enforce the optlen (to copy back the same amount of bytes). It's
> > not that bad, it's just an example of where we need to be extra
> > careful.
> > 
> > > > and maybe recent
> > > > devmem sockopts; we can special-case these if needed, or keep sockptr_t,
> > > > idk. I'm skeptical we can convert everything though, that's why the
> > > > suggestion to start with sk/ip/tcp/udp.
> > > >   
> > > > > How do you handle code that wants to return an updated length (often longer
> > > > > than the one provided) and an error code (eg ERRSIZE or similar).
> > > > >
> > > > > There is also a very strange use (I think it is a sockopt rather than an ioctl)
> > > > > where the buffer length the application provides is only that of the header.
> > > > > The actual buffer length is contained in the header.
> > > > > The return length is the amount written into the full buffer.    
> > > > 
> > > > Let's discuss these special cases as they come up? Worst case these
> > > > places can always re-init iov_iter with a comment on why it is ok.
> > > > But I do agree in general that there are a few places that do wild
> > > > stuff.  
> > > 
> > > The problem is that the generic code has to deal with all the 'wild stuff'.  
> > 
> > getsockopt_iter will have optval_in for the minority of socket options
> > (like TCP_ZEROCOPY_RECEIVE) that want to read user's value as well
> > as optval_out. The latter is what the majority of socket options
> > will use to write their value. That doesn't seem too complicated to
> > handle?
> > 
> > > It is also common to do non-sequential accesses - so iov_iter doesn't match
> > > at all.  
> > 
> > I disagree that it's 'common'. Searching for copy_from_sockptr_offset
> > returns a few cases and they are mostly using read-with-offset because
> > there is no sequential read (iterator) semantics with sockptr_t.
> > 
> > > There also isn't a requirement for scatter-gather.
> > > 
> > > For 'normal' getsockopt (and setsockopt) with short lengths it actually makes
> > > sense for the syscall wrapper to do the user copies.
> > > But it would need to pass the user ptr+len as well as the kernel ptr+len
> > > to give the required flexibilty.
> > > Then you have to work out whether the final copy to user is needed or not.
> > > (not that hard, but it all adds complication).  
> > 
> > Not sure I understand what's the problem. The user vs kernel part will
> > be abstracted by iov_iter. The callers will have to write the optlen
> > back. And there are two call sites we care about: io_uring and regular
> > system call. What's your suggestion? Maybe I'm missing something. Do you
> > prefer get_optlen/put_optlen?
> 
> I think the final aim should be to pass the user supplied length to the
> per-protocol code and have it return the length/error to be passed back to the
> user.

Like what Stefan's patch 3 is doing? Or you're suggesting to change
getsockopt handlers to handle length more explicitly? If we were
to proceed with sockptr to iov_iter conversion we'll have to do it anyway
(or pass the length as the size of iov_iter).

> But in a lot of cases the syscall wrapper can do the buffer copies (as well
> as the length copies).
> That would be restricted to short length (on stack).
> So code that needed a long buffer (like some of the sctp options)
> would need to directly access the user buffer (or a long buffer provided
> by an in-kernel user).

This sounds similar to what we did with bpf hooks - copy (head of) the
buffer and run bpf program on top of it. I remember iptables setsockopt
begin problematic because of its huge size.. It is an option, yes (to
convert protocol handler to kernel memory mostly).

> But you'll find code that reads/writes well beyond the apparent size of
> the user buffer.
> (And not just code that accesses 4 bytes without checking the length).

With can start with getsockopt_iter + sk_getsockopt to see if there are any
issues with that approach. If not, adding ip/tcp/udp to the mix should be doable.
We can explain and comment on special cases if needed. When other protocols
are needed from io_uring, we can convert more. But at least the new code
will use the correct abstractions.
