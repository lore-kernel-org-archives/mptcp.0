Content-Type: multipart/mixed; boundary="===============8485933101864312173=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Selftests: 1 error last night 20191022
Date: Tue, 22 Oct 2019 14:56:42 +0200
Message-ID: <9e06c4068331d54776b9079e81b35dfbabe2723b.camel@redhat.com>
In-Reply-To: ed196678-4f7f-1c58-d7e4-a26548bbbf8e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2259

--===============8485933101864312173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-22 at 14:14 +0200, Matthieu Baerts wrote:
> Hi,
> =

> On 22/10/2019 13:20, Matthieu Baerts wrote:
> > Last night I got an error with selftests without KASAN, etc.:
> =

> I also saw the same type of error with a new build.
> =

> Last night, we move net-next from ebcd670d05d5 to 985fd98ab5cc.
> =

> I don't see one specific commit that could cause these new timeout but I =

> saw a few commits from Eric, mainly to annotate variables for lockless =

> read, we might have to do the same in MPTCP I guess:

Yep we should. But we also should be almost done there ;)

Anyhow such change should not responsible of the timeout

> - ab4e846a82d0 (tcp: annotate sk->sk_wmem_queued lockless reads)
> - e292f05e0df7 (tcp: annotate sk->sk_sndbuf lockless reads)
> - ebb3b78db7bf (tcp: annotate sk->sk_rcvbuf lockless reads)
> - d9b55bf7b678 (tcp: annotate tp->urg_seq lockless reads)
> - e0d694d638db (tcp: annotate tp->snd_nxt lockless reads)
> - 0f31746452e6 (tcp: annotate tp->write_seq lockless reads)
> - 7db48e983930 (tcp: annotate tp->copied_seq lockless reads)
> - dba7d9b8c739 (tcp: annotate tp->rcv_nxt lockless reads)
> - eac66402d1c3 (net: annotate sk->sk_rcvlowat lockless reads)
> - 8265792bf887 (net: silence KCSAN warnings around sk_add_backlog() calls)
> - 1f142c17d19a (tcp: annotate lockless access to tcp_memory_pressure)
> - 60b173ca3d1c (net: add {READ|WRITE}_ONCE() annotations on =

> ->rskq_accept_head)
> - 9669fffc1415 (net: ensure correct skb->tstamp in various fragmenters)

This one possibly could, even if it's quite unlikely, I think.

Is this failure easily reproducible or it happens once in a lot of
runs?

Thanks,

Paolo



--===============8485933101864312173==--
