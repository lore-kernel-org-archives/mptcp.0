Content-Type: multipart/mixed; boundary="===============5130705146280114928=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/4] mptcp: add MPTCP socket diag
 interface
Date: Thu, 09 Jul 2020 11:44:07 -0700
Message-ID: <20200709114407.2f85a2a8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 9c10bd38adebd1d83bfa03545ec2db34ec2b56e8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4963

--===============5130705146280114928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Jul 2020 20:00:09 +0200 Paolo Abeni wrote:
> On Thu, 2020-07-09 at 10:34 -0700, Jakub Kicinski wrote:
> > On Thu,  9 Jul 2020 15:12:41 +0200 Paolo Abeni wrote:  =

> > > exposes basic inet socket attribute, plus some MPTCP socket
> > > fields comprising PM status and MPTCP-level sequence numbers.
> > > =

> > > Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>  =

> > =

> > Any idea why sparse says this:
> > =

> > include/net/sock.h:1612:31: warning: context imbalance in 'mptcp_diag_g=
et_info' - unexpected unlock
> > =

> > ? =F0=9F=A4=A8  =

> =

> AFAICS, that is a sparse false positive, tied
> to unlock_sock_fast() usage. =

> =

> unlock_sock_fast() conditionally releases the socket lock, according to
> it's bool argument, and that fools sparse check: any unlock_sock_fast()
> user splats it.
> =

> IMHO such warning should be addressed into [un]lock_sock_fast()
> function[s] - if possible at all. Outside the scope of this series.
> =

> Matthieu suggested adding some comment to note the above, but I boldly
> opposed, as current unlock_sock_fast() users don't do that.

Sounds reasonable, thanks!
--===============5130705146280114928==--
