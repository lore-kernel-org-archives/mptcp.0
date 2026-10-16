Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715132F6188
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129789; cv=pass; b=Slii2z/IR53e5L+sjblPuN57cvPchw6B72+6C2zj464gwsyycmLPXoM5oL+JPrEhMO/Ww8T9BVEgpMgCFYNfVM6IcPoUFGAwcUao1MpJETLcsAY/lSG0saVLyUJq3c7DwJ39fa8forbfZa/6ClO3qN9J1D5n/il7ybXefRUaIPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129789; c=relaxed/simple;
	bh=tI6ECO85WUW/is8syP9rQ8OWfBxETb362qbx/F4Efb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qj+t/hGaFKpVFFI+wVlgw9Kso5S4Nb+TDKc6wX3du2HlkECgVM5b+jHSwv54tu5KQjZJZ1C2CXksmjUKr/lrK62A2zygy67ffWPnTt5wwFJZmAMP8FDBKhtccBKyRdBLMWaVxTAe0xuLW/cZ0FGAwyab76HP7K6ACfuGIJW0oIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVBNA+Bg; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVBNA+Bg"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a9ad623098so53235881fa.1
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 22:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792129785; cv=none;
        d=google.com; s=arc-20260327;
        b=BKv02hecwYYz7oHNOYeapWjtYdvwAvb1eyQ4Vh1WQPlzzldLYo2Qmbdbw2JuvaloOP
         cqtDZSOvmL8ohmhTSo9wXz78YfoVSUmnpMj4fkOH1VagxJ+bVgD9VJ4XdsoIFi1BFBF7
         /TnqVzlELJbc7iSGxbDk2wLDypDpmG903bg/N2tUPibejYm3XqxbsrC/oerZGCe/klqW
         YJOViq8cfSLBnPEenaSJYwliL78NKR0bueCxtwhylsvXj4g3gFWXv2X0XAVaf7qWezYE
         5xPqbaCVSLrfvACgibaw7BF9AnUnUPoIBoBPOh3/SmV8zCk/mM3QrbCoAen8kJbQ43Wc
         G09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dq3salsc0VDDPLLng4lHCugFC7XMfreQ1H+rlHm0MJU=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=UYllhwNNLZUXR52yBqz5Kec0OeD8yo4nhF0+9BW1cgBasBuAYoph15qitIQlRZDX7P
         r7ANjJEww/0ugf8XOxsQSf4bFG8bQwHVgwxUlOKUFFiD8RY5FHaa3jTZMS1pzFJmiL8n
         QoLKoX4iSXp9jn+Korm9uuGkAWx51pb/gB6uTGGhuBjMPuuMVBEy62Y5R54JBfpiaDJa
         FWsSfQ3DfLOAP7uCjnJ3VlQy8s9g+tXzMxqIyTAz+MFUwNVqSI9VjObZhiPCCxflalf1
         1sReEMo5pXS/4LHNQdteYCI6AIOTJ6cLOxsmbeyJUvpcwEqRitwqW4YJc/kBgu2hqI12
         7ygQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129785; x=1792734585; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dq3salsc0VDDPLLng4lHCugFC7XMfreQ1H+rlHm0MJU=;
        b=qVBNA+BgB6R4to8MO2xhRDNmkhfEdvRd7lPAZZVZI1VH5RPrXRupuEG4rNpRFZbKVJ
         Ma9ld37Gr+8msU2HtGteV7VCBwJ771//m9quF0AASZA3fmbLQ93Fx70GexcvRc7brxkY
         TR5vkfJ4lkCdYiZlWGoUAyoTETEf/wF2pw0oSaK8yLZQlMFAD0jeCr3hXoomuNIPvpY0
         l5Q/QZKSsEYFS5dOA0r/yq3fLbi1VEbqfQddxaenWBOVSXUhVHz4qJM1+sXdHq3vzI2J
         6hTlDvVmkA6RMRVY5bqTuNb4grjQShmX3WWSmBi9BmLM6zg1f2+a+mwIiQtPx04qMdtn
         oiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129785; x=1792734585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dq3salsc0VDDPLLng4lHCugFC7XMfreQ1H+rlHm0MJU=;
        b=ImowqwIYMo8L9Gc4FPKyIwwuM6atDUfRim8XFx/ZMeQKjc1CLgTHIaWHZWZm//7A57
         HydlWWgrNaXyh77bh0XULdPUnA272JihhQCgv0o5yOwwlPqNiBGUX8lSHYM8XGJ1tHeT
         qRLDmsp88HB81I6smPGQk4JvX6+T8yYPcA9WIOWXnqn/9B7GGmdFa5dotq2W0mfRI9Wo
         mEUnCqyAaEZZFoYSKOCghn7KSPOEN3hswgOsU+9YfDQPpFxNq1IvFk9BRsujvEKYU49l
         aVrQDSfvfWiVKnfKyfFNuEKHYeqScQNOJP+1fkrN5HIwM4/fZCffepWbIvAY9FhVdua0
         7v3Q==
