Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBF15D2
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665500472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2P8Y/Ee7RvMwZLWBsYCepgEyl0SPYPsZvC/QkMUOLM8=;
	b=bBH7GOqg3TK774MpgotYUvMTiCvbA5OF14uBnVJxIbuVhu2Ah3MBdZW50ylPI+M343A4Ad
	JMTg+8viZSEqV8RHAFba9c//LslqXHDvKZd2cVeo6eTXy04r9E8VUnVgZLE59gVetrRTCl
	cqYb0A0y5P417e+fvDA6x1CzUv27Oi4=
Received: from mail-wm1-f71.google.com (209.85.128.71 [209.85.128.71]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_128_GCM_SHA256) id us-mta-341-dvcY1c2gOnCo9FqZSONmlg-1; Tue,
 11 Oct 2022 11:00:43 -0400
X-MC-Unique: dvcY1c2gOnCo9FqZSONmlg-1
Received: by mail-wm1-f71.google.com with SMTP id h129-20020a1c2187000000b003bf635eac31so5542357wmh.4
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 08:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2P8Y/Ee7RvMwZLWBsYCepgEyl0SPYPsZvC/QkMUOLM8=;
        b=wki6GUCS3qsFnup5zxs5KbUFcQn9z4AC7JC9M9JwZFvlp7S4HsSplGApeucSPrs9Ik
         ihwtibvsY2xS6egA9kWBMPo0FVh5Bj9hZDcQY9siwRJjmlbOur9ZLnMwVlbHFCZiM5NX
         ybzpPr1ZW5AZVLm3Zzq3rWnCAOHE/+Bu/8PK22m6bGfSsQOx75ey8RG/ip/2xpfuYn+9
         PujcLUzA9JDuY9+/Zy7E3n5s4Dw0AnYs1/1nLnnnpeeezU4i9QlMUSAFT41/YjOg93T2
         isLaNOrsQEa/PmhzKAUVM57DJeScBtbbDrl/DGQFmwlM0Jnlgw4d+fcwKnXmP2qDMt6G
         rIUQ==
X-Gm-Message-State: ACrzQf3IpZmZk4YUVfP/TYdRrtkiL4zY7dGbZJFZcCcaxVqmyUMEaFpy
	+VXZhS1O1Ky/gdWp7epCYDuNhSyrUqzxrtwP/xEcv1MVmOrkRo3ex8ju5lnTVeF4nU7e45H3uke
	M4MweIERgGXdM5ikp0eowuJnyeiEdk247a6TbZAWHwJ65Sf6cOPhWd3oTCt1nhHLg
X-Received: by 2002:a5d:5a06:0:b0:22f:e353:4ba1 with SMTP id bq6-20020a5d5a06000000b0022fe3534ba1mr9244847wrb.458.1665500426625;
        Tue, 11 Oct 2022 08:00:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7hLXGA4c5wexL9Vw9tDm4QeedCap6cTGExQMgBAVKnqPjTXPPwg1co5Q314XDY5pht9KrFyg==
X-Received: by 2002:a5d:5a06:0:b0:22f:e353:4ba1 with SMTP id bq6-20020a5d5a06000000b0022fe3534ba1mr9244806wrb.458.1665500426015;
        Tue, 11 Oct 2022 08:00:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b003b51a4c61aasm20339404wmq.40.2022.10.11.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:00:25 -0700 (PDT)
Message-ID: <c271f8d2de3bb1323c73fbaa09b7ea00e5cc63fa.camel@redhat.com>
Subject: Re: selftests: mptcp: mptfo Initiator/Listener: Build Failure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Dmytro Shytyi <dmytro@shytyi.net>
Date: Tue, 11 Oct 2022 17:00:23 +0200
In-Reply-To: <a8979393-f702-f8d2-0744-43c56f5faff3@gmail.com>
References: <20221010221809.1792-6-dmytro@shytyi.net>
	 <a8979393-f702-f8d2-0744-43c56f5faff3@gmail.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 2022-10-10 at 22:52 +0000, MPTCP CI wrote:
> Hi Dmytro,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/20221010221809.1792-6-dmytro@shytyi.net/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3222787780
> 
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/444fcb2258d7
> 
> Feel free to reply to this email if you cannot access logs, if you need
> some support to fix the error, if this doesn't seem to be caused by your
> modifications or if the error is a false positive one.
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (Tessares)

ooch, this a real deadlock scenario:


======================================================
[22:57:23.369] [  601.707772][ T4716] WARNING: possible circular locking dependency detected
[22:57:23.376] [  601.714262][ T4716] 6.0.0-g444fcb2258d7 #1 Tainted: G                 N
[22:57:23.384] [  601.720670][ T4716] ------------------------------------------------------
[22:57:23.390] [  601.728801][ T4716] mptcp_connect/4716 is trying to acquire lock:
[22:57:23.400] [  601.735023][ T4716] ffff888003b00130 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x255/0x310
[22:57:23.402] [  601.744387][ T4716] 
[22:57:23.406] [  601.744387][ T4716] but task is already holding lock:
[22:57:23.416] [  601.751334][ T4716] ffff888004ef8130 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x255/0x310
[22:57:23.418] [  601.760468][ T4716] 
[22:57:23.424] [  601.760468][ T4716] which lock already depends on the new lock.
[22:57:23.426] [  601.760468][ T4716] 
[22:57:23.428] [  601.770669][ T4716] 
[22:57:23.435] [  601.770669][ T4716] the existing dependency chain (in reverse order) is:
[22:57:23.437] [  601.779576][ T4716] 
[22:57:23.442] [  601.779576][ T4716] -> #1 (k-sk_lock-AF_INET){+.+.}-{0:0}:
[22:57:23.448] [  601.786970][ T4716]        __lock_acquire+0xafe/0x17f0
[22:57:23.454] [  601.793118][ T4716]        lock_acquire+0x1ab/0x570
[22:57:23.459] [  601.798837][ T4716]        lock_sock_nested+0x37/0xd0
[22:57:23.465] [  601.804117][ T4716]        sk_setsockopt+0x2fb/0x2a50
[22:57:23.472] [  601.809824][ T4716]        mptcp_setsockopt_sol_socket+0xce/0x3e0
[22:57:23.478] [  601.816609][ T4716]        __sys_setsockopt+0x137/0x320
[22:57:23.484] [  601.822791][ T4716]        __x64_sys_setsockopt+0xb9/0x150
[22:57:23.490] [  601.829082][ T4716]        do_syscall_64+0x35/0x80
[22:57:23.497] [  601.834821][ T4716]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[22:57:23.499] [  601.842154][ T4716] 
[22:57:23.506] [  601.842154][ T4716] -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
[22:57:23.512] [  601.850379][ T4716]        check_prev_add+0x15e/0x20f0
[22:57:23.517] [  601.856521][ T4716]        validate_chain+0xf65/0x1ba0
[22:57:23.521] [  601.861538][ T4716]        __lock_acquire+0xafe/0x17f0
[22:57:23.527] [  601.866321][ T4716]        lock_acquire+0x1ab/0x570
[22:57:23.533] [  601.871997][ T4716]        lock_sock_nested+0x37/0xd0
[22:57:23.539] [  601.877882][ T4716]        inet_wait_for_connect+0x255/0x310
[22:57:23.545] [  601.883361][ T4716]        __inet_stream_connect+0x272/0x7d0
[22:57:23.551] [  601.889577][ T4716]        tcp_sendmsg_fastopen+0x359/0x630
[22:57:23.556] [  601.896016][ T4716]        mptcp_sendmsg+0xed6/0x1850
[22:57:23.561] [  601.900875][ T4716]        sock_sendmsg+0xb2/0xe0
[22:57:23.565] [  601.905514][ T4716]        __sys_sendto+0x1c1/0x290
[22:57:23.570] [  601.910264][ T4716]        __x64_sys_sendto+0xdc/0x1b0
[22:57:23.575] [  601.915210][ T4716]        do_syscall_64+0x35/0x80
[22:57:23.581] [  601.920146][ T4716]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[22:57:23.584] [  601.926273][ T4716] 
[22:57:23.590] [  601.926273][ T4716] other info that might help us debug this:
[22:57:23.592] [  601.926273][ T4716] 
[22:57:23.596] [  601.936282][ T4716]  Possible unsafe locking scenario:
[22:57:23.599] [  601.936282][ T4716] 
[22:57:23.604] [  601.943757][ T4716]        CPU0                    CPU1
[22:57:23.608] [  601.948719][ T4716]        ----                    ----
[22:57:23.613] [  601.953099][ T4716]   lock(k-sk_lock-AF_INET);
[22:57:23.621] [  601.957515][ T4716]                                lock(sk_lock-AF_INET);
[22:57:23.629] [  601.965517][ T4716]                                lock(k-sk_lock-AF_INET);
[22:57:23.634] [  601.973575][ T4716]   lock(sk_lock-AF_INET);
[22:57:23.637] [  601.978688][ T4716] 
[22:57:23.640] [  601.978688][ T4716]  *** DEADLOCK ***
[22:57:23.642] [  601.978688][ T4716] 
[22:57:23.647] [  601.987018][ T4716] 1 lock held by mptcp_connect/4716:
[22:57:23.659] [  601.992049][ T4716]  #0: ffff888004ef8130 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x255/0x310
[22:57:23.662] [  602.003963][ T4716] 
[22:57:23.665] [  602.003963][ T4716] stack backtrace:
[22:57:23.674] [  602.009926][ T4716] CPU: 1 PID: 4716 Comm: mptcp_connect Tainted: G                 N 6.0.0-g444fcb2258d7 #1
[22:57:23.682] [  602.018796][ T4716] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[22:57:23.686] [  602.027329][ T4716] Call Trace:
[22:57:23.689] [  602.030753][ T4716]  <TASK>
[22:57:23.693] [  602.033599][ T4716]  dump_stack_lvl+0x57/0x7d
[22:57:23.698] [  602.037873][ T4716]  check_noncircular+0x268/0x310
[22:57:23.703] [  602.042896][ T4716]  ? print_circular_bug+0x450/0x450
[22:57:23.708] [  602.048270][ T4716]  ? alloc_chain_hlocks+0x23b/0x700
[22:57:23.713] [  602.053288][ T4716]  check_prev_add+0x15e/0x20f0
[22:57:23.719] [  602.057967][ T4716]  validate_chain+0xf65/0x1ba0
[22:57:23.724] [  602.063553][ T4716]  ? check_prev_add+0x20f0/0x20f0
[22:57:23.730] [  602.069246][ T4716]  __lock_acquire+0xafe/0x17f0
[22:57:23.735] [  602.075009][ T4716]  lock_acquire+0x1ab/0x570
[22:57:23.741] [  602.080178][ T4716]  ? inet_wait_for_connect+0x255/0x310
[22:57:23.747] [  602.086330][ T4716]  ? rcu_read_unlock+0x50/0x50
[22:57:23.751] [  602.091763][ T4716]  ? lock_downgrade+0x130/0x130
[22:57:23.756] [  602.096326][ T4716]  ? mark_held_locks+0x9e/0xe0
[22:57:23.760] [  602.100667][ T4716]  lock_sock_nested+0x37/0xd0
[22:57:23.766] [  602.105128][ T4716]  ? inet_wait_for_connect+0x255/0x310
[22:57:23.771] [  602.111334][ T4716]  inet_wait_for_connect+0x255/0x310
[22:57:23.777] [  602.115938][ T4716]  ? inet_init_net+0x5a0/0x5a0
[22:57:23.783] [  602.121605][ T4716]  ? __init_waitqueue_head+0x150/0x150
[22:57:23.789] [  602.127943][ T4716]  ? mptcp_rcv_space_adjust+0xb70/0xb70
[22:57:23.795] [  602.133500][ T4716]  __inet_stream_connect+0x272/0x7d0
[22:57:23.800] [  602.139615][ T4716]  tcp_sendmsg_fastopen+0x359/0x630
[22:57:23.806] [  602.145221][ T4716]  mptcp_sendmsg+0xed6/0x1850
[22:57:23.811] [  602.150646][ T4716]  ? find_held_lock+0x2c/0x110
[22:57:23.818] [  602.156066][ T4716]  ? selinux_inode_notifysecctx+0x30/0x30
[22:57:23.823] [  602.162559][ T4716]  ? lock_downgrade+0x130/0x130
[22:57:23.828] [  602.167512][ T4716]  ? __mptcp_push_pending+0x6c0/0x6c0
[22:57:23.834] [  602.173404][ T4716]  ? __might_fault+0xb8/0x160
[22:57:23.840] [  602.178753][ T4716]  ? inet_send_prepare+0x3e0/0x3e0
[22:57:23.844] [  602.184567][ T4716]  sock_sendmsg+0xb2/0xe0
[22:57:23.848] [  602.188802][ T4716]  __sys_sendto+0x1c1/0x290
[22:57:23.853] [  602.193139][ T4716]  ? __ia32_sys_getpeername+0xb0/0xb0
[22:57:23.858] [  602.198259][ T4716]  ? ksys_read+0x180/0x1d0
[22:57:23.864] [  602.203225][ T4716]  ? ksys_read+0x180/0x1d0
[22:57:23.869] [  602.208487][ T4716]  __x64_sys_sendto+0xdc/0x1b0
[22:57:23.874] [  602.213874][ T4716]  ? lockdep_hardirqs_on+0x79/0x100
[22:57:23.879] [  602.218732][ T4716]  ? syscall_enter_from_user_mode+0x1d/0x50
[22:57:23.884] [  602.224181][ T4716]  do_syscall_64+0x35/0x80
[22:57:23.889] [  602.228420][ T4716]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[22:57:23.893] [  602.233584][ T4716] RIP: 0033:0x7fecc67dcbba
[22:57:23.910] [  602.237799][ T4716] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[22:57:23.918] [  602.254843][ T4716] RSP: 002b:00007ffd99d1e068 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[22:57:23.927] [  602.262755][ T4716] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007fecc67dcbba
[22:57:23.935] [  602.271446][ T4716] RDX: 0000000000002000 RSI: 00007ffd99d1e0d0 RDI: 0000000000000003
[22:57:23.944] [  602.280166][ T4716] RBP: 0000000000000106 R08: 0000565225e112d0 R09: 0000000000000010
[22:57:23.951] [  602.288795][ T4716] R10: 0000000020000000 R11: 0000000000000246 R12: 0000565225652de9
[22:57:23.958] [  602.295825][ T4716] R13: 0000565225652df2 R14: 0000000000000003 R15: 0000565225e112a0
=================================================

