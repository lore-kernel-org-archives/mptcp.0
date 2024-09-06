Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D21C7B93
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634731; cv=none; b=KgSuaxBv234GGg5YhBJ1i6BeCnq1IKp1cz9oaEwoAebn/v57wfegtUEx0zewSCz70SlY5SiXbKFCqfJ70oyHpXbq5tG99ha6gU81zEtG19XdlPjkRZFQghN81IPqlgO+McccUW9p1rU7vjKDE+RUkEngQ2PJQwdWBDz06EKD7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634731; c=relaxed/simple;
	bh=AUY5qMPF24Vaa31fluYZqJ+GI06B62Eq6etM63Uuqbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlbg5L6elZWDhjPyFBB+Dq3B9WIaMFCw/8R+f2+oDoIVKwDQZ7QiMkUz2CYB/T0EvvHtmBB0FANXhnibTKg7zAqohcIxwWYsOfDkPb996LNzt+7p5be1ynIbKr3uLGtI0lwyiQ1yb5Xf8B47BqwDIrnHhF4/AoKbn6AGDNkEa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it; spf=pass smtp.mailfrom=student.unisi.it; dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b=bM85BaNm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b="bM85BaNm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20551e2f1f8so20859975ad.2
        for <mptcp@lists.linux.dev>; Fri, 06 Sep 2024 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.unisi.it; s=google; t=1725634727; x=1726239527; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TMQsqnsoGWBI2FCYZp9wV+NjWfjs+XZuCfhGtTaMATc=;
        b=bM85BaNmgMMv7aOL6pIAxHj8FkA80xdfi9CIuHPkNi6ODQ4F3yr40PLNfl7qLZbVbZ
         AZnmmBVW7e7GzEzOmuzYTDK0x6fvnu9krMebGy8RqlufgsWRs+VOH58Sv/2GVvyB3pk4
         IOEvIC3bKgw1TPtVJipVjW9syeMKusRZU56PlxORAvDgG2tAEVxGfl0gCzNtU9GBw06q
         nChbK/QOogeSJKZgYpNyrDqnobvMranckwaSfk6yKPmqXP8e4Mktpl4/p0H+qSY1b2xY
         zu85nCcp4VQkM4Y5omxs9HY/gQ1IDUqjw3Dlvxj31myGe6qPEhRCfIkAVpzFnv0v8Y/q
         YBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634727; x=1726239527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMQsqnsoGWBI2FCYZp9wV+NjWfjs+XZuCfhGtTaMATc=;
        b=DgxVaQonxPTEsnaZotRXgdBoMQ4OGQalJMpGojazAIbBcEsR+FiNub3KWkzqshMoS7
         dISyJrD9MOJ7fa6MKQ+dp27S6YHJ1qfl/uMkXF+M/CseQqiZBjUnTMuRFty6m7qLPEgN
         dZZueCXAGE69+ASJJfUQ3r4/2BGEmgzrZAlzkRYnYghjRRbbDp1BExSCat+AI2h23TaJ
         VvLK4Gma2xIsgmOxWNCrq3WCPOntDIGULhhte8IbSHEZVJWZTC9G3JwPTp/fPHS2LEyS
         eEwVx/ui4zbq9eZ51ggVWulP/RNaZzocZrqYHHVVDjtApPrRgOTPc+hhnPVek8MDoncu
         CC5Q==
X-Gm-Message-State: AOJu0YyLQSINVCZGjAkm79EU2ZXbbM/al5avcjU8kQi170xgC2TixOw3
	VB3A0+uKwQEbjxF0igmddD4TIcbh2Aw1MTLtV5Zj70ZHPAS2Fvkab/Ap2rF2hDGTPNDJhmslgBg
	2DQ3crrbGFuf/qfiq7644BeCeK2MF3ZDTTMkHQJ7OOrJ4IMFxp3SfnEtQ0DIrFpVOgMxEnd2cgW
	iGNRPOTv+OVqIGGxfDLnJx/95PpXfmtTlJsg==
