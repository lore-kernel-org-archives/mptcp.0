Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A692FF660
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142331; cv=none; b=PjqOABymDzakpduRacovK3oloZCMMXCL99d6wvJ+Wua+8wbUcWqE7j3pUqgAiL8IWx3C/N+h8+x1Q5qragiLBu33c7F5StyWe0CdcwtMejLRpQpIvZ5T97HyRwmTymXFC0WUPp7j01rJW8CvdYtRrYuUfSOtT3k/85mEI7DiWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142331; c=relaxed/simple;
	bh=EPG5wg+jHgnjds7AcGH4Fx9JNWMgrlmp7Au8zw6rq2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIDoCXhYEMczYmeaxtScCtq0vFakheYehhAf7bWXnSRqgT7G5FPrY/a+NqqWC4NKeNhUs4UUILV8Fmj6nOGncwiR1Ir29pG5miTixyBFkmgQdr9Eu7V/+cAhpRyUr3yfJlFIaIsq2+3hVy8J5WDwsayrfG9SUEWB1yzI79aMqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Sfk4sZZm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Sfk4sZZm"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce526ac04so455937e87.2
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1755142328; x=1755747128; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNARoZDoO9DuMTTSWl+sAj3EwpZbT9Zrtbft7WDRyiQ=;
        b=Sfk4sZZmaeosdqIPqlqmE8DskhdFPBIrbEQA2x+aWeRKp47K/1gZXcC20zwVqzytsS
         Vs2wds3DPeSWvzSyTwmvTvwUxB7TADKAP5mkUXzxAfyxcwepFRuYdHWKVjo6IvHuGuCx
         aPLibjgWjxFBXua0Z3C8xT8a6YIcj4EY0Rxo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142328; x=1755747128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNARoZDoO9DuMTTSWl+sAj3EwpZbT9Zrtbft7WDRyiQ=;
        b=wxlsmrT54TIEDIliqDZU/sOp4El6pXDYTL0VAdoVX6pCn+Rd/v4Xwvm5uLykt5wBwT
         tKBzYxPOhWPtBaudCszSZWEJ1BPMM52N55XTWNSgnI+nT0lGtUzUn5OAi3nm1C9LTpi+
         3NOtXOlog5V/dg851ibJdKeLRQ2/8+v9wNK468Z5VD4LiMiLqZH2GE4H12CrRv8qC5GJ
         49KX9vgFNRkRVqJVTbH80ehaxYgFAyfTunwxKiFYlSBL12+UVNZSGnS+UhLXcEGl+fOC
         GKgNXYIOpgYyMmK47UKBx8V1MqDPbg+bTIPGSVPk7wzcHH3lVPVq+REjg/6e3ESX50py
         kOwg==
X-Gm-Message-State: AOJu0Ywb+H2zsnKfZxyMcIopWDpiaKrByxaf0iOIBSr4qKvFZyB1/ojN
	J07ZL9Bz4ew/VCKRRu94ymNpbF5qoL/ZQRJvLIy1UQqfLRRArXVF1re2WI7KCb8r7ryRHHYxTL3
	5znA/lvjP7Lxv23gt/tdaTtbO4EpynpGbnrK/3Q/jgw==
X-Gm-Gg: ASbGncu9A4lA02LSFO++Os0EpvCi+OfU0AJnX2xMR2ZAe0TPZ20Wb8EUY/5zRuFS2VN
	6uXF15gjzPkx6pWOglkGwGcaFcHf6Uh+JoZ3B7ZWJxyHRzdoxj6jeYDGrZXECu6qUyz887rwiT/
	ek+IWt38Yt/Nyc1rfOws6Srj5RVf4QIuAZqv4x744cfHgwILdbdXxH98Znn2V31RviHGnTvAreW
	Mz3jA==
