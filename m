Content-Type: multipart/mixed; boundary="===============1442690723914292909=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 27th of June 2019
Date: Fri, 12 Jul 2019 10:00:30 +0200
Message-ID: <f58692f9-380f-0117-7231-30b53dbd2b94@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1490

--===============1442690723914292909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday, we had our 57th meeting with Peter (Intel OTC), Paolo and
Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - Change sock->sk_protocol to a 16-bit value:
        - by Mat
        - accepted at the last meeting
        - 2 new topic, 1 "squashed" commit.



Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - commented by Paolo
        - Paolo is looking at the different other possibilities, hard to
reuse the existing helpers, maybe use the wait event API. Paolo is
investigating that. Paolo will reply later on the ML.

    - mptcp: harmonize locking on all socket operations:
        - by Paolo
        - RFC and v1 sent
        - commented by Mat, Peter and Florian
        - v2 has been sent just after the meeting

    - mptcp: simplify crypto.c:
        - by Davide
        - reviewed by Mat, Florian and Christoph
        - a new version has been sent just after the meeting



Error kselftest:
    - looks similar to the previous ones we had:
        - Paolo was testing with the pending patches but it seems the
problem is somewhere else (not fixed with these patches)



Sync with net-next:
    - got a conflict
    - easy to resolve
    - tests are still OK



Feedback from netdev:
    - nobody at the meeting receives any feedback



Feedback from LPC:
    - abstract has been sent by Mat

    - who would like to participate (if we are selected)?
        - Peter would be glad to help (presentation and/or paper)
        - Paolo would be able to help for the paper, not sure yet if he
will be able to go on site.

    - no feedback yet.



sysctl to disable MPTCP:
    - for security reason
    - could be turned off by default, only admin can turn on MPTCP
    - Matth has a prototype
    - Matth has sent that just after the meeting



icsk->icsk_ulp_data is probably going to be RCU-ified:
    - some (small) fix to annotation will probably be needed to fix
sparse warning

    - affect only kTLS because it can be compiled as a module

    - Jakub Kicinski from  Netronome has a patch for that

    - after that, we will need to add an annotation in MPTCP code (ULP)
to avoid sparse warning

    - could be good to execute sparse on the CI job =E2=86=92 *@Matth*
        - anybody can propose updates for the scripts in the "scripts"
branch ;-)

    - anybody is testing MPTCP with Sparse?
        - Not from someone at the meeting
        - *@Davide* will do that this week



About complex patches:
    - recreating them from scratch will be complex (to re-create the
"natural" evolution)

    - rebasing/squashing should be the way to go

    - when to do that?:
        - We can do that "just" before the submission
        - If the refs are set in the commit message, Matth can do this
job sooner, especially if we already know where it needs to go.
        - but in some cases, that might be good to dedicate a commit to
show an important decision we took.



Next meeting:
    - We propose to have it next Thursday, the 18th of July.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190718



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

--===============1442690723914292909==--
