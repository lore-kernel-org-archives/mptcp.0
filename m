Content-Type: multipart/mixed; boundary="===============5608934711204712965=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
Date: Tue, 25 Aug 2020 20:55:43 +0200
Message-ID: <CACXrtpQCE-Yp9=7fbH9sB7-4k-OO12JD18JU=9GL_sYHcmnDtA@mail.gmail.com>
In-Reply-To: 20200824220100.y33yza2sbd7sgemh@ast-mbp.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 5619

--===============5608934711204712965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

Thanks for the feedback!

On Tue, Aug 25, 2020 at 12:01 AM Alexei Starovoitov
<alexei.starovoitov(a)gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 05:15:38PM +0200, Nicolas Rybowski wrote:
> > Previously it was not possible to make a distinction between plain TCP
> > sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
> >
> > This patch series now enables a fine control of subflow sockets. In its
> > current state, it allows to put different sockopt on each subflow from a
> > same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
> > BPF programs.
> >
> > It should also be the basis of exposing MPTCP-specific fields through B=
PF.
>
> Looks fine, but I'd like to see the full picture a bit better.
> What's the point of just 'token' ? What can be done with it?

The idea behind exposing only the token at the moment is that it is
the strict minimum required to identify all subflows linked to a
single MPTCP connection. Without that, each subflow is seen as a
"normal" TCP connection and it is not possible to find a link between
each other.
In other words, it allows the collection of all the subflows of a
MPTCP connection in a BPF map and then the application of per subflow
specific policies. More concrete examples of its usage are available
at [1].

We try to avoid exposing new fields without related use-cases, this is
why it is the only one currently. And this one is very important to
identify MPTCP connections and subflows.

> What are you thinking to add later?

The next steps would be the exposure of additional subflow context
data like the backup bit or some path manager fields to allow more
flexible / accurate BPF decisions.
We are also looking at implementing Packet Schedulers [2] and Path
Managers through BPF.
The ability of collecting all the paths available for a given MPTCP
connection - identified by its token - at the BPF level should help
for such decisions but more data will need to be exposed later to take
smart decisions or to analyse some situations.

I hope it makes the overall idea clearer.

> Also selftest for new feature is mandatory.

I will work on the selftests to add them in a v2. I was not sure a new
selftest was required when exposing a new field but now it is clear,
thanks!


[1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/exampl=
es
[2] https://datatracker.ietf.org/doc/draft-bonaventure-iccrg-schedulers/
--===============5608934711204712965==--
