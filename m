Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585C24A7C6
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049113; cv=none; b=HTnI12pgPIh6NMAnXcnm1gBhJ3ZBGIfk1dRARKNJwnGyLWkxYzAVlixcpnYA6I8+E1u4+KT8US2yiBncqsiC7VcmQShdJ6KiCZZpLdPCzyyomXmWqFX2pvHu+pWAw6lU0S28+bP6eJ/lDsTI5WHNxiSkNRwpDpZks2h6qUah5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049113; c=relaxed/simple;
	bh=ewcQtf+ENUYeuMqUhhIvKEebdy7IXJOo4INWI8BgmXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oPQUmJRNR4nqAyvyeYfj9GVy+Zr++fn8gVpF1nl7ZCsN54a4KevuVf8gTLdwrPrrBCTe+aieJzLZ5qHxdK3/f5Bzi8edS0fda4X0OLp3L1zAb4+oWG5xOTBoVFP4/xIkU4Z5Ojnbxlpxj1IkhiOKK5Y2tbrq58ikYj0Hx5cD0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWCqJPcn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWCqJPcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737049110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LZkMhqGs3WN5Nez6mNT/CmbATYYmf5QPhReWlnERyyw=;
	b=hWCqJPcnpn0pqLnB3/go+hkhMZjkqDleL5OOSi5p1KYqEhzbhHC6sSzWEVS1cYPrnNmoI0
	z7XS+9AGUYUujBC5srRyX0LgXN2Tt+rWQRoAqtqiRwIrdqEGOsuFdrcBrP7u5x92vXCOBn
	gpn22PEekiEf8/bl7TILm4FoxvnmImw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-qyCpCMZ9Pc6fzzI5oSQxNw-1; Thu, 16 Jan 2025 12:38:28 -0500
X-MC-Unique: qyCpCMZ9Pc6fzzI5oSQxNw-1
X-Mimecast-MFC-AGG-ID: qyCpCMZ9Pc6fzzI5oSQxNw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385dcadffebso532769f8f.0
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 09:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737049107; x=1737653907;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4GdbAKVTKiKRveWh4v8kEmQLNGWC8jKIWFnKudm0VRE=;
        b=ltPn13N8xk84KKYtW2Pu2XHOEU4TzAE4etwYU35zo4+K72oQZy/TxCd322i2iTsXw1
         Np46DHmYgxooPXWvL+KxX7hRR609zNPl8G8Ib5hoM8my8+DD3FIq64ZJd7md+IV7fBEa
         R9f6ptDGpcZ2Q/t/LFecBsCVNsFPRTitspdB3FPNehi1mSo/Yw1HHd2jXJRrzO+nqdxW
         uE4lYGcyJ6eCbeRIbKfTP9tvtywfi0mnQl/jANlQ+hib6JMwlz6OsLcgvTE0AbCIfF1J
         MO7XsdO4YABhpbrbrofFoKUO7ey7mmW1nJRlUxxhJWlmGS9AP7ben2ku7M0jGk+8+cH0
         ywqA==
X-Forwarded-Encrypted: i=1; AJvYcCW2zO2vMdrTgso0pQckef/oPzkozexgfu6z+cRnp7RgnBYjak5eIQr7oEmZsyHCuopE1r12ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUlBivvhu4JZbXrt/1f/QY5gRrhIXANR9OMIv2Urc6mb+3Fx3b
	3wezH7ZmoBtHz+N4PXUDPyUFd/x6sW+Y0XAjk9+TOwpYlOtgzkyR+YAGLc+feVaq6Znl//5RSps
	qCGPOCzRNxe8nTF+3DvHxo3gTs2JXCyTC/kLOU6/7hvlYUzVbsNa+fgk4BZwo
