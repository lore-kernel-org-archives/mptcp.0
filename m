Content-Type: multipart/mixed; boundary="===============4724507377433419169=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Warn + crash in mptcp_sendmsg_frag()
Date: Sat, 16 Nov 2019 13:59:28 +0100
Message-ID: <39fd64d6-5fd5-ec15-3ed5-c123edb94f39@tessares.net>
In-Reply-To: 23c393ac68f8ae8857b2eb3e71b7685083ebeaca.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2560

--===============4724507377433419169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for your answer!

On 15/11/2019 23:39, Paolo Abeni wrote:
> On Fri, 2019-11-15 at 22:06 +0100, Matthieu Baerts wrote:
>> Hello,
>>
>> When testing some changes in the kselftests area, I initially saw the
>> message:
>>
>>     main_loop_s: timed out
>>
>> in the middle of the tests. But just after, there was a "[ OK ]".
>> Anybody saw that?
> =

> Yes. It happens when you kill the script via ctrl-c while the server
> program is running (in background). The server is not killed, and so it
> time-out in the background.
> =

> Meanwhile you run another iteration of the self-tests and you see the
> timeout from the previous iteration just in the middle of the current
> output.

Oh it makes sense! That's probably what I had!

>> I tried to understand why because the binary should returns 2 if the
>> message is printed and the shell script should catch the error. Then I
>> added debug in the script and launched it in a while-loop. I didn't get
>> the initial error I was looking for but instead I got a WARN followed by
>> an OOPS:
> =

> That is way worse :(
> =

>> Of course, in parallel I did other stuffs, I no longer have the proper
>> vmlinux and my MPTCP VM was not recent...
> =

> uhm... that's a pity... a decoded stack trace would help

The tests are running in a loop, I don't have any issue so far. Maybe =

because I was using a VM build last week.

>> I suspect that "skb" is NULL and we then have an issue with this chunk:
>>
>>
>>           collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
>>           if (collapsed) {
>>                   WARN_ON_ONCE(!can_collapse);
>>                   /* when collapsing mpext always exists */
>>                   mpext->data_len +=3D ret;
>>                   goto out;
>>           }
>>
>>
>> Please also note that earlier in the function, skb is initialised with:
>>
>>       skb =3D tcp_write_queue_tail(ssk);
>>
>> So I guess collapsed is always true, no?
> =

> No. 'collapsed' is true only if do_tcp_sendpages() did not allocated a
> new skb - that is, collapsed the new data to the tail one. It should
> happen only when the 'can_collapse' variable is true.

OK, I missed that the queue could be modified by this function.

> I just notice that there is a very unlikely scenario where
> =

> 'collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);'
> =

> is true, but do_tcp_sendpages() did not actually collapsed the data:
> =

> - do_tcp_sendpages() is called with 'can_collapse' =3D=3D false.
> - do_tcp_sendpages() tries to create a new skb but hits memory limits
> and calls sk_stream_wait_memory()
> - sk_stream_wait_memory() release the socket lock and goes to sleep.
> - the tail skb is transmitted and freed, than do_tcp_sendpages() is
> woken again
> - do_tcp_sendpages() allocates a new skb and get a ptr to the last
> freed skb - that is, the 'old' tail just freed.
> - do_tcp_sendpages() complete successfully and mptcp_sendmsg_frag()
> sees skb =3D=3D tcp_write_queue_tail(ssk), even if there was no collapsin=
g.
> - havoc happens
> =

> All the above is very unlikely - after all I never observed that in
> practice - but still possible I think.

Thank you for your analysis!

I will let the tests running in a while loop for a few days and check if =

I get an issue.

>> If skb is NULL, mpext is NULL too (even if it could unlikely also be
>> even if skb is no NULL but sounds more like a bug I guess) and
>> can_collapse is False.
> =

> Uhm... I don't think this is the case. mpext is NULL even when
> do_tcp_sendpages() did not collapsed the data - that is in the above
> scenario.

I get the OOPS I got was because mpext was NULL, no?

BUG: kernel NULL pointer dereference, address: 0000000000000014

I didn't check with pahole but maybe linked to this instruction:

   mpext->data_len +=3D ret;

> A possible solution would be let mptcp_sendmsg_frag() allocate the skb
> and do the memory scheduling for the subflow before calling
> do_tcp_sendpages(), so that it would never block.
> =

> Some/a lot of code duplication vs do_tcp_sendpages(), but that would
> allow us also to take care of the pending todo in
> mptcp_sendmsg_frag()[1] e.g. handle mptcp ext allocation failure
> gracefully.
> =

> Any better ideas?!?

#BPF? I thought it was the solution to all problems...

Maybe when MPTCP will be published, it will be possible to modify =

do_tcp_sendpages() :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4724507377433419169==--
