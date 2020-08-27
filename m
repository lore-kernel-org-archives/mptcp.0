Content-Type: multipart/mixed; boundary="===============5881723703906952589=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
Date: Thu, 27 Aug 2020 13:54:28 +0200
Message-ID: <CACXrtpSe0-E5sLH4k6Jmw_FDK=+yKdsPdiR9BDniOXC6NTQ=rQ@mail.gmail.com>
In-Reply-To: CAADnVQL1O3Ncr5iwmZx_5FgVrwbXmEWZfGm_ASrTcu0j6YGbiA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5645

--===============5881723703906952589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Wed, Aug 26, 2020 at 9:13 PM Alexei Starovoitov
<alexei.starovoitov(a)gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 11:55 AM Nicolas Rybowski
> <nicolas.rybowski(a)tessares.net> wrote:
> >
> > Hi Alexei,
> >
> > Thanks for the feedback!
> >
> > On Tue, Aug 25, 2020 at 12:01 AM Alexei Starovoitov
> > <alexei.starovoitov(a)gmail.com> wrote:
> > >
> > > On Fri, Aug 21, 2020 at 05:15:38PM +0200, Nicolas Rybowski wrote:
> > > > Previously it was not possible to make a distinction between plain =
TCP
> > > > sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hoo=
k.
> > > >
> > > > This patch series now enables a fine control of subflow sockets. In=
 its
> > > > current state, it allows to put different sockopt on each subflow f=
rom a
> > > > same MPTCP connection (socket mark, TCP congestion algorithm, ...) =
using
> > > > BPF programs.
> > > >
> > > > It should also be the basis of exposing MPTCP-specific fields throu=
gh BPF.
> > >
> > > Looks fine, but I'd like to see the full picture a bit better.
> > > What's the point of just 'token' ? What can be done with it?
> >
> > The idea behind exposing only the token at the moment is that it is
> > the strict minimum required to identify all subflows linked to a
> > single MPTCP connection. Without that, each subflow is seen as a
> > "normal" TCP connection and it is not possible to find a link between
> > each other.
> > In other words, it allows the collection of all the subflows of a
> > MPTCP connection in a BPF map and then the application of per subflow
> > specific policies. More concrete examples of its usage are available
> > at [1].
> >
> > We try to avoid exposing new fields without related use-cases, this is
> > why it is the only one currently. And this one is very important to
> > identify MPTCP connections and subflows.
> >
> > > What are you thinking to add later?
> >
> > The next steps would be the exposure of additional subflow context
> > data like the backup bit or some path manager fields to allow more
> > flexible / accurate BPF decisions.
> > We are also looking at implementing Packet Schedulers [2] and Path
> > Managers through BPF.
> > The ability of collecting all the paths available for a given MPTCP
> > connection - identified by its token - at the BPF level should help
> > for such decisions but more data will need to be exposed later to take
> > smart decisions or to analyse some situations.
> >
> > I hope it makes the overall idea clearer.
> >
> > > Also selftest for new feature is mandatory.
> >
> > I will work on the selftests to add them in a v2. I was not sure a new
> > selftest was required when exposing a new field but now it is clear,
> > thanks!
> >
> >
> > [1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/ex=
amples
> > [2] https://datatracker.ietf.org/doc/draft-bonaventure-iccrg-schedulers/
>
> Thanks! The links are certainly helpful.
> Since long term you're considering implementing path manager in bpf
> I suggest to take a look at bpf_struct_ops and bpf based tcp congestion c=
ontrol.
> It would fit that use case better.

We will definitively take a look at that, thanks ! It is indeed the
direction we should take.

> For now the approach proposed in this patch is probably good enough
> for simple subflow marking. From the example it's not clear what the netw=
orking
> stack is supposed to do with a different sk_mark.
> Also considering using sk local storage instead of sk_mark. It's arbitrar=
y size.

Originally, this use-case was asked by Android for some app specific behavi=
ours.
But the example is provided here to mainly illustrate the possibility
to put different sockopt per subflow knowing their relations with
other subflows.
Indeed in this example, per se, the marking of the subflows has no
interest, it is for illustration purpose only. It was an easy solution
to have quick tests in the userspace through nftables.

Also, the implementation of all the signals allowing dynamic subflows
creation / removal by the path manager to comply with the RFC [1] is
still under heavy development on the MPTCP side, so we cannot provide
more realistic examples at the moment.

[1] https://tools.ietf.org/html/rfc8684#section-3.4
--===============5881723703906952589==--
