Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2E1FC0FB
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259323; cv=none; b=mtgai1FIAie+slG0JAmroUMm8t/Lf7KIsrDhSUp5zZNuGW/uXT5uQKlJfP3Txg75X3M/dX6/kSMSyeR4+xR9BnmXLSjo+AH2a7zDYailIxdklgDduQnWwI2DUKq0edPQ6i8yh3APTL24SUdLxcB3ytycRPFTbDqaY95PmGWr+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259323; c=relaxed/simple;
	bh=1l2lg4pxnKWN66VYlhTC0zCZyNqViTJOeCnoCR667mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGkLUn0Oqcq3AiLQUfP7ajl2JvMpkuVzMrtHr/74puD6pKuSAH8jX6egZBKV4Km21YIrGmp4j6BLIAgTJ6EUM/ruIWNd4DYvNKVuZmStvKrvFBVe+9e96UgcK07Kl2KQGauT2UfVrW9QrzDr/EFVWC88KZjLQtGuRsBS3+SraAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0WdZLpd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0WdZLpd"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso8907746d6.2
        for <mptcp@lists.linux.dev>; Thu, 06 Mar 2025 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741259320; x=1741864120; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HOAdle44AxtzHdRU+24G5NySxyY61Mu4iq8aJK231o=;
        b=C0WdZLpdnWUSpg+PneSZjvZ3rR+PgL6pZxPgAK3KzhCe0Wwlkfk6kKjmugtwLeSBXW
         uBImnviD5YbWS5K0V7SCy4qBIkY31mZqFGe7X5kE22Y9QmJxsz6to90GkBz/5W5tzy41
         aWnVvSQ6xLIImlUCJlMLfViduwJ8/lBLhz/1ediL5Zn5dFTZ3bsPb/gvrbf+4e16Q/n7
         UN9CRvfvSadDqz8kWLvEkHUnwl2IGCcgEOpM4xe2JwGlqoq5lntUfJThQ2l89W72uDPd
         OREyKZaBW3gRdnn9eLHujZwnfVFwLXYwIuK8+jDss2SD2umLQ0y6gPqC8INbO0sM/1me
         JE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259320; x=1741864120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HOAdle44AxtzHdRU+24G5NySxyY61Mu4iq8aJK231o=;
        b=C9geEROtTkHafU3aisZLk8vWHM77HvLC7Np+S7k9hkw4AC/P9AVe8RWmEgXBObGWjl
         uv+kwAMqDn301cR/rh+PPWuUMuiS4cbpgSrOG7k3P6mb5E6+tEFehKoBPmFxFkEg4eas
         BEawujOkmE9zUTmTJOP6IAaG7UoN17edaTcYT2BnIe1zyHR/4zj3bxlDNz/wx6ETpAjk
         Hir8+ZxmicplFpbwGE5Cq36vxbu4vZaAxkLFYaTwQhUM8wqN+lBCtI7ufNXFw1GdwR2T
         ipGm0fpMwyHsF4PVJcCOnumH+8AM7crK31yaG25XtwJI+smVcW9iA6oLY0ycVg/NxsbO
         wDdA==
X-Forwarded-Encrypted: i=1; AJvYcCWKrGXIoWX2a2t5B/6yK7GVjvM/iyLKsQAmarZBBDOOK+hTuYyFwIipiy7V5Bc4LQG4u4WQaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi2sgFFLGRPQ6+SOVPrJM5a6AZtaHxVht/InHiQlyJ2JVgfXvz
	JaxRfNAt03Sd7G00cMKbtUZLOkDvLB7W0rEBrIxV3Zivm1oltynAObkJJgyqTjzW8AXoEm30av/
	Vjs9sbnUUVDTGKaJnUZCdu4E0R7Dnnol2QviF
X-Gm-Gg: ASbGncvF8cFnFvFWaf2FIK8p5kVka6izqZMxxanJir3aLUyZYLO2FomTf8+h2s0f/vQ
	qWgrLWrIjW7cDiY0HirzXdg/PsTQo5SPX9o19tYs52VFg8c7WKmr0F4QW1Gz8RPxC8WcCYCmXCn
	MscyIjzttRMkRszKCcu/dm6xaceUs=
X-Google-Smtp-Source: AGHT+IGqjDyiWMbG6cj6FS2OJY2L/aGCOTmLPTlaPopreMPZINSjvjq5BUceWbtCkk+LzB1fdNlNrVp3CR8l8HiQTI4=
X-Received: by 2002:a05:6214:252f:b0:6e8:ddf6:d137 with SMTP id
 6a1803df08f44-6e8e6cd170cmr106132706d6.18.1741259319968; Thu, 06 Mar 2025
 03:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
 <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
 <281edb3a-4679-4c75-9192-a5f0ef6952ea@kernel.org> <CANn89iKVsDrL9YFx883wTfRSAe6tOR7x2U5zk=TcgHBMr+VtkQ@mail.gmail.com>
 <a3266974-d561-4e8f-a23a-9c0774ee2bbe@kernel.org> <CANn89iJ4DyC8OSEA2Qn3WhWHAUr9Bpo_ZmJdcx3ofM-qKvEU=g@mail.gmail.com>
