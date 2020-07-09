Content-Type: multipart/mixed; boundary="===============5019731154535940052=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/4] mptcp: add MPTCP socket diag
 interface
Date: Thu, 09 Jul 2020 20:00:09 +0200
Message-ID: <9c10bd38adebd1d83bfa03545ec2db34ec2b56e8.camel@redhat.com>
In-Reply-To: 20200709103405.0075678b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 4962

--===============5019731154535940052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-07-09 at 10:34 -0700, Jakub Kicinski wrote:
> On Thu,  9 Jul 2020 15:12:41 +0200 Paolo Abeni wrote:
> > exposes basic inet socket attribute, plus some MPTCP socket
> > fields comprising PM status and MPTCP-level sequence numbers.
> > =

> > Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> Any idea why sparse says this:
> =

> include/net/sock.h:1612:31: warning: context imbalance in 'mptcp_diag_get=
_info' - unexpected unlock
> =

> ? =F0=9F=A4=A8

AFAICS, that is a sparse false positive, tied
to unlock_sock_fast() usage. =


unlock_sock_fast() conditionally releases the socket lock, according to
it's bool argument, and that fools sparse check: any unlock_sock_fast()
user splats it.

IMHO such warning should be addressed into [un]lock_sock_fast()
function[s] - if possible at all. Outside the scope of this series.

Matthieu suggested adding some comment to note the above, but I boldly
opposed, as current unlock_sock_fast() users don't do that.

Cheers,

Paolo



--===============5019731154535940052==--