X-Google-Smtp-Source: AGHT+IH009XgRvleR1Re2yb889stUaRCLMlm/Mf4Da3wg1ursuhiimJ143ZSPwPyjvUpeZf1x6qRpeOHVoJjl48lPHs=
X-Received: by 2002:a17:902:e849:b0:1fd:69e0:a8e5 with SMTP id
 d9443c01a7336-206f05b3356mr32235645ad.41.1725634726578; Fri, 06 Sep 2024
 07:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOU6Dw9xnP2ha8Csj47_zQQEHg7_FUrgVRW+CrTon-aPLokKog@mail.gmail.com>
 <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org> <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
 <8f355da2-5667-412b-b3fd-1ce8f7571fa8@kernel.org> <CAOU6Dw-P_RRcVJqf2bGY=d8Vsas+H-9Y0tWLRmyTuFxA+5wsMw@mail.gmail.com>
In-Reply-To: <CAOU6Dw-P_RRcVJqf2bGY=d8Vsas+H-9Y0tWLRmyTuFxA+5wsMw@mail.gmail.com>
From: ROSHITH SEBASTIAN <roshith.sebastian@student.unisi.it>
Date: Fri, 6 Sep 2024 16:58:34 +0200
Message-ID: <CAOU6Dw8j5hhWeXc9dXYW_BKr7WYC-1_-7HfeP31f8vDYhZ5dmg@mail.gmail.com>
Subject: Re: mptcpd Usersapce PM
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Gm-Unisi: student.unisi.it

Hi Matthieu,

I have been trying to create a PM using the plugins using the template
already present in the page as a starting point.
The following code snippet was inserted into the xxx_new_connection
and xxx_connection_established functions to identify the remote and
local addresses being passed to the function:

    struct sockaddr_in *l_addr = (struct sockaddr_in *)laddr;
    struct sockaddr_in *r_addr = (struct sockaddr_in *)raddr;
    char *l_a = inet_ntoa(l_addr->sin_addr);
    char *r_a = inet_ntoa(r_addr->sin_addr);
    printf ("Server Side? %s\n", server_side ? "True" : "False");
    printf ("Local address : %s\n", l_a);
    printf ("Remote address : %s\n", r_a);

The output is as follows:
Server Side? False
Local address : 10.0.0.2
Remote address : 10.0.0.2

I am not able to understand why both the remote and local addresses
are the same. The ports are different, but the local addresses
displayed are on the same host. The behaviour is the same for the
server as well, but the addresses are random which are not assigned to
any interface on the host.

The function to create a subflow - mptcpd_pm_add_subflow, takes
mptcpd_aid_t as a parameter. Can you also please let me know where I
can find the documentation to identify which value has to be used
here?

Thanks and Regards,
Roshith Sebastian


On Wed, 4 Sept 2024 at 10:54, ROSHITH SEBASTIAN
<roshith.sebastian@student.unisi.it> wrote:
>
> Thank you for your answer. I will try to proceed accordingly.
>
> Thanks and Regards,
> Roshith Sebastian
>
> On Tue, 3 Sept 2024 at 17:31, Matthieu Baerts <matttbe@kernel.org> wrote:
> >
> > On 03/09/2024 17:21, ROSHITH SEBASTIAN wrote:
> >
> > (...)
> >
> > > I am trying to implement userspace PM, because different rules have to
> > > be set for each suflow based on different conditions (these are still
> > > being defined). For example, 75% of the data should flow through one
> > > and the rest through the other subflow based on the delay or the cost
> > > of the link. The fraction in which the traffic is split might not be
> > > known beforehand and can vary during simulation.
> > > So my objective is to divide the traffic unevenly across the links
> > > based on certain rules.
> > > Is it possible to accomplish this with a PM or is a custom scheduler
> > > needed? Although I have seen references to shedulers in previous
> > > versions, it has not been mentioned in mptcpd.
> >
> > The PM is in charge of subflows, from creation to deletion, and also
> > address announcements. From what I understand, you don't need to have
> > custom rules for that: you just want to create 2 paths using two
> > different networks, no?
> >
> >   https://www.mptcp.dev/#path-manager
> >
> > mptcpd can only control the path-managers.
> >
> > The packet scheduler is in charge of selecting which available
> > subflow(s) to use to send the next data packet.
> >
> >   https://www.mptcp.dev/#packet-scheduler
> >
> > For the moment, it is not possible to control the packet scheduler. It
> > might be possible to do that in the future with BPF, the work is in
> > progress, e.g.
> >
> >   https://github.com/multipath-tcp/mptcp_net-next/issues/75
> >
> > Cheers,
> > Matt
> > --
> > Sponsored by the NGI0 Core fund.
> >
