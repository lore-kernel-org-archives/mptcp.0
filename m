Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4D223313
	for <mptcp@lists.linux.dev>; Fri, 16 May 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401200; cv=none; b=HeEc1ECcoJiDi3aGS9L/uZoMFxiRK20GA0C9kZzvcY8tmJrfL9Srdy96HyY93XYGLAHZObDO+21dfFb4HH1H6mU2AgdvLcIHrlqtAzc/zlFEYfNFVEcM6y9PHtm87jexueQpIP52ilD2oytJSyt51+YraJlD85JeUrXfJbfMqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401200; c=relaxed/simple;
	bh=HFQgM6ugAVl4owkeQNThWUF6C8cZwOX59uai8tO2eIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XtHm0exZZnfpjv5af9HJloY1K+hM191AQwOaNkpqUY/SW5ybLdu3xIJv4afjh+e6Lb+iu+kxRWjyzD8lXhJvop3KuzoVufGNt/6lKw0eMQnMiBexvyQFuW9f9RN1Zi6z6mFDl7We5oM6/OjIGV2JRhf7Ajs5+ninPjMl8d5lWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX756T7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX756T7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C65CC4CEE4;
	Fri, 16 May 2025 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747401199;
	bh=HFQgM6ugAVl4owkeQNThWUF6C8cZwOX59uai8tO2eIg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HX756T7qRmQP/124qZS5zulWzWBvLa9qr8/YjymsFBS/aNDEHr9e6+9AgPieRMXh/
	 lgyYAbeY8Aiik0XxBri1gXmzcdtCCCY2g9Y+e+eV/E5pav7f2uG9ECikM6dJr2wGF7
	 eRNVKzVOFJtPT3m4meK/5MtYz6/BggwWO9fcLiXai87TPoBSJTATfQ2SSyxoM4fghk
	 Dg5BGxOu36fdxovPqr5mvJ3J4QAdvifzi/JsP3OKI12Pg+nqX8PZmeBaAB9dRBekzD
	 ez9mbHODFU+mZ4YUydmKIOOCQr1H0g/rK5ATRq6iddr9zePJ1ILc6IirdtcHqMHZvT
	 7a6yAzE4ZACIQ==
Message-ID: <bf6fa4e7-0f52-4ccf-847b-3cf0f4775b45@kernel.org>
Date: Fri, 16 May 2025 15:13:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_do_fallback
Content-Language: en-GB, fr-BE
To: syzbot <syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com>,
 geliang@kernel.org, martineau@kernel.org, mptcp@lists.linux.dev,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <67ddd191.050a0220.25ae54.006b.GAE@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <67ddd191.050a0220.25ae54.006b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

(keeping only MPTCP and syzbot people, to reduce the noise)

On 21/03/2025 21:52, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a7f2e10ecd8f Merge tag 'hwmon-fixes-for-v6.14-rc8/6.14' of..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101d1e98580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
> dashboard link: https://syzkaller.appspot.com/bug?extid=5cf807c20386d699b524
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a7f2e10e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d3ebf10742dc/vmlinux-a7f2e10e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ec059da4f420/bzImage-a7f2e10e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5347 at net/mptcp/protocol.h:1202 __mptcp_do_fallback net/mptcp/protocol.h:1202 [inline]
> WARNING: CPU: 0 PID: 5347 at net/mptcp/protocol.h:1202 mptcp_do_fallback+0x244/0x360 net/mptcp/protocol.h:1223
> Modules linked in:
> CPU: 0 UID: 0 PID: 5347 Comm: syz.0.0 Not tainted 6.14.0-rc7-syzkaller-00074-ga7f2e10ecd8f #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__mptcp_do_fallback net/mptcp/protocol.h:1202 [inline]
> RIP: 0010:mptcp_do_fallback+0x244/0x360 net/mptcp/protocol.h:1223
> Code: 1c cd f5 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 cb 1c cd f5 90 0f 0b 90 e9 5b fe ff ff e8 bd 1c cd f5 90 <0f> 0b 90 e9 e1 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 1e fe ff
> RSP: 0018:ffffc9000d4b75b8 EFLAGS: 00010293
> RAX: ffffffff8bf4c3c3 RBX: ffff888053250930 RCX: ffff888000d7a440
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff8bf4c283 R09: 1ffff1100a64a126
> R10: dffffc0000000000 R11: ffffed100a64a127 R12: ffff888053250948
> R13: dffffc0000000000 R14: ffff888042efd940 R15: ffff888053250000
> FS:  00007f03895756c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0389574fe0 CR3: 0000000042c44000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  subflow_finish_connect+0x462/0x14e0 net/mptcp/subflow.c:548
>  tcp_finish_connect+0xc4/0x620 net/ipv4/tcp_input.c:6343
>  tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6573 [inline]
>  tcp_rcv_state_process+0x26aa/0x44e0 net/ipv4/tcp_input.c:6794
>  tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1941
>  sk_backlog_rcv include/net/sock.h:1122 [inline]
>  __release_sock+0x214/0x350 net/core/sock.c:3123
>  release_sock+0x61/0x1f0 net/core/sock.c:3677
>  mptcp_connect+0x86b/0xc30 net/mptcp/protocol.c:3810
>  __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:677
>  inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:748
>  __sys_connect_file net/socket.c:2045 [inline]
>  __sys_connect+0x288/0x2d0 net/socket.c:2064
>  __do_sys_connect net/socket.c:2070 [inline]
>  __se_sys_connect net/socket.c:2067 [inline]
>  __x64_sys_connect+0x7a/0x90 net/socket.c:2067
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f038878d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0389575038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 00007f03889a6160 RCX: 00007f038878d169
> RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000005
> RBP: 00007f038880e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f03889a6160 R15: 00007ffcae617168
>  </TASK>

I suggest closing this one: syzbot only saw it once in ~2 months, and my
syzbot machines, using different kernel config and targetting mainly
MPTCP, didn't manage to reproduce it either.

An analysis has been started there:

  https://github.com/multipath-tcp/mptcp_net-next/issues/555

Note that the warning is there because mptcp_do_fallback() should not be
called twice for the same MPTCP socket, but the code is supposed to
handle that case anyway, just in case. So no critical issue here I
guess. Let's close it. If we can reproduce it later, we can continue the
analysis started on the ticket #555.

#syz invalid

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