I'm unsure if the root cause is my patch "mptcp: factor out
mptcp_connect()", or 

d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")

I think somethin alike the following should address the issue
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d34765db0700..2aad655f214d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1664,6 +1664,27 @@ static void mptcp_set_nospace(struct sock *sk)
 	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
 }
 
+static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
+				  size_t len, int *copied_syn)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int ret;
+
+	lock_sock(ssk);
+	msk->connect_flags = O_NONBLOCK;
+	msk->is_sendmsg = 1;
+	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
+	msk->is_sendmsg = 0;
+	release_sock(ssk);
+
+	/* do the blocking bits of inet_stream_connect outside the ssk socket lock*/
+	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT))
+		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
+					    msg->msg_namelen, O_NONBLOCK, 1);
+
+	return ret;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1683,27 +1704,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	lock_sock(sk);
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
-		struct sock *ssk = ssock->sk;
+	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
+			       msg->msg_flags & MSG_FASTOPEN))) {
 		int copied_syn = 0;
 
-		lock_sock(ssk);
-
-		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-		msk->is_sendmsg = 1;
-		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
-		msk->is_sendmsg = 0;
+		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
 		copied += copied_syn;
-		if (ret == -EINPROGRESS && copied_syn > 0) {
-			/* reflect the new state on the MPTCP socket */
-			inet_sk_state_store(sk, inet_sk_state_load(ssk));
-			release_sock(ssk);
+		if (ret == -EINPROGRESS && copied_syn > 0)
 			goto out;
-		} else if (ret) {
-			release_sock(ssk);
+		else if (ret)
 			goto do_error;
-		}
-		release_sock(ssk);
 	}
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);

