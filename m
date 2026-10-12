Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5E4D4879
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834503; cv=pass; b=mlAONR2fBv4/kOTu4XEwfRn/ftmsFzjGRS9PaFpED5YbgiCDQKmx0pMUu2gMQbcYxZwLqdAN1JYsYbjmqjK0aKN7tq/fFrNW+Hc0Eh6+gba0ytKjGc/q5Q10rxQai9gAlTvbRum11dk7NulacBDpptN6s2n+LPpFq42qqWoaYOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834503; c=relaxed/simple;
	bh=B7US8fNePp2tNbb4HE/pkst7F1dJjN1jZlpZjHlvhyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7Te8tYvsYk4yz+zshXy63D/xBZwWaNu1MJEqLotX11ngeotjfiRYuAwF/opg54e/4iCqMljRununncHprh44UhnGssKM6wYcODzHwnv2JLoS9UpRn7raLPJzIC+qw6BQ8f4EeVfWnqLhM4zq8CjO02lZGB7Qc826s3+r2qM3zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish; spf=pass smtp.mailfrom=ink.fish; dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b=y3aKvtxv; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ink.fish
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ink.fish
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ink.fish header.i=@ink.fish header.b="y3aKvtxv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2957561a12.2
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 12:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834500; cv=none;
        d=google.com; s=arc-20260327;
        b=rS/bHPR7x12podhX7htGyzkuwGRb4vH7OrJ33p1Zec0LxSr+oua1KOu5A/qVDWEa0W
         ggtq7wIFmKV51nPoa5tfXBvlzRImFNW+8kK5laoiWxQHZIeG9d9mpOmutdWsRxYSR8RW
         N0ARdrdRNCiP7j8SF0D0CsNpNRghBxYQrP6Sd/gECqtFFOmzBQKQd+ISiG2EPJGEnwPw
         mY1n0Ry79TenmzaYPWpHsawpSxr62hy6b2Gds/C8BkpdsrBt8j0Sv1ZZF7vJyudDjKPh
         xC2+sxPdScVowNggGXD5UDeIsy/bPrbtSpjnhWYpV9R0gAYcPp4TEzyT3t196WLkWgia
         ND+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDhUKkAq9qSEi3pYQ4/Fd8cwrPQgAd0uKr7kcgvf+40=;
        fh=DmscGsNTtDZieTwNmareJY1Y0ZTj47lohRqIS2VoUV8=;
        b=LgfwojQn7wqBrQgdzBXHUwBMxlMJ6nJDDxnxBiv+wrlb8zjLhyfSojIs/23936VA09
         SvAF20PwGmqxaPFFI1Yjo01OhVXM3WRzjFoL8onxvyrDbzPZBxold3p4Lr1+5Fttv6/+
         bQO7poXvetgkKuHlfPIfGH/qv3SqVStOtIvLouY28Gv+9ZCJr4/Pp1U+DDnooT1JEpaK
         x+h+cyk19H2HDoMHoV13o0z7xcEx70/7OWSFZ/TjB0dmPNpxjHDUbUwOzFE6fgloxQX2
         Xaprt+ldRaspS5anqrm9IF82g4hzz1n2xCKY+Dcd9nwWP7a+sDRGOQmJG3wSSE+QpIsp
         +nxw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ink.fish; s=google; t=1791834500; x=1792439300; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WDhUKkAq9qSEi3pYQ4/Fd8cwrPQgAd0uKr7kcgvf+40=;
        b=y3aKvtxvx4Or4KqAvFM+Z6nasqugiA0IqMzwlKJsTKWfbbLoxsJ2IuKgZyva//JZhO
         3oyQuqHFfcANo9t2ZT1DzTNI63V21YadmE4pX1MFlOdfAswYwKdFqlXEsLQfOQ70suKN
         XJC8LMCKvJaweVEOO5K9p16PgcK8YuvEyo/d45rKFj/xobZNqcvO1o9JI2rSXm53ih4/
         Rml0/nkgmFqKw4v2hfKBzKNzsnbK/ZZNiXv/qyBbilEN/kVVhcRsfyMtCOnBar6mPWAt
         mm34UN62iOSI15PHo1eBW8uwlt7Zqr9TH4lAdwrPtNgmYqhSVFc/nWmhExwRJFLhcf4i
         wafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834500; x=1792439300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDhUKkAq9qSEi3pYQ4/Fd8cwrPQgAd0uKr7kcgvf+40=;
        b=SjEUfXCxMwTUzf8RpGJnW1aJcG7TWbe/Q6bPJweO4yshh7lNs96wwX4tpb2c7YzPHq
         /b8+gz28+aBLlPbb/UJxxweirWovXEtEAutxbb9lDEBpq6491JRdj4sQ/U4bOZAUSACR
         J8Q/ECfw8QzIFd72f//i81OZ79jHbk9rDlTiauzqnpXXTyq54TtN8N2kNJR1jJIyT+P2
         SCzDyc5V4kKgDN9RCLo4sVDgSBG2PPu8jqOw1xFb5ZeEw78cbGi4Pu6WNyA+x1oQEyC2
         M1wRdqBziXpETjj78P/6mYpyx/Ru9t2fjNZBM5U8XAZd3T07vmVysTtGcEpmG27yXROG
         9ccQ==
