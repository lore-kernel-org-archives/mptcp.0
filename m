Content-Type: multipart/mixed; boundary="===============3527676007994885076=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 17th of September 2020
Date: Wed, 23 Sep 2020 11:10:26 +0200
Message-ID: <a60b615ff6383f7b0cd18050ffe83874b66c73c3.camel@redhat.com>
In-Reply-To: CA+WQbwvDBQdH5WJonaifaJ+s=J2go0ef8SMMiHrFqVR7oBiiMA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5987

--===============3527676007994885076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

cc-ing the ML, so that native english speakers may add their comments;)

On Wed, 2020-09-23 at 16:55 +0800, Geliang Tang wrote:
> Hi Matt, Paolo,
> =

> Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8820=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:43=E5=86=99=E9=81=93=EF=BC=
=9A
> > Hi Paolo, Matt,
> > =

> > Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:08=E5=86=99=E9=81=93=EF=BC=9A
> > > On Fri, 2020-09-18 at 17:45 +0200, Matthieu Baerts wrote:
> > > > What to send to netdev?:
> > > >      - ADD/REMOVE addresses changes?:
> > > >          - we need to wait for the next sync between net and
> > > > net-next
> > > >          - we should send a merge request to David Miller
> > > > before the WE
> > > >          - TODO: Matth: send this merge request =E2=86=92 Done
> > > =

> > > After the -net -> net-next merge I think it would be nice
> > > submitting
> > > upstream:
> > > =

> > > selftests: mptcp: add ADD_ADDR mibs check function
> > > mptcp: add ADD_ADDR related mibs
> > > mptcp: send out ADD_ADDR with echo flag
> > > mptcp: add the incoming RM_ADDR support
> > > mptcp: add the outgoing RM_ADDR support
> > > mptcp: rename addr_signal and the related functions
> > > =

> > > @Geliang: do you agree? could you take care of that? need some
> > > help
> > > with the cover letter? (not that I'm the right person for that
> > > ;)))
> > =

> > Thanks. I'll do that after the -net -> net-next merge. I want to
> > submit upstream
> > all my 13 patches on the export branch once:
> > =

> >  mptcp: rename addr_signal and the related functions
> >  mptcp: add the outgoing RM_ADDR support
> >  mptcp: add the incoming RM_ADDR support
> >  mptcp: send out ADD_ADDR with echo flag
> >  mptcp: add ADD_ADDR related mibs
> >  selftests: mptcp: add ADD_ADDR mibs check function
> >  mptcp: add accept_subflow re-check
> >  mptcp: remove addr and subflow in PM netlink
> >  mptcp: implement mptcp_pm_remove_subflow
> >  mptcp: add RM_ADDR related mibs
> >  mptcp: add mptcp_destroy_common helper
> >  selftests: mptcp: add remove cfg in mptcp_connect
> >  selftests: mptcp: add remove addr and subflow test cases
> > =

> > I'll send out the cover letter to mptcp mailing list for review
> > before
> > sending these
> > patches to netdev mailing list.
> > =

> =

> Today the depending on patches have been merged to net-next, so it's
> the
> time to submit upstream RM_ADDR and ADD_ADDR echo patches. Here is
> the
> cover letter of these patches for net-next, please review it for me:
> =

