Content-Type: multipart/mixed; boundary="===============4206649900609867063=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: mptcp: better msk receive window updates
Date: Fri, 05 Feb 2021 13:46:38 +0100
Message-ID: <cc4ea925815472215884eaecd750a4f8caa7f6e3.camel@redhat.com>
In-Reply-To: 20210205115126.GD16570@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7636

--===============4206649900609867063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-05 at 12:51 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > In teory, even MPTCP level retransmissions should kick-in, but the
> > current pkt scheduler implementation for re-injection
> > (mptcp_subflow_get_retrans) always decice to do nothing, as the subflow
> > is _not_ in a lossy CA state.
> =

> Retrans skips subflows in lossy CA state, not the other way around?

Uhmm... I underlooked that loop, still I'm seeing ghosts: I added perf
traces to sk_reset_timer, sk_stop_timer and mptcp_retransmit_timer.

In the hang-up I see the push scheduling the rtx timer, but it does not
fire not is stopped (and the rtx never take place) ?!?

/me goes for some coffee...

--===============4206649900609867063==--
