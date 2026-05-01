Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C0B3148D0
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657834; cv=pass; b=GQD3d9SmVjXqf+n3VFmwJUfAi2t/f1X0xHYjOn2Mf3DNX/Fcs+aeGueTV/cqYdlJvBqoVQ7Nog3eqpSLXB0QiNG5/DdMg5dtyl0p2j+ShKvX8BjLOlJn2/4rTDl5GnXi8T/PXRqc1ijUDgVyrw94EFUimMPCJKaOF0nY2Pzb3Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657834; c=relaxed/simple;
	bh=kFa5funtEoZemDlbVSzSpcT0vnFOLlhRx0ocGcXCBe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ5XCOZFtlnQ9hneKOM31axgT5/XF1hFEvMUVmWdMm3Tg4TGEPvdxoieNR91UvTghl5CmJnMNRMyWqp3NtSk3Iq1zz0qvix47OuyMY1FUt+WCs8BhgVIHWrn3H4TBEU2vLAMsUOrPvrUIcXDo7ccHcYe7ex25lxL2+HEbQd/ER8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rq1A/Pit; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rq1A/Pit"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c19d23b19so3200418c88.0
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 10:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777657832; cv=none;
        d=google.com; s=arc-20240605;
        b=Vw8k3qkPW2urEBzOsFq8ln8pRo6pWajhlQ2RAqvOLVWetT86Vanbsl+MF0obF9OfQw
         bi8AiVP8lyggiGGuA9gVUt2K8tbk/U3PKEyfhJma5oLzE7IbEO3iNap6/Q1X6ikvURoI
         BixBwDF7+UjDvnOV1nJd2oaJB0FkEv6/wOBoFCCSfd8mlnG1HkKJmyQbxZ+s3RNonJX3
         Vs8f9aly7B1o6wJhTtleCGXoHtmFwSAfIKRkIw3EqjKlP4KEhwZkFoHJuIT2LQktOmjz
         r1YJ68QhKXp+1ScYwBcoY4/P3cHZhtGyMG3gMpdP3unT1sTlLUW2fiw3KJE1KbDINrXm
         XbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q6uGlKl+waB9h8gpdK6RgY8TnnZSS0A5YEEvvQs8360=;
        fh=xPWE8ao5caYHqZkmOSMcxehcPotDSJlAOBQIK4vX0Ns=;
        b=BuUsZUNFK/durLGn44oq8ixOcXdqIRpRZ/3HFA2Me3w1zSSMRo/sQQ1SRJuIwu3IFU
         uBkhGYrTrzwfn/ikhYAVVDKst3VF/cXR2s+QkLIRiyoZXl3bQddFLAkagSJyrIcV5ete
         Befans0agD6kMh6d8z/qFxSPaaAFQc65sn/En6omxbmk28dCCJRuQbEN2Qm1ZJJ1y7a/
         qCXJxJFswzLtYlfYvklEXbNHqDE1G5CFk61Jn/AMeEzDrSxpWvhMMM1zg+8gu/YS6A/p
         zVsX19XusFdNGtLg7uKhGFmp0Xxg195OUewlZk4m/6UCElqaTPwaVsx4El1qWsKoZbfd
         gfaw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777657832; x=1778262632; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6uGlKl+waB9h8gpdK6RgY8TnnZSS0A5YEEvvQs8360=;
        b=rq1A/PitZTvKQZ1Z3Ns6Zni41wC41E0KByeXAMUzch6T9p3pvoL5aoqHD6oU6gsA6z
         XZqvaUohy/sjVIlaKZ2QWxWlOK7EIbcdq+TMRxcUJ/jClJZwylgCqZLnXgfQLHQe7gug
         V0h3r35p+bP3Qzh+fQj/qxt6lmETmQ8JQ/EaxMec2W1VyY2SgjzVIjWLuhhsuGgceFcU
         +a6mO34Phj/w/CQq2ZctCvsncXf+Ze7Jkwf8nhvJQ9BKDW4gbkbxErtmLY5QLieb3VVK
         oKoRfz3ryuuNJ4tNnuCbY8K80Z2MIfArh6SsXztxRuUT1qME7oGlH0jbILQcqAcO+uMX
         nzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777657832; x=1778262632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6uGlKl+waB9h8gpdK6RgY8TnnZSS0A5YEEvvQs8360=;
        b=fqbBceHaSKEnLt3xfIlZ2nkEUolIkKTpwvcuQBoP9AdObGzjcTwh0rucFhmX9H1Lc4
         3BQhaqRP4a+npHt46nFKDhRtj8Xf4p7rDRACor5HufJ5igbUbObbDkpTEDPLXCsNfhez
         wee/kG7mJ2KNelPxV8y2QUh9M3oZnDtInh8GZ58uov3/o/Xx8MbHsFwMu4OfCK6xJBQZ
         m/pM9Tww0goUI7+fqK//DPQiCmM8kl6CQuP4Wb8I+eGBYmiAnOSre/HP3hT0kvwmamSk
         oZhaDXoodOf07Oru0vrUKaskWTYtMwODBcSr/ORlWWx9B9KrkJTPscwF7VSFPTVPpkLf
         nfhg==
