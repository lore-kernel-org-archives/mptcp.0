Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699E152180
	for <mptcp@lists.linux.dev>; Wed, 24 Jul 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817365; cv=none; b=smO5d/mi0krxLx7CXJbGiWkkBgf3sCD0tkr/on9RRrhSZZ+sI5fD6+9GOT7hjCboXp5c58RlSPkP8lZGLd6NB5hA8A/6g2Bgr/bDRVfGqgtTfKmYjJfJrLcBzlOn3D4JaR23tHdDQAoz+Q9QARfvDaZPJUswrRMtUovmOTrwG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817365; c=relaxed/simple;
	bh=O6vjbx2GDH4VAYilRfk8maQQqQwuV7meGtlS81k1ok8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzu9gmcF0dhRHKcRIBoB3EBLFoNfjwF39FCOeFARjxppRd4M8USnojRzswYfOre6V5sxSxnd5h+iYiWzBeJTIr7pdlLD5vSHZYCl58SwTgBz1m0QjWOIKIF+qCkoM09fq3uhCgEY0cFB7PDpmb60Ek11eCRzsXGhVtwNLEywEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKaK/rsk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKaK/rsk"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso13109a12.0
        for <mptcp@lists.linux.dev>; Wed, 24 Jul 2024 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721817362; x=1722422162; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ousfKxhx+XutxhMDlN6drqCq9yWFYE8n1t3G/0pQAY4=;
        b=jKaK/rsk/iCx0L1HYCBtAIEDx8/i7kbU2z99gC3Sn2fjp/IhAHIMcSMHSEi0bAwNfN
         yNBsTUghWde/SWbX5PUYitGep1B+1EoQ46Jt/c5UNdcZDDpepR/rzYSI0QpOrE8ZAO+2
         9awHk+eYL+mxTL6FWXZqKzmh0dqcxYML8+3J6aBA/RCFdr5AEqz8Zn507P5E9IyczvQV
         55t4juEyszaFMKcoNJE0MYjAV9I1hu4pZCGQuDWixuYFix1rmBBiyWtLTQtvRVyU1GPE
         9EfSN+x+Ahst557gwYQ0wHC3CWEzYh+2d6rNQGAAkRWVVRly72fLq2P5syFFawgC8U/0
         6vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817362; x=1722422162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ousfKxhx+XutxhMDlN6drqCq9yWFYE8n1t3G/0pQAY4=;
        b=SO52E/8G7pGpUlaUSKzJB2a5fTpb1ZU7GLjJyh0UJZQZHKe7ddlTMXQyGsx5Gds8Hb
         O0CWqZtG/OkQNHOoW/ML71FBrFfiRP/Z/7hc/7tzfkINfiCsQq0v1ZrA04X4z+/4q6Ax
         B/nO1UPmwAD664Qfn05x9T5WSwXKjzpVY1MFYqBadNy7OTbrC5B3jSotnaYJURau+T1I
         jdbnJl6tdsApfZ1iZbVCRbzqOq7TExDUdIDpDsirHCUe6C4H0rz2WERw4pPfzPQic21p
         0d722+4j/4QXu75T4Pt5BuK/V5sL/y8/48EJyyjuly4Bn9t19HIr1qYq5lE+BlwVcJBl
         KVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8kl41jIuEXR3hMldi5DFS5yyCOyHiC/yM9VvTZyshDqa+Vkyqe3utj7b1k0sXfJeavOABkbWLJk0wbLKiSqyS3FLs2Y8=
X-Gm-Message-State: AOJu0Yz705tmDrbcBTD2IlJTJFD9cSyYsp9IakLcCipyohVeul4uYcZj
	G8ULZ04dkt1Vqtdm/zbJMBJuVW4pYLW3r5B0C0It3Q7iukxJxkrLbNVmdDtovW61I+AGC5FsF3r
	pwpWH4Fc9aFbF5S96K1JoDKl6s7A14YX5cBug
