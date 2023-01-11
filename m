Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357117EA
	for <mptcp@lists.linux.dev>; Wed, 11 Jan 2023 23:17:49 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id z4-20020a17090a170400b00226d331390cso18911386pjd.5
        for <mptcp@lists.linux.dev>; Wed, 11 Jan 2023 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=anKSjFd4ix3I4kZXTk/7tF1n1Ty5qbB850/Kdbxw9CM=;
        b=bmk4HT3dQVLFH9zuOPF1179yz6Rh125dpHeSwfwwXDTT1WR6ihhbITCrnqH1t5sMHJ
         oyuOF2Rmzu0yR/PLuhZcd+vsVCHEkUVCsTMDxxBZcNoOcouH7i7OUalLhLvUURUwnqUz
         A/48kdMZaAu6QIFtP1SLt1WBeoMPz0kez7aqVtNwbqlDCjykD8LgMAea2N0eivNEbFqW
         bbrOGlXAQshmkP9AGXLbuYe3HwcmoDsQFxGr2UlMgXZaRted0fIpa7ZQ3ssQMjpoYsWQ
         4yUaW4HCXpibNI7lJKuc3ZmHNwyfIPaUdf6AKi6kov1kt1AefDX3mWOMVk2MtsDFbJ0n
         JGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anKSjFd4ix3I4kZXTk/7tF1n1Ty5qbB850/Kdbxw9CM=;
        b=vb8axD4cA1DUc2lgkC4KVMLGVxRnmFeTZ4fELnU0JftQBpipclX0kLaeIA6Kskl+Hi
         b86BV1/NXc9K+kcQ+rPguZYzZj+gj0X2JkBR7kC2jVtQAWHw9DTbHt6pElGeLenEuSBC
         P7WdZK9xbg6keQz32gToeQ+aDDHc6YCrkcWgiIZSI5ZtZw868LPZrysXbdEnxzx6OZSU
         zfEIQtCp2oZEYlRGra57Dih1X/GVHg0Vi//R8z6S6DwmpVLbRKkhz3Pbe1vrAuHdJVX9
         IRkyOvKHoAQxPLYRErGs4dM98RjIL5qcJKkK6rhWRxoVoMVGM9ufSVqLxwFPSF57Dl5d
         TYWQ==
X-Gm-Message-State: AFqh2kqWQebLZiVsIvGVz4YOMeivnyxXIpyWqdwOiz4A3MWKOgpSqWJS
	Is2m0gwaHz8ofpCrCtJCrm/h5CgoXoowT/693imp
X-Google-Smtp-Source: AMrXdXte+NjPzQprM0LEOuueOYKrvF5ZD1D6JgE8mV4KBC45iKaRvkNIV0afGijWNXPQlyCHqoAYTPBdkISJB6IIb1s=
X-Received: by 2002:a17:902:968a:b0:192:7a00:c790 with SMTP id
 n10-20020a170902968a00b001927a00c790mr4792743plp.12.1673479069381; Wed, 11
 Jan 2023 15:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1671469167.git.pabeni@redhat.com> <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
 <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
 <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
 <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com>
 <fd3ca85bbaceea0ef629c35a0a63129cb6090811.camel@redhat.com>
 <CAHC9VhSBYMyjciZbX38OY_5NU-d6fszPj3xX4F3FhQYLCAWe2Q@mail.gmail.com> <b318b611df77a449b162197868e0af14b2d81b68.camel@redhat.com>
In-Reply-To: <b318b611df77a449b162197868e0af14b2d81b68.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jan 2023 18:17:38 -0500
Message-ID: <CAHC9VhR4_jGE47EFbYTgPeD_Dm+u75wJr5Fjqw==0hUmQhfxyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 9, 2023 at 5:31 AM Paolo Abeni <pabeni@redhat.com> wrote:
> Hello,
>
> I'm sorry for the long delay:  I was on PTO with limited internet
> access.

No worries, I hear even kernel developers are allowed to take time off
occasionally ... at least that's what they tell me ;)

(I hope you're enjoying the time away!)

> On Fri, 2022-12-23 at 12:11 -0500, Paul Moore wrote:
> > On Thu, Dec 22, 2022 at 10:57 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > On Wed, 2022-12-21 at 20:21 -0500, Paul Moore wrote:
> > > > On Wed, Dec 21, 2022 at 2:24 PM Paolo Abeni <pabeni@redhat.com> wrote:

...

> > I generally take the long term view when it comes to Linux Kernel
> > development; given the nature of the kernel, and all the constraints
> > that come with it, I would much rather pursue solutions that we
> > believe have the longest staying power.
> >
> > I'm also happy to work on, and/or review, LSM patches in conjunction
> > with a MPTCP refactor.  If the only reason to split the work over two
> > kernel releases is to soften the blow during the merge window, I think
> > we can work that out in a single release ... at least I say that now
> > :)
>
> I thought about doing the MPTCP and selinux patches sequentially to
> both avoid the possibly untrivial conflicts resultion issues and to
> ensure that the mptcp patches are in place when the selinux ones are
> applied, as there is a fuctional dependency.

Sure, when working across subsystems there is usually some sort of
dependency challenge which dictates which side is tackled first, I
just wanted to make sure we don't consider one side "done" until we
finish both sides.

> > Basically when it comes down to it, I want to make sure that any fix
> > we come up with *works*.  In my mind that means doing the LSM fix in
> > conjunction with the rework; I would hate to see all of the rework
> > happen only to find out later that it still didn't solve the LSM
> > problem.
> >
> > Does that make sense?
>
> Indeed it makes sense to me.
>
> I think we can address that concern in a quite consolidated way. We
> usually include in the MPTCP tree a (very limited) number of patches
> that will not be submitted to the netdev because belong to other trees
> and/or are handled/owned by others devel.
>
> We use the above e.g. to fix build and/or functional issues in our
> self-tests caused by other subsystems without the need to wait for the
> proper fix to land into vanilla. When such event happen, we simply drop
> the local copy of the fixup patch.
>
> We could use a similar schema in this scenario. We can include the the
> LSM patches to the mptcp in our tree while the rework is in progress to
> ensure that overall the effort really addresses the LSM issue.
>
> We can rebase the LSM patches as needed to address conflicts as
> needed/if/when they pops up.
>
> Once that the mptcp patches will land into the LSM tree, we will submit
> formally the LSM ones to you. During the process I'll check and ensure
> that the LSM issue is really/still fixed. Would that work for you?

Sure, I'm pretty flexible on how we do these things, I just want it to
end up fixed in Linus' tree and there are plenty of ways we can make
that happen :)

> > > If that would prove to be the most reasonable option, could we consider
> > > to transiently merge first something alike:
> > >
> > > https://lore.kernel.org/mptcp/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/T/#m06c612f84f6b6fe759e670573b2c8092df71607b
> > >
> > > to have a workable short-term solution, and later revert it when the
> > > final solution would be in place?
> >
> > I would need to go back through that to make sure that it makes sense,
> > and ensure that the hook is idempotent for SELinux, AppArmor, and
> > Smack (current hook implementations), *aaaand* if we promise that this
> > is just a *temporary* hack I think I would be okay with that.
>
> I would appreciate that addtional extra mile a lot, as it will allow a
> (temporary!) fix to be delivered quite earlier than what the above
> process will provide.
>
> Of course the deal is that I'll take ownership of pursuing the complete
> fix till resolution.

Okay, let me do the investigation mentioned above to make sure this is
possible and report back (I need to refresh my memory first, the
holiday break kinda flushed this out of my mind ;).

-- 
paul-moore.com
