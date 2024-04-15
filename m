Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09F15688A
	for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214121; cv=none; b=YH9GLbxqevfJtkq6mPIO8HVjZYeNPX4QjKLVX8ZpHLUCJZrsau5hlauL0yJFGsTV/EmC4pKjJSMLyyQgObQ1WY5c7mjRMnggtPIVwy4YiF71LaTkW4BoWA5gptzXgNp7ZzAlNGQnRZ38d0ZMofU8J99m+Pl6Kd5/uUEsr7OsGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214121; c=relaxed/simple;
	bh=TzNXW+3qOOjLSWfVwqsLUK0QkxxzzqTK58SQ6ew71K4=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=maAL+nhQtJzBBjjrAjiXEbch5/foQ/FPYo/eRRhnGiU8gyefEnHt1w0M6jHANMRtNr4Q3z7jK2kI/Yf7lmMfZjMn7FcpOayJBsgk0vQS1gS9qP+7AECXpajOWAU5DTu7ruTKL4NhzJ8J+gJu5m/ilrcUCioViaI4ypeXxjKoiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=mOgIUBzH; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="mOgIUBzH"
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SC000SZT4G6FJ00@ma-mailsvcp-mx-lapp03.apple.com> for
 mptcp@lists.linux.dev; Mon, 15 Apr 2024 13:48:33 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=TSPbjSxTqO63P1KhjVgiWsKOAWOf1tJswr67SFxYOPo=;
 b=mOgIUBzHcWNPJYV2eBW+G7k0wJN9CB0oKDUQgoZigfzi0QgDpNoSnvKYFQI4s3ldkMKx
 2uJT5cwut05+IpyV63++MmYFJYK2+2vlY6o882spNFRmQrO9tK5q691LEMRwl+ULQZoE
 O0lV5ZbooYyd36zdnjvz2OWqXm8eFWuhVjfPVl2vo1pFpwEhgnNMPDIOoSClA6UsIkl/
 cEx81d7HS+r6lg4Inaa8/WpptcJwNIT3LBExPyZ1loxTbd2qzbUvSowUgj/Hcfmss06a
 8t9BJmpv5P2JfIb8OqxqkeGjbJ/3jRAQboAdzUGBznzvpkxmH+wixUfa/fNHVmQDNsVm 6Q==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SC000A0Z4GXBEH0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Mon, 15 Apr 2024 13:48:33 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SC000V0046WAN00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 15 Apr 2024 13:48:33 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 75a69f036fc0108a34de819ffbe86eaf
X-Va-R-CD: f0ef44ea6ddacf4c0ab7cf2f7a3c1017
X-Va-ID: a40bd66b-bd07-4225-af6f-8caa63f00295
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 75a69f036fc0108a34de819ffbe86eaf
X-V-R-CD: f0ef44ea6ddacf4c0ab7cf2f7a3c1017
X-V-ID: 68513467-7973-4498-a460-677a7854593e
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
Received: from smtpclient.apple ([17.192.155.222])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SC000YA54GWHY00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 15 Apr 2024 13:48:32 -0700 (PDT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.600.21\))
Subject: Re: [PATCH mptcp-net v2] mptcp: ensure snd_una is properly initialized
 on connect
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com>
Date: Mon, 15 Apr 2024 13:48:22 -0700
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-transfer-encoding: quoted-printable
Message-id: <E329F291-4819-4D5A-AA6D-56D7DCFC184E@apple.com>
References:
 <864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3774.600.21)

Hello Paolo,

