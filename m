Content-Type: multipart/mixed; boundary="===============1179346303360721022=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 12th of September 2019
Date: Thu, 12 Sep 2019 19:12:23 +0200
Message-ID: <86520739-a10c-8048-038b-635578a06a75@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1830

--===============1179346303360721022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 66th (yes, that's a long road as well... OK, I am tired
and it's just to check if people read these notes :-D ) meeting with
Ossama (Intel OTC), Christoph (Apple), Paolo, Florian and Davide
(RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - mptcp: token api refactoring/cleanup:
        - by Florian
        - accepted by Peter/Matth



Pending patches:
    - mptcp: Implement interim path manager:
        - by Peter
        - no more an RFC, 2 patches
        - one of the two has been reviewed, waiting for review for the
second one

    - mptcp: implement retransmit infrastructure:
        - 7 patches
        - by Paolo
        - RFC =E2=86=92 v1 =E2=86=92 v2
        - Waiting for accept

    - mptcp: fix mptcp socket cleanup:
        - by Paolo
        - obsoleted by Florian patch "mptcp: remove token_release"

    - net/mptcp: rcu-ify the subflow context:
        - by Davide
        - waiting for review

    - mptcp_poll rework preview:
        - by Florian
        - RFC
        - Waiting for comments

    - mptcp sparse "fixes":
        - by Florian
        - Waiting for reviews

    - mptcp: remove token_release:
        - by Florian
        - Waiting for application
        - Reviewed by Paolo



Git:
    - Sync with net-next on 20190907: 3 conflicts
    - more details on the ML



Feedback from LPC:
    - IPv6 support will be required for the initial patch-set. That
might delay our plan but that's something we could add at the end.

    - Supporting only MPTCPv1 is to good way to go

    - Creating MPTCP socket can be done by any app as long as we have a
way to block the creation of new sockets in case of issues (CGroup, etc.)

    - I certainly forget things, maybe Peter took some notes when we
were speaking.

    - Recording should be available "soon"



Proposition from Paolo:
    - Could be good to send again the patches that we have to netdev ML
to have some feedbacks

    - last time it was just before netconf, we were "unlucky" =E2=86=92 we
"just" need to have people, who have the knowledge to review it, also
having time to do that.

    - end of the month seems to be a good date

    - should be fine to send what we have with the refactoring at the end



Paolo:
    - when working on the retransmissions (reinjections), he saw:

    - We should rework recvmsg because he is hitting some bugs, hard to
track (because the mapping is missed)

    - Paolo is already looking at that



eBPF SOCKET LOOKUP:
    - maybe interesting for the join for us?



for the MP Join:
    - for the moment, the kernel look for a listen socket (+ token)

    - might be an issue if the client tries to establish a connection to
another port (but the right token)

    - there are use cases for that

    - Note by Paolo: seems possible to have some netfilter rules to
change the port number and "fix" this lack of support



Next meeting:
    - We propose to have it next Thursday, the 19th of September.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190919



Feel free to comment on these points and propose new ones for the next
meeting!


Talk to you next week,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1179346303360721022==--
