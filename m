Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DA23DB;
	Tue, 13 Jun 2023 16:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC23C433F0;
	Tue, 13 Jun 2023 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686672480;
	bh=e6YWB9fh2KmtYk7Xq2kMJRapKPZPbhcJ5t1vuY0fBto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I1mnskrRQ2FKItWQ6IJN0sw3ByMneAcH+CNkuxsO26/7JgcmuzJV1vTNC6mg3dSjy
	 9H6lnNICeCkC+k89WoTgJsJ5aUAEbR92y1YeZaPl5ED1eTKeRjQ0W56USrcEqJQ95u
	 U/hd1r1LnN1Zh26AmZp9gOWJxD6fIhLDPDVBQD3LkNeN+NAtj5BuCR2LZAnWxWkal3
	 3rkjd4Fq3QEZqzsCFYMIlF5aqAEcWqS/beTcS4hntRnWhW8SXb7q4AY3ySgvbp2hPy
	 n0ITZc/wHhJiAouiUSPlg3kw6dSuQfqVunzfNQnaINUSp+QIiV5rfvDPvAlcFV6+8l
	 EdGK1ces7hn3Q==
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bd20beffda6so1056629276.1;
        Tue, 13 Jun 2023 09:08:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDx8ejog3zy05y7yri8ESIVxJY3AGRj1xXKYLDr8PUDpo2Xn55sy
	sHOkk/6fGMy1UcKPtuGHGNJpEcjKhVtv0Nx9k+M=
X-Google-Smtp-Source: ACHHUZ4oCkGM4mw3oh536ynCF+vchNGmO9W+rMcJqfPR9PC2cp06ume/ZTJudMz8VUMx9mmR4kAF8Q/pPSDG5UDY2io=
X-Received: by 2002:a25:9d02:0:b0:bc0:bfa7:7658 with SMTP id
 i2-20020a259d02000000b00bc0bfa77658mr1919292ybp.2.1686672479589; Tue, 13 Jun
 2023 09:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
 <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net> <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
 <4830cc62-64fd-f74b-bbfc-b8e44e023513@leemhuis.info>
In-Reply-To: <4830cc62-64fd-f74b-bbfc-b8e44e023513@leemhuis.info>
From: Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 13 Jun 2023 11:07:48 -0500
X-Gmail-Original-Message-ID: <CAFkjPTnAV6Rngwn6voCF332CX+eUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com>
Message-ID: <CAFkjPTnAV6Rngwn6voCF332CX+eUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com>
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: evanhensbergen@icloud.com, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood, this on top of my 9p stack, but day job has been getting
in the way lately so I need to unstack there first.  Will do my best
to reproduce and understand as quickly as I can -- but given its a
performance regression it is likely going to be tricky to reproduce
and understand, so I'm not sure how confident I am that we'll be able
to close it out prior to the final -rc.

     -eric


     -eric

On Tue, Jun 13, 2023 at 9:57=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 06.06.23 20:47, evanhensbergen@icloud.com wrote:
> > Interesting - so looks like caches aren=E2=80=99t being used so curious=
 that there is any impact at all from mostly cache-related patches!
