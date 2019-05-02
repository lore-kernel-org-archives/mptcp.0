Content-Type: multipart/mixed; boundary="===============2524204488322153373=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 2nd of May 2019
Date: Thu, 02 May 2019 18:46:03 +0200
Message-ID: <05455aa5-7862-0fdd-ad5d-b65c379cb2fb@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1110

--===============2524204488322153373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 48th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Florian, Paolo, Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Netlink PM client:
    * we can follow the progression / contribute there:
https://github.com/intel/mptcpd/pull/15

    * many attributes are the same

    * idea for the future:
        * an application could set a strategy via a setsockopt
        * netlink PM would give this info to the daemon



MPTCP.org:
    * MPTCP might suffer from a similar bug discovered in SCTP but
already backported in most stable versions
https://github.com/torvalds/linux/commit/66033f47ca60294a95fc85ec3a3cc909da=
b7b765



Architecture:
    * new patch: mptcp: honor net namespace when creating subflow sk =E2=86=
=92
squashed in the series

    * bug: scheduling-while-atomic splat in mptcp_shutdown =E2=86=92 change
conn_list type to list_head (WIP by Paolo)

    * mptcp: selftests: switch to netns+veth based tests =E2=86=92 not in R=
FCv10
but has been appended

    * RFCv10:
        * new patch in the series:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/452480

        * Changes:
            1) Split the mptcp.h header file
                internal header file
            2) Refined handling CONFIG_MPTCP vs non-CONFIG_MPTCP builds
                better for the compiler =E2=86=92 compiler can remove unused
code "like it was before"
            3) Refactored option writing code to minimize changes in
tcp_output.c and avoid using magic numbers
            4) Added ULP clone hook and modified MPTCP subflow cloning
to use it
            5) Florian's namespacing fix and conn_finished fix (rx dst
update crash)
            6) Fix locking in mptcp_recvmsg()

    * remaining change: Paolo's fix about sendmsg()



Code:
    * keeping track of the pending patches is quite difficult

    * merge the beginning of the patch set in our repo =E2=86=92 still using
topgit? (Matth can manage that, nobody else would need to deal with it)

    * What we just agreed on (as always, feel free to correct me if it
is not correct ;-) ):

        * We merge all the patch-set available on Gerrit in our repo

        * We do that via TopGit (Matthieu will handle that):
            * devs don't need to deal with TopGit, only Matthieu and the
scripts will play with TG

            * in case of issue with TopGit, we can still stop everything
and maintain the "export" branch manually

        * If corrections need to be done, we propose a patch (on top of
"for-review" branch or "export" if you prefer):

            * in the commit message, we mark if we want to amend it to
another commit (also use the commit title: "export" branch is rebased
once per day) or to append at the end of the series.

            * we can of course add new commits at the end and still do
the rebase job later, not to loose time doing a constant rebase. We can
do this bigger job later, just before the submission to Netdev.

            * we can use Gerrit or Mailing List:

                * we "had to" use Gerrit because the patches were in
review for a long time, that's was easier to follow.

                * if the patch sent by mail are quickly reviewed and
accepted, we can merge them and that should be OK to follow.



Next meeting:
    - We propose to have it next Thursday, the 9th of May.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190509



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2524204488322153373==--
