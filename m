Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B592F22
	for <mptcp@lists.linux.dev>; Wed, 21 Dec 2022 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671650643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4C3I/Aflv3a3nMUzlPmw+f0O/d9xiUukrVA5sTOzdo=;
	b=ZZuVtfLYVjUBaKIe73jhswZWoFinuL1gFLKI3cjckvTiLMnB9V9y9gh1gVNLXIDkDqMLTu
	bpL7lkmGJBeKnVNisGGPSCF3hTO1j1OWlcboCzkWXBa9Y+cdkBS5ht0uJxaTptQ5vYA/T+
	4I9ZK7kukh60KAmO5TFLa9eyQQbwEok=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-8xwwVSnQOoKv88OgT8B6JQ-1; Wed, 21 Dec 2022 14:24:01 -0500
X-MC-Unique: 8xwwVSnQOoKv88OgT8B6JQ-1
Received: by mail-wr1-f69.google.com with SMTP id m24-20020adfa3d8000000b00242168ce9d1so3192235wrb.15
        for <mptcp@lists.linux.dev>; Wed, 21 Dec 2022 11:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4C3I/Aflv3a3nMUzlPmw+f0O/d9xiUukrVA5sTOzdo=;
        b=8J3cv+qgssava8pM3q7KM2xtHxTnh25DcMNwTKBrJ3A1Vh2w9q1QQFf4FRE3fKIoLb
         2akPMF2TSX2vg1JPUl4++MhnhjULdvOYjdP4xGlVpQ0wkySjRwkL35kqjJsjSPVhOoum
         CFkvVxpE6byJKvtwQFjMJdNA2GmyFA7XdBpk9GEUqpuAHlIkNYT8i4WAlCMT4p5CfHIQ
         a88J+Sm6Mi2ZZ5luGbiMoMflasuiLW12JBr79DTICS70topUrKCuU15lBpK2d2VCb9oK
         jlP+RNDYrFa7/oP/lTBDp+Ywh1HdDJ5XQQPK+/5meL/tWNdVW1Z9qiGewxdG5o0LSyb7
         U47g==
X-Gm-Message-State: AFqh2krKQgWVRPxmYRsEt2rXPUGxdgtl7gvGv8bKQLemOsS2e8a7zBKc
	sgG9lIhJ1UBMhTBvcdo0UtxeGr8WCnbUG8av2kMOjT1RTDbDwv1hV9V1p5xCuqO+xpu/WqgeSgv
	kiHhe3wLVdF1qjNw=
X-Received: by 2002:a05:600c:601d:b0:3d6:4ba9:c111 with SMTP id az29-20020a05600c601d00b003d64ba9c111mr2561747wmb.40.1671650640556;
        Wed, 21 Dec 2022 11:24:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxoGwwyTymheQbysuArpiDBLiZi1NQiT6NkCs/M8vdLElzezhLtyH/z6oPBoaDj4DtPpHoQA==
X-Received: by 2002:a05:600c:601d:b0:3d6:4ba9:c111 with SMTP id az29-20020a05600c601d00b003d64ba9c111mr2561741wmb.40.1671650640324;
        Wed, 21 Dec 2022 11:24:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm675610wmo.14.2022.12.21.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:23:59 -0800 (PST)
Message-ID: <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
From: Paolo Abeni <pabeni@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	mptcp@lists.linux.dev
Date: Wed, 21 Dec 2022 20:23:58 +0100
In-Reply-To: <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
References: <cover.1671469167.git.pabeni@redhat.com>
	 <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
	 <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-12-20 at 17:07 -0500, Paul Moore wrote:
> On Mon, Dec 19, 2022 at 12:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > Newly added subflows should inherit the associated label
> > from the current process context, regarless of the sk_kern_sock
> > flag value.
> > 
> > This patch implements the above resetting the subflow sid, deleting
> > the existing subflow label, if any, and then re-creating a new one.
> > 
> > The new helper reuses the selinux_netlbl_sk_security_free() function,
> > and it can end-up being called multiple times with the same argument;
> > we additionally need to make it idempotent.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - fix build issue with !CONFIG_NETLABEL
> > ---
> >  security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
> >  security/selinux/netlabel.c |  4 +++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3c5be76a9199..f785600b666a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
> >         selinux_netlbl_sctp_sk_clone(sk, newsk);
> >  }
> > 
> > +static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> > +{
> > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +       struct sk_security_struct *ssksec = ssk->sk_security;
> > +       u16 sclass;
> > +       u32 sid;
> > +       int err;
> > +
> > +       /* create the sid using the current cred, regardless of the ssk kern
> > +        * flag
> > +        */
> > +       sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
> > +                                              ssk->sk_protocol);
> > +       err = socket_sockcreate_sid(tsec, sclass, &sid);
> > +       if (err)
> > +               return err;
> > +
> > +       ssksec->sid = sid;
> > +
> > +       /* replace the existing subflow label deleting the existing one
> > +        * and re-recrating a new label using the current context
> > +        */
> > +       selinux_netlbl_sk_security_free(ssksec);
> > +       return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
> > +}
> 
> I thought the idea was to ensure that new subflows of an existing
> MPTCP connection would be created with the same label as the main
> MPTCP connection socket?  The code above labels the new subflow based
> on the current process, not the main MPTCP connection; it matches the
> commit description, but not what we had previously discussed - or I am
> horribly mis-remembering something? :)

You are right, I picked a wrong turn.

I just tested the other option and there is another problem :(

The first subflow creations happens inside af_inet->create, via the sk-
>sk_prot->init() hook. The security_socket_post_create() call on the
owning MPTCP sockets happens after that point. So we copy data from a
not yet initialized security context (and the test fail badly).

There are a few options to cope with that:
- [ugly hack] call  security_socket_post_create() on the mptcp code
before creating the subflow. I experimented this just to double the
problem and a possible solution.

- refactor the mptcp code to create the first subflow on later
syscalls, as needed. This will require quite a bit of refactoring in
the MPTCP protocol as we will need also to update the
shutdown/disconnect accordingly (currently we keep the first subflow
around, instead we will need to close it).

- use the code proposed in these patches as-is ;) 

WDYT?

Thanks,

Paolo