> > Okay thanks, I=E2=80=99ll dig in and see what I can find.
>
> Gentle reminder that this apparently made no progress for a week now. Or
> was there progress and I just missed it? Then apologies in advance.
>
> I'm asking, as it afaics would be nice to have this resolved in mainline
> before the next -rc. That would be ideal to avoid last minute changes
> after the last rc.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
>
> >> On Jun 6, 2023, at 10:08 AM, Matthieu Baerts <matthieu.baerts@tessares=
.net> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 06/06/2023 16:49, Eric Van Hensbergen wrote:
> >>> thanks for the detailed report - I=E2=80=99ll have a look.
> >>
> >> Thank you for the quick reply!
> >>
> >> No hurry, we can also revert these patches in our tree for the time be=
ing.
> >>
> >>> Do you know off hand
> >>> what cache options for 9p are in use?
> >>
> >> Sorry, I'm not sure what to look at.
> >>
> >> In the VM, I see that this mount command is used:
> >>
> >>  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3D=
any \
> >>             virtme.guesttools /run/virtme/guesttools
> >>
> >> In virtme source, I can see these commands should be executed:
> >>
> >>  /bin/mount -n -t 9p -o ro,version=3D9p2000.L,trans=3Dvirtio,access=3D=
any \
> >>             /dev/root /newroot/
> >>  mount -t 9p -o version=3D9p2000.L,trans=3Dvirtio,access=3Dany \
> >>        "virtme.initmount${tag:16}" "${!tag}"
> >>
> >> From the VM, I can see:
> >>
> >>> # mount | grep 9p
> >>> /dev/root on / type 9p (ro,relatime,access=3Dany,trans=3Dvirtio)
> >>> virtme.guesttools on /run/virtme/guesttools type 9p (ro,relatime,acce=
ss=3Dany,trans=3Dvirtio)
> >>> virtme.initmount0 on /mptcp_net-next type 9p (rw,relatime,access=3Dan=
y,trans=3Dvirtio)
> >>
> >> And the VM is started using:
> >>
> >>> /usr/bin/qemu-system-x86_64 -fsdev local,id=3Dvirtfs1,path=3D/,securi=
ty_model=3Dnone,readonly=3Don,multidevs=3Dremap -device virtio-9p-pci,fsdev=
=3Dvirtfs1,mount_tag=3D/dev/root -fsdev local,id=3Dvirtfs5,path=3D/opt/virt=
me/virtme/guest,security_model=3Dnone,readonly=3Don,multidevs=3Dremap -devi=
ce virtio-9p-pci,fsdev=3Dvirtfs5,mount_tag=3Dvirtme.guesttools -fsdev local=
,id=3Dvirtfs9,path=3D.,security_model=3Dnone,multidevs=3Dremap -device virt=
io-9p-pci,fsdev=3Dvirtfs9,mount_tag=3Dvirtme.initmount0 -machine accel=3Dkv=
m:tcg -watchdog i6300esb -cpu host -parallel none -net none -echr 1 -serial=
 none -chardev stdio,id=3Dconsole,signal=3Doff,mux=3Don -serial chardev:con=
sole -mon chardev=3Dconsole -vga none -display none -m 2048M -smp 2 -device=
 virtio-net-pci,netdev=3Dn0 -netdev user,id=3Dn0 -kernel .virtme/build/arch=
/x86/boot/bzImage -append 'virtme_link_mods=3D.virtme/build/.virtme_mods/li=
b/modules/0.0.0 virtme_initmount0=3D/mptcp_net-next earlyprintk=3Dserial,tt=
yS0,115200 console=3DttyS0 psmouse.proto=3Dexps "virtme_stty_con=3Drows 59 =
cols 132 iutf8" TERM=3Dxterm virtme.dhcp virtme_chdir=3D/mptcp_net-next roo=
tfstype=3D9p rootflags=3Dversion=3D9p2000.L,trans=3Dvirtio,access=3Dany rai=
d=3Dnoautodetect ro mitigations=3Doff init=3D/bin/sh -- -c "mount -t tmpfs =
run /run;mkdir -p /run/virtme/guesttools;/bin/mount -n -t 9p -o ro,version=
=3D9p2000.L,trans=3Dvirtio,access=3Dany virtme.guesttools /run/virtme/guest=
tools;exec /run/virtme/guesttools/virtme-init"'
> >>
> >> I don't see anything about the cache and nothing in the dmesg. If you
> >> think this info is in the dmesg, the logs are publicly available there=
:
> >>
> >> https://cirrus-ci.com/task/5569063884161024?logs=3Dtest#L5626
> >>
> >>
> >>> Since things are slower, my first
> >>> suspect is the don't cache qid.version =3D=3D 0 change.  That can be
> >>> overridden with a mount option but perhaps we should invert the defau=
lt
> >>> as it is new behavior from a linux perspective.
> >>
> >> Can I easily change the default behaviour on the kernel side to try
> >> (without modifying the tools launching the mount commands)?
> >>
> >> Cheers,
> >> Matt
> >> --
> >> Tessares | Belgium | Hybrid Access Solutions
> >> www.tessares.net
> >>
> >
> >
> >
