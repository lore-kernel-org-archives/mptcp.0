Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494441F4188
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255371; cv=none; b=PGivy4/wwFKzWIsYp9a+eNqutKcE77DNf0PV+Vr/sJHXFsloi0L9eKZbEM3CoZsVhoGllLP5kS25qWCL8gi74i51+J6jsWv063aVnyC3+AFxQnip3qcFukDkvlvuwP3WDgzxNyLFm20nBS1gywOj4qRlZbHT5zQa1jTjZ6QR3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255371; c=relaxed/simple;
	bh=HsRBxEOsATnne1eQ3OkNuWRbsRwyHHR86jhp69zJgzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNObR5/KhC9yiJXwwv+rg7ACUdQ1PkAiSYoQjDTKIsrV1YECTbhRigxcctQZ6S/p1CZ2jo5IoNlHuCjcwwXan0z3ZBkiJ7vBKP241pSHGam5saxLvSDb6LyGdCgbhxMKxyf5urmCY/DiolBs5CDtiMMtyhWmnBYJFcKA3k2viz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5F63fr+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5F63fr+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47208e35f9cso4448001cf.3
        for <mptcp@lists.linux.dev>; Thu, 06 Mar 2025 02:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741255368; x=1741860168; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sPmaeX1x05bYpEnk3NGTrmxS0rSOx4NYk/DbTEnnrk=;
        b=v5F63fr+AMM7JTAExzMrPoLt/A2tUb9orvPdr0zyZeJzURdW1U8IB49jRlMrAU79Iq
         j8+w/b8lE9H6RF8Irzy503MjBIEMRdRGejA6ML4TQzD9/ctSZScLcdsTYKyA0HXLxamS
         7MGnJfYhh2eKWiU2lo9eGGe0irBio1U7DEn1P1zjIU0mhrjKI/JWC6guktHvM6T3KcaD
         2R72kjUfQ+mYj/2y6HqkzpSW4SYnX4HkfWp7v54dwdzH59xAjmPR2/QBRLcV2ohEPSSz
         XHgkDWG3/FB3ad1F9UE3MRqiQ+VJe2zh870ESpjZhA+oAVmq1PnBNXtH5t0qzj30YVKZ
         qzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255368; x=1741860168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sPmaeX1x05bYpEnk3NGTrmxS0rSOx4NYk/DbTEnnrk=;
        b=RFtaG+020XlEJeMydyzcota63wLF4jfO4y/EpF8Tmj4wHT8zGjlB37xE0/rpVgbJwM
         6EdzFJQ+8LeSAfEo+OrNL4nFtfDUtl7/ylPVofCBkjDEZfvxWgHtv93FR4JoHUqr72Hi
         HIpeRkiL6EeHrrnbrESg3cr31wrvIAWpE+AQTlJ+bQuJXaWt+QQ7+bPQjdKMXWjX9U0h
         /nSOUzNdt+Nl/fDAI6F/lhvhTzqUFphUybO5ULqSYwOVLbYM2/xmBTDm9vXoGF10q+u8
         ApRkCnPr7HXqhtXbdYOdvnVLxRiC76ufPuXwuEFC1yTUmeYviwPwidFHXZbOAZhCAa7Y
         npDg==
X-Forwarded-Encrypted: i=1; AJvYcCXEfFL0NI4t7vTEceuHN/GRCL8cJjMgrVQlJ0EOQDal5oQw5QTEPPRgmWCUt5bfAAy03JWZ4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxbpcdpNiOj68qz/xaA6alGyP2C33gxRQysDZ1qPzxDjAD3aUx
	L5cYf6E6YBTaMlV/R5FrXACHcv8txcMCqoYYE8xKs4GC5kvYYaAMZJlDR26yoRYavVpNCd/BH7s
	hrr74GKeK1wnsHq17OKuzL36sS8J4OvxWtm30
X-Gm-Gg: ASbGncvUj3wFqgHkjdnwdzgZ2i9TV34b21LrmKm4txTjSylrWoEpv7zNtlX70BtB6cI
	Zi+87otU9kFR5X/k+C/iW5LqGygZpAqNNvSjLZwUrQrCnPVKitLZUOUfMaT6oyCdFGreMB2qffG
	Vw1KMHgoteNv1iKVyqcbxFJumSuCQ=
X-Google-Smtp-Source: AGHT+IHd1HIb0eXA4rKqblE465qJbAez2NG9Yf1BwvaxbW9nnIkEBNovq0uQEXai6+ONuiH5tyu+dBoz8/Y2zl/Vxxg=
X-Received: by 2002:ac8:7d56:0:b0:475:aef:3f9b with SMTP id
 d75a77b69052e-4750b4e6a53mr96885501cf.47.1741255367764; Thu, 06 Mar 2025
 02:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
 <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com> <281edb3a-4679-4c75-9192-a5f0ef6952ea@kernel.org>
