Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE83AD528
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475167; cv=pass; b=LWvD+EYErN8mt5/ZrLcX7pT0NCDQoMpfaOpu9KSMQ4t2rVDlYSOVYq1v/ErsQTjdvYGcQao6HCFZrzCWO+7+sndRVNxU8PrPVzN5BgXpyBHj1zqltakI8GskXMng7B6UZIsKtL6Ao7LcgbKTLsNjr1LzdSrYRMhStWv56rGh5Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475167; c=relaxed/simple;
	bh=rKjUe8l12laQaYCR2nsnMV+NraIoKfBe+/vXRLFKb04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePKYPq+7B5Mxh04DZjwLy7wXsLAElzzVvx2DK83/1fPl/S5mg3LEC/BRS5cW0cSXPawZSPSi984gH5yQfy0iS6Cau+zfdS3VNX7UJAlm3h1G/vxtYoCryJ6aVS0jsUXKnjOE8B1+c/IGbF9rjMZkjdiHDNovqFCtrdHdlllp6IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFV0DKEY; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFV0DKEY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2a449c57so2053241cf.1
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 12:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786475165; cv=none;
        d=google.com; s=arc-20260327;
        b=resmLe0eaXm+ZO+uNx0R+m+6kzDZ6b8rk7FRInfQcqD9hbMvwgaEYa39fF8Ab/onKO
         mYtvkbEer4tRkrt+fEkBngk7mKy0/wLzt0T5HsuhSVcN0bGNXDwLZrn9hgGzDiWdZ2pK
         97lJ7Bx+Rl9wl91piZ6DSX/JeDWu5q0MeAxUbbFqvEkqYeJ7Za3J3jBwn+/fl8JswmLo
         YNjd2N1zmZ5zyA40QlDC1utyFfVL+OvCBktCSDnVPRTfHoH+f7YVM4iInSrWWC0x8t1K
         5cH6HIrIyeLCU654yV7chxjwIEJkiD5K8PNQ63cDNeWq4H3eqRZZk9hBstfziSP+IKi/
         K+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=enZbBxN3Oyyjq7G1ENN3d+tcDx1SrKg3URWD8Mv+loA=;
        fh=BP+rJXqV0TXfVBcgKX0HmrwRZ2a6eicHFa4SBosrIHA=;
        b=HxNmiqhuWTGY/6y4k0GG2C6uvcDhex79fQaAowb11V8r1o9kvAH1YGEVeL0vT24uik
         VxpnnQk6UEEiw+DEgh+Bm3xU7XQ8LIO+HY4FK7uELIV/MK1Cewkru4jT58j3JXx6R+7f
         mYn3s769Q5P22gt6TrVriefzvAmMl/n581lu/wFOead4AuV6MblkOGfIHF+4zWwDcdco
         hqkUa1UFgLOrQWQDUXBJ/oFRrXCJOXUQmWf5kxs02qbyooZ9FOfFuNF1OsJ+c5K2HPMk
         et8lh0lfauD6yaZSD5oW+Wst6jRGkkJxpDxbJKXwuTqBS57TaOOfWxaq2cWSNNXL+oCn
         92Qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786475165; x=1787079965; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enZbBxN3Oyyjq7G1ENN3d+tcDx1SrKg3URWD8Mv+loA=;
        b=FFV0DKEYq6/yZeKTapc/qUC5HQHCqEQk6eMoV36J45z5v3xpKejMXyFfbd2hs0UwwK
         5P2pbt+R+VE8CgfHUDUHP24veHtY/pjEhzWFTAO6E3ZlyfGgDr3Wk8aCM9V2rARXNO2v
         qsVbAAdUOp7o5csvygJLFgFPqwr2qY0jsWdwgK0m+Xc5PT8S0cpmQGW8Thp+Kc+t4Ube
         GtuLOSejSq8+TzMhHn73M+JJppm0jvqq/1VQLWF0RYHLlsmsv8HU3cGbTYocd4k4Wf0c
         coL5+K36hrPLEM3lB3T0wZIwjCurS2HvE2vPKlVP3jIDHZRvW3qoe53GADCTLkmJx7f1
         wKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786475165; x=1787079965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enZbBxN3Oyyjq7G1ENN3d+tcDx1SrKg3URWD8Mv+loA=;
        b=PDATkj+x9Al5KsKMDHuls/1s3FZDU1lICbVR/ihWbStJuPJLR/fiUnV35ILYxo3Jit
         lSZ3iEA+AqFBKjbvvVgnNnEhb76wdT/eCTIS6Sy4wmqpDDkKi+Tc6SOnj3E6+Sk1azkK
         eADZDQJcmVXE4D+DeNvO+Ayg/VzH6uqLOqE/hJvlkWpktQTpkrzHAKis04xSxkgcvYuS
         L31byCMh1Ruoks5X20nYimMOpZpoITeErf9gyv8d7X7lQoh8UFjT46CpU/J3oLcGOr47
         FtRHNJWkSzsZKoa/Q2sQoGPN5KP4r5piA2bAbFCVe5snAQkFK+AxKisJHosnBpMgcYAJ
         iWBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rquktl6PI7T9NpERRpMccw0P4+Wi/mDugTydCIcqTh3gUm986L5djipf5COZgwpdKcsenB/RQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDDZPUuYb4EmGSURLp7gDI7OvJ03TblKMDZSxr9CKFaaXHk3hD
	91BcjL6YJ6xYzfvwZwgbEmEtvhbwsG/YpIlUKhEtHEH7PTba5bMANzY6cri9Nml5Af+0iAf8hFW
	Lj9Po3kDhwAjWclZlSLhRmDcU57AjlZg=
