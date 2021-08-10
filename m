Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FE177
	for <mptcp@lists.linux.dev>; Tue, 10 Aug 2021 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628582726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2JavuOV0Ae2lIrBAXqlWiUNeWHknxXPpHXJjpj1llQ=;
	b=LYhKKOLrUwdUviKxdHsaPF6WYu9eGVVDLZa5GE46MYGqX6e+MydUf8STRyIoBjCEx9AStt
	dXaDzalM0VnP4V+9tbzECD5F1La89xK3GrF9Sj/Mw4sC3xwRdgiGBoqq89VPbieEWmcgJ3
	PhiDryHQC4+0ub3BnW3rNOe7iNuxI7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-jVeXy5ypP4qIUmnIehjkMQ-1; Tue, 10 Aug 2021 04:05:24 -0400
X-MC-Unique: jVeXy5ypP4qIUmnIehjkMQ-1
Received: by mail-wr1-f70.google.com with SMTP id r17-20020adfda510000b02901526f76d738so6135578wrl.0
        for <mptcp@lists.linux.dev>; Tue, 10 Aug 2021 01:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=O2JavuOV0Ae2lIrBAXqlWiUNeWHknxXPpHXJjpj1llQ=;
        b=tYXfcYheQabBUCDN+tqwuWBGfqNCLdBD8cU8oc9LAiZ000k50gs3d5KPphJ0Okmlvo
         tqrEXPe+x1pkS2UPFb9N2XyxkRch6/f/wUjyduSmqZjST9tWsfm+9eSmWxyBwdRDZl47
         +LFp4PRpY03buF9p+26pQuf23afHKYkhgUFUpSkornmjiv8nKLNWB4PHwSpuP4rBfKoj
         e8dZJ/k6GpBSJF6B1qtGIUdSPKz/2djedGPC2P1UaegMnw2YLuhdzYaVyFZvid3svB5h
         wRjbDdoVLgdZFjurEIaHB0v+wjhec6f0fR9kZFK0UcFThPRv5NNC5ZUkMBt4NSXGR52i
         Fquw==
X-Gm-Message-State: AOAM532agfLb7pr+mGynzQHOtzZty1jUgHpkyWETv6QT0d9w/S7bgd3D
	iKS7YYPxjRdF06SUFxQkcGzw3ZQ/4QOVNj3Lv7xB1bKz1flrSMOuNtD1SzTklfTbLcRW8cbcIuy
	ZJbNVcCzdmCXj204=
X-Received: by 2002:a05:6000:225:: with SMTP id l5mr30077936wrz.242.1628582723331;
        Tue, 10 Aug 2021 01:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz6b4awCBr1wBbUwvWvLf8f6IWoWC6Fcw5A7JrMxM0fzlr3LttraUV5tkScAhchBsLeOdphA==
X-Received: by 2002:a05:6000:225:: with SMTP id l5mr30077918wrz.242.1628582723151;
        Tue, 10 Aug 2021 01:05:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id h4sm22998040wru.2.2021.08.10.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:05:22 -0700 (PDT)
Message-ID: <fdb04aa3b434b90ac93aaebfe6ed966a1d196108.camel@redhat.com>
Subject: Re: [multipath-tcp/mptcp_net-next] [syzkaller] Memory leak in
 mptcp_nl_cmd_add_addr (#223)
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 10 Aug 2021 10:05:21 +0200
In-Reply-To: <CA+WQbwsnVEEcNG1Bp=nXU+gzygUpMTTmO29HxsZaVnu2boMFbw@mail.gmail.com>
References: <multipath-tcp/mptcp_net-next/issues/223@github.com>
	 <CA+WQbwsnVEEcNG1Bp=nXU+gzygUpMTTmO29HxsZaVnu2boMFbw@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-08-09 at 18:15 +0800, Geliang Tang wrote:
> Hi Mat,
> 
> Mat Martineau <notifications@github.com> 于2021年8月5日周四 上午7:46写道：
> > BUG: memory leak
> > unreferenced object 0xffff88810680ea00 (size 64):
> > comm "syz-executor.6", pid 6191, jiffies 4295756280 (age 24.138s)
> > hex dump (first 32 bytes):
> > 58 75 7d 3c 80 88 ff ff 22 01 00 00 00 00 ad de Xu}<....".......
> > 01 00 02 00 00 00 00 00 ac 1e 00 07 00 00 00 00 ................
> > backtrace:
> > [<0000000072a9f72a>] kmalloc include/linux/slab.h:591 [inline]
> > [<0000000072a9f72a>] mptcp_nl_cmd_add_addr+0x287/0x9f0 net/mptcp/pm_netlink.c:1170
> > [<00000000f6e931bf>] genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/netlink/genetlink.c:731
> > [<00000000f1504a2c>] genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
> > [<00000000f1504a2c>] genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c:792
> > [<0000000097e76f6a>] netlink_rcv_skb+0x148/0x430 net/netlink/af_netlink.c:2504
> > [<00000000ceefa2b8>] genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
> > [<000000008ff91aec>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
> > [<000000008ff91aec>] netlink_unicast+0x537/0x750 net/netlink/af_netlink.c:1340
> > [<0000000041682c35>] netlink_sendmsg+0x846/0xd80 net/netlink/af_netlink.c:1929
> > [<00000000df3aa8e7>] sock_sendmsg_nosec net/socket.c:704 [inline]
> > [<00000000df3aa8e7>] sock_sendmsg+0x14e/0x190 net/socket.c:724
> > [<000000002154c54c>] ____sys_sendmsg+0x709/0x870 net/socket.c:2403
> > [<000000001aab01d7>] ___sys_sendmsg+0xff/0x170 net/socket.c:2457
> > [<00000000fa3b1446>] __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
> > [<00000000db2ee9c7>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > [<00000000db2ee9c7>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
> > [<000000005873517d>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > BUG: leak checking failed
> > 
> > Config: config.txt
> > Reproducer: repro.cprog.gz repro.prog.gz
> 
> I didn't reproduce this issue yet. I don't know to use the first repro.cprog
> file. 

You should just compile it and run it:

mv repro.cprog repro.c
gcc -o repro repro.c
./repro

> I just used the second repro.prog file like this:
> 
> /usr/sbin/syz-execprog -executor=/usr/sbin/syz-executor -repeat=0
> -procs=16 -cover=0 repro.prog

this is different from the requested command line, which is described
by the first (commented) line into the reproducer:

# {Threaded:false Collide:false Repeat:true RepeatTimes:0 Procs:1
Slowdown:1 Sandbox: Fault:true FaultCall:5 FaultNth:9 Leak:true
NetInjection:false NetDevices:false NetReset:false Cgroups:false
BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false USB:false
VhciInjection:false Wifi:false IEEE802154:false Sysctl:false
UseTmpDir:false HandleSegv:false Repro:false Trace:false}

I'm not sure how the above translates to syz-executor arguments, as the
argoment name and list changes quite frequently with new revisions. The
inline help could give some hints.

> And I got no memory leaking. 

Anyhow the same here, using the c repro. Possibly it requires very high
end system? Code inspection did not show anything relevant either.

> It seems that MPTCP dosen't work in this test
> at all, since I got no MPTCP debug output in the dmesg log.

Did you double check your kernel config and did you set properly
dynamic_debug at runtime?

You can additionaly use ftrace or perf (probe) to verify some piece of
code is actually reached by the self-test. Here I see the relevant
pm_netlink.c function being reached.

Cheers,

Paolo

