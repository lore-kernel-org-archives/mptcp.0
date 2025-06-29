Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA44188587
	for <mptcp@lists.linux.dev>; Sun, 29 Jun 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751189276; cv=none; b=i0RmO7KnuEAjlNZKuF4b5Os4lMkC/Hdde+bLBKfyINAR+Eapaku5yNK6WmJAh60OtYaG0VHDgyFohFURLuMId3armBsbe1EztJQI9ydTitDpsKtbHHKhoPK3n+7kMk6ioPDLVw6OYIY2OpoWR6NR/QyWuA2waWDTrTPQW+noNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751189276; c=relaxed/simple;
	bh=cC1e1AgDluYvXAmsPZIhDVc7LkG055dmH0h/Hx7PWhk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tgbb3ISHaQR7s1+xaYjUylO91OoQhMUb1wWcdoY6qxZ5wgwGRJyl2NxHnFuh9X+XGONLbU5pK1Vn5Bsp2y6XTqW8eZffCrJCzjFa3/FPhWjND4Cz57k3ZPCDdDEIeLd48Z2V2W3VdXUFZSfJxWoTgqLqWHrtuV8/4kXzWQzp5lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNq2CIB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNq2CIB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB1BC4CEEB;
	Sun, 29 Jun 2025 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751189276;
	bh=cC1e1AgDluYvXAmsPZIhDVc7LkG055dmH0h/Hx7PWhk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FNq2CIB/leZbiXgAmdvM306OkfjujZpBw8NMInha1jQO99CeKi8HV62o8otpsAmL/
	 C5IaS9g+Hw1buBzSAjSEP/PVxBRujswVNIPUA1iL8VDl8SrRvdrxWevH20LzKT2Qdo
	 0csqrFBR5W3DHBEluNmlQ0uoIzfguSj74igGRwRkrtlzigGzw2wMuFrjBW6OF6kfdv
	 ttriB4qWdO57xIlGUyFL3HLZJSUvRKcv/YCNxGbXI7GJQkuef5B6zaVZVh07LNc38r
	 1BrPndXzMyPWHW38KNi/ywsYytQXnhHNIfnp9oCPIlqxepJU71hLqbYtA0Ne0QsnT8
	 G6J9MuPjC7hvA==
Message-ID: <47e97515be89fea46a0253aa8aa880130d87b39b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking
 IO mode #487
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Sun, 29 Jun 2025 17:27:52 +0800
In-Reply-To: <b90f35f04a8ea06593c44e988b39615a06646deb.camel@kernel.org>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
		 <a5c20f9f-3038-ed11-b78c-522ef40f9031@kernel.org>
		 <23fd5569-f383-441e-9be4-48a8430954d9@kernel.org>
	 <b90f35f04a8ea06593c44e988b39615a06646deb.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mat, Matt,

