Content-Type: multipart/mixed; boundary="===============8366891255418811821=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 14/25] tcp_extra_options: Check static branch
 before _parse
Date: Wed, 29 Nov 2017 12:50:24 -0800
Message-ID: <20171129205024.GU94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711291117560.22612@skpadalx-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 221

--===============8366891255418811821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 29/11/17 - 12:19:32, Mat Martineau wrote:
> On Wed, 29 Nov 2017, Christoph Paasch wrote:
> =

> > On 28/11/17 - 17:58:52, Mat Martineau wrote:
> > > =

> > > On Tue, 28 Nov 2017, Mat Martineau wrote:
> > > =

> > > > =

> > > > On Mon, 27 Nov 2017, Christoph Paasch wrote:
> > > > =

> > > > > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > > > > ---
> > > > > net/ipv4/tcp_input.c | 8 +++++---
> > > > > 1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > =

> > > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > > index 4e84f299c96f..7acc1f46641c 100644
> > > > > --- a/net/ipv4/tcp_input.c
> > > > > +++ b/net/ipv4/tcp_input.c
> > > > > @@ -3799,9 +3799,11 @@ void tcp_parse_options(const struct net *n=
et,
> > > > > 				break;
> > > > > =

> > > > > 			default:
> > > > > -				tcp_extra_options_parse(opcode, opsize, ptr,
> > > > > -							skb, opt_rx,
> > > > > -							tcp_to_sk(tp));
> > > > > +				if (static_branch_unlikely(&tcp_extra_options_enabled))
> > > > =

> > > > Since this case in the switch statement is only executed for
> > > > unrecognized options, I had skipped the static branch in the initial
> > > > implementation. It is more consistent to use the static branch, and
> > > > there isn't much use in making the function call just to try to ite=
rate
> > > > over an empty list.
> > > > =

> > > > > +					tcp_extra_options_parse(opcode, opsize,
> > > > > +								ptr, skb,
> > > > > +								opt_rx,
> > > > > + tcp_to_sk(tp));
> > > > > 				break;
> > > > > =

> > > > > 			}
> > > > > --
> > > > > 2.15.0
> > > > > =

> > > > > =

> > > =

> > > I sent my reply and then realized I had one more point to make. We mi=
ght
> > > need to take another look at the use of static branching by the extra
> > > options framework. It's one thing to inc/dec tcp_extra_options_enable=
d when
> > > modules are added or removed, but we don't want to be rapidly changing
> > > static branches as MPTCP sockets come and go. Does tcp_extra_options_=
enabled
> > > still make sense for per-socket extra_option lists?
> > =

> > You think that the test for whether or not the tcp_option_list is emtpy=
 is
> > sufficient?
> =

> It might be if we wrap it in a "unlikely()".
> =

> > =

> > I don't know about the cost of static_branch_inc/dec. Is it that bad?
> > =

> =

> Yeah, it's that bad. The kernel is patching machine code every time the k=
ey
> is enabled or disabled (rewriting no-ops with jump instructions and
> vice-versa).
> =

> """
>  * Since this relies on modifying code, the branch modifying functions
>  * must be considered absolute slow paths (machine wide synchronization e=
tc.).
> """
> =

> http://elixir.free-electrons.com/linux/v4.15-rc1/source/include/linux/jum=
p_label.h#L56
> =

> Not just a slow path, but an *absolute* slow path!
> =

> static_key_deferred and static_key_slow_dec_deferred() are available in
> jump_label_ratelimit.h, which is one way to keep it from thrashing too mu=
ch.
> This rate-limited static key is only used in one file
> (arch/x86/kvm/lapic.c). That subsystem limits jump label patching to once
> per second.

I see.

> =

> > =

> > One thing is that having the static branches allows for sure to avoid a=
ny
> > cost in the hot data-path. Which is definitely something netdev will wa=
nt.
> > =

> > =

> > If we pay a cost for MPTCP, I think it's fine IMO. (at least in a first=
 step ;))
> =

> It would be more straightforward if only MPTCP was paying the cost, but in
> this case the hit is systemwide if any extra TCP options are in use. The
> combination of a rate-limiting static_key and checking the option list
> before the call could be fast enough.

If we have rate-limited static keys, do we still need to check the
option-list before the call?

Also, what if we rather inc/dec the static key more rarely. E.g., not for
every new connection but rather for the very first one and then dec again at
the very last one.

I'm trying to cook a patch...


Christoph





> =

> --
> Mat Martineau
> Intel OTC

--===============8366891255418811821==--
