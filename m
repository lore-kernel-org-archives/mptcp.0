Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3E152515
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752959; cv=none; b=pIJCYw4KDMaBKoUHcykw2fW0eperQV3crxkn0PqfREs1mscsD/UOGaRAuIVTEUw7pHSmnepNyMoT1Yuti/02pu6J7R0yFBKRfPesmsZj6F0Yr2Qxaen0jS9J82Oxe72ms4g2bloUKhAPM5X71TJ1+1cop5jtYxSEGkPTi0whPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752959; c=relaxed/simple;
	bh=8+9nOcXVKsjItQ3q2o1xz0E/8W2ANuTroVpe5CFk/cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2cGwF/PQAvn1B8ulWziMhPJaF8Mk/Pd1LMOKK8iu0nQz+L/4VWGrn09SjtCpFSGuO1V66IsW7PzGdPH7M3rWdMw2dXQ/eAIhMvoC98DhBD1LLT4+EMG5HYCOpw5sgu7OrfuLcV3GdScx2BhJq+BuqcbSGUabAscXJVZe4b8FVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zf24jzKD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zf24jzKD"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so69a12.1
        for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721752956; x=1722357756; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMgrUZYhZ291PCb07pbCFMhXLROzuLP5cMbjUbcyg/c=;
        b=zf24jzKD1GEYAhECYiO1z/Ci7ba8SiZ1VGG1/HD1YsS9aKwb0GYbO7v+mPwUYhymAn
         eNouvZdrc7m4euoR/0dY7ToCfRg7P8sAeArt4EZHe54qOv+N4z0dbspLFy26T2H5KgFD
         h2vEdcIdJFLWqlLyr/9Okz7AypA9++D5tI6SBKFBsE2wcjf6+SACWF+6tn771TJOoG5Y
         1GHHzFq7SIO+t93947kybSnneGjn0rjwz0n1Kum60EMmfxPL/xUvmqgQTC7Td8QZsTa6
         RD8wMVjSkTNH1Sm4fKD3VXHVc3Hy6d4Bk5JhiHPojAYO5XCTiAc7G7gTuQ5csoy4Plg0
         3yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752956; x=1722357756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMgrUZYhZ291PCb07pbCFMhXLROzuLP5cMbjUbcyg/c=;
        b=Lg4OwMisQ76CBoXfofvziJtruggN45C1F5+8W9zSaSVoWcreMhdJmLgtrWdjo+O5Ul
         M00FyEmYrWBwD7yOCZfVG5bQqCrbVb27TMqPa/Cf7xvIPur+I/4hxW062Ddi6FbkubVO
         cly+07+dtkyLq33OujgFDzdQOkbNkzDGVgvisbp1RSFa6nBY9fYLROXQX5f7YSH0EIav
         qUMklaBYD9NWNbDpiURVdWqZcH/EvN83Or4w6OffbjHHnHoFgSABPd54QHHAfvtN41lI
         qvqVsFgDsoSacZlrVkSad+X/PW45FUYD5Vf2va3MuPfmhf36kuQGLXlf8mzSK31NpWhV
         upbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUns2Q7nx4ivj1aEJD61XpBjTG4td7zYmlZJ6rqcCcuPZPj2HyRl9A325NlgVTO/iLq2Ed8HTVCzO3JA/QMsoVbPHY96qo=
X-Gm-Message-State: AOJu0YymSvjQ6nXv04rlzB9p4KhttmuRjw2YHOxuMldyRn6TqjHWc262
	8fp2ey+2kvn/9gVX4DYUbb8qAZ33LVeRqTAfZO/JpvdAcmnqApOossUPDJ5wEaDH0TFYNhXGFbX
	8u7Vj/aPOEQfxAo9v7kimg0TGuYAVxltmaLB4
X-Google-Smtp-Source: AGHT+IGcuYGTEY2zkTAtoxiNPuK40FrcisAWLBI2aeeYJc1FQnsJqQnlNJ01lTiqGeQf+LAaIya7+C4ntELJwfZMxUQ=
X-Received: by 2002:a05:6402:13c2:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5aacb8e3ef4mr467a12.3.1721752955552; Tue, 23 Jul 2024 09:42:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
 <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org> <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
 <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org>
In-Reply-To: <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 18:42:24 +0200
Message-ID: <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 6:08=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 23/07/2024 17:38, Eric Dumazet wrote:
> > On Tue, Jul 23, 2024 at 4:58=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Eric,
> >>
> >> +cc Neal
> >> -cc Jerry (NoSuchUser)
> >>
> >> On 23/07/2024 16:37, Eric Dumazet wrote:
> >>> On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
> >>> <matttbe@kernel.org> wrote:
> >>>>
> >>>> The 'Fixes' commit recently changed the behaviour of TCP by skipping=
 the
