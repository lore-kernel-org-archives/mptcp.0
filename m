Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CB70
	for <mptcp@lists.linux.dev>; Mon,  9 Aug 2021 10:15:53 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso740124pjb.1
        for <mptcp@lists.linux.dev>; Mon, 09 Aug 2021 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hB+w4KhYJAzNy71wjogZ3vB7/joEGiqBICORw8YAeH0=;
        b=jjl+NfwQBsJpLit4Xfmxem2AcvCaPQXfsR55fK0xepCQB73RcnzqBXIsCgy72EOwf4
         D4BjwhVql77GyHEdCyO419vlZzXNnc5h4uLfgyM11TTVnXEIHZrHuiDbWiAbrSJO152W
         jGRWMWEZffrbjO9f5BH5UpKbbXuP3/Fir8bwQean12L4GiMIGVTPqKwJElgcID6+J8Xv
         MetsiS+tW/pDbgZ4+ZuqfAbREPUX0D55KH0bbWpfpa79qSJuxjlKFKSRK4E8ueqLY/JN
         rFr9Ioeb4uMlnK1A6bQzdkZI42RERSwjiWIBOmsXOgIs5zlgM2lYUdF814r8+q7n/gaz
         zk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hB+w4KhYJAzNy71wjogZ3vB7/joEGiqBICORw8YAeH0=;
        b=TcUwt5ucincEWLdqrjSzo9piZcEKt4/PPzinb2F/Te7+IXImoc8XAYil8fbeFwqFWD
         lZviRCMNz7Y98BuJI/EQxu0RxaMrKsudFLkGqS1Ev4Jvj539PIdDSQs0LqEKobbLi+et
         ye1K4jVhieQkZTXlx/qgeRUstLU0y+2Tjb0T0Vcvk6Cofi1zio08hWtgYhgoIm8dsEO2
         sHWsDlXww+EwXLqL8NpvofsLoCvh68LkQUEI17jB0QHsX7UcU4r+GhOKQI+7k+gLNO8r
         9yBL7ym1/MNwPyTfC6tngeimUFPd2Qy67WvB/aiLHHqVRunMSHGvBykIUhU1clnlVLPt
         xuuA==
X-Gm-Message-State: AOAM5335qL9bdlXASjoKkKVjmzRdYFYYZvq5hQXgFeEJMjr80ECGvuTg
	PGrsPxnb9aWXjS4g4yfyVdWv4OKYCgYaa1DYFlE=
X-Google-Smtp-Source: ABdhPJz0kJZmqm94P0gaMRRgz0rBMfnwkUD4U6uRMTyT+sIW1hjDb4l84h9RrmpjOoa/Cdv2PEo7vjfc43ylNFxjwdE=
X-Received: by 2002:a17:90a:4fa3:: with SMTP id q32mr36309304pjh.123.1628504153007;
 Mon, 09 Aug 2021 03:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <multipath-tcp/mptcp_net-next/issues/223@github.com>
In-Reply-To: <multipath-tcp/mptcp_net-next/issues/223@github.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 9 Aug 2021 18:15:41 +0800
Message-ID: <CA+WQbwsnVEEcNG1Bp=nXU+gzygUpMTTmO29HxsZaVnu2boMFbw@mail.gmail.com>
Subject: Re: [multipath-tcp/mptcp_net-next] [syzkaller] Memory leak in
 mptcp_nl_cmd_add_addr (#223)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <notifications@github.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=885=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:46=E5=86=99=E9=81=93=EF=BC=
=9A
>
> BUG: memory leak
> unreferenced object 0xffff88810680ea00 (size 64):
> comm "syz-executor.6", pid 6191, jiffies 4295756280 (age 24.138s)
> hex dump (first 32 bytes):
> 58 75 7d 3c 80 88 ff ff 22 01 00 00 00 00 ad de Xu}<....".......
> 01 00 02 00 00 00 00 00 ac 1e 00 07 00 00 00 00 ................
> backtrace:
> [<0000000072a9f72a>] kmalloc include/linux/slab.h:591 [inline]
> [<0000000072a9f72a>] mptcp_nl_cmd_add_addr+0x287/0x9f0 net/mptcp/pm_netli=
nk.c:1170
> [<00000000f6e931bf>] genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/netl=
ink/genetlink.c:731
> [<00000000f1504a2c>] genl_family_rcv_msg net/netlink/genetlink.c:775 [inl=
ine]
> [<00000000f1504a2c>] genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c:792
> [<0000000097e76f6a>] netlink_rcv_skb+0x148/0x430 net/netlink/af_netlink.c=
:2504
> [<00000000ceefa2b8>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
> [<000000008ff91aec>] netlink_unicast_kernel net/netlink/af_netlink.c:1314=
 [inline]
> [<000000008ff91aec>] netlink_unicast+0x537/0x750 net/netlink/af_netlink.c=
:1340
> [<0000000041682c35>] netlink_sendmsg+0x846/0xd80 net/netlink/af_netlink.c=
:1929
> [<00000000df3aa8e7>] sock_sendmsg_nosec net/socket.c:704 [inline]
> [<00000000df3aa8e7>] sock_sendmsg+0x14e/0x190 net/socket.c:724
> [<000000002154c54c>] ____sys_sendmsg+0x709/0x870 net/socket.c:2403
> [<000000001aab01d7>] ___sys_sendmsg+0xff/0x170 net/socket.c:2457
> [<00000000fa3b1446>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
> [<00000000db2ee9c7>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> [<00000000db2ee9c7>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
> [<000000005873517d>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> BUG: leak checking failed
>
> Config: config.txt
> Reproducer: repro.cprog.gz repro.prog.gz

I didn't reproduce this issue yet. I don't know to use the first repro.cpro=
g
file. I just used the second repro.prog file like this:

/usr/sbin/syz-execprog -executor=3D/usr/sbin/syz-executor -repeat=3D0
-procs=3D16 -cover=3D0 repro.prog

And I got no memory leaking. It seems that MPTCP dosen't work in this test
at all, since I got no MPTCP debug output in the dmesg log.

I think maybe I used it in the wrong way. Could you give me some help about
how to use these reproducers?

Thanks,
-Geliang

>
> =E2=80=94
> You are receiving this because you are subscribed to this thread.
> Reply to this email directly, view it on GitHub, or unsubscribe.
> Triage notifications on the go with GitHub Mobile for iOS or Android.