X-Gm-Message-State: AFq9FYLQYhLBAGpSrRnqMtg3L5pwrAC1LQys/RSwW7eR80ENfB+n70lg
	+M4HHWOXo7Fa/7QTV+rPuxP+Hdk/BqC1eg4ofdljxD/YOkOiTWF0fwlF4jKKkJnziYiULRWbjMg
	H286H/WCe0OpbhqTt3tohtXNEmG8HphQIMIwj
X-Gm-Gg: AYBFou2WNYzez32D05OgF15TkzHTWfahzQ9z+hY4iB0LM7tCwLkb/oJ0eal8viqn/I+
	30BBS5nNutlZ90j6gBIeXwBmkl60QeQiLSMRdjlCpDiva2Ukh4yO6hOK6VYXn22+JrVyD45ht35
	HkYHpWXRpfjJ5kQOBjS9hwbhCgVa2rWeqlvSIXV9RKkP0L42q7lHvsg9RPJ0t8rOxXbpDhtguUN
	MR4tZsMHl07N+kRSrRsSKru1QCUuJEbRp4IJYEUuvC70oWtbXuZ+KqvExw2DXeevqOJLbtquMy4
	4E7MI/Q64Ls/8zwjLUpu0q02S5TbT/43TNyIHOlDBbPvVpWabC7Z9RE=
X-Received: by 2002:a05:651c:1542:b0:3aa:f617:5c85 with SMTP id
 38308e7fff4ca-3aaf61768fbmr18522801fa.12.1792129784880; Thu, 15 Oct 2026
 22:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com> <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
In-Reply-To: <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Fri, 16 Oct 2026 11:19:33 +0530
X-Gm-Features: AclHuK9-PYiL8Qa0eL07mloqWOLHT32jSa5JO7zt4NsAwsZhUboWNKzcx0h1R4U
Message-ID: <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for the review.

> Add a sensible default value (what do you recommend?)

15 SYN retries: about 20 minutes with the 120s max RTO.

> modify icsk_syn_retries instead [...] WDYT?

Good idea, I will do that: one new subflow per failure, with its SYN
retries set from the new netlink limit, 0 =3D disabled. It also removes
the socket reuse, the retries counter and the 60s check.

One point to think though, If ICMP unreachable stops the SYN at once.
I would not retry
again then. Is that OK?

> Do we have other similar ones? [...] ss -Mte, would that work?

I will drop the MIB counter. The test can use the MPJ counters and the
netlink events.

> Is it specific for your case?

No, it came from a Sashiko review: a dead subflow waiting to be closed
could be re-created after its endpoint or the peer's address was
removed. I will try to move it to pm_kernel.c.

> can we not check why it failed instead?

With your idea it is not needed: only one retry, nothing to count.

> what error do you get when the issue is detected via TCP Keepalive?

ETIMEDOUT, so it is retried.

> Why can we not always re-used?

A subflow that carried data needs the full close cleanup. With your
idea we always create a new subflow, so there is only one path.

For the rest: OK. I will go through pm.c, avoid struct holes and
duplicated connect code, drop the RFC tag, add a changelog per patch,
and test closing the connection while retrying plus the netlink events.
I will wait for the netdev Sashiko review before sending.

Thanks,
Anil

