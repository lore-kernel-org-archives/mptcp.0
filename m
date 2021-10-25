Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927342C9F
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635169939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuJqgemhXYraS4eAGk8pm+lYvUSiKFhqZPHoydbFuNs=;
	b=Ij4II3GMauEDKxvHAIOvqGvLJ3p/pfi/avv34f7FkoQCH38kWg9Pa8yQCXjUdnGcT3YIGP
	Lgbtp73TgMj+szxA+EFRyF/BknAw0KL5cnYHN4wPKVczW7AwRv+CYtKm8SOMMPettA5Fvj
	SKpmQ1a3bqsA/EKL708qUPXyUjacuqM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-nCzRPhRZM-eej-QH7GKT5Q-1; Mon, 25 Oct 2021 09:52:16 -0400
X-MC-Unique: nCzRPhRZM-eej-QH7GKT5Q-1
Received: by mail-lf1-f69.google.com with SMTP id z29-20020a195e5d000000b003fd437f0e07so5204084lfi.20
        for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 06:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuJqgemhXYraS4eAGk8pm+lYvUSiKFhqZPHoydbFuNs=;
        b=NxFBMyQo+xuHrBGQjpIWCmTS7RZHPDuBpqoKQ3tGZWNnSHcxQx6qCf5pGQwSzy27l1
         MMwee5ifqFyUiKiYlv2egH9mQONZ9e+ZIUGqnIJy/BAGPg7H9Ckka4sRuBW1rR9GML/2
         rVwcLepjvY1HxqBmtpA8DeoA8IA49VkKceHmJpcpQxLzAz+JsS3faSG8EzV13g2oqj89
         SJ5/PykWDIOHY3rnN8Ua2mC8fzr82H8a5JPD02ZMvI7MfkJlKfehhUJ39Z17EUnJ2BLa
         S6n9MglYd3SNvAP4mjl7MqRBseJIBNtKqHevny9x26Tm7NJGm7aDr0YX39llBnCNI50n
         THGA==
X-Gm-Message-State: AOAM533/AGAmFxN2NOYhEycZHdBkK09z4xx1yBh4HXLarxVKvi0fzYfn
	jYnEw4tuTUmzFiMAwIRPs/mEz1Sv1s5O3muyMpXTJVpeAA+S82mTUSbJh+NHAEO42jYTmSuDemq
	Zez/u09JFLp+GEAFHhDX7CYgS4bggyaw=
X-Received: by 2002:a2e:aaa5:: with SMTP id bj37mr19488915ljb.97.1635169934002;
        Mon, 25 Oct 2021 06:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIfIMtOE/OBAJUx3Wax2YFbpp/uI2+VEj1fdb78JiVqeBZrTtSwoPQ3klnmqa6DgyezPRlOZhvAxTU8++EL2U=
X-Received: by 2002:a2e:aaa5:: with SMTP id bj37mr19488898ljb.97.1635169933779;
 Mon, 25 Oct 2021 06:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0c05b2c0bfb6cd5b6788d00c7f61474d0cd5a747.1634749192.git.psonparo@redhat.com>
 <f424e68a-7332-531e-9fe6-ef5fcbaddfd5@linux.intel.com> <CADppAWAgBA4qaxA1CrbwhUpaoRkX-aZGfQ8EC=-KkM9eZOMztA@mail.gmail.com>
