Content-Type: multipart/mixed; boundary="===============1837601419378134154=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Fri, 04 Dec 2020 11:21:14 +0100
Message-ID: <44e8c96b26e4b8506b9480a7c38b58fb9e6f4b28.camel@redhat.com>
In-Reply-To: 6816d41f-9856-10f1-8b61-8ca75ac1dbc@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7044

--===============1837601419378134154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-03 at 17:47 -0800, Mat Martineau wrote:
> On Mon, 30 Nov 2020, Geliang Tang wrote:
> =

> > This patch created a listening socket when an address with a port-number
> > is added by PM netlink. Then binded the new port to the socket, and
> > listened for the connection.
> > =

> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm_netlink.c | 58 ++++++++++++++++++++++++++++++++++++++++++
> > net/mptcp/protocol.c   |  2 +-
> > net/mptcp/protocol.h   |  3 +++
> > net/mptcp/subflow.c    |  4 +--
> > 4 files changed, 64 insertions(+), 3 deletions(-)
> > =

> =

> Another thing I don't think we discussed yet with this "extra listening =

> socket" approach: what do we do about socket options?

Good point!
> =

> Are there any options we should be concerned about on this listening =

> socket? Should SO_REUSEADDR be set by default?

I think we should _not_ set SO_REUSEADDR. Perhaps we should allow the
netlink APIs to additionally call setsockopt() on this socket with
arguments specified via the netlink API itselfs, but it looks a bit
overkill at this stage ?!?

Paolo

--===============1837601419378134154==--
