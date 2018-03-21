Content-Type: multipart/mixed; boundary="===============7097683710508052635=="
MIME-Version: 1.0
From: Krystad, Peter <peter.krystad at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/1] Add MPTCP code to work with the modified TCP
 code
Date: Wed, 21 Mar 2018 20:18:04 +0000
Message-ID: <1521663482.23414.4.camel@intel.com>
In-Reply-To: ae22c65d-23bb-74bf-abc1-ab81a7334325@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 389

--===============7097683710508052635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao -

On Thu, 2018-03-01 at 12:02 -0800, Rao Shoaib wrote:
> =

> On 03/01/2018 11:20 AM, Christoph Paasch wrote:
> > On 28/02/18 - 16:49:52, rao.shoaib(a)oracle.com wrote:
> > > From: Rao Shoaib <rao.shoaib(a)oracle.com>
> > > =

> > > Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
> > > ---
> > >   include/net/mptcp.h          | 1474 +++++++++++++++++++++
> > >   include/net/mptcp_v4.h       |   56 +
> > >   include/net/mptcp_v6.h       |   56 +
> > >   include/net/netns/mptcp.h    |   52 +
> > >   net/Kconfig                  |    1 +
> > >   net/Makefile                 |    1 +
> > >   net/mptcp/Kconfig            |  129 ++
> > >   net/mptcp/Makefile           |   22 +
> > >   net/mptcp/mptcp_balia.c      |  267 ++++
> > >   net/mptcp/mptcp_binder.c     |  487 +++++++
> > >   net/mptcp/mptcp_coupled.c    |  270 ++++
> > >   net/mptcp/mptcp_ctrl.c       | 2981
> > > ++++++++++++++++++++++++++++++++++++++++++
> > >   net/mptcp/mptcp_fullmesh.c   | 1877 ++++++++++++++++++++++++++
> > >   net/mptcp/mptcp_input.c      | 2970
> > > +++++++++++++++++++++++++++++++++++++++++
> > >   net/mptcp/mptcp_ipv4.c       |  345 +++++
> > >   net/mptcp/mptcp_ipv6.c       |  316 +++++
> > >   net/mptcp/mptcp_ndiffports.c |  169 +++
> > >   net/mptcp/mptcp_ofo_queue.c  |  177 +++
> > >   net/mptcp/mptcp_olia.c       |  309 +++++
> > >   net/mptcp/mptcp_output.c     | 1837 ++++++++++++++++++++++++++
> > >   net/mptcp/mptcp_pm.c         |  178 +++
> > >   net/mptcp/mptcp_redundant.c  |  268 ++++
> > >   net/mptcp/mptcp_rr.c         |  301 +++++
> > >   net/mptcp/mptcp_sched.c      |  597 +++++++++
> > >   net/mptcp/mptcp_wvegas.c     |  268 ++++
> > >   25 files changed, 15408 insertions(+)
> > =

> > Please read the sections "Separate your changes" and "E-mail size"
> > of
> > process/submitting-patches.rst.
> =

> If you are worried about the size than do not use it. I am not
> asking =

> for review, just posting it in case someone wants to try out MPTCP
> with =

> my changes.
> =



It seems now you are asking for a review. Can we get this as a patch
relative to the existing MPTCP implementation so we can see your work?

Thanks,

Peter.

> Shoaib
> > Christoph
> > =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
--===============7097683710508052635==--
