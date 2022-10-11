Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087A3C32
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 18:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665512548; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iYddscmBDlenGnhkrcDSWN9rYl/kH8PdwfOCXwQJEd84V7g5//Hxs6tj0562cxsgx7mIihJ3Hw9TSNd92Phg3wbz1TVoTsJbxYNZdbdvi/6tQnjwdBs4878ypsPTAawMMjvp/vahlDm9oxlkKuIodZGkBWwm4wD20jokSWKcEzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665512548; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=xPr8On9cwx567erdE4ArnsBhweNMpWQYxs9lHmquoWE=; 
	b=du7dccReX22+wz+2q8JMMGb7gnieuKLZcS/EWG1ZshzuLicMjCVRBNQZ/+gkEjRlmYnZ87kCSR+gMgGbIZGGMjXyNUtiGaddqGSo7MCO0zTvp47iLwsK5+jvaEgvxcJ2wA4njtcTdisakfKJTYmdBX480c1YNUeEraiAtTDsHy4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665512548;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xPr8On9cwx567erdE4ArnsBhweNMpWQYxs9lHmquoWE=;
	b=Vd83aXSGEd3ng2xcZx7g8i0LpKuF2UvAS1hlANif3/f2cKT81B8kq4xGhvl8esbW
	O8IqeRnPzBJb74VII4ux7bKxLB9LptNsbPz6QYdrIUuvmHmXz1uJxUiAl2xCNL3OVv3
	eYxy8i6NqeWrIzKwNc0ZZCB3zZSxo/v85PbBjidw=