In-Reply-To: <CADppAWAgBA4qaxA1CrbwhUpaoRkX-aZGfQ8EC=-KkM9eZOMztA@mail.gmail.com>
From: Poorva Sonparote <psonparo@redhat.com>
Date: Mon, 25 Oct 2021 06:52:02 -0700
Message-ID: <CADppAWD9WLh9u2fqVhDMuoz-u1CXF=91NL4CVnpRkk2Y2J2zYA@mail.gmail.com>
Subject: Re: [PATCH RFC] Support for SOL_IP for MPTCP setsockopt
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=psonparo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Mat,
>
> On Fri, Oct 22, 2021 at 4:50 PM Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>>
>> On Wed, 20 Oct 2021, Poorva Sonparote wrote:
>>
>> > Hello!
>> >
>> > I have been working on adding support for IP_TOS for setsockopt(). I
>> > am attaching the packetdrill test and the patch but it  still won't set the TOS value
>> > for the subflows that are created after the setsockopt() call.
>> >
>> > https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717
>> >
>> > Thanks,
>> > Poorva
>> >
>> >
>> >
>> >
>> > This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
>> > https://github.com/multipath-tcp/mptcp_net-next/issues/220
>> >
>> > Currently, any new subflows that are created after the setsockopt()
>> > call are not being updated with the set IP_TOS value.
>> >
>>
>> Hi Poorva,
>>
>>> Thanks for the patch!
>>>
>>>
>>> A 'Closes:' tag with the github issue link is also helpful here.
>>
>>
>
Thank you for looking into this. I'll incorporate all the changes and
send out an updated version.
>
>>
>> > Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
>> > ---
>> > net/mptcp/sockopt.c | 39 ++++++++++++++++++++++++++++++++++++++-
>> > 1 file changed, 38 insertions(+), 1 deletion(-)
>> >
>>
>> If you have more commentary that isn't part of the commit message you want
>> to be permanently stored in git, this space (after the '---' line above
>> but before the 'diff --git ...' below) is a good for that! 'git am' will
>> drop this text when applying. This is especially not a big deal with RFC
>> patches like this one, since they don't end up getting merged anyway.
>>
>>
>> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> > index 8137cc3a4296..f5ee49660902 100644
>> > --- a/net/mptcp/sockopt.c
>> > +++ b/net/mptcp/sockopt.c
>> > @@ -598,6 +598,40 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
>> >       return ret;
>> > }
>> >
>> > +static int mptcp_setsockopt_sol_ip_set_tos(struct mptcp_sock *msk, int optname,
>> > +                                        sockptr_t optval, unsigned int optlen)
>> > +{
>> > +     struct mptcp_subflow_context *subflow;
>> > +     struct sock *sk = (struct sock *)msk;
>> > +     int ret, err;
>> > +     int val = 0;
>> > +
>> > +     err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
>> > +     val = inet_sk(sk)->tos;
>> > +
>> > +     if (err != 0)
>> > +             return err;
>>
>> Minor - need a blank line here.
>>
>> > +     lock_sock(sk);
>> > +     mptcp_for_each_subflow(msk, subflow) {
>> > +             struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> > +
>> > +             ip_sock_set_tos(ssk, val);
>> > +     }
>> > +     release_sock(sk);
>>
>> and here
>>
>> > +     return ret;
>> > +}
>> > +
>> > +static int mptcp_setsockopt_sol_ip(struct mptcp_sock *msk, int optname,
>> > +                                sockptr_t optval, unsigned int optlen)
>> > +{
>> > +     switch (optname) {
>> > +     case IP_TOS:
>> > +             return  mptcp_setsockopt_sol_ip_set_tos(msk, optname, optval, optlen);
>> > +     }
>> > +
>> > +     return -EOPNOTSUPP;
>> > +}
>> > +
>> > static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>> >                                   sockptr_t optval, unsigned int optlen)
>> > {
>> > @@ -637,12 +671,14 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
>> >       if (ssk)
>> >               return tcp_setsockopt(ssk, level, optname, optval, optlen);
>> >
>> > +     if (level == SOL_IP)
>> > +             return mptcp_setsockopt_sol_ip(msk, optname, optval, optlen);
>> > +
>> >       if (level == SOL_IPV6)
>> >               return mptcp_setsockopt_v6(msk, optname, optval, optlen);
>> >
>> >       if (level == SOL_TCP)
>> >               return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
>> > -
>>
>> Looks like an accidental line deletion here.
>>
>> >       return -EOPNOTSUPP;
>> > }
>> >
>> > @@ -1000,6 +1036,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>> >       ssk->sk_priority = sk->sk_priority;
>> >       ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
>> >       ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
>> > +     ip_sock_set_tos(ssk, inet_sk(sk)->tos);
>>
>>> > I think this does sync the tos value to new subflows, right? Since the ssk
>>> > is already locked, use __ip_sock_set_tos(). Maybe you ran in to a deadlock
>>> > here that interfered with the syncing.
>
>
Yes, I did. Thanks for the suggestion!
>>
>>
>> >
>> >       if (sk->sk_userlocks & tx_rx_locks) {
>> >               ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
>> > --
>> > 2.18.2
>> >
>> >
>> >
>>
>> --
>> Mat Martineau
>> Intel
>>

