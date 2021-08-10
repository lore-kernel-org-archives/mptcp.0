Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0672
	for <mptcp@lists.linux.dev>; Tue, 10 Aug 2021 11:36:25 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id bo18so10563694pjb.0
        for <mptcp@lists.linux.dev>; Tue, 10 Aug 2021 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Ds2Fdlmn9tXplg7L9XEumUJ5d2mt/KWTDBM/qYA210=;
        b=PPBEx3N/3qMx7H21qxxL4LXpQ/gzeCdYjwUY0TJijGH9jrB5SAgAurTbDnGy2eL+Rt
         w4J4oEzJjhTgKXAqNYhQ5XU+HTs/ul/Vd0w0hEhNEUhf/YNKIAKp37z/ALNHA2K5dCs4
         winIdWU9Y0aDwPsqHjf5G3exqgp5GxLlG9/K5hcBez/jda6iYf6qjOxUkg7OhnGqT+d0
         G/FIz2Wrv1ZGNt9YnBBhU7huM6rYhi9jTUMbfaO2IL13NDgS9V0rK3t7ZOPtrgmhSjcX
         8W2vZyxBPa0Vi7/yX7aJAvLoMQ0fOSnW97CCuBDk56y5Y7ZMI6rEIrBsr5Rlcd8BIDMA
         l3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Ds2Fdlmn9tXplg7L9XEumUJ5d2mt/KWTDBM/qYA210=;
        b=h7PNTlJhTX/sm2NOyVB+1PSiiBmzUyAqj41IXiv0wqV2jXx+iGvjfiRch1zx+UvqXR
         1it5x9Wi8JQKE8tBeeqmgQsxszrFGbljP1kfVVzyQEcbHbG6W/Gm+nHijr9FR2YiBTck
         pnlrEL+lUUMshqMdmZcTsb8es9UMzGNczhfMlMWDiSonXD8gFpzr+FFmmLrC3R19f5Dy
         XuWBpYF8CiK/NRG4/DIbFTQmNDccpa3+Hvoxoz4Y6YBl2uIO/T9q/xMY4kiPhkPZXU4S
         8bjxy99V4Q3MVtwNCzhRAlwtXvspvcimYNUl87oaDqYdwAstH+/AQKEd76PV2u5QrrO3
         Mesg==
X-Gm-Message-State: AOAM533+iurUG0/rCtdKpAwwLVIp9Yjm3drn/RuslxasUut6l/M8m1C9
	iO38LvC7TgwdoBfVpEuBQqYZdlVc7LRupdwEKEw=
X-Google-Smtp-Source: ABdhPJyYHV/vicBx1GH98hSmrBIq87p7JpNX7X/OVJgmBAtNLKbTVtU7QEOdo6plpzxNqurtbcADnhLY18Hhkbmhz+U=
X-Received: by 2002:a63:ef12:: with SMTP id u18mr610100pgh.331.1628595384924;
 Tue, 10 Aug 2021 04:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <multipath-tcp/mptcp_net-next/issues/223@github.com>
 <CA+WQbwsnVEEcNG1Bp=nXU+gzygUpMTTmO29HxsZaVnu2boMFbw@mail.gmail.com> <fdb04aa3b434b90ac93aaebfe6ed966a1d196108.camel@redhat.com>