Received: from [10.8.0.6] (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665512545980912.0280974605606; Tue, 11 Oct 2022 20:22:25 +0200 (CEST)
Message-ID: <50ee6498-c859-aa2b-a969-d8d4510f2788@shytyi.net>
Date: Tue, 11 Oct 2022 20:22:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: selftests: mptcp: mptfo Initiator/Listener: Build Failure
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
 Matthieu Baerts <matthieu.baerts@tessares.net>
References: <20221010221809.1792-6-dmytro@shytyi.net>
 <a8979393-f702-f8d2-0744-43c56f5faff3@gmail.com>
 <c271f8d2de3bb1323c73fbaa09b7ea00e5cc63fa.camel@redhat.com>
 <c85864f1-132e-e464-f89b-d92efafe8d32@shytyi.net>
 <80f4291f5e157e7b9faf865030d74ec0ea05452e.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <80f4291f5e157e7b9faf865030d74ec0ea05452e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,

On 10/11/2022 7:32 PM, Paolo Abeni wrote:
> On Tue, 2022-10-11 at 18:37 +0200, Dmytro Shytyi wrote:
>> On 10/11/2022 5:00 PM, Paolo Abeni wrote:
>>> On Mon, 2022-10-10 at 22:52 +0000, MPTCP CI wrote:
>>>> Hi Dmytro,
>>>>
>>>> Thank you for your modifications, that's great!
>>>>
>>>> But sadly, our CI spotted some issues with it when trying to build it.
>>>>
>>>> You can find more details there:
>>>>
>>>>     https://patchwork.kernel.org/project/mptcp/patch/20221010221809.1792-6-dmytro@shytyi.net/
>>>>     https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3222787780
>>>>
>>>> Status: failure
>>>> Initiator: MPTCPimporter
>>>> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/444fcb2258d7
>>>>
>>>> Feel free to reply to this email if you cannot access logs, if you need
>>>> some support to fix the error, if this doesn't seem to be caused by your
>>>> modifications or if the error is a false positive one.
>>>>
>>>> Cheers,
>>>> MPTCP GH Action bot
>>>> Bot operated by Matthieu Baerts (Tessares)
>>> ooch, this a real deadlock scenario:
>>>
>> hopefully the selftests came at time, as you suggested prevously :)
>>> ======================================================
>>> [22:57:23.369] [  601.707772][ T4716] WARNING: possible circular locking dependency detected
>>> [22:57:23.376] [  601.714262][ T4716] 6.0.0-g444fcb2258d7 #1 Tainted: G                 N
>>> [22:57:23.384] [  601.720670][ T4716] ------------------------------------------------------
>>> [22:57:23.390] [  601.728801][ T4716] mptcp_connect/4716 is trying to acquire lock:
>>> [22:57:23.400] [  601.735023][ T4716] ffff888003b00130 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x255/0x310
>>> [22:57:23.402] [  601.744387][ T4716]
>>> [22:57:23.406] [  601.744387][ T4716] but task is already holding lock:
>>> [22:57:23.416] [  601.751334][ T4716] ffff888004ef8130 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x255/0x310
>>> [22:57:23.418] [  601.760468][ T4716]
>>> [22:57:23.424] [  601.760468][ T4716] which lock already depends on the new lock.
>>> [22:57:23.426] [  601.760468][ T4716]
>>> [22:57:23.428] [  601.770669][ T4716]
>>> [22:57:23.435] [  601.770669][ T4716] the existing dependency chain (in reverse order) is:
>>> [22:57:23.437] [  601.779576][ T4716]
>>> [22:57:23.442] [  601.779576][ T4716] -> #1 (k-sk_lock-AF_INET){+.+.}-{0:0}:
>>> [22:57:23.448] [  601.786970][ T4716]        __lock_acquire+0xafe/0x17f0
>>> [22:57:23.454] [  601.793118][ T4716]        lock_acquire+0x1ab/0x570
>>> [22:57:23.459] [  601.798837][ T4716]        lock_sock_nested+0x37/0xd0
>>> [22:57:23.465] [  601.804117][ T4716]        sk_setsockopt+0x2fb/0x2a50
>>> [22:57:23.472] [  601.809824][ T4716]        mptcp_setsockopt_sol_socket+0xce/0x3e0
>>> [22:57:23.478] [  601.816609][ T4716]        __sys_setsockopt+0x137/0x320
>>> [22:57:23.484] [  601.822791][ T4716]        __x64_sys_setsockopt+0xb9/0x150
>>> [22:57:23.490] [  601.829082][ T4716]        do_syscall_64+0x35/0x80
>>> [22:57:23.497] [  601.834821][ T4716]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [22:57:23.499] [  601.842154][ T4716]
>>> [22:57:23.506] [  601.842154][ T4716] -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
>>> [22:57:23.512] [  601.850379][ T4716]        check_prev_add+0x15e/0x20f0
>>> [22:57:23.517] [  601.856521][ T4716]        validate_chain+0xf65/0x1ba0
>>> [22:57:23.521] [  601.861538][ T4716]        __lock_acquire+0xafe/0x17f0
>>> [22:57:23.527] [  601.866321][ T4716]        lock_acquire+0x1ab/0x570
>>> [22:57:23.533] [  601.871997][ T4716]        lock_sock_nested+0x37/0xd0
>>> [22:57:23.539] [  601.877882][ T4716]        inet_wait_for_connect+0x255/0x310
>>> [22:57:23.545] [  601.883361][ T4716]        __inet_stream_connect+0x272/0x7d0
>>> [22:57:23.551] [  601.889577][ T4716]        tcp_sendmsg_fastopen+0x359/0x630
>>> [22:57:23.556] [  601.896016][ T4716]        mptcp_sendmsg+0xed6/0x1850
>>> [22:57:23.561] [  601.900875][ T4716]        sock_sendmsg+0xb2/0xe0
>>> [22:57:23.565] [  601.905514][ T4716]        __sys_sendto+0x1c1/0x290
>>> [22:57:23.570] [  601.910264][ T4716]        __x64_sys_sendto+0xdc/0x1b0
>>> [22:57:23.575] [  601.915210][ T4716]        do_syscall_64+0x35/0x80
>>> [22:57:23.581] [  601.920146][ T4716]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [22:57:23.584] [  601.926273][ T4716]
>>> [22:57:23.590] [  601.926273][ T4716] other info that might help us debug this:
>>> [22:57:23.592] [  601.926273][ T4716]
>>> [22:57:23.596] [  601.936282][ T4716]  Possible unsafe locking scenario:
>>> [22:57:23.599] [  601.936282][ T4716]
>>> [22:57:23.604] [  601.943757][ T4716]        CPU0                    CPU1
>>> [22:57:23.608] [  601.948719][ T4716]        ----                    ----
>>> [22:57:23.613] [  601.953099][ T4716]   lock(k-sk_lock-AF_INET);
>>> [22:57:23.621] [  601.957515][ T4716]                                lock(sk_lock-AF_INET);
>>> [22:57:23.629] [  601.965517][ T4716]                                lock(k-sk_lock-AF_INET);
>>> [22:57:23.634] [  601.973575][ T4716]   lock(sk_lock-AF_INET);
>>> [22:57:23.637] [  601.978688][ T4716]
>>> [22:57:23.640] [  601.978688][ T4716]  *** DEADLOCK ***
>>> [22:57:23.642] [  601.978688][ T4716]
>>> [22:57:23.647] [  601.987018][ T4716] 1 lock held by mptcp_connect/4716:
>>> [22:57:23.659] [  601.992049][ T4716]  #0: ffff888004ef8130 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x255/0x310
>>> [22:57:23.662] [  602.003963][ T4716]
>>> [22:57:23.665] [  602.003963][ T4716] stack backtrace:
>>> [22:57:23.674] [  602.009926][ T4716] CPU: 1 PID: 4716 Comm: mptcp_connect Tainted: G                 N 6.0.0-g444fcb2258d7 #1
>>> [22:57:23.682] [  602.018796][ T4716] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>>> [22:57:23.686] [  602.027329][ T4716] Call Trace:
>>> [22:57:23.689] [  602.030753][ T4716]  <TASK>
>>> [22:57:23.693] [  602.033599][ T4716]  dump_stack_lvl+0x57/0x7d
>>> [22:57:23.698] [  602.037873][ T4716]  check_noncircular+0x268/0x310
>>> [22:57:23.703] [  602.042896][ T4716]  ? print_circular_bug+0x450/0x450
>>> [22:57:23.708] [  602.048270][ T4716]  ? alloc_chain_hlocks+0x23b/0x700
>>> [22:57:23.713] [  602.053288][ T4716]  check_prev_add+0x15e/0x20f0
>>> [22:57:23.719] [  602.057967][ T4716]  validate_chain+0xf65/0x1ba0
>>> [22:57:23.724] [  602.063553][ T4716]  ? check_prev_add+0x20f0/0x20f0
>>> [22:57:23.730] [  602.069246][ T4716]  __lock_acquire+0xafe/0x17f0
>>> [22:57:23.735] [  602.075009][ T4716]  lock_acquire+0x1ab/0x570
>>> [22:57:23.741] [  602.080178][ T4716]  ? inet_wait_for_connect+0x255/0x310
>>> [22:57:23.747] [  602.086330][ T4716]  ? rcu_read_unlock+0x50/0x50
>>> [22:57:23.751] [  602.091763][ T4716]  ? lock_downgrade+0x130/0x130
>>> [22:57:23.756] [  602.096326][ T4716]  ? mark_held_locks+0x9e/0xe0
>>> [22:57:23.760] [  602.100667][ T4716]  lock_sock_nested+0x37/0xd0
>>> [22:57:23.766] [  602.105128][ T4716]  ? inet_wait_for_connect+0x255/0x310
>>> [22:57:23.771] [  602.111334][ T4716]  inet_wait_for_connect+0x255/0x310
>>> [22:57:23.777] [  602.115938][ T4716]  ? inet_init_net+0x5a0/0x5a0
>>> [22:57:23.783] [  602.121605][ T4716]  ? __init_waitqueue_head+0x150/0x150
>>> [22:57:23.789] [  602.127943][ T4716]  ? mptcp_rcv_space_adjust+0xb70/0xb70
>>> [22:57:23.795] [  602.133500][ T4716]  __inet_stream_connect+0x272/0x7d0
>>> [22:57:23.800] [  602.139615][ T4716]  tcp_sendmsg_fastopen+0x359/0x630
>>> [22:57:23.806] [  602.145221][ T4716]  mptcp_sendmsg+0xed6/0x1850
>>> [22:57:23.811] [  602.150646][ T4716]  ? find_held_lock+0x2c/0x110
>>> [22:57:23.818] [  602.156066][ T4716]  ? selinux_inode_notifysecctx+0x30/0x30
>>> [22:57:23.823] [  602.162559][ T4716]  ? lock_downgrade+0x130/0x130
>>> [22:57:23.828] [  602.167512][ T4716]  ? __mptcp_push_pending+0x6c0/0x6c0
>>> [22:57:23.834] [  602.173404][ T4716]  ? __might_fault+0xb8/0x160
>>> [22:57:23.840] [  602.178753][ T4716]  ? inet_send_prepare+0x3e0/0x3e0
>>> [22:57:23.844] [  602.184567][ T4716]  sock_sendmsg+0xb2/0xe0
>>> [22:57:23.848] [  602.188802][ T4716]  __sys_sendto+0x1c1/0x290
>>> [22:57:23.853] [  602.193139][ T4716]  ? __ia32_sys_getpeername+0xb0/0xb0
>>> [22:57:23.858] [  602.198259][ T4716]  ? ksys_read+0x180/0x1d0
>>> [22:57:23.864] [  602.203225][ T4716]  ? ksys_read+0x180/0x1d0
>>> [22:57:23.869] [  602.208487][ T4716]  __x64_sys_sendto+0xdc/0x1b0
>>> [22:57:23.874] [  602.213874][ T4716]  ? lockdep_hardirqs_on+0x79/0x100
>>> [22:57:23.879] [  602.218732][ T4716]  ? syscall_enter_from_user_mode+0x1d/0x50
>>> [22:57:23.884] [  602.224181][ T4716]  do_syscall_64+0x35/0x80
>>> [22:57:23.889] [  602.228420][ T4716]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [22:57:23.893] [  602.233584][ T4716] RIP: 0033:0x7fecc67dcbba
>>> [22:57:23.910] [  602.237799][ T4716] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
>>> [22:57:23.918] [  602.254843][ T4716] RSP: 002b:00007ffd99d1e068 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>>> [22:57:23.927] [  602.262755][ T4716] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007fecc67dcbba
>>> [22:57:23.935] [  602.271446][ T4716] RDX: 0000000000002000 RSI: 00007ffd99d1e0d0 RDI: 0000000000000003
>>> [22:57:23.944] [  602.280166][ T4716] RBP: 0000000000000106 R08: 0000565225e112d0 R09: 0000000000000010
>>> [22:57:23.951] [  602.288795][ T4716] R10: 0000000020000000 R11: 0000000000000246 R12: 0000565225652de9
>>> [22:57:23.958] [  602.295825][ T4716] R13: 0000565225652df2 R14: 0000000000000003 R15: 0000565225e112a0
>>> =================================================
>>>
>>> I'm unsure if the root cause is my patch "mptcp: factor out
>>> mptcp_connect()", or
>>>
>>> d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
>>>
>>> I think somethin alike the following should address the issue
>>
>>
>> Ok, I'm working on this subject. I will post in new version.
> It looks like this issue is pre-existent WRT both this series and the
> patch "mptcp: factor out mptcp_connect()". I can reproduce the splat on
> the current export branch with the following pktdrill (from Mat):
> ---
> // Send data with MSG_FASTOPEN
> --tolerance_usecs=100000
> `../common/defaults.sh
>   sysctl -q net.ipv4.tcp_fastopen=0x5`
>
>   0.0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> +0.0    fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> +0.0    setsockopt(3, SOL_TCP, TCP_FASTOPEN_CONNECT, [1], 4) = 0
> +0.0    connect(3, ..., ...) = 0
>
> +0.0    fcntl(3, F_SETFL, O_RDWR) = 0 // but then the next step will block waiting for the SYN+ACK to arrive...
> +0...0.4    sendto(3, ..., 500, 0, ..., ...) = 500
> +0     >  S   0:500(500)                           <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
> +0.4     <  S.  0:0(0)          ack 501   win 65535  <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
> +0     >   .  501:501(0)      ack 1                <nop, nop,         TS val 100 ecr 700,                mpcapable v1 flags[flag_h] key[ckey, skey]>
> ---
>
> I've just shared a patch to address the issue.
>
> @Mat: could you please push the above drill? or do you prefer I'll do the PR?
>
> Cheers,
>
> Paolo
>
I will rebase on the top when this patch will be merged to the tree.


Thanks,

Dmytro