X-Gm-Gg: ASbGncvOOD3qfprEYaC3W4sb/NcP1Tk8vQHC2fbuTWdrPLE9P7STe1ddZK9ADC8SpQ/
	9zQWnhA6v40f8Ix4yXOoMrWNbtQBhvfOcB4vwYSZ29WHrhsj3JpZVhfVwOreT1fUhuejclAVwA7
	jlvGdD02B3TPakSWWZU1iDRMwA6RsQUZQXpTr/aONCvzouxO2ReoIheYTDDGl/FnJoG6Ep0PAm7
	o6dJ1MFNkY2NNlCeCtG4IAzRnr3/oYPjP6BSoLOXnIDzu5g1L5qOoIYTALB+PaocYdAZy5XPDI/
	iyuEvD1NalU=
X-Received: by 2002:a5d:648b:0:b0:386:3e3c:ef1 with SMTP id ffacd0b85a97d-38a87312f36mr36590253f8f.35.1737049107427;
        Thu, 16 Jan 2025 09:38:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW+czCA/X5NSGjWjL3gXd2IlXUZt+HQ3xIDrUGee2V3AUDECVVNbfNRTY+BpbT/Fq8AGiKgQ==
X-Received: by 2002:a5d:648b:0:b0:386:3e3c:ef1 with SMTP id ffacd0b85a97d-38a87312f36mr36590221f8f.35.1737049106949;
        Thu, 16 Jan 2025 09:38:26 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c752910esm67929305e9.28.2025.01.16.09.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 09:38:26 -0800 (PST)
Message-ID: <1ac7d9c7-9f30-4915-ac6d-fe12b188d3b0@redhat.com>
Date: Thu, 16 Jan 2025 18:38:25 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
To: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>,
 mptcp@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <67605870.050a0220.37aaf.0137.GAE@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67605870.050a0220.37aaf.0137.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: N1jFq99xWdBmrn1DsN2BbZ8iIOiDrWNeABT6wH8JGcQ_1737049108
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------0eEBxsWJbrfDaYRGucFXg0h8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0eEBxsWJbrfDaYRGucFXg0h8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 5:42 PM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    00a5acdbf398 bpf: Fix configuration-dependent BTF function..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=148de730580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d82344580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179654f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc306c95490c/disk-00a5acdb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e17d5125ee77/vmlinux-00a5acdb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65f791a7fd14/bzImage-00a5acdb.xz
> 
> The issue was bisected to:
> 
> commit 3f83d8a77eeeb47011b990fd766a421ee64f1d73
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Thu Feb 8 18:03:51 2024 +0000
> 
>     mptcp: fix more tx path fields initialization
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d2c7e8580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d2c7e8580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d2c7e8580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
> Fixes: 3f83d8a77eee ("mptcp: fix more tx path fields initialization")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9846 at net/mptcp/protocol.c:1024 __mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
> Modules linked in:
> CPU: 0 UID: 0 PID: 9846 Comm: syz-executor351 Not tainted 6.13.0-rc2-syzkaller-00059-g00a5acdbf398 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> RIP: 0010:__mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
> Code: fa ff ff 48 8b 4c 24 18 80 e1 07 fe c1 38 c1 0f 8c 8e fa ff ff 48 8b 7c 24 18 e8 e0 db 54 f6 e9 7f fa ff ff e8 e6 80 ee f5 90 <0f> 0b 90 4c 8b 6c 24 40 4d 89 f4 e9 04 f5 ff ff 44 89 f1 80 e1 07
> RSP: 0018:ffffc9000c0cf400 EFLAGS: 00010293
> RAX: ffffffff8bb0dd5a RBX: ffff888033f5d230 RCX: ffff888059ce8000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000c0cf518 R08: ffffffff8bb0d1dd R09: 1ffff110170c8928
> R10: dffffc0000000000 R11: ffffed10170c8929 R12: 0000000000000000
> R13: ffff888033f5d220 R14: dffffc0000000000 R15: ffff8880592b8000
> FS:  00007f6e866496c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6e86f491a0 CR3: 00000000310e6000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __mptcp_clean_una_wakeup+0x7f/0x2d0 net/mptcp/protocol.c:1074
>  mptcp_release_cb+0x7cb/0xb30 net/mptcp/protocol.c:3493
>  release_sock+0x1aa/0x1f0 net/core/sock.c:3640
>  inet_wait_for_connect net/ipv4/af_inet.c:609 [inline]
>  __inet_stream_connect+0x8bd/0xf30 net/ipv4/af_inet.c:703
>  mptcp_sendmsg_fastopen+0x2a2/0x530 net/mptcp/protocol.c:1755
>  mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1830
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x1a6/0x270 net/socket.c:726
>  ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
>  ___sys_sendmsg net/socket.c:2637 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2669
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6e86ebfe69
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6e86649168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f6e86f491b8 RCX: 00007f6e86ebfe69
> RDX: 0000000030004001 RSI: 0000000020000080 RDI: 0000000000000003
> RBP: 00007f6e86f491b0 R08: 00007f6e866496c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6e86f491bc
> R13: 000000000000006e R14: 00007ffe445d9420 R15: 00007ffe445d9508
>  </TASK>