X-Forwarded-Encrypted: i=1; AFNElJ+L+vkj0JdXxQFd03yAtD9cwOiiB4qMi8/rP1Zi7NIaMZ+BQ5+9d7ZaleorLHQVofesM8a9Wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP+naCm/oi2rbHymnNrFdfClLVLA9KwsRqfg/5A1VP93wbtuAv
	IVB7t6XVM3Y9H7qQZW35AV9pG82Gc5YK7QpYZLsg3K8rXCki6ulaMQclbPUK+BdK2GUSU6oI/CF
	3kEtaaAb7o8i8l2G1t7tRdksVLQEKJuft4/+HdKG3
X-Gm-Gg: AeBDies4jJoEtA5vUZiNdctqGx0ZrnhJ9LDYJNqKDolAf1nYB/FG0NmSSmqZbYsvk8E
	r/OXWSBh8zMjZahcE+5mVYCpd63y68nj0ECovHiCyABpMdLZiES6Lqk7NGMSdohns26gGgI4waz
	H5sr5Nmh115L+g5Lqli9p73DPEYGKlIqbAl1fUg4rOgvB93gc/A1t70qt78FYMeGggwBve7qsZy
	w/t8ueqmPmas/kUy8zlyeJBLS0jUkHbbu7lwiMiCOhfAyWq+5KWLh/M06AmoJJ6MxaYy2nrxnVv
	be5Wc01TTx2Mx3y+5nh5nW08WzKa3S/E7JzNxG1GjTQPbEHW1IJipR6n29Q5W1cp6dN1lCOZ4oX
	DNzvW6WG2GDIHCnPwekpLvRJsrqbMPYzSOWq3QBz8YGH7coedp27LoKjow7is9i+OnUAxkG4Atg
	==
X-Received: by 2002:a05:7022:660c:b0:12c:3d3c:ac08 with SMTP id
 a92af1059eb24-12dfd7ac2bamr123570c88.4.1777657831361; Fri, 01 May 2026
 10:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260501061939.1808489-1-kuniyu@google.com> <177764580322.3218472.133815625568510242.b4-review@b4>
In-Reply-To: <177764580322.3218472.133815625568510242.b4-review@b4>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 May 2026 10:50:19 -0700
X-Gm-Features: AVHnY4JMH4xakDl2KzjzK2eScz1nszSAQm14M5Kd35ZM81P57bZ2vcBloEi3p5Q
Message-ID: <CAAVpQUAEbZKDPVyWegkTndLm4Gr287FKxAPZJ2Ux-QQNJX-QgQ@mail.gmail.com>
Subject: Re: [PATCH v1 mptcp] mptcp: Clear mptcp_out_options.ext_copy in mptcp_established_options_dss().
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Keita Morisaki <kmta1236@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, mptcp@lists.linux.dev, 
	syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 7:30=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> On Fri, 01 May 2026 06:19:35 +0000, Kuniyuki Iwashima <kuniyu@google.com>=
 wrote:
> > syzbot reported read of uninit-value in mptcp_write_data_fin().
> >
> > Since the cited commit, struct mptcp_out_options is not cleared
> > in __tcp_transmit_skb().
> >
> > Let's clear it in mptcp_established_options_dss().
>
> Thank you for looking at that! I forgot to look at the bitfields that
> can be half initialised when reviewing the cited commit...
>
> >
> > Another option is to move struct mptcp_out_options to struct
>
> Indeed.
>
> >
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 4cc583fdc7a9..ae1cb955035b 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -572,6 +572,7 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
> >       bool ret =3D false;
> >       u64 ack_seq;
> >
> > +     memset(&opts->ext_copy, 0, sizeof(opts->ext_copy));
> >       opts->csum_reqd =3D READ_ONCE(msk->csum_enabled);
>
> Sashiko is saying:
>
>   Will the bitfield assignment to opts->csum_reqd still trigger a KMSAN w=
arning?
>
>   Looking at struct mptcp_out_options in include/net/mptcp.h, there are s=
everal
>   bitfields that reside outside the ext_copy union:
>
>         u8 reset_reason:4,
>            reset_transient:1,
>            csum_reqd:1,
>            allow_join_id0:1;
>
>   Because __tcp_transmit_skb() allocates the mptcp_out_options structure =
on the
>   stack without zeroing it, the byte containing these bitfields remains
>   uninitialized.

Oh this is right.

>
>   The compiler translates the bitfield assignment into a read-modify-writ=
e
>   operation on that uninitialized byte, which will cause KMSAN to still r=
eport a
>   read of uninitialized memory.
>
>   -> via: https://sashiko.dev/#/message/20260501061939.1808489-1-kuniyu@g=
oogle.com
>
> That's the only other bitfield in this structure, but it is not next to
> the other one, and with all the unions and inner structures, it might be
> harder to introduce a new struct_group().
>
> Maybe safer and easier for the moment to memset mptcp_out_options struct
> before calling mptcp_{syn,synack,established}_options() from
> tcp_output.c? Or from these functions. This will then only be done when
> the TCP sk is being used by MPTCP, so that doesn't impact "plain" TCP
> connections. WDYT?

Sounds good, I'll simply clear the struct in the mptcp functions.

Thanks !