In-Reply-To: <CANn89iJ4DyC8OSEA2Qn3WhWHAUr9Bpo_ZmJdcx3ofM-qKvEU=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 12:08:28 +0100
X-Gm-Features: AQ5f1JqnqOEjgEt1NTmjqKYptzUm18O7uGofh7YTyGk_91RbtSC-SoxS4lIhJ18
Message-ID: <CANn89iJ2S+mCs8PxZ-EBAfH--j6v9cUazCc8O4FWvMat=_yURQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:16=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Mar 6, 2025 at 11:12=E2=80=AFAM Matthieu Baerts <matttbe@kernel.o=
rg> wrote:
> >
> > On 06/03/2025 11:02, Eric Dumazet wrote:
> > > On Thu, Mar 6, 2025 at 10:55=E2=80=AFAM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> > >>
> > >> Hi Eric,
> > >>
> > >> On 06/03/2025 10:45, Eric Dumazet wrote:
> > >>> On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > >>>>
> > >>>> On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> > >>>> <matttbe@kernel.org> wrote:
> > >>>>>
> > >>>>> A recent cleanup changed the behaviour of tcp_set_window_clamp().=
 This
> > >>>>> looks unintentional, and affects MPTCP selftests, e.g. some tests
> > >>>>> re-establishing a connection after a disconnect are now unstable.
> > >>>>>
> > >>>>> Before the cleanup, this operation was done:
> > >>>>>
> > >>>>>   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> > >>>>>   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> > >>>>>
> > >>>>> The cleanup used the 'clamp' macro which takes 3 arguments -- val=
ue,
> > >>>>> lowest, and highest -- and returns a value between the lowest and=
 the
> > >>>>> highest allowable values. This then assumes ...
> > >>>>>
> > >>>>>   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> > >>>>>
> > >>>>> ... which doesn't seem to be always the case here according to th=
e MPTCP
> > >>>>> selftests, even when running them without MPTCP, but only TCP.
> > >>>>>
> > >>>>> For example, when we have ...
> > >>>>>
> > >>>>>   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> > >>>>>
> > >>>>> ... before the cleanup, the rcv_ssthresh was not changed, while a=
fter
> > >>>>> the cleanup, it is lowered down to rcv_wnd (highest).
> > >>>>>
> > >>>>> During a simple test with TCP, here are the values I observed:
> > >>>>>
> > >>>>>   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> > >>>>>       117760   (out)         65495         <  65536
> > >>>>>       128512   (out)         109595        >  80256  =3D> lo > hi
> > >>>>>       1184975  (out)         328987        <  329088
> > >>>>>
> > >>>>>       113664   (out)         65483         <  65536
> > >>>>>       117760   (out)         110968        <  110976
> > >>>>>       129024   (out)         116527        >  109696 =3D> lo > hi
> > >>>>>
> > >>>>> Here, we can see that it is not that rare to have rcv_ssthresh (l=
o)
> > >>>>> higher than rcv_wnd (hi), so having a different behaviour when th=
e
> > >>>>> clamp() macro is used, even without MPTCP.
> > >>>>>
> > >>>>> Note: new_window_clamp is always out of range (rcv_ssthresh < rcv=
_wnd)
> > >>>>> here, which seems to be generally the case in my tests with small
> > >>>>> connections.
> > >>>>>
> > >>>>> I then suggests reverting this part, not to change the behaviour.
> > >>>>>
> > >>>>> Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> > >>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55=
1
> > >>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > >>>>
> > >>>> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > >>>>
> > >>>> Thanks for catching this. I should have done more tests :(
> > >>>>
> > >>>> Now I use netperf with TCP_CRR to test loopback and easily see the
> > >>>> case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which mean=
s
> > >>>> tp->rcv_wnd is not the upper bound as you said.
> > >>>>
> > >>>> Thanks,
> > >>>> Jason
> > >>>>
> > >>>
> > >>> Patch looks fine to me but all our tests are passing with the curre=
nt kernel,
> > >>> and I was not able to trigger the condition.
> > >>
> > >> Thank you for having looked at this patch!
> > >>
> > >>
> > >>> Can you share what precise test you did ?
> > >>
> > >> To be able to get a situation where "rcv_ssthresh > rcv_wnd", I simp=
ly
> > >> executed MPTCP Connect selftest. You can also force creating TCP onl=
y
> > >> connections with '-tt', e.g.
> > >>
> > >>   ./mptcp_connect.sh -tt
> > >
> > > I was asking Jason about TCP tests. He mentioned TCP_CRR
> >
> > Oops, I'm sorry, I didn't look at the "To:" field.
> >
> > > I made several of them, with temporary debug in the kernel that did
> > > not show the issue.
> > >
> > >
> > > I am wondering if this could hide an issue in MPTCP ?
> > Indeed, I was wondering the same thing. I didn't see anything obvious
> > when looking at this issue. The behaviours around the window clamping,
> > with MPTCP single flow, and "plain" TCP were quite similar I think.
>
> OK, let me run mptcp tests just in case I see something dubious.

I have no idea why only MPTCP flows can trigger the condition, I do
not think it matters anyway.

Reviewed-by: Eric Dumazet <edumazet@google.com>
