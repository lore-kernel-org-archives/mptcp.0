Content-Type: multipart/mixed; boundary="===============4763248548936498336=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 4th of October 2018
Date: Thu, 04 Oct 2018 18:45:48 +0200
Message-ID: <d89753fd-9e54-0aa4-9b16-00960a1a0ae0@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 762

--===============4763248548936498336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 24th meeting with Mat, Peter and Ossama (Intel OTC),
Christoph and Vishnu (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:




Podcast interview:
    - We might participate to a podcast, related to our presentation
@Netdev 0x12
    - Matth will reply that OK to participate, we will check later who
can join but should be fine for Christoph and maybe Mat (and Matth if
not alone and needed :) )



current MPTCP:
    - Matth saw some "MPTCP traffic", maybe a kind of attack but looked
like forged SYN packet with add-addr, was not an issue, just strange to see:
        Flags [S], seq 94050709, win 8192, options [mss 1380,nop,wscale
7,nop,nop,sackOK,mptcp add-addr[bad opt]
    - Matth saw a crash with mptcp_v0.94, last update (4.14.73), we
still need to investigate that
    - New release v0.93.2 =E2=86=92  start looking at that tomorrow, was de=
layed.



Packetdrill with MPTCP:
    - Waiting for a reply from Neal and Intel
    - contributing to Packetdrill (official version): we need to sign
the "Contributor agreement" =E2=86=92 we need to check if OK for everybody =
who
wants/can contribute.



Christoph:
    - continuing removing feature:
        - fast open
        - PM selection
        - scheduler selection
        - (...)
    - next step:
        - testing
        - publishing -> published in branch nn_cpaasch_current in the
mptcp_net-next repository.
        - removing client side



Mat & Peter:
    - improving the patch after review
    - improving send message part
    - good progress on the rebasing stuff
    - will focus on the server first (as agreed before)
    - will propose that on top of net-next
    - Christoph will push his modifications on another branch for Peter
to get sync with what Christoph did.



Ossama:
    - Continuing on the Open-Sourcing process
    - Should be released soon, finger crossed



Linux Plumbers:
    - https://blog.linuxplumbersconf.org/2018/ =E2=86=92 Conference is almo=
st
completely full



Other events:
    - https://lwn.net/Calendar/ =E2=86=92 not so many things in 2018
    - maybe? https://lca2019.linux.org.au/programme/
    - (we need to share code anyway :) )



Git repo:
    - proposition to push stuffs on the git repo, their latest version,
easier to sync
    -
https://github.com/multipath-tcp/mptcp_net-next/tree/nn_cpaasch_current
=E2=86=92 latest work from Christoph



Next meeting:
    - We propose to have it on Thursday, the 11th of October. Usual
time: 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20181011



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

--===============4763248548936498336==--
