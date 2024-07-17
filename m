Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36371802DF
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228297; cv=none; b=QCUFvAH3iKN/6n4VQ5qKNLZNNJvYvaif/yVH7jDLrYgqgl5G2UQR3b/3ogc1EXdA8AuMEGiQiweyx5UCuQvwz/WKX8LgnrXlne0uu01AG6mMwsJ/5ECmJVtJtV+ctJHZzJHC/lIXXwXqqUp+aPPOUwxIs+n33e9/dkQwDNo0nJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228297; c=relaxed/simple;
	bh=dpjUFS34+Kn5fyMlt2g900XkmwZUM84v+Sue8ykQgOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz9XSVnQdT6AsHzHWarEikzK+Sv41/N3yN4u8+Ey7My8ZqqIZ9UNDk3DKZMcx9P3yWiYHHzpnZhhs5ZCft7zS/rlf/oMHdyBwk2JpNYILRGEO11ruoY24huJfFhMM5HS6nQaDTjxOf5hHwt7+GRkMFbwHgvwqqIV/5FGeXTW4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boCPkZMm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boCPkZMm"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso20117a12.0
        for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721228294; x=1721833094; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQSNc99mSLlBbaOi1xCED/nnBkGtLUEtseNxdNSuNO8=;
        b=boCPkZMmbYD5Lw2+oeJM4ksltCuzj1PChp/krOzg6vyK6mCLtGfpw4/CSiEgV9omv4
         kaJlbqC9b+pW8R0IaMQzQXNnQSwOiuBbS2sR5KPzzizaolCl5C+3wNp5SDNkZW+8ZrwG
         ejmOB7eGexBrnDNHrHzZ+eTe9xUXc18wpf4Z7+ZPn+TKz7knEmPuk0wY61zXc/V/DSWp
         Xa9sEMd6W3W0CyAqQHJuJ7yTx4T9dDAckMO5bwJU4IMmtwOFwcEj2UhDdpkjj/Zm17JO
         XaigI28y+be1AfoTuAZpWwdsaVTAT13s1dcSaLfJZZrSCwa0cqDJYxHGGfqe7M8HjBr7
         qmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228294; x=1721833094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQSNc99mSLlBbaOi1xCED/nnBkGtLUEtseNxdNSuNO8=;
        b=dklhUTmu6+oHMT0/KYbLiwnUiCDbozqa4fbk7SWbMed4/wsWrtrvFQzkxzo59KEosC
         F8U1+5uI/i06wxmuGy1Ou3+Enj4ryExEULogqpO/iq+rxKVDteYiZFBhvUJLNQ8nSRIk
         y4FMNMLURbU518WnJlaceHoH2ngZcerYj/TmgydxiU2zJIAHucyvU8hUzzAhoHXQ6dPW
         Wjlh9aD0IQn/F7MMlQXK0PKqYa31ak2rZkI5UyO1d8FWBdMzZWkJgayaF2pcSi3LhqS+
         hyAaF+r9hjA6Cwc4gBOtzn1rFmFvPkI8oT/c08cyDA3l9yC3cSczWPRfuQc3dPd6trOD
         LUaA==
X-Gm-Message-State: AOJu0YwOcpG9lmCQRRnu3aJ1Bgua98akCYGqhL7MIqTTujarWe+O8F5F
	vN1yPp7YWTfpWaUr7lcoOU0c+gw0cUG1gE1WxBLGbkse5W7Ez+G4Zjpa8DL0P/sN4WO7qIZR77o
	tt0tNtOmLVoWHlRoWWqN/6WlwOXQL8857yt4F
X-Google-Smtp-Source: AGHT+IFiGEvyTzeYTN0dVhUmIpZZx/yHVA3uop/MuC3ufQZ/Oxya9cPJoO2sp/D/qKluIbTjfrLOEDl73SAIjX/CGhA=
X-Received: by 2002:a50:9f6e:0:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-5a018b20444mr280272a12.2.1721228293562; Wed, 17 Jul 2024
 07:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
In-Reply-To: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Jul 2024 07:57:58 -0700
Message-ID: <CANn89iKrHnzuHpRn0fi6+2WB_wxi5r-HpZ2jrkhrZEPyhBe0HQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: process the 3rd ACK with sk_socket for for TFO/MPTCP
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Neal Cardwell <ncardwell@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:43=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
> had an impact on TFO and MPTCP.
>
> I started to look at the impact on MPTCP, because the MPTCP CI found
> some issues with the MPTCP Packetdrill tests [1]. Then Paolo suggested
> me to look at the impact on TFO with "plain" TCP.
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
> passing: if the 3rd ACK contains data, these data would no longer be
> processed, and thus not ACKed.
>
> Note that for MPTCP, in case of simultaneous connect(), a fallback to
> TCP will be done, which seems fine:
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
>
>   +0 write(3, ..., 100) =3D 100
>   +0 >  . 1:1(0)     ack 1 <nop, nop, TS val 845707014 ecr 700, nop, nop,=
 sack 0:1>
>   +0 > P. 1:101(100) ack 1 <nop, nop, TS val 845958933 ecr 700>
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
> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().=
")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - We could also drop this 'goto consume', and send the unnecessary ACK
>    in this simultaneous connect case, which doesn't seem to be a "real"
>    case, more something for fuzzers.
>  - When sending this patch, the 'Fixes' commit is only in net-next, this
>    patch is then on top of net-next. But because net-next will be merged
>    into -net soon -- judging by the PR that has been sent to Linus a few
>    hours ago -- the 'net' prefix is then used.
> ---
>  net/ipv4/tcp_input.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ff9ab3d01ced..a89b3ee57d8c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6820,7 +6820,13 @@ tcp_rcv_state_process(struct sock *sk, struct sk_b=
uff *skb)
>                 if (sk->sk_shutdown & SEND_SHUTDOWN)
>                         tcp_shutdown(sk, SEND_SHUTDOWN);
>
> -               if (sk->sk_socket)
> +               /* In simult-connect cases, sk_socket will be assigned. B=
ut also
> +                * with TFO and MPTCP (MPJ) while they required further
> +                * processing later in tcp_data_queue().
> +                */
> +               if (sk->sk_socket &&
> +                   TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq =
&&
> +                   !sk_is_mptcp(sk))
>                         goto consume;
>                 break;
>

Hi Matthieu

I had no time yet to run all our packetdrill tests with Kuniyuki patch
because of the ongoing netdev conference.

Is it ok for you if we hold your patch for about 5 days ?

I would like to make sure we did not miss anything else.

I am CCing Neal, perhaps he can help to expedite the testing part
while I am busy.

Thanks !