X-Google-Smtp-Source: AGHT+IFEjhDzLdhWHT+zceRMmBx7YQzdRgU6EVKs/yIo1Web8OQC5eFWU78w2bg/uviOv8XACzLOixoCsI9ZBYt+6dE=
X-Received: by 2002:a05:6512:6cf:b0:553:d910:9344 with SMTP id
 2adb3069b0e04-55ce6339ec2mr296125e87.45.1755142327593; Wed, 13 Aug 2025
 20:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com> <2f037b38-c9f4-44a0-857c-0f65cbd50688@kernel.org>
In-Reply-To: <2f037b38-c9f4-44a0-857c-0f65cbd50688@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 13 Aug 2025 20:31:56 -0700
X-Gm-Features: Ac12FXyos46rcqORlP25gAvlroFwAr6ogareuSG9QL-7GNfqSpYP-XnDhUYtjIo
Message-ID: <CADg4-L9YE8guQWz1xDovoyyHrb723WaurRoeWJZ5P+J=OVrRDg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] mptcp: record subflows in RPS table
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang@kernel.org>, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:54=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 07/08/2025 20:14, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > Accelerated Receive Flow Steering (aRFS) relies on sockets recording
> > their RX flow hash into the rps_sock_flow_table so that incoming packet=
s
> > are steered to the CPU where the application runs.
> >
> > With MPTCP, the application interacts with the parent MPTCP socket whil=
e
> > data is carried over per-subflow TCP sockets. Without recording these
> > subflows, aRFS cannot steer interrupts and RX processing for the flows
> > to the desired CPU.
> >
> > Record all subflows in the RPS table by calling sock_rps_record_flow()
> > for each subflow at the start of mptcp_sendmsg() and mptcp_recvmsg().
> >
> > It does not by itself improve throughput, but ensures that IRQ and RX
> > processing are directed to the right CPU, which is a
> > prerequisite for effective aRFS.
>
> Thank you for looking at that!
>
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  net/mptcp/protocol.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4b510e04724f5c8be08a00a1cc03093bcd031905..86f1fc5be47bd5f6dc8bf40=
a488de32f253c1beb 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/atomic.h>
> >  #include <net/aligned_data.h>
> > +#include <net/rps.h>
> >  #include <net/sock.h>
> >  #include <net/inet_common.h>
> >  #include <net/inet_hashtables.h>
> > @@ -1740,6 +1741,17 @@ static u32 mptcp_send_limit(const struct sock *s=
k)
> >       return limit - not_sent;
> >  }
> >
> > +static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
> > +{
> > +     struct mptcp_subflow_context *subflow;
> > +
> > +     mptcp_for_each_subflow(msk, subflow) {
> > +             struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +
> > +             sock_rps_record_flow(ssk);
>
> Should we eventually open code this RPS function and directly call
> sock_rps_record_flow_hash()? If RPS is not needed, no need to go through
> the subflow list. So we could add: #ifdef CONFIG_RPS + &rfs_needed
> before the for_each, then check the state for each subflow, no?
>
> Or maybe such optimisation is not worth it?

IMO it's not worth it. Because it would also mean that we pull in more
of non-MPTCP things over to MPTCP files.

> While at it, I see that sock_rps_record_flow() is called in
> __inet_accept(), inet(6)_sendmsg and inet(6)_recvmsg, but with the msk.
> I guess that's OK, right?

AFAICS, that should be alright. sk_rxhash should not be set on an msk.
Even on the passive opener side, we clone msk from the ssk, but at
that point sk_rxhash is not set yet. (I may be wrong of course, I'm
still not super familiar with the source-code...)

> Also, is sock_rps_record_flow() called when a subflow is "accept()ed",
> or is there something else to do there for this subflow to copy TCP's
> behaviour?

For new subflows, I don't think we can easily do that. Because
sock_rps_record_flow() records the CPU on which it is running. From
what I see, when new subflows get accepted, that is not happening in
the application's context necessarily. So, we have to wait for a
recvmsg/sendmsg.


Christoph

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
