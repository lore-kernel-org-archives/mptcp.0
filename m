Received: from rn-mailsvcp-mx-lapp03.apple.com (rn-mailsvcp-mx-lapp03.apple.com [17.179.253.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BBA7CF1B
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.179.253.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122292; cv=none; b=T3vgp5oqYV+/4Zq0jDCH4rkmyL+3Tj87oyYVsE2UU185deZ2md6dmeg4qx6MJGqg2kbEeYId5Dg+slQutrxlxmXV+f+i9tWTcWkGLnqZ1N840dITFNq23rkT6/+0bxTZuNrFhZcww9yw2IkRhTF5mk4uW5jCjeJSEzHUw9fyhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122292; c=relaxed/simple;
	bh=XGsM9iSdlt6U7JcQ0/fanVVKii3kqRDT+sueRVxPh7g=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=aPoXCA8vpe/70nt622gW9TFiwjBmAbhTbVKK7614VtF54nN8dfHKIXgXZour3IOsTolwoIRuhZAbW6V9Mxa5es5fvYfVpJ2bGL0ldrXVJPphMUkQYwuvvMA3mACODrK+e4zdzK4452+GdKWbp0up2OA4N5q7UnfRnIV0gNwojFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=drKtXr3v; arc=none smtp.client-ip=17.179.253.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="drKtXr3v"
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by rn-mailsvcp-mx-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S7S00PC11LM4Q10@rn-mailsvcp-mx-lapp03.rno.apple.com>
 for mptcp@lists.linux.dev; Wed, 24 Jan 2024 09:51:24 -0800 (PST)
X-Proofpoint-GUID: HU0W9UZTdNOaeefGvOkEXPmb2QQ96r08
X-Proofpoint-ORIG-GUID: HU0W9UZTdNOaeefGvOkEXPmb2QQ96r08
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.1011
 definitions=2024-01-24_07:2024-01-24,2024-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=EfUuAClhXUuC2Bl/JrYm0/q0E8lRYZknzdlXYr1ZemM=;
 b=drKtXr3vUstm4kbllUp4q2ar6LAg8Nl8y+Psbf2d4K4zKRSXdJK80+6OVOx5qYcwP/aN
 eUsd2EVdmL8u3ZfHa24gFeRaUVCezI8HdwX3yY4F3R2YRGag0jy5Dx7w7VUf25dJuldw
 dSEkrzXgpCM51Pys9L/TuSB0czcK7SwGV5fCB0rVpW2rI298sXUAYkv4oXS0mWb8Z65Y
 5vSuqZ/MU2aWAz5pOO3h/2Kz+DodY+0yorQbQOfxkSK0xMXl0BDI1AoVbkjpcnjmcshK
 D44DXA9qJOZzHOflUlB6gn9meKsjBXjwDKE9OYPiN3SIegP+C28qG6gt3i67cB/2zrkC pA==
Received: from rn-mailsvcp-mmp-lapp02.rno.apple.com
 (rn-mailsvcp-mmp-lapp02.rno.apple.com [17.179.253.15])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S7S00QX61LNB3C0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Wed, 24 Jan 2024 09:51:23 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp02.rno.apple.com by
 rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S7S006001IPMC00@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Wed,
 24 Jan 2024 09:51:23 -0800 (PST)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 065f87e5e5db2bf8991102f07c5e0146
X-Va-R-CD: 874dbe7a0fa0efb713c0b51e6333f147
X-Va-ID: c2d5f5e8-2178-427c-becc-febdee163a24
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 065f87e5e5db2bf8991102f07c5e0146
X-V-R-CD: 874dbe7a0fa0efb713c0b51e6333f147
X-V-ID: 6be3f9e5-9cbc-46f5-8534-4594b21bd495
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.1011
 definitions=2024-01-24_07:2024-01-24,2024-01-24 signatures=0
Received: from smtpclient.apple ([17.192.155.119])
 by rn-mailsvcp-mmp-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S7S002M81LML000@rn-mailsvcp-mmp-lapp02.rno.apple.com>; Wed,
 24 Jan 2024 09:51:23 -0800 (PST)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH mptcp-stable] mptcp: introduce explicit flag for first
 subflow disposal
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com>
Date: Wed, 24 Jan 2024 09:51:12 -0800
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <9B692AAE-74A8-4101-9CDA-2580FCBAC7F0@apple.com>
References:
 <a1503ab571c8c076de62b872437d220a2260d2a5.1706094997.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hello Paolo,

> On Jan 24, 2024, at 3:35=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> =
wrote:
>=20
> This is a partial backport of the upstram commit 39880bd808ad ("mptcp:
> get rid of msk->subflow"). It's partial to avoid a long a complex
> dependency chain not suitable for stable.
>=20
> The only bit remaning from the original commit is the introduction of =
a
> new field avoid a race at close time causing an UaF:
>=20
> BUG: KASAN: use-after-free in mptcp_subflow_queue_clean+0x2c9/0x390 =
include/net/mptcp.h:104
> Read of size 1 at addr ffff88803bf72884 by task syz-executor.6/23092
>=20
> CPU: 0 PID: 23092 Comm: syz-executor.6 Not tainted =
6.1.65-gc6114c845984 #50
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-2.el7 04/01/2014
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x125/0x18f lib/dump_stack.c:106
> print_report+0x163/0x4f0 mm/kasan/report.c:284
> kasan_report+0xc4/0x100 mm/kasan/report.c:495
> mptcp_subflow_queue_clean+0x2c9/0x390 include/net/mptcp.h:104
> mptcp_check_listen_stop+0x190/0x2a0 net/mptcp/protocol.c:3009
> __mptcp_close+0x9a/0x970 net/mptcp/protocol.c:3024
> mptcp_close+0x2a/0x130 net/mptcp/protocol.c:3089
> inet_release+0x13d/0x190 net/ipv4/af_inet.c:429
> sock_close+0xcf/0x230 net/socket.c:652
> __fput+0x3a2/0x870 fs/file_table.c:320
> task_work_run+0x24e/0x300 kernel/task_work.c:179
> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> exit_to_user_mode_loop+0xa4/0xc0 kernel/entry/common.c:171
> exit_to_user_mode_prepare+0x51/0x90 kernel/entry/common.c:204
> syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:286
> do_syscall_64+0x53/0xa0 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x64/0xce
> RIP: 0033:0x41d791
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 74 2a 00 00 =
c3 48 83 ec 08 e8 9a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b =
3c 24 48 89 c2 e8 e3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00000000008bfb90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 000000000041d791
> RDX: 0000001b33920000 RSI: ffffffff8139adff RDI: 0000000000000003
> RBP: 000000000079d980 R08: 0000001b33d20000 R09: 0000000000000951
> R10: 000000008139a955 R11: 0000000000000293 R12: 00000000000c739b
> R13: 000000000079bf8c R14: 00007fa301053000 R15: 00000000000c705a
> </TASK>
>=20
> Allocated by task 22528:
> kasan_save_stack mm/kasan/common.c:45 [inline]
> kasan_set_track+0x40/0x70 mm/kasan/common.c:52
> ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> __kasan_kmalloc+0xa0/0xb0 mm/kasan/common.c:383
> kasan_kmalloc include/linux/kasan.h:211 [inline]
> __do_kmalloc_node mm/slab_common.c:955 [inline]
> __kmalloc+0xaa/0x1c0 mm/slab_common.c:968
> kmalloc include/linux/slab.h:558 [inline]
> sk_prot_alloc+0xac/0x200 net/core/sock.c:2038
> sk_clone_lock+0x56/0x1090 net/core/sock.c:2236
> inet_csk_clone_lock+0x26/0x420 net/ipv4/inet_connection_sock.c:1141
> tcp_create_openreq_child+0x30/0x1910 net/ipv4/tcp_minisocks.c:474
> tcp_v6_syn_recv_sock+0x413/0x1a90 net/ipv6/tcp_ipv6.c:1283
> subflow_syn_recv_sock+0x621/0x1300 net/mptcp/subflow.c:730
> tcp_get_cookie_sock+0xf0/0x5f0 net/ipv4/syncookies.c:201
> cookie_v6_check+0x130f/0x1c50 net/ipv6/syncookies.c:261
> tcp_v6_do_rcv+0x7e0/0x12b0 net/ipv6/tcp_ipv6.c:1147
> tcp_v6_rcv+0x2494/0x2f50 net/ipv6/tcp_ipv6.c:1743
> ip6_protocol_deliver_rcu+0xba3/0x1620 net/ipv6/ip6_input.c:438
> ip6_input+0x1bc/0x470 net/ipv6/ip6_input.c:483
> ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:302
> __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5525
> process_backlog+0x353/0x660 net/core/dev.c:5967
> __napi_poll+0xc6/0x5a0 net/core/dev.c:6534
> net_rx_action+0x652/0xea0 net/core/dev.c:6601
> __do_softirq+0x176/0x525 kernel/softirq.c:571
>=20
> Freed by task 23093:
> kasan_save_stack mm/kasan/common.c:45 [inline]
> kasan_set_track+0x40/0x70 mm/kasan/common.c:52
> kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:516
> ____kasan_slab_free+0x13a/0x1b0 mm/kasan/common.c:236
> kasan_slab_free include/linux/kasan.h:177 [inline]
> slab_free_hook mm/slub.c:1724 [inline]
> slab_free_freelist_hook mm/slub.c:1750 [inline]
> slab_free mm/slub.c:3661 [inline]
> __kmem_cache_free+0x1eb/0x340 mm/slub.c:3674
> sk_prot_free net/core/sock.c:2074 [inline]
> __sk_destruct+0x4ad/0x620 net/core/sock.c:2160
> tcp_v6_rcv+0x269c/0x2f50 net/ipv6/tcp_ipv6.c:1761
> ip6_protocol_deliver_rcu+0xba3/0x1620 net/ipv6/ip6_input.c:438
> ip6_input+0x1bc/0x470 net/ipv6/ip6_input.c:483
> ipv6_rcv+0xef/0x2c0 include/linux/netfilter.h:302
> __netif_receive_skb+0x1ea/0x6a0 net/core/dev.c:5525
> process_backlog+0x353/0x660 net/core/dev.c:5967
> __napi_poll+0xc6/0x5a0 net/core/dev.c:6534
> net_rx_action+0x652/0xea0 net/core/dev.c:6601
> __do_softirq+0x176/0x525 kernel/softirq.c:571
>=20
> The buggy address belongs to the object at ffff88803bf72000
> which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 2180 bytes inside of
> 4096-byte region [ffff88803bf72000, ffff88803bf73000)
>=20
> The buggy address belongs to the physical page:
> page:00000000a72e4e51 refcount:1 mapcount:0 mapping:0000000000000000 =
index:0x0 pfn:0x3bf70
> head:00000000a72e4e51 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)
> raw: 0100000000010200 ffffea0000a0ea00 dead000000000002 =
ffff888100042140
> raw: 0000000000000000 0000000000040004 00000001ffffffff =
0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
> ffff88803bf72780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88803bf72800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff88803bf72880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                   ^
> ffff88803bf72900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88803bf72980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>=20
> Prevent the MPTCP worker from freeing the first subflow for unaccepted
> socket when such sockets transition to TCP_CLOSE state, and let that
> happen at accept() or listener close() time.
>=20
> Fixes: b6985b9b8295 ("mptcp: use the workqueue to destroy unaccepted =
sockets")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This is targeting _stable_ and specifically 6.1.65.
> I tested vs the repro in:
>=20
> https://github.com/multipath-tcp/mptcp_net-next/issues/466
>=20
> and WFM. @Christoph could you please validate this in your testbed, =
too?

Yes, this fixes both #466 and #465.

I=E2=80=99m updating syzkaller and if it=E2=80=99s happy I can push it =
to upstream.


Thanks a lot!

Christoph

>=20
> If pass the testing it would be great if you could take over the
> upstream submission.
>=20
> The hash blamed above is the upstream/vanilla. I'm unsure if it's more
> relevant to tag the corresponding stable one
> ---
> net/mptcp/protocol.c | 9 ++++-----
> net/mptcp/protocol.h | 3 ++-
> 2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 76539d1004eb..db5369b6442d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2422,7 +2422,7 @@ static void __mptcp_close_ssk(struct sock *sk, =
struct sock *ssk,
> 		goto out_release;
> 	}
>=20
> -	dispose_it =3D !msk->subflow || ssk !=3D msk->subflow->sk;
> +	dispose_it =3D msk->free_first || ssk !=3D msk->first;
> 	if (dispose_it)
> 		list_del(&subflow->node);
>=20
> @@ -2440,7 +2440,6 @@ static void __mptcp_close_ssk(struct sock *sk, =
struct sock *ssk,
> 	need_push =3D (flags & MPTCP_CF_PUSH) && =
__mptcp_retransmit_pending_data(sk);
> 	if (!dispose_it) {
> 		__mptcp_subflow_disconnect(ssk, subflow, flags);
> -		msk->subflow->state =3D SS_UNCONNECTED;
> 		release_sock(ssk);
>=20
> 		goto out;
> @@ -3341,10 +3340,10 @@ static void mptcp_destroy(struct sock *sk)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
>=20
> -	/* clears msk->subflow, allowing the following to close
> -	 * even the initial subflow
> -	 */
> 	mptcp_dispose_initial_subflow(msk);
> +
> +	/* allow the following to close even the initial subflow */
> +	msk->free_first =3D 1;
> 	mptcp_destroy_common(msk, 0);
> 	sk_sockets_allocated_dec(sk);
> }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4ec8e0a81b5a..e5d553dfc13f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -287,7 +287,8 @@ struct mptcp_sock {
> 			cork:1,
> 			nodelay:1,
> 			fastopening:1,
> -			in_accept_queue:1;
> +			in_accept_queue:1,
> +			free_first:1;
> 	struct work_struct work;
> 	struct sk_buff  *ooo_last_skb;
> 	struct rb_root  out_of_order_queue;
> --=20
> 2.43.0
>=20
>=20