In-Reply-To: <281edb3a-4679-4c75-9192-a5f0ef6952ea@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 11:02:36 +0100
X-Gm-Features: AQ5f1JponQjKg0-oTqSrqiSL_Le-2bBFIMoznJ3kyCjReeZGsPCuhxXuES6US3o
Message-ID: <CANn89iKVsDrL9YFx883wTfRSAe6tOR7x2U5zk=TcgHBMr+VtkQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:55=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 06/03/2025 10:45, Eric Dumazet wrote:
> > On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >>
> >> On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> >> <matttbe@kernel.org> wrote:
> >>>
> >>> A recent cleanup changed the behaviour of tcp_set_window_clamp(). Thi=
s
> >>> looks unintentional, and affects MPTCP selftests, e.g. some tests
> >>> re-establishing a connection after a disconnect are now unstable.
> >>>
> >>> Before the cleanup, this operation was done:
> >>>
> >>>   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> >>>   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> >>>
> >>> The cleanup used the 'clamp' macro which takes 3 arguments -- value,
> >>> lowest, and highest -- and returns a value between the lowest and the
> >>> highest allowable values. This then assumes ...
> >>>
> >>>   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> >>>
> >>> ... which doesn't seem to be always the case here according to the MP=
TCP
> >>> selftests, even when running them without MPTCP, but only TCP.
> >>>
> >>> For example, when we have ...
> >>>
> >>>   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> >>>
> >>> ... before the cleanup, the rcv_ssthresh was not changed, while after
> >>> the cleanup, it is lowered down to rcv_wnd (highest).
> >>>
> >>> During a simple test with TCP, here are the values I observed:
> >>>
> >>>   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> >>>       117760   (out)         65495         <  65536
> >>>       128512   (out)         109595        >  80256  =3D> lo > hi
> >>>       1184975  (out)         328987        <  329088
> >>>
> >>>       113664   (out)         65483         <  65536
> >>>       117760   (out)         110968        <  110976
> >>>       129024   (out)         116527        >  109696 =3D> lo > hi
> >>>
> >>> Here, we can see that it is not that rare to have rcv_ssthresh (lo)
> >>> higher than rcv_wnd (hi), so having a different behaviour when the
> >>> clamp() macro is used, even without MPTCP.
> >>>
> >>> Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_wnd=
)
> >>> here, which seems to be generally the case in my tests with small
> >>> connections.
> >>>
> >>> I then suggests reverting this part, not to change the behaviour.
> >>>
> >>> Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> >>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
> >>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>
> >> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> >>
> >> Thanks for catching this. I should have done more tests :(
> >>
> >> Now I use netperf with TCP_CRR to test loopback and easily see the
> >> case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
> >> tp->rcv_wnd is not the upper bound as you said.
> >>
> >> Thanks,
> >> Jason
> >>
> >
> > Patch looks fine to me but all our tests are passing with the current k=
ernel,
> > and I was not able to trigger the condition.
>
> Thank you for having looked at this patch!
>
>
> > Can you share what precise test you did ?
>
> To be able to get a situation where "rcv_ssthresh > rcv_wnd", I simply
> executed MPTCP Connect selftest. You can also force creating TCP only
> connections with '-tt', e.g.
>
>   ./mptcp_connect.sh -tt

I was asking Jason about TCP tests. He mentioned TCP_CRR

I made several of them, with temporary debug in the kernel that did
not show the issue.


I am wondering if this could hide an issue in MPTCP ?

>
>
> To be able to reproduce the issue with the selftests mentioned in [1], I
> simply executed ./mptcp_connect.sh in a loop after having applied this
> small patch to execute only a part of the subtests ("disconnect"):
>
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools=
/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 5e3c56253274..d8ebea5abc6c 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -855,6 +855,7 @@ make_file "$sin" "server"
> >
> >  mptcp_lib_subtests_last_ts_reset
> >
> > +if false; then
> >  check_mptcp_disabled
> >
> >  stop_if_error "The kernel configuration is not valid for MPTCP"
> > @@ -882,6 +883,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
> >
> >  stop_if_error "Could not even run ping tests"
> >  mptcp_lib_pr_ok
> > +fi
> >
> >  [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem l=
oss random $tc_loss delay ${tc_delay}ms
> >  tc_info=3D"loss of $tc_loss "
> > @@ -910,6 +912,7 @@ mptcp_lib_pr_info "Using ${tc_info}on ns3eth4"
> >
> >  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}=
ms $tc_reorder
> >
> > +if false; then
> >  TEST_GROUP=3D"loopback v4"
> >  run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> >  stop_if_error "Could not even run loopback test"
> > @@ -959,6 +962,7 @@ log_if_error "Tests with MPTFO have failed"
> >  run_test_transparent 10.0.3.1 "tproxy ipv4"
> >  run_test_transparent dead:beef:3::1 "tproxy ipv6"
> >  log_if_error "Tests with tproxy have failed"
> > +fi
> >
> >  run_tests_disconnect
> >  log_if_error "Tests of the full disconnection have failed"
>
> Note that our CI was able to easily reproduce it. Locally, it was taking
> around 30 to 50 iterations to reproduce the issue.
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/issues/551
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
