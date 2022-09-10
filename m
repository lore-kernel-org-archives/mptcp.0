Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99DA2C
	for <mptcp@lists.linux.dev>; Sat, 10 Sep 2022 03:55:47 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id e68so3444596pfe.1
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 20:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Dk04sliNH3XESHFYnCcCfD5NxUfi5xy5IplaMwM6KkE=;
        b=CUW/l1RZSoJEplS+AQpRzRBUHDqJfVZK0c2eeBtEnrEDXqrPaopLBZatVGtdgpLEJD
         KIwqNaCa2CNzWmF8Jz1o0xNyFM1cLxI9dTBhpg1QLQvs9nhx7Xm3gvNT5pul6x+c8rWG
         1VxHFmpcwRb3swsZog4C45nluRRzm9isLyCijbbwF/lJthTn/LjM+l5Jj9l8E9TsD5+u
         420sW1aq2Iyt4d0OWPSo6JLLLNRqsUipEu7CtFqDRpWu+X4uyDNbNVJcjaBKAE614noq
         P+QsGcZBJkSGt44IirFMirbiIUbBwB+bIVZ6zHN04dCwaMgM+8VBZzBV9UfJPCrJ213m
         82Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Dk04sliNH3XESHFYnCcCfD5NxUfi5xy5IplaMwM6KkE=;
        b=GVwhKiB2GA/TBua0MoVkFk/W1NXzjCPOTu1R1h8UMbEDIJ+HUZT76KBG1gXjzns3qq
         f7eUFms/EwoLUKRK3x5rWncvxHm5B0YyuJYTKhq8sV1Tu4Zobm/yIhEY7apG0r5bLMhs
         LmmoBX8yUL6gtNHTlhPIaZ2EG0xSFk73P+4oquwS1WnvwWgp6CZNrbKtFmpSMiXLg6KY
         rUWoAZ4UydILKq+xkRD0yXMJkLD8t8YBwjs1ekfGQ2eYnkdxlnc7RqLUDDb2UBICDooS
         Vsvp2z8KUC9fqfm8fvuiAlE414IpEUQ2UzlTWBzQaVJtkhtnZ89N7Sza0Mv1k6NXyIuy
         mbhQ==
X-Gm-Message-State: ACgBeo3QQ/lxOm4tbf1IwL+UI8birgHnh6qIucLfSiA6a9uPN/G5LnvQ
	67AGiELkwFQxcSSeZRPHcPbkmFGE/VfFhxWVezg=
X-Google-Smtp-Source: AA6agR5HZBrkfIfoxbsXOnuTvbIAgS1q4ijz5TpdVB6DqxwAdtlfj9d3y6iDUak8Qz9N5mibGUUUUsFt6pXweeGsJBc=
X-Received: by 2002:a05:6a00:1307:b0:53a:9663:1bd6 with SMTP id
 j7-20020a056a00130700b0053a96631bd6mr17182929pfu.55.1662782146856; Fri, 09
 Sep 2022 20:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADxym3aTrj_0ETtHzZg38y=JjOdNz+arYaCYTaHuhSvg+8rUhw@mail.gmail.com>
 <1a260c2c486c2c4bf60c7f953a17c820d4e8b4bc.camel@redhat.com>
In-Reply-To: <1a260c2c486c2c4bf60c7f953a17c820d4e8b4bc.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Sep 2022 11:55:35 +0800
Message-ID: <CADxym3ZdJCWiUrc6o_NFs+AgFJtwx901Ni-msq1jY0WDsO5Ajg@mail.gmail.com>
Subject: Re: net: mptcp: mptcp selftest cause page_counter underflow
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>, mptcp@lists.linux.dev, 
	Mengen Sun <mengensun@tencent.com>, Biao Jiang <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 9, 2022 at 3:19 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2022-09-09 at 13:05 +0800, Menglong Dong wrote:
> > Hello,
> >
> > I find a kernel warning when I run mptcp selftest with
> > following print:
> >
> > [  138.448383] ------------[ cut here ]------------
> > [  138.448386] page_counter underflow: -4294952882 nr_pages=4294967289
> > [  138.448396] WARNING: CPU: 36 PID: 13372 at mm/page_counter.c:56
> > page_counter_uncharge+0x68/0x80
> > [  138.448403] Modules linked in: nft_tproxy nf_tproxy_ipv6
> > nf_tproxy_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 ipt_REJECT
> > nf_reject_ipv4 sch_netem xt_mark veth tcp_diag udp_diag inet_diag tun
> > nf_conntrack_netlink xt_addrtype nft_compat overlay binfmt_misc
> > squashfs edac_core crc32_pclmul ghash_clmulni_intel aesni_intel
> > crypto_simd cryptd virtio_balloon drm i2c_core backlight fuse autofs4
> > btrfs blake2b_generic zstd_compress multipath crc32c_intel sr_mod
> > cdrom floppy
> > [  138.448429] CPU: 36 PID: 13372 Comm: mptcp_connect Kdump: loaded
> > Not tainted 6.0.0-rc2-0008+ #60
> > [  138.448431] Hardware name: Tencent Cloud CVM, BIOS
> > seabios-1.9.1-qemu-project.org 04/01/2014
> > [  138.448432] RIP: 0010:page_counter_uncharge+0x68/0x80
> > [  138.448435] Code: 5b 41 5c 41 5d 5d e9 47 bf ee 00 80 3d 08 e4 0b
> > 02 00 75 18 48 89 da 48 c7 c7 78 ea 7f 82 c6 05 f5 e3 0b 02 01 e8 6d
> > 66 bd 00 <0f> 0b 49 c7 45 00 00 00 00 00 31 f6 eb b7 66 2e 0f 1f 84 00
> > 00 00
> > [  138.448437] RSP: 0018:ffffc9000a143b18 EFLAGS: 00010086
> > [  138.448439] RAX: 0000000000000000 RBX: 00000000fffffff9 RCX: 0000000000000000
> > [  138.448440] RDX: 0000000000000202 RSI: ffffffff827e53f1 RDI: 00000000ffffffff
> > [  138.448441] RBP: ffffc9000a143b30 R08: 0000000000013ffb R09: 00000000ffffbfff
> > [  138.448442] R10: ffffffff830760a0 R11: ffffffff830760a0 R12: ffffffff00000007
> > [  138.448443] R13: ffff8881229780d0 R14: ffff8882072a0f80 R15: 00000000084072b6
> > [  138.448447] FS:  00007f886f30d740(0000) GS:ffff889fbf700000(0000)
> > knlGS:0000000000000000
> > [  138.448449] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  138.448450] CR2: 00007ffd8d488478 CR3: 0000000132088000 CR4: 00000000003506e0
> > [  138.448451] Call Trace:
> > [  138.448453]  <TASK>
> > [  138.448456]  drain_stock+0x43/0xc0
> > [  138.448459]  __refill_stock+0x62/0x90
> > [  138.448461]  mem_cgroup_uncharge_skmem+0x4e/0x90
> > [  138.448463]  __sk_mem_reduce_allocated+0x12e/0x1b0
> > [  138.448467]  __mptcp_update_rmem+0x8e/0xb0
> > [  138.448470]  mptcp_release_cb+0x23a/0x320
> > [  138.448473]  release_sock+0x48/0xa0
> > [  138.448475]  mptcp_recvmsg+0x448/0xb70
> > [  138.448478]  ? balance_dirty_pages_ratelimited+0x10/0x20
> > [  138.448481]  ? generic_perform_write+0x13c/0x1f0
> > [  138.448484]  inet_recvmsg+0x120/0x130
> > [  138.448488]  sock_recvmsg+0x6e/0x80
> > [  138.448490]  sock_read_iter+0x8f/0xf0
> > [  138.448492]  vfs_read+0x29f/0x2d0
> > [  138.448495]  ksys_read+0xb9/0xf0
> > [  138.448497]  __x64_sys_read+0x19/0x20
> > [  138.448499]  do_syscall_64+0x42/0x90
> > [  138.448501]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  138.448504] RIP: 0033:0x7f886f0f9a7e
> > [  138.448506] Code: c0 e9 b6 fe ff ff 50 48 8d 3d be ec 0b 00 e8 d9
> > f1 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75
> > 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83
> > ec 28
> > [  138.448507] RSP: 002b:00007ffd8d488478 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000000
> > [  138.448509] RAX: ffffffffffffffda RBX: 0000000000000feb RCX: 00007f886f0f9a7e
> > [  138.448510] RDX: 0000000000000feb RSI: 00007ffd8d48e550 RDI: 0000000000000003
> > [  138.448511] RBP: 0000000000000003 R08: 00007f886f1f2210 R09: 00007f886f1f2260
> > [  138.448512] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8d48e550
> > [  138.448513] R13: 0000000000002000 R14: 0000000000000000 R15: 00007ffd8d48e550
> > [  138.448516]  </TASK>
> > [  138.448516] ---[ end trace 0000000000000000 ]---
> >
> > It is easy to reproduce, just run mptcp_connect.sh, mptcp_sockopt.sh and
> > mptcp_join.sh together.
> >
> > Hmm...I'm not good at kernel memory, so someone who
> > is good at this part may have a look at this problem.
> >
> > You can add
> > Reported-by: Menglong Dong <imagedong@tencent.com>
> > when you fix this warning.
>
> Thank you for the report. We already got a similar one from the intel
> bot, but we did not find an easy way to reproduce it.
>
> The issue should be addressed by this patch:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20220906180404.1255873-1-matthieu.baerts@tessares.net/
>

Awesome! I totally have no idea about this warning.

> Thanks,
>
> Paolo
>