In-Reply-To: <fdb04aa3b434b90ac93aaebfe6ed966a1d196108.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 10 Aug 2021 19:36:13 +0800
Message-ID: <CA+WQbwv6MQKBRLzW0KEb0V=Rbpoh979L5spQwNJym+PgdUCqaQ@mail.gmail.com>
Subject: Re: [multipath-tcp/mptcp_net-next] [syzkaller] Memory leak in
 mptcp_nl_cmd_add_addr (#223)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2021-08-09 at 18:15 +0800, Geliang Tang wrote:
> > Hi Mat,
> >
> > Mat Martineau <notifications@github.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=885=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:46=E5=86=99=E9=81=93=EF=
=BC=9A
> > > BUG: memory leak
> > > unreferenced object 0xffff88810680ea00 (size 64):
> > > comm "syz-executor.6", pid 6191, jiffies 4295756280 (age 24.138s)
> > > hex dump (first 32 bytes):
> > > 58 75 7d 3c 80 88 ff ff 22 01 00 00 00 00 ad de Xu}<....".......
> > > 01 00 02 00 00 00 00 00 ac 1e 00 07 00 00 00 00 ................
> > > backtrace:
> > > [<0000000072a9f72a>] kmalloc include/linux/slab.h:591 [inline]
> > > [<0000000072a9f72a>] mptcp_nl_cmd_add_addr+0x287/0x9f0 net/mptcp/pm_n=
etlink.c:1170
> > > [<00000000f6e931bf>] genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/=
netlink/genetlink.c:731
> > > [<00000000f1504a2c>] genl_family_rcv_msg net/netlink/genetlink.c:775 =
[inline]
> > > [<00000000f1504a2c>] genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c=
:792
> > > [<0000000097e76f6a>] netlink_rcv_skb+0x148/0x430 net/netlink/af_netli=
nk.c:2504
> > > [<00000000ceefa2b8>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
> > > [<000000008ff91aec>] netlink_unicast_kernel net/netlink/af_netlink.c:=
1314 [inline]
> > > [<000000008ff91aec>] netlink_unicast+0x537/0x750 net/netlink/af_netli=
nk.c:1340
> > > [<0000000041682c35>] netlink_sendmsg+0x846/0xd80 net/netlink/af_netli=
nk.c:1929
> > > [<00000000df3aa8e7>] sock_sendmsg_nosec net/socket.c:704 [inline]
> > > [<00000000df3aa8e7>] sock_sendmsg+0x14e/0x190 net/socket.c:724
> > > [<000000002154c54c>] ____sys_sendmsg+0x709/0x870 net/socket.c:2403
> > > [<000000001aab01d7>] ___sys_sendmsg+0xff/0x170 net/socket.c:2457
> > > [<00000000fa3b1446>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
> > > [<00000000db2ee9c7>] do_syscall_x64 arch/x86/entry/common.c:50 [inlin=
e]
> > > [<00000000db2ee9c7>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:=
80
> > > [<000000005873517d>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > BUG: leak checking failed
> > >
> > > Config: config.txt
> > > Reproducer: repro.cprog.gz repro.prog.gz
> >
> > I didn't reproduce this issue yet. I don't know to use the first repro.=
cprog
> > file.
>
> You should just compile it and run it:
>
> mv repro.cprog repro.c
> gcc -o repro repro.c
> ./repro

Thanks Paolo, I ran ./repro and reproduced this memory leaking issue. I'll
try to fix it recently.

-Geliang

>
> > I just used the second repro.prog file like this:
> >
> > /usr/sbin/syz-execprog -executor=3D/usr/sbin/syz-executor -repeat=3D0
> > -procs=3D16 -cover=3D0 repro.prog
>
> this is different from the requested command line, which is described
> by the first (commented) line into the reproducer:
>
> # {Threaded:false Collide:false Repeat:true RepeatTimes:0 Procs:1
> Slowdown:1 Sandbox: Fault:true FaultCall:5 FaultNth:9 Leak:true
> NetInjection:false NetDevices:false NetReset:false Cgroups:false
> BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false USB:false
> VhciInjection:false Wifi:false IEEE802154:false Sysctl:false
> UseTmpDir:false HandleSegv:false Repro:false Trace:false}
>
> I'm not sure how the above translates to syz-executor arguments, as the
> argoment name and list changes quite frequently with new revisions. The
> inline help could give some hints.
>
> > And I got no memory leaking.
>
> Anyhow the same here, using the c repro. Possibly it requires very high
> end system? Code inspection did not show anything relevant either.
>
> > It seems that MPTCP dosen't work in this test
> > at all, since I got no MPTCP debug output in the dmesg log.
>
> Did you double check your kernel config and did you set properly
> dynamic_debug at runtime?
>
> You can additionaly use ftrace or perf (probe) to verify some piece of
> code is actually reached by the self-test. Here I see the relevant
> pm_netlink.c function being reached.
>
> Cheers,
>
> Paolo
>
