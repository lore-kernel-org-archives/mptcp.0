Content-Type: multipart/mixed; boundary="===============7857859053178739472=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Tue, 27 Feb 2018 10:50:38 -0800
Message-ID: <alpine.OSX.2.21.1802261405290.7401@cporter-mobl.amr.corp.intel.com>
In-Reply-To: 20180226095758.GX1235@MacBook-Pro-4.local
X-Status: 
X-Keywords:                  
X-UID: 317

--===============7857859053178739472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph,

On Mon, 26 Feb 2018, Christoph Paasch wrote:

> Hello,
>
> as for next steps after the submission of the TCP-option framework to net=
dev
> and DaveM's feedback on it.
>
> Even if the submission got rejected, I think we still have a very useful =
set
> of patches here. The need for a framework might pop up again in the futur=
e,
> and so these patches could come in handy.
> Mat, maybe you can put our latest submission on your kernel.org-git repo
> just so that we don't lose track of these patches?

Done: =

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dmd5


> I can also create a github repo if you prefer that.
>
>
> As for DaveM's feedback, the main takeaway - as Mat already noted on his =
other
> mail - is that fast-path performance he the highest priority. Branching a=
nd
> indirect function calls are hardly accepted there.
>
>
> So, in that spirit I think we need to work towards reducing MPTCP's
> intrusiveness to the TCP stack.
>
> * Stop taking meta-lock when receiving subflow data (all the changes where
>  we check for mptcp(tp) and then do bh_lock_sock(meta_sk)).
>  The reason we do this in today's implementation is because it allows to
>  access the meta data-structure at any point. If we stop taking the
>  meta-lock a few things need to change:
>  1. Do lockless accesses for selected fields (e.g., for the DATA_ACK).
>  2. Group the more intrusive accesses to few select points in the TCP-sta=
ck
>     where we then take the meta-lock (e.g., when receiving data).
>     (this would be equivalent as if the TCP-option framework would be the=
re
>     - thus we need to move code to these or similar points in the stack)
>  3. Sometimes schedule work-queues when we need to avoid deadlocks due to
>     lock-ordering issues (e.g., when we can't take the meta-lock because
>     it's already held by another thread).
>
>  I think, the way to approach this here, is by working iteratively and st=
art
>  moving code in such a way that accesses to the meta-socket are grouped
>  together.
>
>  Also, we have a few callbacks that we added (cfr., struct tcp_sock_ops).
>  We added them to avoid duplicating the code. Let's review those and see =
if
>  we can get rid of them. (as an example: .send_fin could be removed as it=
 is only
>  called from tcp_shutdown, called from the .shutdown callback in tcp_prot=
 -
>  thus if we expose a separate MPTCP socket-type with its own struct proto,
>  we can get rid of the .send_fin callback)
>

I think a separate MPTCP socket type will be important for upstream =

acceptance. My team has been working on some code with this separate =

socket type that we can share. I'm thinking that it will be useful to =

share once a connection can stay up without falling back to TCP.

> * Investigate how/if we can make MPTCP adopt KCM or ULP.

My main concern about ULP is that only one upper layer protocol can be set =

up (at least as the code is now), so you wouldn't be able to do something =

like use in-kernel TLS over MPTCP. Other than that, it seems like a =

natural fit for MPTCP.

So far I've been looking at KCM as a source of good ideas rather than =

something we could use directly. KCM uses SOCK_SEQPACKET or SOCK_DGRAM, =

but maybe it could be extended to include SOCK_STREAM. Where MPTCP places =

DSS mappings in the TCP options, KCM handles message boundaries within the =

data stream - that made me ponder using XDP to place the DSS mappings in =

the data payload (with the necessary TCP sequence number adjustments). I'm =

not sure it's workable because it can be expensive to change the length of =

an incoming skb and adjusting the acks gets complicated, but it's at least =

an interesting thought experiment :)

> * There is still the open question of the API, path-management,... Tessar=
es
>  has some experience with that, so maybe they can provide some ideas here.

We (at OTC) are working on a generic netlink proposal for path management =

as well.

>
> * The size of the skb. Well, we have been discussing this for quite a whi=
le :)
>  One option is always to have a lookup table as they do for the
>  TLS-records. That will hurt performance, but at least it's a step forwar=
d.
>  And we have a bunch of other ideas that might be worth exploring as well.
>  If I'm not mistaken, Rao had an approach that could work as well, right?

This is what I'm working on now. For outgoing packets, I have a way to =

optionally allocate sk_buffs with extra control block space. For incoming =

packets, my initial experiment is with preventing packet coalesce/collapse
so TCP options are still in the skb headroom. I don't consider that a =

long-term solution, though. Some kind of lookup table will probably be =

needed.

> Any other comments, suggestions,...? :-)

I had these thoughts on evolving the multipath-tcp.org kernel fork last =

summer (excerpt from =

https://lists.01.org/pipermail/mptcp/2017-July/000064.html), which I think =

are still relevant:

"""

One approach is to attempt to merge the multipath-tcp.org fork. This is an =

implementation in which the multipath-tcp.org community has invested a lot =

of time and effort, and it is in production for major applications (see =

https://tools.ietf.org/html/rfc8041). This is a tremendous amount of code =

to review at once (even separating out modules), and currently doesn't fit =

with what the maintainers have asked for (non-intrusive, sk_buff size, =

MPTCP by default). I don't think the maintainers would consider merging =

such an extensive piece of git history, especially where there are a fair =

number of commits without an "mptcp:" label on the subject line or without =

a DCO signoff =

(https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sig=
n-your-work-the-developer-s-certificate-of-origin). =

Today, the fork is at kernel v4.4 and current upstream development is at =

v4.13-rc1, so the fork would have to catch up and stay current. (2018 =

note: Christoph has merged up to more recent kernels now)

The other extreme is to rewrite from scratch. This would allow incremental
development with maintainer review from the start, but doesn't take
advantage of existing code.

The most realistic approach is somewhere in between, where we write new
code that fits maintainer expectations and utilize components from the
fork where licensing allows and the code fits. We'll have to find the
right balance: over-reliance on new code could take extra time, but
constantly reworking the fork and keeping it up-to-date with net-next is
also a lot of overhead.

"""

Gregory and Matthieu, do you have any thoughts on where the right balance =

is on evolving the fork vs. adding new code?


> On my side, as a first concrete step, I will work towards lockless subflow
> establishment. In tcp_v4_rcv, we are currently taking the meta-level lock
> when the socket-lookup matches on a request-socket. Now that TCP supports
> lockless listeners, MPTCP should do that as well.

I'll work on getting my team's MPTCP socket type code posted to =

git.kernel.org, and getting our generic netlink proposal posted to this =

list.


Thanks,

--
Mat Martineau
Intel OTC

--===============7857859053178739472==--