X-Forwarded-Encrypted: i=1; AKwUvBynOoLLx415WMyFtL4yF7v4P0VPyIRXcFLVRVpRrFj7uuuEPhTohrqaVYsZeqjzyZPDaVUhZQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKfj1hNb2WitLsLtL35B/3H0U9j2O5U+h1ptpHtT3WMksG7GwWx
	pbqPadoIBZG52l/Vv7bwEXk/RxdZQiIxyS+Jbn85atdAL19VOR/NYsLMzwsaC4OUi8noAZLTDMx
	fA2PckB+eZHBPZgfDG9SDeaDDOtvBtYTHMV7fX1P2DR9iQD8WiJKLodlKO8Kn
X-Gm-Gg: AYBFou0IROkgJuTl5hKz7dkXc1+OZVv5zpKqwHGuT77j1viA3jTZbEeHnOMy9v/eXKx
	nKfGWcAVgetUupY7e50PHeT4gK2lQsB9YBkBlt7DZupZhv2rYwGSaoeBo+kCKmraEuGhm4BbRUW
	iy1t4buZ80k5edXEAwySgYV2CtrebODkYnF+UbLAjuEzvohihtbXDQHap3j9RwezQ2WDdG9c2io
	be7S/MTTgX7nmE4e7/QShMmLbeJEsAKNhno8ysiGedJO5NXWeeUZzx6fWdKPGPRR8VpqhQ7SzcW
	Dx4UfqkgMgdV1yI7uLzzogR80y3jS/pFZN15p3Z2GhQQ6KrXdovZ+G0GI5+I0QACWzPvMV6+Juv
	wTuz87PItFr9oG600PEvBVjxfFIliL0LUQdB42aiYnzQtaDfn5g+AqefKwbxTqCJrJG/vIHUP
X-Received: by 2002:a05:6402:2346:b0:6aa:e37e:92b8 with SMTP id
 4fb4d7f45d1cf-6b17c294046mr9127137a12.16.1791834500341; Mon, 12 Oct 2026
 12:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
 <CADRhS2uk-P8TSmyiM=X5JQXHtzdm68vg6+vyBDr-UCf0EAu0HA@mail.gmail.com> <b5d420d1-859a-4c84-a658-e7aa44abbb30@kernel.org>
In-Reply-To: <b5d420d1-859a-4c84-a658-e7aa44abbb30@kernel.org>
From: Petar Sakic <petar.sakic@ink.fish>
Date: Mon, 12 Oct 2026 21:48:09 +0200
X-Gm-Features: AclHuK-ZKDufcBnW9I3rYZfIzzKqmuhwPe1hMduO1lLdfuXfhvTkbtyJrQnKfEs
Message-ID: <CAFPPu1gEqVx=LuW8Z5qv-6GRDwzkLjbvdQwYOgaacL3zLBXWtQ@mail.gmail.com>
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
To: Matthieu Baerts <matttbe@kernel.org>
Cc: T S RAMESHKUMAR <rameshsv06@gmail.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu and T S

I hope replying here is OK.

Tested v2 on top of 6.12.111 (applies with a 15-line offset, no other chang=
e).

Setup: two netns over a veth pair, netem 50 ms each way (100 ms RTT). MPTCP
listener with TCP_FASTOPEN=3D16; the server replies as soon as accept() ret=
urns,
while the TFO child is still SYN_RECV (checked via TCP_INFO). Client: first
connection fetches the cookie, the next ones use TCP_FASTOPEN_CONNECT so th=
e
request rides the SYN. Checked per run: TCPFastOpenActive/Passive,
MPCapableSYNTX/ACKRX, MPCapableFallbackACK =3D 0.

- 6.12.111 unpatched: reply stranded on every TFO connection (3/3).
- 6.12.111 + v2: reply delivered on every TFO connection (3/3), ~2 RTT.
  Plain TCP control unchanged.

Tested-by: Petar Sakic <petar.sakic@ink.fish>

One case v2 does not cover, same setup: a cookie-bearing SYN with no data
(sendmsg MSG_FASTOPEN, zero bytes), server speaking first.
tcp_fastopen_create_child() still creates the child (TCPFastOpenPassive
increments, accept() returns in SYN_RECV), but
mptcp_fastopen_subflow_synack_set_params() returns before setting
subflow->is_mptfo because the receive queue is empty, so the new check
never fires and the reply is stranded again (2/2, with and without v2).
Plain TCP handles it. Moving the assignment above the early return makes
both cases pass here (3/3 and 2/2), no splats:

--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -25,13 +25,13 @@
        tp =3D tcp_sk(ssk);

+       subflow->is_mptfo =3D 1;
+
        /* A valid TFO cookie does not guarantee SYN data. */
        skb =3D skb_peek(&ssk->sk_receive_queue);
        if (!skb)
                return;

-       subflow->is_mptfo =3D 1;
-
        /* dequeue the skb from sk receive queue */

Up to you whether that belongs in this patch or a follow-up.

Cheers,
- Petar


On Mon, Oct 12, 2026 at 3:28=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi T S,
>
> +cc Petar.
>
> On 12/10/2026 12:00, T S RAMESHKUMAR wrote:
> > Hi Matt, Petar,
> >
> > Thank you both!
> >
> > I have prepared [PATCH mptcp-net v2] based on the export branch.
> > In v2:
> > - Reverted bitfield modifications: check_fully_established() is only
> > called once upon receiving the MPC 3rd-ACK, so is_mptfo is read-only at
> > that stage and safe from concurrency races.
> > - Added "Suggested-by: Petar Sakic <petar.sakic@ink.fish>" and
> > "Reported-by: Petar Sakic <petar.sakic@ink.fish>".
> > - Kept the Fixes tag pointing to fb7084501a61 ("mptcp: add support for
> > TCP_FASTOPEN sockopt") to ensure backports cover 6.8 and all stable tre=
es.
>
> Thank you. I will try to review this after the automated tests.
>
> > Regarding Packetdrill:
> > I have prepared the packetdrill test case (server-TCP_FASTOPEN-early-
> > write.pkt) which simulates the server writing data in SYN_RECV before
> > the 3rd ACK arrives and verifies that the 100 bytes are pushed
> > immediately with DSS mapping once the 3rd ACK is received. All 51
> > fastopen tests pass.
> >
> > I can submit the packetdrill test via a PR on https://github.com/
> > multipath-tcp/packetdrill <https://github.com/multipath-tcp/
> > packetdrill>, or send it directly to the list if preferred. Here is the
> > test script for reference:
>
> Please open a new PR.
>
> > --- server-TCP_FASTOPEN-early-write.pkt ---
> > // SPDX-License-Identifier: GPL-2.0
> > // Test MPTCP passive Fast Open early write before 3rd ACK arrives
> > --tolerance_usecs=3D100000
> > `../common/defaults.sh`
> >
> >  0.0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
> > +0.0    setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0.0    setsockopt(3, SOL_TCP, TCP_FASTOPEN, [2], 4) =3D 0
> >
> > +0.0    bind(3, ..., ...) =3D 0
> > +0.0    listen(3, 1) =3D 0
> >
> > // Client connects with TFO Cookie and 500 bytes of SYN data
> > +0.1      <  S   0:500(500)                win 65535  <mss 1460, sackOK=
,
> > TS val 100 ecr 0,   nop, wscale 8, FO TFO_COOKIE, nop, nop, mpcapable v=
1
> > flags[flag_h] nokey>
> > +0.0      >  S.  0:0(0)          ack 501              <mss 1460, sackOK=
,
> > TS val 100 ecr 100, nop, wscale 8,                          mpcapable v=
1
> > flags[flag_h] key[skey]>
> >
> > // Server accepts while still in SYN_RECV and reads the SYN data
> > +0.0    accept(3, ..., ...) =3D 4
> > +0.0    read(4, ..., 500) =3D 500
> >
> > // Server writes early reply data before receiving client's 3rd ACK
> > +0.0    write(4, ..., 100) =3D 100
> >
> > // Client's 3rd ACK arrives with no data, establishing the MPTCP connec=
tion
> > +0.2      <   .  501:501(0)      ack 1     win 450    <
> >                                                              mpcapable
> > v1 flags[flag_h] key[ckey, skey]>
>
> Here, you are dropping TCP Timestamps (TS) negotiated before. Probably
> better to keep it (or you don't inject it in he first SYN, clearer).
>
> > // Server must immediately push the queued 100 bytes with DSS mapping
> > +0.0      >  P.  1:101(100)      ack 501              <nop, nop, TS val
> > 100 ecr 100, dss dack8=3D0 dsn8=3D1 ssn=3D1 dll=3D100 nocs>
>
> "dack8=3D0"? That's strange...
>
> Also, TCP options are not padded correctly to ensure TCP header is a
> multiple of 4 bytes: 2 excess bytes =E2=86=92 you are missing two "nop" a=
t the end.
>
> How did you test it?
>
>  $ cd <Packetdrill DIR>/gtests/net
>  $ run_all.py -lv mptcp/fastopen/server-TCP_FASTOPEN-early-write.pkt
>
> Don't forget to add the "Assisted-by: LLM" tag if used, and mention what
> you did, how you tested things. You can use this docker image to ease
> the testing part:
>
>   https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