I can't repro the issue locally on net, please let me double check if
the bot can reply it on such a tree and additionally add report debug
info if the splat happens

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
--------------0eEBxsWJbrfDaYRGucFXg0h8
Content-Type: text/x-patch; charset=UTF-8;
 name="mptcp_clean_una_splat_debug.patch"
Content-Disposition: attachment; filename="mptcp_clean_una_splat_debug.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0L21wdGNwL3Byb3RvY29sLmMK
aW5kZXggMWIyZTdjYmI1NzdmLi4wNjczMWNmZWQzNzQgMTAwNjQ0Ci0tLSBhL25ldC9tcHRjcC9w
cm90b2NvbC5jCisrKyBiL25ldC9tcHRjcC9wcm90b2NvbC5jCkBAIC0xMDIyLDggKzEwMjIsMTQg
QEAgc3RhdGljIHZvaWQgX19tcHRjcF9jbGVhbl91bmEoc3RydWN0IHNvY2sgKnNrKQogCiAJCWlm
ICh1bmxpa2VseShkZnJhZyA9PSBtc2stPmZpcnN0X3BlbmRpbmcpKSB7CiAJCQkvKiBpbiByZWNv
dmVyeSBtb2RlIGNhbiBzZWUgYWNrIGFmdGVyIHRoZSBjdXJyZW50IHNuZCBoZWFkICovCi0JCQlp
ZiAoV0FSTl9PTl9PTkNFKCFtc2stPnJlY292ZXJ5KSkKKwkJCWlmICghbXNrLT5yZWNvdmVyeSkg
eworCQkJCXByX2Vycigic25kX3VuYSAlbGx4IHNuZF9ueHQgJWxseCB3cml0ZV9zZXEgJWxseCBp
ZHNuICVsbHggZGZyYWcgc2VxICVsbHggbGVuICVkXG4iLAorCQkJCSAgICAgICBzbmRfdW5hLCBt
c2stPnNuZF9ueHQsIG1zay0+d3JpdGVfc2VxLAorCQkJCSAgICAgICBtcHRjcF9zdWJmbG93X2N0
eChtc2stPmZpcnN0KS0+aWRzbiwKKwkJCQkgICAgICAgZGZyYWctPmRhdGFfc2VxLCBkZnJhZy0+
ZGF0YV9sZW4pOworCQkJCVdBUk5fT04oMSk7CiAJCQkJYnJlYWs7CisJCQl9CiAKIAkJCVdSSVRF
X09OQ0UobXNrLT5maXJzdF9wZW5kaW5nLCBtcHRjcF9zZW5kX25leHQoc2spKTsKIAkJfQo=
--------------0eEBxsWJbrfDaYRGucFXg0h8--

