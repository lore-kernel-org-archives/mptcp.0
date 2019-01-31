Content-Type: multipart/mixed; boundary="===============5053373221316124012=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 31st of January 2019
Date: Thu, 31 Jan 2019 18:47:04 +0100
Message-ID: <fbf0f5b0-fc0c-a524-62f0-94158281b28d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 983

--===============5053373221316124012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 37th meeting with Mat and Ossama (Intel OTC), Christoph
(Apple), Hoang (UCLouvain) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Mat and Peter's new patch-set:
    - it is on Gerrit:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437388/6
    - Matth and Christoph started the new reviews: see Gerrit
    - Florian commented too:
https://lists.01.org/pipermail/mptcp/2019-January/000981.html
    - Florian mentioned that it could be nice to add a kselftest. We
need to check how other network protocols are doing their kselftests.
(Florian also proposed to have a look at that.)
    - ULP to manage subflows by Peter: seems to be the way to go not to
expose the new proto to userspace, linked to:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437392/6



Integrate changes in MPTCP repo (mptcp_net-next):
    - Proposition to integrate reviewed/validated (code review +2)
changes in mptcp net-next tree. It seems we are all OK with that.
    - Matth can integrate changes directly in topgit (no need to use the
Gerrit' submit button)
    - What would be upstreamed in term of code would be in t/upstream
branch but in term of commits (with the description) would be the result
of a 'tg export'.
    - Matth: what is also possible is to ask the CI to 'tg export' on a
clean branch on top of Dave's net-next. It is something easy to do (with
1 topgit command). Might help people who doesn't want to setup topgit to
export the tree and see the commits messages.



Misc:
    - alternative to topgit but for the future: git evolve
    - doc:
https://github.com/gitster/git/blob/sx/evolve/Documentation/technical/evolv=
e.txt
    - submission:
https://public-inbox.org/git/20190127194415.171035-1-sxenos(a)google.com/t/=
#u



What's next?
    -  we already discussed about that last time but without Peter and
Florian. We report this discussion to next week. Here are the questions
to discuss:
    - focus on the first patch-set and try to upstream this base?
    - integrate Mat and Peter's patch-set in our topgit tree? (or at
least what we agreed on) not to have a lot of pending changes?
    - removing feature on mptcp_net-next/master?
    - testing? (packetdrill?)



mptcp_trunk:
    - two new patches from Christoph. To be reviewed and applied.



Next meeting:
    - We propose to have the next one on Thursday, the 7th of February.
    - Usual time: 17:00 UTC (9am PST, 6pm CET)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190207



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

--===============5053373221316124012==--
