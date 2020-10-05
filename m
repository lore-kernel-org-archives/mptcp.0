Content-Type: multipart/mixed; boundary="===============5201444474129858391=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 12/13] mptcp: keep track of advertised windows
 right edge
Date: Mon, 05 Oct 2020 10:39:17 +0200
Message-ID: <9bbbc5d8-3dc0-6dc4-4168-c91fd390f644@tessares.net>
In-Reply-To: 20201002160850.GC12773@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6193

--===============5201444474129858391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 02/10/2020 18:08, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> From: Florian Westphal <fw(a)strlen.de>
>>
>> Before sending 'x' new bytes also check that the new snd_una would
>> be within the permitted receive window.
>>
>> For every ACK that also contains a DSS ack, check whether its tcp-level
>> receive window would advance the current mptcp window right edge and
>> update it if so.
>>
>> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>>   net/mptcp/options.c  | 24 ++++++++++++++++++----
>>   static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>>   			      struct mptcp_data_frag *dfrag,
>>   			      struct mptcp_sendmsg_info *info)
>>   {
>>   	u64 data_seq =3D dfrag->data_seq + info->sent;
>>   	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +	bool zero_window_probe =3D false;
>>   	struct mptcp_ext *mpext =3D NULL;
>>   	struct sk_buff *skb, *tail;
>>   	bool can_collapse =3D false;
>> @@ -950,6 +976,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
>>   			avail_size =3D info->size_goal - skb->len;
>>   	}
>>   =

>> +	/* Zero window and all data acked? Probe. */
>> +	avail_size =3D mptcp_check_allowed_size(msk, data_seq, avail_size);
>> +	if (avail_size =3D=3D 0 && atomic64_read(&msk->snd_una) =3D=3D msk->sn=
d_nxt) {
> =

> This needs to check "!skb" (or !mpext) as well, now that this is not conn=
ected to
> previous conditional anymore.
> =

>> @@ -973,6 +1007,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
>>   	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
>>   		WARN_ON_ONCE(!can_collapse);
>>   		mpext->data_len +=3D ret;
>> +		WARN_ON_ONCE(zero_window_probe);
> =

> I saw this trigger right now during a test run, should not happen
> anymore after adding the check.

I think I also got the same warning on my side without the additional =

check above (&& !skb):


------------[ cut here ]------------
WARNING: CPU: 0 PID: 5 at net/mptcp/protocol.c:1017 mptcp_sendmsg_frag =

(net/mptcp/protocol.c:1017 (discriminator 1))
Modules linked in: sch_netem mptcp_token_test mptcp_crypto_test kunit
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.9.0-rc6+ #44
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =

1.13.0-1ubuntu1 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:mptcp_sendmsg_frag (net/mptcp/protocol.c:1017 (discriminator 1))
[ 143.370087] Code: 84 32 02 00 00 4c 8b 7c 24 08 4c 8d a5 08 07 00 00 =

49 8d 7f 14 e8 5a 1c f4 fe 66 41 01 5f 14 80 7c 24 28 00 0f 84 d9 00 00 =

00 <0f> 0b e9 d2 00 00 00 48 8b 7c 24 18 4d 8d bc 24 10 09 00 00 e8 b1
All code
=3D=3D=3D=3D=3D=3D=3D=3D
    0:	84 32                	test   %dh,(%rdx)
    2:	02 00                	add    (%rax),%al
    4:	00 4c 8b 7c          	add    %cl,0x7c(%rbx,%rcx,4)
    8:	24 08                	and    $0x8,%al
    a:	4c 8d a5 08 07 00 00 	lea    0x708(%rbp),%r12
   11:	49 8d 7f 14          	lea    0x14(%r15),%rdi
   15:	e8 5a 1c f4 fe       	callq  0xfffffffffef41c74
   1a:	66 41 01 5f 14       	add    %bx,0x14(%r15)
   1f:	80 7c 24 28 00       	cmpb   $0x0,0x28(%rsp)
   24:	0f 84 d9 00 00 00    	je     0x103
   2a:*	0f 0b                	ud2    		<-- trapping instruction
   2c:	e9 d2 00 00 00       	jmpq   0x103
   31:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
   36:	4d 8d bc 24 10 09 00 	lea    0x910(%r12),%r15
   3d:	00
   3e:	e8                   	.byte 0xe8
   3f:	b1                   	.byte 0xb1

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    0:	0f 0b                	ud2
    2:	e9 d2 00 00 00       	jmpq   0xd9
    7:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    c:	4d 8d bc 24 10 09 00 	lea    0x910(%r12),%r15
   13:	00
   14:	e8                   	.byte 0xe8
   15:	b1                   	.byte 0xb1
RSP: 0018:ffff888023997a78 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff8d6eef96
RDX: dffffc0000000000 RSI: 0000000000000005 RDI: ffff88801fea63dc
RBP: ffff88801fd40000 R08: ffffffff8d3486b1 R09: ffffed1003fa8123
R10: ffff88801fd40916 R11: ffffed1003fa8122 R12: ffff88801fd40708
R13: ffff88801fea63c0 R14: 0000000000000001 R15: ffff88801fea63c8
FS:  0000000000000000(0000) GS:ffff888023e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef8c45948 CR3: 000000002018c004 CR4: 0000000000370ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
mptcp_push_pending (net/mptcp/protocol.c:1219)
? mptcp_close (net/mptcp/protocol.c:1182)
? __mptcp_move_skbs (net/mptcp/protocol.c:1532)
? mptcp_check_data_fin (net/mptcp/protocol.c:1511)
? __mptcp_flush_join_list (./include/linux/list.h:282)
mptcp_worker (net/mptcp/protocol.c:1823)
? check_flags.part.0 (kernel/locking/lockdep.c:4890)
? check_flags.part.0 (kernel/locking/lockdep.c:4914)
? mptcp_sendmsg (net/mptcp/protocol.c:1802)
? rcu_read_lock_bh_held (kernel/rcu/update.c:131)
? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:54)
process_one_work (./arch/x86/include/asm/jump_label.h:25)
? check_flags (kernel/locking/lockdep.c:5000)
? pwq_dec_nr_in_flight (kernel/workqueue.c:2165)
? rwlock_bug.part.0 (kernel/locking/spinlock_debug.c:111)
worker_thread (./include/linux/list.h:282)
? preempt_count_sub (kernel/sched/core.c:4211)
? process_one_work (kernel/workqueue.c:2358)
kthread (kernel/kthread.c:292)
? kthread_create_on_node (kernel/kthread.c:245)
ret_from_fork (arch/x86/entry/entry_64.S:300)
irq event stamp: 322273
hardirqs last enabled at (322283): console_unlock =

(kernel/printk/printk.c:2530 (discriminator 1))
hardirqs last disabled at (322292): console_unlock =

(kernel/printk/printk.c:2441 (discriminator 1))
softirqs last enabled at (321876): __do_softirq =

(./arch/x86/include/asm/preempt.h:26)
softirqs last disabled at (321871): asm_call_on_stack =

(arch/x86/entry/entry_64.S:714)
---[ end trace 47554ab7fbf55b9c ]---

I guess it is related to what you saw.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5201444474129858391==--
