Content-Type: multipart/mixed; boundary="===============1142678266419327926=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sockopt: pass set/getsockopt to subflows
Date: Thu, 15 Aug 2019 21:56:34 +0200
Message-ID: <20190815195634.5h5qbbhloci5fbio@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1908151109190.43379@tdsilva-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1642

--===============1142678266419327926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> =

> On Thu, 15 Aug 2019, Florian Westphal wrote:
> =

> > This allows to e.g. set tcp congestion control algorithm
> > on all subflows by issuing the setsockopt on the mptcp meta socket.
> > =

> > In the future we could keep a record of sockopts so we can "replay"
> > them when another subflow is added at a later point in time.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> =

> Hi Florian -
> =

> There are a few problems with passing through all the socket options, and
> adding subflows later is one of them.
> =

> A bigger problem is options that will break MPTCP or lead to unexpected c=
ode
> paths. We don't want TCP_FASTOPEN (for now) or TCP_MD5SIG, for example.
> Fortunately TCP_ULP checks for existing icsk_ulp_ops. The MPTCP socket ow=
ns
> the subflow sockets and the subflows have been modified for MPTCP use, so=
 I
> think it would be better to whitelist specific options that we know are s=
afe
> to adjust. It also limits the combinations of TCP subflow features we have
> to consider for implementation and testing.
> =

> I'd also like to be careful about committing to userspace behavior (like
> "getsockopt returns info for the first subflow"), since we don't want to
> break userspace later.

Ok, can I at least change getsockopt to return -EOPNOTSUPP or similar?

Right now it returns 0 without doing anything, which is not expected.

> What do you think about limiting this to SOL_TCP / TCP_CONGESTION for now,
> and we can expand support for other options as needed?

Sure, I can respin with a whitelist in place.

--===============1142678266419327926==--