On Mon, 2025-06-16 at 14:34 +0800, Geliang Tang wrote:
> Hi Matt, Mat,
> 
> On Sun, 2025-06-15 at 23:29 +0200, Matthieu Baerts wrote:
> > Hi Mat, Geliang,
> > 
> > On 14/06/2025 01:11, Mat Martineau wrote:
> > > On Thu, 29 May 2025, Geliang Tang wrote:
> > > 
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Good news! I finally solved the unstable issue of MPTCP BPF
> > > > sched
> > > > selftests
> > > > I reported a year ago, #487 "send() fails with EAGAIN in
> > > > blocking
> > > > IO
> > > > mode".
> > > > 
> > > > The fix is simple, it can be solved by explicitly setting
> > > > SO_SNDBUF
> > > > sockopt, but be sure not to set SO_RCVBUF at the same time
> > > > (see sk->sk_userlocks & SOCK_RCVBUF_LOCK in
> > > > mptcp_rcv_space_adjust()).
> > > > 
> > > > With this fix, BPF sched selftests are now very stable, I run
> > > > loop
> > > > testing
> > > > using mptcp-upstream-virtme-docker (run_loop run_bpftest_all),
> > > > and can
> > > > run
> > > > it normally for hundreds of times without error:
> > > > 
> > > 
> > > Hi Geliang -
> > > 
> > > I can see how changing SO_SNDBUF on the sending socket side would
> > > shift
> > > timing behavior in a way that affect the test outcome, but it
> > > doesn't
> > > address the root issue with bug #487:
> > > 
> > > It is either OK to get an EAGAIN from a blocking send(), or it's
> > > not OK.
> > > 
> > > 
> > > If it's not ok to ever return EAGAIN from a blocking send, the
> > > existing
> > > test code is a reproducer for a bug, and changing the test is
> > > hiding
> > > that bug.
> > > 
> > > If EAGAIN is ok, then we should change the code in
> > > send_recv_server() to
> > > allow it.
> 
> I did try to handle EAGAIN in send_recv_server() but it didn't work.
> MPTCP BPF sched selftests still fail. Test code and results are
> attached.
> 
> I added this in send_recv_server():
> 
> 	if (errno == EAGAIN && again < 5) {
> 		again++;
> 		continue;
> 	}
> 
> And still got the EAGAIN error:
> 
> # (network_helpers.c:728: errno: Resource temporarily unavailable)
> send
> 7867500 expected 10485760
> # (network_helpers.c:782: errno: Resource temporarily unavailable)
> recv
> 3469500 ​​expected 10485760
> # (network_helpers.c:790: errno: Resource temporarily unavailable)
> Failed in thread_ret -11
> # send_data_and_verify:FAIL:send_recv_data unexpected error: -11
> (errno
> 11)
> 
> In addition, BPF selftests adds a new mechanism that does not allow
> any
> test item to run for more than 10 seconds. Otherwise, the following
> error will be reported:
> 
> # WATCHDOG: test case mptcp/default executes for 10 seconds...
> 
> In my testing, I have not found any other solution besides limiting
> the
> send buffer. This allows data to be sent at a constant rate, which
> ensures the stability of MPTCP BPF sched selftests.
> 
> In order to avoid hiding this bug, we can add a test item for this in
> mptcp selftest in the future, like in [1].

Last week I debugged this issue further and found something (Thanks to
Gang Yan for his help): when mptcp bpf sched selftests fail, the memory
limit check (if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)) is always true
in __mptcp_move_skbs_from_subflow(), at this time sk->sk_receive_queue
is empty, but no skb is moved from this subflow to sk-
>sk_receive_queue, which causes the transmission to fail.

One fix is ​​to also consider the case where sk->sk_receive_queue is
empty when doing the memory limit check:

  -               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
  +               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
  +                   !skb_queue_empty(&sk->sk_receive_queue))
                          break;

In addition, this memory limit check was moved from the end of do {}
while (more_data_avail) to the front in the commit e0ca4057e0ec
("mptcp: micro-optimize __mptcp_move_skb()"), so another better fix is
​​to restore this check to the end of do {} while () so that move skbs
from this subflow to sk->sk_receive_queue always has a chance to do at
least once:

@@ -587,9 +587,6 @@ static bool __mptcp_move_skbs_from_subflow(struct
mptcp_sock *msk,
                struct sk_buff *skb;
                bool fin;
 
-               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-                       break;
-
                /* try to move as much data as available */
                map_remaining = subflow->map_data_len -
                                mptcp_subflow_get_map_offset(subflow);
@@ -634,6 +631,8 @@ static bool __mptcp_move_skbs_from_subflow(struct
mptcp_sock *msk,
                WRITE_ONCE(tp->copied_seq, seq);
                more_data_avail = mptcp_subflow_data_available(ssk);
 
+               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+                       break;
        } while (more_data_avail);

I think this is the root cause of #487, I would like to hear your
opinions on which fix is ​​better.

Thanks,
-Geliang

> 
> WDYT?
> 
> Thanks,
> -Geliang
> 
> [1]
> https://patchwork.kernel.org/project/mptcp/cover/cover.1722502941.git.tanggeliang@kylinos.cn/
> 
> > 
> > It is now a bit hidden in the middle of #487, but if I'm not
> > mistaken,
> > it is OK to get EAGAIN with a blocking send() **if** SO_SNDTIMEO is
> > used, and in case of timeout.
> > 
> > See:
> > https://github.com/multipath-tcp/mptcp_net-next/issues/487#issuecomment-2485577676
> > 
> > So I think the question should be: is it normal to block for longer
> > than
> > the timeout period (which is a "long" period, no?)? If yes, then
> > limiting the send buffer might be a solution, but as Mat said, it
> > looks
> > better to understand the root cause than hiding a bug :)
> > 
> > Cheers,
> > Matt
