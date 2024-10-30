Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D991200CA6
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300725; cv=none; b=Gt5OsnlOHxb90rPXuGk2Tcoq69xwQWrFcHg2wvTmTIaRDhaZgFpEpmabUAHQM6h522R9qFQJlZ+nhfg16mGKJsILxWLLiRTlj0bMDA/9R1GapzyJVV5TcUNxKEqiCET0+pPoqVm7WcwDljlNGS0y+HR8Q7+ETnzrGqpA2PFCZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300725; c=relaxed/simple;
	bh=goD+pGiQ0rQVe2pgjoni/ZwmQIGCuuYK5AaP0rfWv34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fixnNdt5yaD+A7xig2wpzuHiG1dx7dl8OtE0lKCMRqv5qwMArVLn25TSFCQg63PeVREpGiKEDJefZHqZuzTpeQTX7pIPb3dbHhcR6OrS1TII0wtYpRU9W/03sPmbMfEHUaFsxn2Q3yX6mHkeUWUEiw0ZmeVCL+lOMqTt0/RRJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so3368673a12.2
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 08:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300721; x=1730905521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsliBAqPxcmrKVPgDw8B1SlwFR9KYGJogW4u3jch/nA=;
        b=wt3fL4YfGFrLSLYAnf76reAsCWRv9DXW+lgFOdn3mQb2jEzDPWKxMnaZhqOn+ElU06
         r8qGWkGNj8G/sjbh6x56tromnxkdLyREUxX22hIVCnXFJvA1phYPnex/Ju4JDF9DT2+D
         rcRC5dEeAKNTwc9iLoW1+HYACQt6RLkX0pGWVyzZrUXCN9BXO+I6vCPYFs5xLW3NfOAW
         o6itJn7fwhGwtKER3cy8IPszaE8Q4wr4QvdQJzGo8dUbwVu+53SDR962W/AQ+GZ4Xaa8
         dj2LcAi/Di8s65Jdtzcv/cx157TEQIhgPIPdi/iOUO3qX1wS7m/jWpASKMTIlkJBSrQ3
         q9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPe2hQes0uivjIpK/hg6kWEq3cgDHsCflpei92GoJBHU8c+XuPn6upHkV0Dk4cOCrFGOjnGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPhs/jU/KALYjuy1MKv07i9LIY3lRw/twnNLBtFu6rcJ8kbBIY
	NWHUOVt/4d5j82ilTUeUNwSnYYPIlFl4lracLnpAfeXSlYw5fPNv
X-Google-Smtp-Source: AGHT+IFwv5tYlaHMsIZ+p3GmjDzFyvvMxeVJcS1ooiACmmXEJ/AH7Zp6UzqKlykAB7fpZidVS9XvLw==
X-Received: by 2002:a05:6402:1d4c:b0:5cb:e6c3:d2c6 with SMTP id 4fb4d7f45d1cf-5cbe6c3d308mr10047483a12.15.1730300721025;
        Wed, 30 Oct 2024 08:05:21 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629c250sm4837003a12.27.2024.10.30.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:05:19 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:05:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vlad.wing@gmail.com, max@kutsevol.com,
	kernel-team@meta.com, aehkn@xenhub.one, stable@vger.kernel.org,
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling
 mptcp_sched_find()
Message-ID: <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
References: <20241030140224.972565-1-leitao@debian.org>
 <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>

Hello Eric,

On Wed, Oct 30, 2024 at 03:18:14PM +0100, Eric Dumazet wrote:
> On Wed, Oct 30, 2024 at 3:02 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > The mptcp_sched_find() function must be called with the RCU read lock
> > held, as it accesses RCU-protected data structures. This requirement was
> > not properly enforced in the mptcp_init_sock() function, leading to a
> > RCU list traversal in a non-reader section error when
> > CONFIG_PROVE_RCU_LIST is enabled.
> >
> >         net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> >
> > Fix it by acquiring the RCU read lock before calling the
> > mptcp_sched_find() function. This ensures that the function is invoked
> > with the necessary RCU protection in place, as it accesses RCU-protected
> > data structures.
> >
> > Additionally, the patch breaks down the mptcp_init_sched() call into
> > smaller parts, with the RCU read lock only covering the specific call to
> > mptcp_sched_find(). This helps minimize the critical section, reducing
> > the time during which RCU grace periods are blocked.
> >
> > The mptcp_sched_list_lock is not held in this case, and it is not clear
> > if it is necessary.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> > Cc: stable@vger.kernel.org
> > ---
> >  net/mptcp/protocol.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6d0e201c3eb2..8ece630f80d4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2854,6 +2854,7 @@ static void mptcp_ca_reset(struct sock *sk)
> >  static int mptcp_init_sock(struct sock *sk)
> >  {
> >         struct net *net = sock_net(sk);
> > +       struct mptcp_sched_ops *sched;
> >         int ret;
> >
> >         __mptcp_init_sock(sk);
> > @@ -2864,8 +2865,10 @@ static int mptcp_init_sock(struct sock *sk)
> >         if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
> >                 return -ENOMEM;
> >
> > -       ret = mptcp_init_sched(mptcp_sk(sk),
> > -                              mptcp_sched_find(mptcp_get_scheduler(net)));
> > +       rcu_read_lock();
> > +       sched = mptcp_sched_find(mptcp_get_scheduler(net));
> > +       rcu_read_unlock();
> 
> You are silencing the warning, but a potential UAF remains.
> 
> sched could have been freed already, it is illegal to deref it.

Thanks.  I got the impression that the scheduler list was append-only,
and the entries were never freed.