> >>>> processing of the 3rd ACK when a sk->sk_socket is set. The goal was =
to
> >>>> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> >>>> unnecessary ACK in case of simultaneous connect(). Unfortunately, th=
at
> >>>> had an impact on TFO and MPTCP.
> >>>>
> >>>> I started to look at the impact on MPTCP, because the MPTCP CI found
> >>>> some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggest=
ed
> >>>> me to look at the impact on TFO with "plain" TCP.
> >>>>
> >>>> For MPTCP, when receiving the 3rd ACK of a request adding a new path
> >>>> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock th=
at
> >>>> has been created when the MPTCP connection got established before wi=
th
> >>>> the first path. The newly added 'goto' will then skip the processing=
 of
> >>>> the segment text (step 7) and not go through tcp_data_queue() where =
the
> >>>> MPTCP options are validated, and some actions are triggered, e.g.
> >>>> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
> >>>> running a packetdrill test [3] establishing a second subflow.
> >>>>
> >>>> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> >>>> delayed. Still, we don't want to have this behaviour as it delays th=
e
> >>>> switch to the fully established mode, and invalid MPTCP options in t=
his
> >>>> 3rd ACK will not be caught any more. This modification also affects =
the
> >>>> MPTCP + TFO feature as well, and being the reason why the selftests
> >>>> started to be unstable the last few days [4].
> >>>>
> >>>> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
> >>>> passing: if the 3rd ACK contains data, and the connection is accept(=
)ed
> >>>> before receiving them, these data would no longer be processed, and =
thus
> >>>> not ACKed.
> >>>>
> >>>> One last thing about MPTCP, in case of simultaneous connect(), a
> >>>> fallback to TCP will be done, which seems fine:
> >>>>
> >>>>   `../common/defaults.sh`
> >>>>
> >>>>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) =3D 3
> >>>>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progr=
ess)
> >>>>
> >>>>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0=
,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> >>>>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0=
,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> >>>>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0=
,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> >>>>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 1=
00, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=3D2]>
> >>>>
> >>>>   +0 write(3, ..., 100) =3D 100
> >>>>   +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop,=
 nop, sack 0:1>
> >>>>   +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
> >>>>
> >>>> Simultaneous SYN-data crossing is also not supported by TFO, see [6]=
.
> >>>>
> >>>> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/9=
936227696 [1]
> >>>> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
> >>>> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-ne=
xt/gtests/net/mptcp/syscalls/accept.pkt#L28 [3]
> >>>> Link: https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-m=
ptcp-dbg&test=3Dmptcp-connect-sh [4]
> >>>> Link: https://github.com/google/packetdrill/blob/master/gtests/net/t=
cp/fastopen/server/basic-cookie-not-reqd.pkt#L21 [5]
> >>>> Link: https://github.com/google/packetdrill/blob/master/gtests/net/t=
cp/fastopen/client/simultaneous-fast-open.pkt [6]
> >>>> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous conne=
ct().")
> >>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> >>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>> ---
> >>>> Notes:
> >>>>  - We could also drop this 'goto consume', and send the unnecessary =
ACK
> >>>>    in this simultaneous connect case, which doesn't seem to be a "re=
al"
> >>>>    case, more something for fuzzers. But that's not what the RFC 929=
3
> >>>>    recommends to do.
> >>>>  - v2:
> >>>>    - Check if the SYN bit is set instead of looking for TFO and MPTC=
P
> >>>>      specific attributes, as suggested by Kuniyuki.
> >>>>    - Updated the comment above
> >>>>    - Please note that the v2 has been sent mainly to satisfy the CI =
(to
> >>>>      be able to catch new bugs with MPTCP), and because the suggesti=
on
> >>>>      from Kuniyuki looks better. It has not been sent to urge TCP
> >>>>      maintainers to review it quicker than it should, please take yo=
ur
> >>>>      time and enjoy netdev.conf :)
> >>>> ---
> >>>>  net/ipv4/tcp_input.c | 7 ++++++-
> >>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>>> index ff9ab3d01ced..bfe1bc69dc3e 100644
> >>>> --- a/net/ipv4/tcp_input.c
> >>>> +++ b/net/ipv4/tcp_input.c
> >>>> @@ -6820,7 +6820,12 @@ tcp_rcv_state_process(struct sock *sk, struct=
 sk_buff *skb)
