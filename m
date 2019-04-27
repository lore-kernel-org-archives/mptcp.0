Content-Type: multipart/mixed; boundary="===============5419065141472887406=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] scheduling-while-atomic splat in mptcp_shutdown
Date: Fri, 26 Apr 2019 17:26:58 -0700
Message-ID: <alpine.OSX.2.21.1904261720430.50032@leejosex-mobl.amr.corp.intel.com>
In-Reply-To: 1694c7b1f848a9b5759a082affac12b263297887.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1094

--===============5419065141472887406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 26 Apr 2019, Paolo Abeni wrote:

> On Fri, 2019-04-26 at 16:27 +0200, Florian Westphal wrote:
>> Hi,
>>
>> I get following splat in mptcp_shutdown:
>> -----
>> BUG: sleeping function called from invalid context at net/core/sock.c:29=
11
>> in_atomic(): 0, irqs_disabled(): 0, pid: 2238, name: mptcp_connect
>> [   61.599662] 1 lock held by mptcp_connect/2238:
>> [   61.600395]  #0: 000000005d0e085e (rcu_read_lock){....}, at: mptcp_sh=
utdown+0x91/0x2a0
>> [   61.601754] Preemption disabled at:
>> [   61.601780] [<ffffffff811a28ee>] rcu_lockdep_current_cpu_online+0x2e/=
0xa0
>> [   61.606184] Call Trace:
>> [   61.607183]  ? rcu_lockdep_current_cpu_online+0x2e/0xa
>> [   61.608047]  ___might_sleep.cold.73+0x129/0x13d
>> [   61.608800]  lock_sock_nested+0x32/0xc0
>> [   61.609447]  inet_shutdown+0x51/0x1c0
>> [   61.609999]  mptcp_shutdown+0x13e/0x2a0
>>
>
> This happens due to the RCU critical section around
> kernel_sock_shutdown() in mptcp_shutdown().
>
> To fix the above, I'd like to change conn_list type to list_head -
> should also simplify a bit the code. Is there any argument against such
> change?
>

That seems ok to me. I'd suggest waiting to do the work on that until we =

push the next revision of the prototype, since there are several changes =

coming (based on code review feedback) that will probably make it hard to =

rebase your work.

--
Mat Martineau
Intel

--===============5419065141472887406==--
