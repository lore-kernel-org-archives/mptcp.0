Content-Type: multipart/mixed; boundary="===============1956987841996139302=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 8th of August 2019
Date: Thu, 08 Aug 2019 19:00:01 +0200
Message-ID: <08627991-b5dd-97cd-5248-7e92b66322cd@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1613

--===============1956987841996139302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 61st meeting with Mat and Peter (Intel OTC), Christoph
(Apple), Paolo and Florian (RedHat) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Accepted patches:
    - Remove unused variable, causes compile warning (2):
        - by Peter
        - Accepted by Mat
        - Squashed in 2 different commits



Pending patches:
    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
        - by Mat
        - Mat has sent a new version (2 August)
        - Waiting for reviews (especially regarding the new flags and
other modifications)
        - Paolo will try to look at it
        - Note: this patch is still fixing the original issue reported
by Mat

    - mptcp: new sysctl to control the activation per NS:
        - by Matthieu
        - still some open questions
        - reviewed by Ossama, Peter, needs to send a v2 for two small
fixes (rename a function and add a comment + maybe rename ctrl.c to
something else)
        - note: no need to rename the ctrl.c file

    - Implement outgoing MP_JOIN:
        - patch-set (10 patches) by Peter
        - Peter has sent a v3
        - waiting for accept
        - Seems good for Paolo
        - Mat will try to have a look

    - Rename lookup_token() to __token_lookup:
        - by Peter
        - 3 patches
        - Paolo is looking at it

    - mptcp: Implement interim path manager:
        - by Peter
        - RFC
        - the idea is to be able to control it via sysctl to ease the tests



Git: sync with upstream (net-next):
    - There was a conflict
    - easy to resolved, see ML for details
    - it was linked to a new callback added in ULP



Feedback from LPC:
    - accepted! (no schedule yet)
    - Paper: 2 to 10 pages (limit: September the 2nd)
    - Presentation: 30 minutes + 10 minutes Q&A
    - Mat, Peter and Matth will be present
    - Matth will setup a new project on sharelatex (or the new service
with a new name) with the template from Netdev 0x12
    - Would be nice to talk about:
        - the diff with mptcp.org
        - diff between now and the initial merge
        - future (roadmap, can change be to give an idea)
        - take into account the feedback we got from Netconf
        - We can take slides from
http://vger.kernel.org/netconf2019_files/FlorianWestphal_netconf2019.pdf



Ci Scripts:
    - detail: ccache is now used to accelerate the compilation as we
always start from a clean workspace (ccache dir is not cleaned).



Packetdrill:
    - Florian is looking at Packetdrill
    - basic tests are already working
    - starting from the current MPTCP version (from Arnaud), hoping to
modify it to fit with upstream (packetdrill repo) standards.
    - seems there are quite a lot of work to do there



Next meeting:
    - /!\ next Thursday (15th of August) is a day off in Italy, in some
regions in Germany and in Belgium
    - We propose to have it next *Wednesday*, the 14th of August.
    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190814



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

--===============1956987841996139302==--
