Content-Type: multipart/mixed; boundary="===============3353206340142282365=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 17th of September 2020
Date: Sun, 20 Sep 2020 22:43:02 +0800
Message-ID: <CA+WQbwtuE4wnpFzSioSuRvfbOog_ruJMYPLOajpb4T-whFKt6Q@mail.gmail.com>
In-Reply-To: 1a4a3dfe2daa55a37d339b2bd7a1d7bf1c9675fc.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5949

--===============3353206340142282365==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Matt,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8819=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2020-09-18 at 17:45 +0200, Matthieu Baerts wrote:
> > What to send to netdev?:
> >      - ADD/REMOVE addresses changes?:
> >          - we need to wait for the next sync between net and net-next
> >          - we should send a merge request to David Miller before the WE
> >          - TODO: Matth: send this merge request =E2=86=92 Done
>
> After the -net -> net-next merge I think it would be nice submitting
> upstream:
>
> selftests: mptcp: add ADD_ADDR mibs check function
> mptcp: add ADD_ADDR related mibs
> mptcp: send out ADD_ADDR with echo flag
> mptcp: add the incoming RM_ADDR support
> mptcp: add the outgoing RM_ADDR support
> mptcp: rename addr_signal and the related functions
>
> @Geliang: do you agree? could you take care of that? need some help
> with the cover letter? (not that I'm the right person for that ;)))

Thanks. I'll do that after the -net -> net-next merge. I want to submit ups=
tream
all my 13 patches on the export branch once:

 mptcp: rename addr_signal and the related functions
 mptcp: add the outgoing RM_ADDR support
 mptcp: add the incoming RM_ADDR support
 mptcp: send out ADD_ADDR with echo flag
 mptcp: add ADD_ADDR related mibs
 selftests: mptcp: add ADD_ADDR mibs check function
 mptcp: add accept_subflow re-check
 mptcp: remove addr and subflow in PM netlink
 mptcp: implement mptcp_pm_remove_subflow
 mptcp: add RM_ADDR related mibs
 mptcp: add mptcp_destroy_common helper
 selftests: mptcp: add remove cfg in mptcp_connect
 selftests: mptcp: add remove addr and subflow test cases

I'll send out the cover letter to mptcp mailing list for review before
sending these
patches to netdev mailing list.

Thanks.
-Geliang

>
> Cheers,
>
> Paolo
>
>
--===============3353206340142282365==--
