Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536D65A
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662707986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaeCnJa8gIbHFQzoDZnFvGzLYz113ntpfY0w/PvkMoo=;
	b=B+T8WB3p+qy9UXJsjX43mzaPl4s+hXjH38bi0cB5XJ6gBcuyE5H2xbCVooK8o23wK4URo5
	HWPgarH3ZV2MTCWK/QxFjy/2ZJt0vbYazlQIW26ZdVZbjOfgCC/LW+T1LVGqGRrW6MGb/F
	6yL5ypm9eYKnNIBysIgDTk2DmwpwQaY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-JAZ9PxxfMSOb1rg5C-nNGQ-1; Fri, 09 Sep 2022 03:19:44 -0400
X-MC-Unique: JAZ9PxxfMSOb1rg5C-nNGQ-1
Received: by mail-wm1-f69.google.com with SMTP id r186-20020a1c44c3000000b003b3309435a9so1598748wma.6
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 00:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aaeCnJa8gIbHFQzoDZnFvGzLYz113ntpfY0w/PvkMoo=;
        b=tCh4x3prHvnmNHz8o0fs9VGsHTaDS6fHYNvKPWeZfVR9xfw+8RdkIWb/IpLm+kIa0Y
         I9HM9KQ2JsJuU2p2Ir/hIvz1gHKXsHozl8wC/Nl0AJWiaf86UKJYmsFVw0GV0H4HNMOo
         s4aEMV5qKO6XhV019YMSTtsEHx+2fLOAyDW9ZdnRPe02hYIsg6U/erlt73pN9f0n2NLa
         EqbysZfD3zQ5XmLuCOH0k+7aGUf8CJjhfoPh5EC8pq9fl5r4D0OkH1jgZWmrQNtggVQJ
         EnoghWwH1/y3h2N8Gd3EWr0jouHx7TJQyoC3MFEuZ1Aaoo33R4d+zD4PSsqgCSZfjHzA
         fPvw==
X-Gm-Message-State: ACgBeo2384SJp7YId0o3iISMZXWYwRQUDyxt5kUXZqVIPm29+uUtlPbJ
	04+3/DQXtARsLga7ITabWa60q1LNWlhz/uvWbHTYeUqxeGPSA47FOfYq+TUbnGdNqsacDy/UtI3
	Jpnbq3+9lzzxXq1Y=
X-Received: by 2002:a05:600c:548a:b0:3b3:21b1:20ca with SMTP id iv10-20020a05600c548a00b003b321b120camr4021836wmb.77.1662707983199;
        Fri, 09 Sep 2022 00:19:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4F5Cylfv8K6BRb3rTviXbFDOrt/+9tbv+5onKkEX6UVWSB0MHJA3hW4AJ/fwLd1cKGNPHTyQ==
X-Received: by 2002:a05:600c:548a:b0:3b3:21b1:20ca with SMTP id iv10-20020a05600c548a00b003b321b120camr4021817wmb.77.1662707982830;
        Fri, 09 Sep 2022 00:19:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id g15-20020adffc8f000000b00228692033dcsm1131549wrr.91.2022.09.09.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:19:42 -0700 (PDT)
Message-ID: <1a260c2c486c2c4bf60c7f953a17c820d4e8b4bc.camel@redhat.com>
Subject: Re: net: mptcp: mptcp selftest cause page_counter underflow
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, mptcp@lists.linux.dev, Mengen Sun
	 <mengensun@tencent.com>, Biao Jiang <benbjiang@tencent.com>
Date: Fri, 09 Sep 2022 09:19:40 +0200
In-Reply-To: <CADxym3aTrj_0ETtHzZg38y=JjOdNz+arYaCYTaHuhSvg+8rUhw@mail.gmail.com>
References: <CADxym3aTrj_0ETtHzZg38y=JjOdNz+arYaCYTaHuhSvg+8rUhw@mail.gmail.com>
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