> On Apr 15, 2024, at 7:05=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> =
wrote:
>=20
> Christoph reported a splat hinting at a corrupted snd_una:
>=20
> WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 =
__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
> Modules linked in:
> CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 =
#59
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-2.el7 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
> Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
> 8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
> <0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
> RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
> RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
> R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
> FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
> Call Trace:
> <TASK>
> __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
> mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
> __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
> mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
> process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
> process_scheduled_works kernel/workqueue.c:3335 [inline]
> worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
> kthread+0x121/0x170 kernel/kthread.c:388
> ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> </TASK>
>=20
> When fallback to TCP happens early on client socket, and the mptcp
> worker (dumbly) tries mptcp-level re-injection, the snd_una is
> not yet initialized, and the worker tries to use it to clean-up
> the send buffer.
>=20
> Address the issue always initializing snd_una for active sockets
> at establish .
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous =
connect")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - moved the initialization at established time (Mat)
> - dropped debug code wrongly landed in v1
> - added fixes tag
>=20
> @Christoph: could you please add also the following chunk, for debug
> purpouse?

The issue still reproduces:

[   20.153874] ------------[ cut here ]------------
[   20.153882] MPTCP: snd_una 0 dfrag end seq d9b32cd3cf5bc831 frag len =
32728 bytes sent 3763720 acked 2759812858423158191
[   20.154574] ------------[ cut here ]------------
[   20.154498] WARNING: CPU: 1 PID: 50 at net/mptcp/protocol.c:1005 =
__mptcp_clean_una+0x10ba/0x13d0
[   20.156057] WARNING: CPU: 0 PID: 7 at net/mptcp/protocol.c:1025 =
__mptcp_clean_una+0x12dd/0x13d0
[   20.156774] Modules linked in:
[   20.157988] Modules linked in:
[   20.159157] CPU: 1 PID: 50 Comm: kworker/1:1 Not tainted =
6.9.0-rc2-g14566b183225-dirty #623
[   20.159623]
[   20.160079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.11.0-2.el7 04/01/2014
[   20.160089] Workqueue: events mptcp_worker
[   20.161349] CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted =
6.9.0-rc2-g14566b183225-dirty #623
[   20.161544]
[   20.162779] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.11.0-2.el7 04/01/2014
[   20.163265] RIP: 0010:__mptcp_clean_una+0x10ba/0x13d0
[   20.164450] Workqueue: events mptcp_worker
[   20.164661] Code: e8 4b 99 97 fd e9 60 fa ff ff 44 89 f1 80 e1 07 38 =
c1 0f 8c 67 fa ff ff 4c 89 f7 e8 40 98 97 fd e9 5a fa ff ff e8 b6 ab 4a =
fd <0f> 0b 48 8b 44 24 70 42 80 3c 30 00 74 0a 48 8b 7c 24 50 e8 ae 98
[   20.165896]
[   20.166517] RSP: 0018:ffffc9000029f900 EFLAGS: 00010293
[   20.167092] RIP: 0010:__mptcp_clean_una+0x12dd/0x13d0
[   20.169307]
[   20.169311] RAX: ffffffff83fbfaba RBX: 1ffff11021ff9003 RCX: =
ffff888100803f00
[   20.169537] Code: fc ff df e9 95 f3 ff ff 89 d9 80 e1 07 80 c1 03 38 =
c1 0f 8c d0 f3 ff ff 48 89 df e8 7d 96 97 fd e9 c3 f3 ff ff e8 93 a9 4a =
fd <0f> 0b eb 07 e8 8a a9 4a fd 0f 0b 49 be 00 00 00 00 00 fc ff df 4c
[   20.170162] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[   20.170905] RSP: 0018:ffffc90000077900 EFLAGS: 00010293
[   20.171135] RBP: ffffc9000029fa30 R08: ffffea00043ff037 R09: =
1ffffd400087fe06
[   20.172144]
[   20.174498] R10: dffffc0000000000 R11: fffff9400087fe07 R12: =
1ffff11021ff9002
[   20.175515] RAX: ffffffff83fbfcdd RBX: 0000000000000000 RCX: =
ffff8881001e5e80
[   20.176170] R13: ffff88810ffc8000 R14: dffffc0000000000 R15: =
ffff88810fa88698
[   20.177152] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[   20.177372] FS:  0000000000000000(0000) GS:ffff88811b300000(0000) =
knlGS:0000000000000000
[   20.178393] RBP: ffffc90000077a30 R08: ffffc90000077647 R09: =
1ffff9200000eec8
[   20.179273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.180272] R10: dffffc0000000000 R11: fffff5200000eec9 R12: =
1ffff110207660b1
[   20.181222] CR2: 00000000203c6000 CR3: 0000000103804004 CR4: =
0000000000170ef0
[   20.182340] R13: ffff888103b30588 R14: ffff88810fbf8000 R15: =
264cd32c30a4b7a7
[   20.183232] Call Trace:
[   20.184059] FS:  0000000000000000(0000) GS:ffff88811b200000(0000) =
knlGS:0000000000000000
[   20.184949]  <TASK>
[   20.185950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.186842]  ? __warn+0x161/0x3e0
[   20.187222] CR2: 00000000203c6000 CR3: 00000001038ba005 CR4: =
0000000000170ef0
[   20.188212]  ? __mptcp_clean_una+0x10ba/0x13d0
[   20.188566] Call Trace:
[   20.189286]  ? report_bug+0x473/0x660
[   20.189782]  <TASK>
[   20.190613]  ? __mptcp_clean_una+0x10ba/0x13d0
[   20.191246]  ? __warn+0x161/0x3e0
[   20.191595]  ? handle_bug+0x3d/0x80
[   20.192121]  ? __mptcp_clean_una+0x12dd/0x13d0
[   20.192396]  ? exc_invalid_op+0x1a/0x50
[   20.193022]  ? report_bug+0x473/0x660
[   20.193432]  ? asm_exc_invalid_op+0x1a/0x20
[   20.193942]  ? __mptcp_clean_una+0x12dd/0x13d0
[   20.194533]  ? __mptcp_clean_una+0x10ba/0x13d0
[   20.195097]  ? handle_bug+0x3d/0x80
[   20.195575]  ? __mptcp_clean_una+0x10ba/0x13d0
[   20.196171]  ? exc_invalid_op+0x1a/0x50
[   20.196724]  ? __pfx___mptcp_clean_una+0x10/0x10
[   20.197358]  ? asm_exc_invalid_op+0x1a/0x20
[   20.197799]  ? preempt_count_add+0x93/0x190
[   20.198444]  ? __mptcp_clean_una+0x12dd/0x13d0
[   20.198989]  ? __vmap_pages_range_noflush+0xc0e/0xc30
[   20.199668]  ? __mptcp_clean_una+0x12dd/0x13d0
[   20.200177]  __mptcp_retrans+0x105/0x12b0
[   20.200797]  ? __enqueue_entity+0x25e/0x4f0
[   20.201332]  ? __local_bh_enable_ip+0x58/0x80
[   20.202042]  ? __pfx___mptcp_clean_una+0x10/0x10
[   20.202605]  ? lock_sock_nested+0x258/0x320
[   20.203188]  __mptcp_retrans+0x105/0x12b0
[   20.203750]  ? mptcp_check_data_fin+0x2e7/0x840
[   20.204396]  ? __local_bh_enable_ip+0x58/0x80
[   20.204949]  ? __pfx___mptcp_retrans+0x10/0x10
[   20.205548]  ? lock_sock_nested+0x258/0x320
[   20.206037]  ? mm_cid_get+0xb5/0x700
[   20.206706]  ? mptcp_check_data_fin+0x2e7/0x840
[   20.207222]  mptcp_worker+0xe00/0x1790
[   20.207863]  ? __pfx___mptcp_retrans+0x10/0x10
[   20.208421]  ? __pfx_mptcp_worker+0x10/0x10
[   20.208940]  ? update_load_avg+0x50f/0x1910
[   20.209629]  ? kick_pool+0x16b/0x5d0
[   20.210163]  mptcp_worker+0xe00/0x1790
[   20.210711]  ? read_word_at_a_time+0xe/0x20
[   20.211310]  ? __pfx_mptcp_worker+0x10/0x10
[   20.211866]  ? sized_strscpy+0x8c/0x220
[   20.212388]  ? kick_pool+0x16b/0x5d0
[   20.212866]  process_scheduled_works+0x74e/0xfb0
[   20.213502]  ? read_word_at_a_time+0xe/0x20
[   20.214012]  worker_thread+0xb79/0x11d0
[   20.214563]  ? sized_strscpy+0x8c/0x220
[   20.215018]  kthread+0x298/0x330
[   20.215673]  process_scheduled_works+0x74e/0xfb0
[   20.216233]  ? __pfx_worker_thread+0x10/0x10
[   20.216829]  worker_thread+0xb79/0x11d0
[   20.217341]  ? __pfx_kthread+0x10/0x10
[   20.217820]  kthread+0x298/0x330
[   20.218401]  ret_from_fork+0x4e/0x80
[   20.219020]  ? __pfx_worker_thread+0x10/0x10
[   20.219515]  ? __pfx_kthread+0x10/0x10
[   20.220049]  ? __pfx_kthread+0x10/0x10
[   20.220445]  ret_from_fork_asm+0x1a/0x30
[   20.220952]  ret_from_fork+0x4e/0x80
[   20.221513]  </TASK>
[   20.222051]  ? __pfx_kthread+0x10/0x10
[   20.222507] ---[ end trace 0000000000000000 ]---
[   20.223069]  ret_from_fork_asm+0x1a/0x30
[   20.223501] MPTCP: snd_una 0 dfrag end seq 817baffcc5438272 frag len =
32728 bytes sent 3763720 acked 9116499520509078382
[   20.223854]  </TASK>
[   20.227837] ---[ end trace 0000000000000000 ]---
[   20.426084] MPTCP: snd_una 0 dfrag end seq 817baffcc5438272 frag len =
32728 bytes sent 3763720 acked 9116499520509078382
[   20.433870] MPTCP: snd_una 0 dfrag end seq d9b32cd3cf5bc831 frag len =
32728 bytes sent 3763720 acked 2759812858423158191
[   20.633862] MPTCP: snd_una 0 dfrag end seq 817baffcc5438272 frag len =
32728 bytes sent 3763720 acked 9116499520509078382



Christoph


>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3e1b15d76442..46fd84697495 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1002,8 +1002,12 @@ static void __mptcp_clean_una(struct sock *sk)
>=20
>                if (unlikely(dfrag =3D=3D msk->first_pending)) {
>                        /* in recovery mode can see ack after the =
current snd head */
> -                       if (WARN_ON_ONCE(!msk->recovery))
> +                       if (WARN_ON_ONCE(!msk->recovery)) {
> +                               pr_err("snd_una %llx dfrag end seq =
%llx frag len %d bytes sent %lld acked %lld",
> +                                       msk->snd_una, dfrag->data_seq =
+ dfrag->data_len, dfrag->data_len,
> +                                       msk->bytes_sent, =
msk->bytes_acked);
>                                break;
> +                       }
>=20
>                        WRITE_ONCE(msk->first_pending, =
mptcp_send_next(sk));
>                }
> ---
> net/mptcp/subflow.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b94d1dca1094..25004473e7ef 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -475,12 +475,12 @@ static void mptcp_propagate_state(struct sock =
*sk, struct sock *ssk,
> struct mptcp_sock *msk =3D mptcp_sk(sk);
>=20
> mptcp_data_lock(sk);
> + WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
> + WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
> if (mp_opt) {
> /* Options are available only in the non fallback cases
> * avoid updating rx path fields otherwise
> */
> - WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
> - WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
> subflow_set_remote_key(msk, subflow, mp_opt);
> }
>=20
> --=20
> 2.43.2
>=20
>=20