On Wed, Oct 14, 2026 at 11:43=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Anil,
>
> Thank you for the new version. Here is a very quick other review, mostly
> questions.
>
> Also, please wait for the netdev Sashiko review (24 to 48h) before
> sending a new version. You can remove the RFC tag. Ideally, include a
> changelog per patch.
>
> On 14/10/2026 16:33, Anil Kaushik wrote:
> > With the in-kernel PM, a subflow closed after an error, e.g. a timeout
> > when a path silently drops packets, is never re-created, even once the
> > path works again. For example, with a main link and a backup link,
> > connections move to the backup after an outage but never come back.
> >
> > Add an opt-in sysctl, net.mptcp.subflow_retries (0 by default): the
>
> I confirm that it would be better to avoid the sysctl for this in-kernel
> PM specific setting. Instead, please add another limit that can be
> configured via netlink. Add a sensible default value (what do you
> recommend?), but on by default.
>
> By default, I think the kernel tries to establish a connection for 67
> seconds.
>
> A (maybe bad?) idea: I wonder if we shouldn't modify icsk_syn_retries
> instead: by doing that, we would do only one retry, but with a long
> exponential backoff timeout. The config would set this value directly,
> with 0 meaning disabled (and not "no retransmission after the retry"). WD=
YT?
>
> > maximum number of attempts to re-create such a subflow. When TCP closes
> > a subflow created by this side after an error, the PM creates a new one
> > with the same addresses right away. Its SYN retransmissions space out
> > the attempts, so no extra state or timer is needed. If it cannot
> > connect, the same socket is used for the next attempt. The number of
> > attempts is kept in the subflow context, and counted from scratch once
> > a re-created subflow stayed established for a minute. Re-creating the
> > initial subflow uses one of the additional subflows allowed by the
> > limits.
> >
> > Subflows refused by the peer, reset by the peer without the transient
> > flag (RFC 8684 section 3.6), aborted locally, or using a removed addres=
s
> > are not retried.
> >
> > A new counter, SubflowRetry, counts the attempts.
>
> I'm not a fan of a MIB counter only for the in-kernel PM. Do we have
> other similar ones? We already expose some diag counters per subflow (ss
> -Mte), would that work?
>
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index d7c5b50b34cc..b3f7f7b2ef84 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -794,6 +794,14 @@ static void mptcp_pm_rm_addr_or_subflow(struct mpt=
cp_sock *msk,
> >                       int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
> >                       u8 id =3D subflow_get_local_id(subflow);
> >
> > +                     /* a dead subflow still waiting to be closed must=
 not
> > +                      * be re-created on a removed address
> > +                      */
> > +                     if ((rm_type =3D=3D MPTCP_MIB_RMADDR &&
> > +                          remote_id =3D=3D rm_id) ||
> > +                         (rm_type =3D=3D MPTCP_MIB_RMSUBFLOW && id =3D=
=3D rm_id))
> > +                             subflow->retries =3D MPTCP_SUBFLOW_NO_RET=
RY;
>
> Is it specific for your case?
>
> BTW, it would be interesting to test cases where the right actions are
> taken when a subflow is disconnected or it is trying to reconnect, e.g.
> closing the socket, etc. Maybe easier with Packetdrill to get the right
> timing? (or extend the existing test to end with a drop, then close the
> connetion
>
> Also we should (manually?) check the right netlink events are being
> sent, e.g. not having a "closed subflow" event if the subflow wasn't
> established before (but we are probably already doing the right thing
> there, just to be sure, I didn't check). I guess your current test can
> also check the netlink events.
>
> >                       if ((1 << inet_sk_state_load(ssk)) &
> >                           (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSI=
NG | TCPF_CLOSE))
> >                               continue;
> > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> > index d3014bf57bf3..d020e5f69c01 100644
> > --- a/net/mptcp/pm_kernel.c
> > +++ b/net/mptcp/pm_kernel.c
> > @@ -1591,6 +1591,151 @@ bool mptcp_pm_nl_check_work_pending(struct mptc=
p_sock *msk)
> >       return true;
> >  }
> >
> > +/* a re-created subflow reset sooner counts as a failed attempt */
> > +#define MPTCP_PM_RETRY_STABLE        (60 * HZ)
>
> That feels "fragile" (e.g. with net.ipv4.tcp_syn_retries=3D0): can we not
> check why it failed instead?
>
> > +static bool mptcp_pm_retry_path_error(int err)
> > +{
> > +     switch (err) {
> > +     case ETIMEDOUT:
> > +     case EHOSTUNREACH:
> > +     case ENETUNREACH:
> > +     case EHOSTDOWN:
> > +     case ENETDOWN:
>
> Out-of-curiosity: what error do you get when the issue is detected via
> TCP Keeplive?
>
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/* A subflow initiated by this side and closed by TCP after an error c=
an be
> > + * re-created with the same addresses, see the 'subflow_retries' sysct=
l. The
> > + * SYN retransmissions of the new subflow space out the attempts. Call=
ed with
> > + * the msk socket lock held, before the subflow is closed.
> > + */
>
> (probably only the last sentence is useful)
>
> > +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> > +                              const struct mptcp_subflow_context *subf=
low,
> > +                              struct mptcp_pm_retry *retry)
> > +{
> > +     struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +     bool established =3D READ_ONCE(subflow->fully_established);
> > +     struct sock *sk =3D (struct sock *)msk;
> > +     int err =3D READ_ONCE(ssk->sk_err);
> > +
> > +     if (!mptcp_pm_is_kernel(msk) || !err ||
> > +         sk->sk_state !=3D TCP_ESTABLISHED || __mptcp_check_fallback(m=
sk))
> > +             return false;
> > +
> > +     /* mptcp_close_ssk() will not handle it again, e.g. the initial
> > +      * subflow, kept in the list once closed
> > +      */
> > +     if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0=
)
> > +             return false;
> > +
> > +     /* removed address, see mptcp_pm_rm_addr_or_subflow() */
> > +     if (subflow->retries =3D=3D MPTCP_SUBFLOW_NO_RETRY)
> > +             return false;
> > +
> > +     /* The peer asked not to use this path again (MP_RST without the =
T
> > +      * flag), the subflow has been aborted locally, or it hit an MPTC=
P
> > +      * protocol error.
> > +      */
> > +     if ((subflow->reset_seen && !subflow->reset_transient) ||
> > +         err =3D=3D ECONNABORTED || err =3D=3D EBADMSG)
> > +             return false;
> > +
> > +     /* A subflow that never got established is retried only after net=
work
> > +      * errors: if the peer rejected it, trying again will not help.
> > +      */
> > +     if (!established && !mptcp_pm_retry_path_error(err))
> > +             return false;
> > +
> > +     /* Only re-create subflows initiated by this side: MP_JOIN ones, =
or the
> > +      * initial one on the client side.
> > +      */
> > +     if (!subflow->request_join &&
> > +         (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
> > +             return false;
> > +
> > +     /* Count the attempts from scratch only if the path worked for a
> > +      * while: a re-created subflow reset soon after its creation coun=
ts
> > +      * as a failed attempt.
> > +      */
> > +     retry->retries =3D subflow->retries;
> > +     if (established &&
> > +         (!subflow->retries ||
> > +          (u32)(tcp_jiffies32 - subflow->retry_stamp) >=3D
> > +          MPTCP_PM_RETRY_STABLE))
> > +             retry->retries =3D 0;
> > +     /* a failed attempt is retried with the same socket */
> > +     retry->reuse =3D !established && subflow->retries;
>
> Why can we not always re-used?
>
> If we cannot always do that, maybe we should always re-create one? It
> might be better to avoid having multiple paths for that in the code.
>
> > +     if (retry->retries >=3D mptcp_subflow_retries(sock_net(sk)))
> > +             return false;
> > +
> > +     mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
> > +     retry->remote.id =3D READ_ONCE(subflow->remote_id);
> > +     if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
> > +             return false;
> > +
> > +     mptcp_local_address((struct sock_common *)ssk, &retry->local.addr=
);
> > +     retry->local.addr.port =3D 0;
> > +     retry->local.addr.id =3D subflow_get_local_id(subflow);
> > +     retry->local.flags =3D subflow->request_bkup ?
> > +                          MPTCP_PM_ADDR_FLAG_BACKUP : 0;
> > +     retry->local.ifindex =3D ssk->sk_bound_dev_if;
> > +
> > +     return true;
> > +}
> > +
> > +/* Called with the msk socket lock held, instead of closing the subflo=
w */
> > +bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct so=
ck *ssk,
> > +                                  const struct mptcp_pm_retry *retry)
> > +{
> > +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +     struct sock *sk =3D (struct sock *)msk;
> > +
> > +     /* like mptcp_close_ssk() does for the failed attempt */
> > +     mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk, GFP_KERNEL);
> > +
> > +     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> > +     if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remot=
e))
> > +             return false;
> > +
> > +     /* the reset cleared them */
> > +     subflow->retries =3D retry->retries + 1;
> > +     subflow->retry_stamp =3D tcp_jiffies32;
> > +     return true;
> > +}
> > +
> > +/* Called with the msk socket lock held, after the subflow has been cl=
osed */
> > +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> > +                        const struct mptcp_pm_retry *retry)
>
> Yes, probably better to avoid having both retry_reconnect and retry.
>
> > +{
> > +     struct mptcp_subflow_context *subflow;
> > +     struct sock *sk =3D (struct sock *)msk;
> > +     bool allowed;
> > +
> > +     spin_lock_bh(&msk->pm.lock);
> > +     allowed =3D msk->pm.extra_subflows <
> > +               mptcp_pm_get_limit_extra_subflows(msk);
> > +     if (allowed)
> > +             msk->pm.extra_subflows++;
> > +     spin_unlock_bh(&msk->pm.lock);
> > +
> > +     if (!allowed)
> > +             return;
> > +
> > +     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
> > +     if (__mptcp_subflow_connect(sk, &retry->local, &retry->remote))
> > +             return;
> > +
> > +     /* the new subflow is the last one: it carries the number of atte=
mpts */
> > +     subflow =3D list_last_entry(&msk->conn_list, struct mptcp_subflow=
_context,
> > +                               node);
> > +     subflow->retries =3D retry->retries + 1;
> > +     subflow->retry_stamp =3D tcp_jiffies32;
> > +}
> > +
> >  /* Called under PM lock */
> >  void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
> >  {
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 60cbd91be632..f29cfd2ad69b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2816,6 +2816,8 @@ static void __mptcp_close_subflow(struct sock *sk=
)
> >       mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> >               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >               int ssk_state =3D inet_sk_state_load(ssk);
> > +             struct mptcp_pm_retry retry;
> > +             bool do_retry;
> >
> >               if (ssk_state !=3D TCP_CLOSE &&
> >                   (ssk_state !=3D TCP_CLOSE_WAIT ||
> > @@ -2827,7 +2829,14 @@ static void __mptcp_close_subflow(struct sock *s=
k)
> >               if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
> >                       continue;
> >
> > +             do_retry =3D mptcp_pm_kernel_retry_check(msk, subflow, &r=
etry);
> > +             if (do_retry && retry.reuse &&
> > +                 mptcp_pm_kernel_retry_reconnect(msk, ssk, &retry))
> > +                     continue;
> > +
> >               mptcp_close_ssk(sk, ssk, subflow);
> > +             if (do_retry && !retry.reuse)
> > +                     mptcp_pm_kernel_retry(msk, &retry);
>
> Avoid calling in-kernel specific functions directly: it should be done
> via the PM "interface". IOW, call something in pm.c, which would call
> the in-kernel function if this pm is being used.
>
> (later, we should do that via a pm ops, but we are not there yet --
> still best to avoid calling pm kernel functions directly here in all
> conditions)
>
>
> >       }
> >
> >  }
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index ed2f363bb915..1aa92c9614cd 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -622,6 +622,8 @@ struct mptcp_subflow_context {
> >       u8      reset_transient:1;
> >       u8      reset_reason:4;
> >       u8      stale_count;        /* Protected by the msk socket lock *=
/
> > +     u8      retries;            /* re-creation attempts, msk socket l=
ock */
> > +     u32     retry_stamp;        /* creation of a re-created subflow *=
/
>
> Probably best not to add that between stale_count and stale + avoid
> creating new "holes" in structures (I didn't check with pahole, but I
> guess that's the case)
>
> >       u8      stale;              /* Protected by the msk socket lock,
> >                                    * if set the subflow is unable to sn=
d/rcv
> >                                    * data, the schedule should skip it
> > @@ -818,6 +820,7 @@ int mptcp_is_checksum_enabled(const struct net *net=
);
> >  int mptcp_allow_join_id0(const struct net *net);
> >  unsigned int mptcp_stale_loss_cnt(const struct net *net);
> >  unsigned int mptcp_close_timeout(const struct sock *sk);
> > +u8 mptcp_subflow_retries(const struct net *net);
> >  int mptcp_get_pm_type(const struct net *net);
> >  const char *mptcp_get_path_manager(const struct net *net);
> >  const char *mptcp_get_scheduler(const struct net *net);
> > @@ -859,6 +862,9 @@ void mptcp_remote_address(const struct sock_common =
*skc,
> >                         struct mptcp_addr_info *addr);
> >
> >  /* called with sk socket lock held */
> > +int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
> > +                         const struct mptcp_pm_local *local,
> > +                         const struct mptcp_addr_info *remote);
> >  int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_loc=
al *local,
> >                           const struct mptcp_addr_info *remote);
> >  int mptcp_subflow_create_socket(struct sock *sk, unsigned short family=
,
> > @@ -1258,6 +1264,24 @@ void __init mptcp_pm_userspace_register(void);
> >  void __init mptcp_pm_nl_init(void);
> >  void mptcp_pm_worker(struct mptcp_sock *msk);
> >  void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
> > +
> > +/* subflow->retries value preventing any re-creation */
> > +#define MPTCP_SUBFLOW_NO_RETRY       U8_MAX
> > +
> > +struct mptcp_pm_retry {
> > +     struct mptcp_pm_local   local;
> > +     struct mptcp_addr_info  remote;
> > +     u8                      retries;
> > +     bool                    reuse;  /* failed attempt: same socket */
> > +};
> > +
> > +bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
> > +                              const struct mptcp_subflow_context *subf=
low,
> > +                              struct mptcp_pm_retry *retry);
> > +void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
> > +                        const struct mptcp_pm_retry *retry);
> > +bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct so=
ck *ssk,
> > +                                  const struct mptcp_pm_retry *retry);
> >  u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
> >  u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
> >  u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 78e886b20258..0cdeae4b45fa 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1766,6 +1766,69 @@ int __mptcp_subflow_connect(struct sock *sk, con=
st struct mptcp_pm_local *local,
> >       return err;
> >  }
> >
> > +/* Connect again an MPJ subflow that failed to connect, with the same =
socket.
> > + * The subflow never carried data: like for the initial subflow in
> > + * __mptcp_subflow_disconnect(), resetting the TCP and the subflow sta=
tes is
> > + * enough. Called with the msk socket lock held.
> > + */
> > +int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
> > +                         const struct mptcp_pm_local *local,
> > +                         const struct mptcp_addr_info *remote)
> > +{
> > +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +     struct sockaddr_unsized *uaddr;
> > +     struct mptcp_sock *msk =3D mptcp_sk(sk);
> > +     struct sockaddr_storage addr;
> > +     u32 remote_token;
> > +     int addrlen;
> > +     int err;
> > +
> > +     lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> > +     err =3D tcp_disconnect(ssk, 0);
> > +     if (err)
> > +             goto out;
> > +
> > +     mptcp_subflow_ctx_reset(subflow);
> > +     subflow->request_mptcp =3D 0;
> > +     do {
> > +             subflow->local_nonce =3D get_random_u32();
> > +     } while (!subflow->local_nonce);
> > +     subflow_set_local_id(subflow, local->addr.id);
> > +     subflow->remote_key_valid =3D 1;
> > +     subflow->remote_key =3D READ_ONCE(msk->remote_key);
> > +     subflow->local_key =3D READ_ONCE(msk->local_key);
> > +     subflow->token =3D msk->token;
> > +     mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
> > +     subflow->remote_token =3D remote_token;
> > +     WRITE_ONCE(subflow->remote_id, remote->id);
> > +     subflow->request_join =3D 1;
> > +     subflow->request_bkup =3D !!(local->flags & MPTCP_PM_ADDR_FLAG_BA=
CKUP);
> > +     subflow->subflow_id =3D msk->subflow_id++;
> > +
> > +     mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
> > +     addrlen =3D sizeof(struct sockaddr_in);
> > +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > +     if (addr.ss_family =3D=3D AF_INET6)
> > +             addrlen =3D sizeof(struct sockaddr_in6);
> > +#endif
> > +     uaddr =3D (struct sockaddr_unsized *)&addr;
> > +
> > +     /* like __inet_stream_connect() for __mptcp_subflow_connect() */
> > +     if (BPF_CGROUP_PRE_CONNECT_ENABLED(ssk)) {
> > +             err =3D ssk->sk_prot->pre_connect(ssk, uaddr, addrlen);
> > +             if (err)
> > +                     goto out;
> > +     }
> > +
> > +     err =3D ssk->sk_prot->connect(ssk, uaddr, addrlen);
> > +
> > +out:
> > +     release_sock(ssk);
> > +     MPTCP_INC_STATS(sock_net(sk), err ? MPTCP_MIB_JOINSYNTXCONNECTERR=
 :
> > +                                         MPTCP_MIB_JOINSYNTX);
> > +     return err;
> > +}
>
> This might not be used if we always call close_subflow then connect, but
> in general: avoid this bunch of duplicated code. Here you could extract
> code from the normal connect case and call that from here instead of
> re-written with a different way (i.e. not calling kernel_connect()).
>
> > +
> >  void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gf=
p)
> >  {
> >       /* Only if the msk has been accepted already (and not orphaned).*=
/
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