On Fri, 2022-09-09 at 13:05 +0800, Menglong Dong wrote:
> Hello,
> 
> I find a kernel warning when I run mptcp selftest with
> following print:
> 
> [  138.448383] ------------[ cut here ]------------
> [  138.448386] page_counter underflow: -4294952882 nr_pages=4294967289
> [  138.448396] WARNING: CPU: 36 PID: 13372 at mm/page_counter.c:56
> page_counter_uncharge+0x68/0x80
> [  138.448403] Modules linked in: nft_tproxy nf_tproxy_ipv6
> nf_tproxy_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 ipt_REJECT
> nf_reject_ipv4 sch_netem xt_mark veth tcp_diag udp_diag inet_diag tun
> nf_conntrack_netlink xt_addrtype nft_compat overlay binfmt_misc
> squashfs edac_core crc32_pclmul ghash_clmulni_intel aesni_intel
> crypto_simd cryptd virtio_balloon drm i2c_core backlight fuse autofs4
> btrfs blake2b_generic zstd_compress multipath crc32c_intel sr_mod
> cdrom floppy
> [  138.448429] CPU: 36 PID: 13372 Comm: mptcp_connect Kdump: loaded
> Not tainted 6.0.0-rc2-0008+ #60
> [  138.448431] Hardware name: Tencent Cloud CVM, BIOS
> seabios-1.9.1-qemu-project.org 04/01/2014
> [  138.448432] RIP: 0010:page_counter_uncharge+0x68/0x80
> [  138.448435] Code: 5b 41 5c 41 5d 5d e9 47 bf ee 00 80 3d 08 e4 0b
> 02 00 75 18 48 89 da 48 c7 c7 78 ea 7f 82 c6 05 f5 e3 0b 02 01 e8 6d
> 66 bd 00 <0f> 0b 49 c7 45 00 00 00 00 00 31 f6 eb b7 66 2e 0f 1f 84 00
> 00 00
> [  138.448437] RSP: 0018:ffffc9000a143b18 EFLAGS: 00010086
> [  138.448439] RAX: 0000000000000000 RBX: 00000000fffffff9 RCX: 0000000000000000
> [  138.448440] RDX: 0000000000000202 RSI: ffffffff827e53f1 RDI: 00000000ffffffff
> [  138.448441] RBP: ffffc9000a143b30 R08: 0000000000013ffb R09: 00000000ffffbfff
> [  138.448442] R10: ffffffff830760a0 R11: ffffffff830760a0 R12: ffffffff00000007
> [  138.448443] R13: ffff8881229780d0 R14: ffff8882072a0f80 R15: 00000000084072b6
> [  138.448447] FS:  00007f886f30d740(0000) GS:ffff889fbf700000(0000)
> knlGS:0000000000000000
> [  138.448449] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  138.448450] CR2: 00007ffd8d488478 CR3: 0000000132088000 CR4: 00000000003506e0
> [  138.448451] Call Trace:
> [  138.448453]  <TASK>
> [  138.448456]  drain_stock+0x43/0xc0
> [  138.448459]  __refill_stock+0x62/0x90
> [  138.448461]  mem_cgroup_uncharge_skmem+0x4e/0x90
> [  138.448463]  __sk_mem_reduce_allocated+0x12e/0x1b0
> [  138.448467]  __mptcp_update_rmem+0x8e/0xb0
> [  138.448470]  mptcp_release_cb+0x23a/0x320
> [  138.448473]  release_sock+0x48/0xa0
> [  138.448475]  mptcp_recvmsg+0x448/0xb70
> [  138.448478]  ? balance_dirty_pages_ratelimited+0x10/0x20
> [  138.448481]  ? generic_perform_write+0x13c/0x1f0
> [  138.448484]  inet_recvmsg+0x120/0x130
> [  138.448488]  sock_recvmsg+0x6e/0x80
> [  138.448490]  sock_read_iter+0x8f/0xf0
> [  138.448492]  vfs_read+0x29f/0x2d0
> [  138.448495]  ksys_read+0xb9/0xf0
> [  138.448497]  __x64_sys_read+0x19/0x20
> [  138.448499]  do_syscall_64+0x42/0x90
> [  138.448501]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  138.448504] RIP: 0033:0x7f886f0f9a7e
> [  138.448506] Code: c0 e9 b6 fe ff ff 50 48 8d 3d be ec 0b 00 e8 d9
> f1 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75
> 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83
> ec 28
> [  138.448507] RSP: 002b:00007ffd8d488478 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [  138.448509] RAX: ffffffffffffffda RBX: 0000000000000feb RCX: 00007f886f0f9a7e
> [  138.448510] RDX: 0000000000000feb RSI: 00007ffd8d48e550 RDI: 0000000000000003
> [  138.448511] RBP: 0000000000000003 R08: 00007f886f1f2210 R09: 00007f886f1f2260
> [  138.448512] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8d48e550
> [  138.448513] R13: 0000000000002000 R14: 0000000000000000 R15: 00007ffd8d48e550
> [  138.448516]  </TASK>
> [  138.448516] ---[ end trace 0000000000000000 ]---
> 
> It is easy to reproduce, just run mptcp_connect.sh, mptcp_sockopt.sh and
> mptcp_join.sh together.
> 
> Hmm...I'm not good at kernel memory, so someone who
> is good at this part may have a look at this problem.
> 
> You can add
> Reported-by: Menglong Dong <imagedong@tencent.com>
> when you fix this warning.

Thank you for the report. We already got a similar one from the intel
bot, but we did not find an easy way to reproduce it.

The issue should be addressed by this patch:

https://patchwork.kernel.org/project/netdevbpf/patch/20220906180404.1255873-1-matthieu.baerts@tessares.net/

Thanks,

Paolo

