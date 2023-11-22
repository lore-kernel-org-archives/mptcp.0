Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256D2576D
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwAeQcgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700659551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h7B2BG5nkVc2JI1Ak1gOm1h4dtSa8wuI5aIMuSiqcU=;
	b=RwAeQcgnFi8VQUC6ZV7DIaJF36nUJ6dcCG1r8uxUfqNZNKRS+ZA4SMsEUykJD6PiN7x77s
	pTGKYsPoOANSIGSW4Cw6344btSlGucgw1zqfZkMJB9D+AEqBDnmy3VZy5eeVLylOiZfU4J
	KRL2VttCL6u8DqJPGqZR3zyIu3kF1Hs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Cc18jyQ0N-Wd9xuW6Ppohg-1; Wed, 22 Nov 2023 08:25:49 -0500
X-MC-Unique: Cc18jyQ0N-Wd9xuW6Ppohg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ff9b339e8cso43498566b.1
        for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 05:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700659548; x=1701264348;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8jvIKnF6irVy4FhFGCSbAIt3a6g91RjQxYYVpcJl+8=;
        b=PdyLlhWDsjnZrGWMKexFEC4fADhBWRNcG6nUYmjraUL8vNGEdLhgSEvT653zM/xLUR
         CZBoiaIRAu+gEzTYcuYxnn4L+Sa3Ur8ad3smQTFoBPf2x1BhhNc7iDmRhgPivQozou0D
         IPgXHxUNa7yE0Sa1eIsjv7CrtLdFkmufj0r1C3A4F+FqLxMBTyfiqo8f7PTEqtxFanKK
         A+ib8sthZvrgM3lxWu3pp/6AtUuvUMoPNZuow8dVudMGF8pciCxJu1LCqUocpJCEpYHT
         rG8kyADt+p7EgIw5Z3F/pcJUSU2mI3tVcCyezrF7BogXaWlsUpz5T4CtSPmGe8OZZsfc
         aViQ==
X-Gm-Message-State: AOJu0YwwJuSC/ixGvI+c+d1pkvTKWv4s+Jy98piwLf+DKtzW9HRkInnj
	pYPJDWJomGgUaJHPpyqE8Ai4uvd9os4I0ETHMoRkOgQZPnRNoTOHWjJKBykd5R0WoB1syL9WuDC
	jrPwtOc8z9wtxygm4mypQI/c=
X-Received: by 2002:a17:906:25e:b0:a01:ae7b:d190 with SMTP id 30-20020a170906025e00b00a01ae7bd190mr1272073ejl.5.1700659548281;
        Wed, 22 Nov 2023 05:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6O4ad/JmSUoKGy+PsvKFDtEc18ubqFCn4mkQIE4lfW93xtxZ/GNoSOSIkwokNUADyc3QCwg==
X-Received: by 2002:a17:906:25e:b0:a01:ae7b:d190 with SMTP id 30-20020a170906025e00b00a01ae7bd190mr1272054ejl.5.1700659547781;
        Wed, 22 Nov 2023 05:25:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-248-230.dyn.eolo.it. [146.241.248.230])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709064a1400b009fc927023bcsm4522738eju.34.2023.11.22.05.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:25:47 -0800 (PST)
Message-ID: <0e7b905ea6f9934786df272dd6dc96e8c6786a2c.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix inconsistent state on fastopen race
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 22 Nov 2023 14:25:46 +0100
In-Reply-To: <24ff0e7e-0ed6-469f-0aff-1451b152a997@kernel.org>
References: <c753d1520719374102ea5064d3f8eac46135a165.1700050135.git.pabeni@redhat.com>
	 <24ff0e7e-0ed6-469f-0aff-1451b152a997@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-11-17 at 12:10 -0800, Mat Martineau wrote:
> On Wed, 15 Nov 2023, Paolo Abeni wrote:
>=20
> > The netlink PM can race with fastopen self-connect attempts, shutting
> > down the first subflow via:
> >=20
> > MPTCP_PM_CMD_DEL_ADDR -> mptcp_nl_remove_id_zero_address ->
> >  mptcp_pm_nl_rm_subflow_received -> mptcp_close_ssk
> >=20
> > and transitioning such subflow to FIN_WAIT1 status before the syn-ack
> > packet is processed. The MPTCP code does not react to such state change=
,
> > leaving the connection in not-fallback status and the subflow handshake
> > uncompleted, triggering the following splat:
> >=20
> > WARNING: CPU: 0 PID: 10630 at net/mptcp/subflow.c:1405 subflow_data_rea=
dy+0x39f/0x690 net/mptcp/subflow.c:1405
> > Modules linked in:
> > CPU: 0 PID: 10630 Comm: kworker/u4:11 Not tainted 6.6.0-syzkaller-14500=
-g1c41041124bd #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/09/2023
> > Workqueue: bat_events batadv_nc_worker
> > RIP: 0010:subflow_data_ready+0x39f/0x690 net/mptcp/subflow.c:1405
> > Code: 18 89 ee e8 e3 d2 21 f7 40 84 ed 75 1f e8 a9 d7 21 f7 44 89 fe bf=
 07 00 00 00 e8 0c d3 21 f7 41 83 ff 07 74 07 e8 91 d7 21 f7 <0f> 0b e8 8a =
d7 21 f7 48 89 df e8 d2 b2 ff ff 31 ff 89 c5 89 c6 e8
> > RSP: 0018:ffffc90000007448 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffff888031efc700 RCX: ffffffff8a65baf4
> > RDX: ffff888043222140 RSI: ffffffff8a65baff RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
> > R10: 000000000000000b R11: 0000000000000000 R12: 1ffff92000000e89
> > R13: ffff88807a534d80 R14: ffff888021c11a00 R15: 000000000000000b
> > FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa19a0ffc81 CR3: 000000007a2db000 CR4: 00000000003506f0
> > DR0: 000000000000d8dd DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > Call Trace:
> > <IRQ>
> > tcp_data_ready+0x14c/0x5b0 net/ipv4/tcp_input.c:5128
> > tcp_data_queue+0x19c3/0x5190 net/ipv4/tcp_input.c:5208
> > tcp_rcv_state_process+0x11ef/0x4e10 net/ipv4/tcp_input.c:6844
> > tcp_v4_do_rcv+0x369/0xa10 net/ipv4/tcp_ipv4.c:1929
> > tcp_v4_rcv+0x3888/0x3b30 net/ipv4/tcp_ipv4.c:2329
> > ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
> > ip_local_deliver_finish+0x2e4/0x510 net/ipv4/ip_input.c:233
> > NF_HOOK include/linux/netfilter.h:314 [inline]
> > NF_HOOK include/linux/netfilter.h:308 [inline]
> > ip_local_deliver+0x1b6/0x550 net/ipv4/ip_input.c:254
> > dst_input include/net/dst.h:461 [inline]
> > ip_rcv_finish+0x1c4/0x2e0 net/ipv4/ip_input.c:449
> > NF_HOOK include/linux/netfilter.h:314 [inline]
> > NF_HOOK include/linux/netfilter.h:308 [inline]
> > ip_rcv+0xce/0x440 net/ipv4/ip_input.c:569
> > __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5527
> > __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5641
> > process_backlog+0x101/0x6b0 net/core/dev.c:5969
> > __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6531
> > napi_poll net/core/dev.c:6600 [inline]
> > net_rx_action+0x956/0xe90 net/core/dev.c:6733
> > __do_softirq+0x21a/0x968 kernel/softirq.c:553
> > do_softirq kernel/softirq.c:454 [inline]
> > do_softirq+0xaa/0xe0 kernel/softirq.c:441
> > </IRQ>
> > <TASK>
> > __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:381
> > spin_unlock_bh include/linux/spinlock.h:396 [inline]
> > batadv_nc_purge_paths+0x1ce/0x3c0 net/batman-adv/network-coding.c:471
> > batadv_nc_worker+0x9b1/0x10e0 net/batman-adv/network-coding.c:722
> > process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
> > process_scheduled_works kernel/workqueue.c:2703 [inline]
> > worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
> > kthread+0x33c/0x440 kernel/kthread.c:388
> > ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> > ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > </TASK>
> >=20
> > To address the issue, catch the racing subflow state change and
> > use it to cause the MPTCP fallback. Such fallback is also used to
> > cause the first subflow state propagation to the msk socket via
> > mptcp_set_connected(). After this change, the first subflow can
> > additionally propagate the TCP_FIN_WAIT1 state, so rename the
> > helper accordingly.
> >=20
> > Finally, if the state propagation is delayed to the msk release
> > callback, the first subflow can change to a different state in between.
> > Cache the relevant target state in a new msk-level field and use
> > such value to update the msk state at release time.
> >=20
> > Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
> > Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/458
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note: we can probably avoid the splat even preventing the PM from
> > removing any address/subflow before reaching the fully established
> > status, but we still miss catching a relevant state change.
>=20
> Hi Paolo -
>=20
> It's useful to be able to remove a subflow that is unable (or slow) to=20
> connect, so I think the approach in this patch is better.
>=20
> > ---
> > net/mptcp/protocol.c |  2 +-
> > net/mptcp/protocol.h |  7 +++++--
> > net/mptcp/subflow.c  | 23 ++++++++++++++---------
> > 3 files changed, 20 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6956fde61c68..1eea04b11227 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3407,7 +3407,7 @@ static void mptcp_release_cb(struct sock *sk)
> > =09=09 * On sk release avoid actions depending on the first subflow
> > =09=09 */
> > =09=09if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags) && msk-=
>first)
> > -=09=09=09__mptcp_set_connected(sk);
> > +=09=09=09__mptcp_propagate_state(sk);
>=20
> As part of my suggestion below (adding new state as a 2nd arg), it would=
=20
> be good to clear msk->pending_state here.