X-Gm-Gg: AR+sD11dfy5CHUeQmlzG8ByWSH3WZQhSytT/evNhymq6iG+Wh//sAuxgrIqcGvYMDB7
	zsRCm9Bo6N1SUI5nrYofhojg+o/qk/5yZfy9NmGntLlaLzFFer4w8GGWTzvnz57EYAD21H/19NU
	N2IRY68IUG1piIu+SHodMTZr0uF61t/9MfQi9+nnHYj+LVxUqRS3qXMRu39EwXaKZXrnplBbhzf
	bFzN9IunoLpT3SohIm7n8Oc5aZHOeqjVe5S1ngg073teH8fCaySgWGN5x+x7PqJMsGbAB8byT6X
	swR9hSKvnNQ97y6Wi6V1W1LLfrVFuarFcsZ/2VMTIw==
X-Received: by 2002:a05:622a:4e9b:b0:517:6d6c:187f with SMTP id
 d75a77b69052e-52d600f6931mr26600781cf.14.1786475164759; Tue, 11 Aug 2026
 12:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785995291.git.caoruide123@gmail.com> <a12d76b7f2305b5a8d64c3d6c3585e39684ff792.1785995291.git.caoruide123@gmail.com>
 <5ac3773c-4a6f-4796-a43f-545c3c42271c@kernel.org>
In-Reply-To: <5ac3773c-4a6f-4796-a43f-545c3c42271c@kernel.org>
From: Ryder Grass <caoruide123@gmail.com>
Date: Wed, 12 Aug 2026 03:05:54 +0800
X-Gm-Features: AUfX_mycIscTqbCmmYibXLk6WZz8k7CRi-SgcT9cJyOuNj-7U0yDo1zelPV2cj0
Message-ID: <CACveakTyaFu-KSuPU7xHGC-_y4AMZTL4E2qFwMmF208d0j_GbA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] mptcp: fix MP_CAPABLE token migration when
 cloning reqsk
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com, 
	kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thank you for your comment. We are adding a
mptcp_sk_clone_destroy(nsk) in our v4.

Regarding the comments from Clashiko, my reply is as follows:

Comment 1:

> This isn't a bug introduced by this patch, but does this clone helper als=
o
> need to migrate the MPTCP token_node for MP_CAPABLE requests?

I agree. Patch 1 only fixes the MP_JOIN msk reference ownership problem, bu=
t
the same request clone helper also needs to handle MP_CAPABLE token_node
ownership.

Comment 2:

> Is it ok to pass an MPTCP socket to tcp_done() in this failure path?

I agree that passing nsk to tcp_done() was wrong. nsk is an MPTCP master
socket, not a TCP socket. tcp_done() and inet_csk_prepare_forced_close() ar=
e
TCP-only here because they use tcp_sk(), so they can interpret the private
MPTCP socket layout as struct tcp_sock after the shared inet_connection_soc=
k
header.

We are reviewing v4, and will send it out soon.

Best,
Ruide


Matthieu Baerts <matttbe@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=80 02:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ren, Ruide,
>
> On 06/08/2026 13:14, Ren Wei wrote:
> > From: Ruide Cao <caoruide123@gmail.com>
> >
> > TCP request migration clones pending request sockets with
> > inet_reqsk_clone().  For MPTCP MP_CAPABLE requests this byte-copies the
> > token_node hlist state into the clone even though the token table still
> > names the original request.
> >
> > Moving the token only after inet_ehash_insert() succeeds leaves a windo=
w
> > where the cloned request is already globally visible from the ehash but
> > the token table still points at the original request.  Reordering the
> > move after clone but before ehash exposure closes that window, but
> > concurrent RX can still race on the old request and observe that the
> > token was already moved.
> >
> > Move MP_CAPABLE token request ownership during MPTCP request cloning
> > under the token bucket lock.  Make mptcp_token_accept() and
> > mptcp_token_destroy_request() re-check token_node under the same lock a=
nd
> > treat an already moved or removed request as a normal race instead of
> > warning.
> >
> > If the passive MP_CAPABLE socket cannot claim the token, fail
> > mptcp_sk_clone_init() and let the subflow fall back instead of
> > installing a socket with mismatched token ownership.
>
> Thank you for the new version!
>
> I have one major comment, please see below:
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf140402=
2e8c9430.1776149210.git.caoruide123%40gmail.com
> > Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> > Signed-off-by: Ren Wei <weir@nebusec.ai>
> > ---
> >  net/mptcp/protocol.c   | 12 +++++----
> >  net/mptcp/protocol.h   |  4 ++-
> >  net/mptcp/subflow.c    |  2 ++
> >  net/mptcp/token.c      | 61 +++++++++++++++++++++++++++++++++++++-----
> >  net/mptcp/token_test.c |  4 +--
> >  5 files changed, 68 insertions(+), 15 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index ca644ec53eed..07eaa6858d05 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3608,17 +3608,19 @@ struct sock *mptcp_sk_clone_init(const struct s=
ock *sk,
> >        */
> >       mptcp_set_state(nsk, TCP_ESTABLISHED);
> >
> > +     if (!mptcp_token_accept(subflow_req, msk)) {
> > +             mptcp_release_sched(msk);
> > +             inet_csk_prepare_forced_close(nsk);
> > +             tcp_done(nsk);
>
> Here, you cannot call tcp_done(nsk): nsk is an MPTCP socket, not a TCP
> one. You probably want to destroy the msk instead.
>
> (In theory, your reproducer launched on a kernel with your patches
> applied on top of MPTCP's export branch [1] should produce a warning)
>
> Apart from that, Clashiko has a few comments. Do you mind checking them
> and reply to each comment here, before sending a new version, whether
> you agree/disagree or if it is unclear, please?
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
> pw-bot: cr
>