> '''
> To: Mat Martineau <mathew.j.martineau(a)linux.intel.com>, Matthieu
> Baerts <matthieu.baerts(a)tessares.net>,
>      "David S. Miller" <davem(a)davemloft.net>, Jakub Kicinski <
> kuba(a)kernel.org>
> Cc: netdev(a)vger.kernel.org, mptcp(a)lists.01.org
> =

> Subject: [MPTCP][PATCH net-next 00/16] mptcp: RM_ADDR/ADD_ADDR
> enhancements
> =

> This series include two enhancements for MPTCP path management,
> RM_ADDR
> support and ADD_ADDR echo support. These two enhancements had been
> developed in the last two months simultaneously, and been merged to
> mptcp_net-next's export branch successively, so they are separated in
> this series.

I suggest avoding (here and later) references to export branch: that is
a workflow detail. I would drop """These two...""" and perhaps add some
references to the RFC:

"""
This series include two enhancements for the MPTCP path management,
namely RM_ADDR support and ADD_ADDR echo support, as specified by RFC
sections 3.4.1. and 3.4.2.
"""

> 1 RM_ADDR support include 9 patches (1-3 and 8-13):
> =

> Patch 1 is the helper for patch 2, these two patches add the RM_ADDR
> outgoing functions, which are copied from ADD_ADDR's corresponding
                                ^^^^^^ "derived" (or "inspired") sounds
better ;)
> functions.
> =

> Patch 3 adds the RM_ADDR incoming logic, when RM_ADDR suboption is
> received, close the subflow matching the rm_id, and update PM
> counter.
> =

> Patch 8 is the main remove routine. When the PM netlink removes an
> address,
> we traverse all the existing msk sockets to find the relevant
> sockets. Then
> trigger the RM_ADDR signal and remove the subflow which using this
> local
> address, this subflow removing functions has been implemented in
> patch 9.
> =

> Finally, patches 10-13 are the self-tests for RM_ADDR.
> =

> 2 ADD_ADDR echo support include 7 patches (4-7 and 14-16).
> =

> Patch 4 adds the ADD_ADDR echo logic, when the ADD_ADDR suboption has
> been
> received, send out the same ADD_ADDR suboption with echo-flag, and no
> HMAC
> included.
> =

> Patches 5-6 are the self-tests for ADD_ADDR echo. Patch 7 is a little
> cleaning up.
> =

> Patch 14 and 15 are the helpers for patch 16. These three patches add
> the ADD_ADDR retransmition when no ADD_ADDR echo is received.
> =

> This series have been reviewed and tested by MPTCP upstreaming team.

As said above, I would drop this last sentence - I fear it could be
perceived as a "we don't need netdev reviews" statement.

Cheers,

Paolo

> =

> Geliang Tang (16):
>   mptcp: rename addr_signal and the related functions
>   mptcp: add the outgoing RM_ADDR support
>   mptcp: add the incoming RM_ADDR support
>   mptcp: send out ADD_ADDR with echo flag
>   mptcp: add ADD_ADDR related mibs
>   selftests: mptcp: add ADD_ADDR mibs check function
>   mptcp: add accept_subflow re-check
>   mptcp: remove addr and subflow in PM netlink
>   mptcp: implement mptcp_pm_remove_subflow
>   mptcp: add RM_ADDR related mibs
>   mptcp: add mptcp_destroy_common helper
>   selftests: mptcp: add remove cfg in mptcp_connect
>   selftests: mptcp: add remove addr and subflow test cases
>   mptcp: add struct mptcp_pm_add_entry
>   mptcp: add sk_stop_timer_sync helper
>   mptcp: retransmit ADD_ADDR when timeout
> =

>  include/net/sock.h                            |   2 +
>  net/core/sock.c                               |   7 +
>  net/mptcp/mib.c                               |   4 +
>  net/mptcp/mib.h                               |   4 +
>  net/mptcp/options.c                           |  81 +++--
>  net/mptcp/pm.c                                |  91 ++++--
>  net/mptcp/pm_netlink.c                        | 276
> +++++++++++++++++-
>  net/mptcp/protocol.c                          |  30 +-
>  net/mptcp/protocol.h                          |  39 ++-
>  net/mptcp/subflow.c                           |   3 +-
>  .../selftests/net/mptcp/mptcp_connect.c       |  18 +-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 189 +++++++++++-
>  12 files changed, 674 insertions(+), 70 deletions(-)
> '''
> =

> Thanks very much.
> -Geliang
> =

> =

> > Thanks.
> > -Geliang
> > =

> > > Cheers,
> > > =

> > > Paolo
> > > =

> > >=20

--===============3527676007994885076==--
