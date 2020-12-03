Content-Type: multipart/mixed; boundary="===============6790858653572510404=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/3] security: add const qualifier to
 struct sock in various places
Date: Thu, 03 Dec 2020 14:24:09 -0800
Message-ID: <20201203142409.3bbc068f@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: alpine.LRH.2.21.2012040407080.9312@namei.org
X-Status: 
X-Keywords:                  
X-UID: 7029

--===============6790858653572510404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Dec 2020 04:07:16 +1100 (AEDT) James Morris wrote:
> On Wed, 2 Dec 2020, Jakub Kicinski wrote:
> > On Mon, 30 Nov 2020 16:36:29 +0100 Florian Westphal wrote:  =

> > > A followup change to tcp_request_sock_op would have to drop the 'cons=
t'
> > > qualifier from the 'route_req' function as the
> > > 'security_inet_conn_request' call is moved there - and that function
> > > expects a 'struct sock *'.
> > > =

> > > However, it turns out its also possible to add a const qualifier to
> > > security_inet_conn_request instead.
> > > =

> > > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > > ---
> > >  The code churn is unfortunate.  Alternative would be to change
> > >  the function signature of ->route_req:
> > >  struct dst_entry *(*route_req)(struct sock *sk, ...
> > >  [ i.e., drop 'const' ].  Thoughts?  =

> > =

> > Security folks - is this okay to merge into net-next?
> > =

> > We can put it on a branch and pull into both trees if the risk =

> > of conflicts is high.  =

> =

> Acked-by: James Morris <jamorris(a)linux.microsoft.com>

Thank you!

Into net-next it goes..
--===============6790858653572510404==--