I think that would not be needed, as we clear the relevant cb_flags bit
when taking action: the __test_and_clear_bit() above. Additionally
clearing pending_state would be IMHO rendundant.

>=20
> > =09=09if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> > =09=09=09__mptcp_error_report(sk);
> > =09=09if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 8529b3ae55e9..0148600e4f6d 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -296,6 +296,9 @@ struct mptcp_sock {
> > =09bool=09=09use_64bit_ack; /* Set when we received a 64-bit DSN */
> > =09bool=09=09csum_enabled;
> > =09bool=09=09allow_infinite_fallback;
> > +=09u8=09=09pending_state; /* A subflow asked to set this sk_state,
> > +=09=09=09=09=09* protected by the msk data lock
> > +=09=09=09=09=09*/
> > =09u8=09=09mpc_endpoint_id;
> > =09u8=09=09recvmsg_inq:1,
> > =09=09=09cork:1,
> > @@ -733,7 +736,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> > =09=09       struct mptcp_options_received *mp_opt);
> >=20
> > void mptcp_finish_connect(struct sock *sk);
> > -void __mptcp_set_connected(struct sock *sk);
> > +void __mptcp_propagate_state(struct sock *sk);
> > void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_=
tout);
> >=20
> > static inline void mptcp_stop_tout_timer(struct sock *sk)
> > @@ -1129,7 +1132,7 @@ static inline bool subflow_simultaneous_connect(s=
truct sock *sk)
> > {
> > =09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> >=20
> > -=09return sk->sk_state =3D=3D TCP_ESTABLISHED &&
> > +=09return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1) &&
> > =09       is_active_ssk(subflow) &&
> > =09       !subflow->conn_finished;
>=20
> is_active_ssk() will return true on joins as well - does it make sense to=
=20
> force a fallback in that case?

Right, not much! I think we should close the subflow. Note that
triggering a self connect on a subflow is very hard. AFAICS the only
way to get there is the remote sending an ADD_ADDR with port to a local
address, and the local kernel binding to such port at connect time by
random chance.

In any case this looks like a separate fix?

Ack to all the other suggestions!

Cheers,

Paolo