X-Google-Smtp-Source: AGHT+IE2UVOVTpAlrBj6qDLRJHI/efrh0NOisoQWTce2uyvbySR2MiI9a/47VDNXNTBkv9lMRW7GxrzOqZButaluidQ=
X-Received: by 2002:a05:6402:2554:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5aacc18da2dmr198040a12.5.1721817361344; Wed, 24 Jul 2024
 03:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
In-Reply-To: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 12:35:47 +0200
Message-ID: <CANn89i+N578sZBjGtKs1CCU5WGudF-z+g0C4T-MHg751ykYZBQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:25=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
> had an impact on TFO and MPTCP.
>
> I started to look at the impact on MPTCP, because the MPTCP CI found
> some issues with the MPTCP Packetdrill tests [1]. Then Paolo Abeni
> suggested me to look at the impact on TFO with "plain" TCP.
>
> For MPTCP, when receiving the 3rd ACK of a request adding a new path
> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
> has been created when the MPTCP connection got established before with
> the first path. The newly added 'goto' will then skip the processing of
> the segment text (step 7) and not go through tcp_data_queue() where the
> MPTCP options are validated, and some actions are triggered, e.g.
> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
> running a packetdrill test [3] establishing a second subflow.
>
> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> delayed. Still, we don't want to have this behaviour as it delays the
> switch to the fully established mode, and invalid MPTCP options in this
> 3rd ACK will not be caught any more. This modification also affects the
> MPTCP + TFO feature as well, and being the reason why the selftests
> started to be unstable the last few days [4].
>
> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
> passing: if the 3rd ACK contains data, and the connection is accept()ed
> before receiving them, these data would no longer be processed, and thus
> not ACKed.
>
> One last thing about MPTCP, in case of simultaneous connect(), a
> fallback to TCP will be done, which seems fine:
>
>   `../common/defaults.sh`
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, n=
op, wscale 8, mpcapable v1 flags[flag_h] key[skey=3D2]>
>   +0 >  . 1:1(0) ack 1           <nop, nop, TS val 845707014 ecr 700, nop=
, nop, sack 0:1>
>
> Simultaneous SYN-data crossing is also not supported by TFO, see [6].
>
> Kuniyuki Iwashima suggested to restrict the processing to SYN+ACK only:
> that's a more generic solution than the one initially proposed, and
> also enough to fix the issues described above.
>
> Later on, Eric Dumazet mentioned that an ACK should still be sent in
> reaction to the second SYN+ACK that is received: not sending a DUPACK
> here seems wrong and could hurt:
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0)                <mss 1460, sackOK, TS val 1000 ecr 0,nop,=
wscale 8>
>   +0 < S  0:0(0)       win 1000 <mss 1000, sackOK, nop, nop>
>   +0 > S. 0:0(0) ack 1          <mss 1460, sackOK, TS val 3308134035 ecr =
0,nop,wscale 8>
>   +0 < S. 0:0(0) ack 1 win 1000 <mss 1000, sackOK, nop, nop>
>   +0 >  . 1:1(0) ack 1          <nop, nop, sack 0:1>  // <=3D=3D Here
>
> So in this version, the 'goto consume' is dropped, to always send an ACK
> when switching from TCP_SYN_RECV to TCP_ESTABLISHED. This ACK will be
> seen as a DUPACK -- with DSACK if SACK has been negotiated -- in case of
> simultaneous SYN crossing: that's what is expected here.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/993622=
7696 [1]
> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gt=
ests/net/mptcp/syscalls/accept.pkt#L28 [3]
> Link: https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-mptcp-=
dbg&test=3Dmptcp-connect-sh [4]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/server/basic-cookie-not-reqd.pkt#L21 [5]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/client/simultaneous-fast-open.pkt [6]
> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().=
")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks a lot !

Reviewed-by: Eric Dumazet <edumazet@google.com>
