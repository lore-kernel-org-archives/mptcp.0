Content-Type: multipart/mixed; boundary="===============8173578691957801107=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 4th of April 2019
Date: Thu, 04 Apr 2019 18:33:06 +0200
Message-ID: <82cdb6a5-60e3-9db9-2229-e2957513fa01@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1043

--===============8173578691957801107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 45th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph (Apple), Paolo and Davide (Red Hat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Mat and Peter's patch set:
    - Changes:
        * Peter has modified the internal subflow sockets to use ULP

https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/450099/1

https://github.com/multipath-tcp/mptcp_net-next/commit/0500c9d7586e8fe73c41=
5a89aa1a195da6b02546
        * Fixed building without CONFIG_MPTCP
        * Modified self-test commits to account for removal of
IPPROTO_SUBFLOW

    - Review on Gerrit: don't hesitate to review and give a score ;-)

    - ULP:
        - Mat mentioned that for the moment it is possible to register a
subflow from userspace (setsockopt ULP).
        - it was possible not to allow that before but this has been
removed recently =E2=86=92 @Mat: feel free to share the link to this patch =
;-)
        - we should then re-add this support

    - we should be able to share that with Eric soon:
        - Mat want to do a last change not to send the SKB to the TCP
stack too soon.
        - Paolo is reviewing the code and he has some changes to propose
related to mptcp_send_msg()
        - there are maybe some memory allocating issues found by Paolo,
the trace/log can be shared on the ML.

    - For the kselftests, we can squash them: Paolo is OK / @Florian ?
(it should be fine according to his colleagues :) )



Next steps:
    - Review the architecture design code (Mat & Peter's patch-set)
        - ideally on Gerrit:
https://review.gerrithub.io/q/project:multipath-tcp/mptcp_net-next+status:o=
pen
        - or on the ML if needed.

    - Merge this code in our repo

    - Prepare a cover-letter

    - Send this to Eric for first review

    - What is important and still need to be done: (and this would then
not be part of what we will send to Eric)
        - MP_JOIN
        - coupled received window
        - IPv6
        - DATA-FIN handling

        - Once a first version of the architecture design code is
frozen, feel free to one of these items and share that on the ML ;-)



Next meeting:
    - We propose to have it next Thursday, the 11th of April.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Paolo might not be there but ok for him not to be there
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190411



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

--===============8173578691957801107==--