> >>>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
> >>>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
> >>>>
> >>>> -               if (sk->sk_socket)
> >>>> +               /* For crossed SYN cases, not to send an unnecessary=
 ACK.
> >>>> +                * Note that sk->sk_socket can be assigned in other =
cases, e.g.
> >>>> +                * with TFO (if accept()'ed before the 3rd ACK) and =
MPTCP (MPJ:
> >>>> +                * sk_socket is the parent MPTCP sock).
> >>>> +                */
> >>>> +               if (sk->sk_socket && th->syn)
> >>>>                         goto consume;
> >>>
> >>> I think we should simply remove this part completely, because we
> >>> should send an ack anyway.
> >>
> >> Thank you for having looked, and ran the full packetdrill test suite!
> >>
> >>>
> >>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >>> index ff9ab3d01ced89570903d3a9f649a637c5e07a90..91357d4713182078debd7=
46a224046cba80ea3ce
> >>> 100644
> >>> --- a/net/ipv4/tcp_input.c
> >>> +++ b/net/ipv4/tcp_input.c
> >>> @@ -6820,8 +6820,6 @@ tcp_rcv_state_process(struct sock *sk, struct
> >>> sk_buff *skb)
> >>>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
> >>>                         tcp_shutdown(sk, SEND_SHUTDOWN);
> >>>
> >>> -               if (sk->sk_socket)
> >>> -                       goto consume;
> >>>                 break;
> >>>
> >>>         case TCP_FIN_WAIT1: {
> >>>
> >>>
> >>> I have a failing packetdrill test after  Kuniyuki  patch :
> >>>
> >>>
> >>>
> >>> //
> >>> // Test the simultaneous open scenario that both end sends
> >>> // SYN/data. Although we don't support that the connection should
> >>> // still be established.
> >>> //
> >>> `../../common/defaults.sh
> >>>  ../../common/set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=3D0`
> >>>
> >>> // Cache warmup: send a Fast Open cookie request
> >>>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> >>>    +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
> >>>    +0 sendto(3, ..., 0, MSG_FASTOPEN, ..., ...) =3D -1 EINPROGRESS
> >>> (Operation is now in progress)
> >>>    +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO,nop,nop>
> >>>  +.01 < S. 123:123(0) ack 1 win 14600 <mss
> >>> 1460,nop,nop,sackOK,nop,wscale 6,FO abcd1234,nop,nop>
> >>>    +0 > . 1:1(0) ack 1
> >>>  +.01 close(3) =3D 0
> >>>    +0 > F. 1:1(0) ack 1
> >>>  +.01 < F. 1:1(0) ack 2 win 92
> >>>    +0 > .  2:2(0) ack 2
> >>>
> >>>
> >>> //
> >>> // Test: simulatenous fast open
> >>> //
> >>>  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 4
> >>>    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
> >>>    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) =3D 1000
> >>>    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
> >>> abcd1234,nop,nop>
> >>> // Simul. SYN-data crossing: we don't support that yet so ack only re=
mote ISN
> >>> +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscal=
e
> >>> 6,FO 87654321,nop,nop>
> >>>    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> >>>
> >>> // SYN data is never retried.
> >>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> >>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >>>    +0 > . 1001:1001(0) ack 1
> >>
> >> I recently sent a PR -- already applied -- to Neal to remove this line=
:
> >>
> >>   https://github.com/google/packetdrill/pull/86
> >>
> >> I thought it was the intension of Kuniyuki's patch not to send this AC=
K
> >> in this case to follow the RFC 9293's recommendation. This TFO test
> >> looks a bit similar to the example from Kuniyuki's patch:
> >>
> >>
> >> --------------- 8< ---------------
> >>  0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
> >> +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
> >>
> >> +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
> >> +0 < S  0:0(0) win 1000 <mss 1000>
> >> +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wsca=
le 8>
> >> +0 < S. 0:0(0) ack 1 win 1000
> >>
> >>   /* No ACK here */
> >>
> >> +0 write(3, ..., 100) =3D 100
> >> +0 > P. 1:101(100) ack 1
> >> --------------- 8< ---------------
> >>
> >>
> >>
> >> But maybe here that should be different for TFO?
> >>
> >> For my case with MPTCP (and TFO), it is fine to drop this 'goto consum=
e'
> >> but I don't know how "strict" we want to be regarding the RFC and this
> >> marginal case.
> >
> > Problem of this 'goto consume' is that we are not properly sending a
> > DUPACK in this case.
> >
> >  +.01 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 4
> >    +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
> >    +0 sendto(4, ..., 1000, MSG_FASTOPEN, ..., ...) =3D 1000
> >    +0 > S 0:1000(1000) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO
> > abcd1234,nop,nop>
> > // Simul. SYN-data crossing: we don't support that yet so ack only remo=
te ISN
> > +.005 < S 1234:1734(500) win 14600 <mss 1040,nop,nop,sackOK,nop,wscale
> > 6,FO 87654321,nop,nop>
> >    +0 > S. 0:0(0) ack 1235 <mss 1460,nop,nop,sackOK,nop,wscale 8>
> >
> > +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
> > 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
> >    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
>
> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?

It is normal, because the SYN was already received/processed.

sack 0:1 represents this SYN sequence.
