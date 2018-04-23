Content-Type: multipart/mixed; boundary="===============1466592687647907116=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Mon, 23 Apr 2018 13:13:41 -0700
Message-ID: <9bd1a123-b4fb-00d4-0cc9-1200cbb71bc5@oracle.com>
In-Reply-To: 021c8818-f78d-5e02-9a76-aaa715ac39c8@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 545

--===============1466592687647907116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

For the next meeting on the 26th can you add discussion of Oracle's patch.

Thanks,

Shoaib


On 04/16/2018 10:18 AM, Matthieu Baerts wrote:
> Hello,
>
> We just had our 6th meeting with Mat (Intel OTC), Christoph (Apple) =

> and myself (Tessares).
>
> Thanks again for this new good meeting!
>
> Please note that this meeting was exceptionally on Monday because it =

> was not possible to have it at the end of last week nor at the end of =

> this week. We propose to have the next meeting next Thursday (26th of =

> April). Feel free to propose other dates if needed.
>
>
>
> Here are the minutes of the meeting:
>
>
>
> Progress from last week:
> =C2=A0=C2=A0=C2=A0 - as expected, many people off or busy with other stuf=
fs, not so =

> much new to share.
> =C2=A0=C2=A0=C2=A0 - Mat has updated the mptcp_net-net repo (see below)
> =C2=A0=C2=A0=C2=A0 - Mat is dealing with issue on the client side (versio=
n from =

> github.com/multipath-tcp/mptcp) when using it with a modified server =

> (having his patches). More discussions will continue later with a pcap.
> =C2=A0=C2=A0=C2=A0 - Matthieu finished the review of Christoph's patches =
(Note for =

> myself: not the review of Christoph's Paasch, that's different...). Do =

> not hesitate to review the two last commits.
>
>
>
> mptcp_net-next merge:
> =C2=A0=C2=A0=C2=A0 - Mat started the work: =

> https://github.com/multipath-tcp/mptcp_net-next/
> =C2=A0=C2=A0=C2=A0 - one fix has been done (related to checksum and gso),=
 seems OK, =

> feel free to comment if not: =

> https://github.com/multipath-tcp/mptcp_net-next/commit/6ba7f217d3a69a8815=
2a3fbee8b9dfc47c77bf4d
> =C2=A0=C2=A0=C2=A0 - Christoph will try to launch some tests using this b=
ranch
> =C2=A0=C2=A0=C2=A0 - Could be good to merge with net-next once per week t=
o reduce the =

> amount of conflicts we need to fix in once
> =C2=A0=C2=A0=C2=A0 - Could be good to have two branches:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - one close to net-next and th=
e current mptcp_trunk
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - one where we have a minimal =
implementation =E2=86=92 focus on the =

> client, simple version.
>
>
>
> netdevconf:
> =C2=A0=C2=A0=C2=A0 - tutorial ideas: more should come. Feel free to propo=
se any idea.
> =C2=A0=C2=A0=C2=A0 - Matthieu is trying to get more ideas
> =C2=A0=C2=A0=C2=A0 - Matthieu: will start a dedicated discussion on the M=
L (should do =

> that on Wednesday (or short after) after having collected more ideas)
>
>
>
> topgit to manage patch sets, maybe not needed now, maybe later
> =C2=A0=C2=A0=C2=A0 - looks like a good tool for what we have to do
> =C2=A0=C2=A0=C2=A0 - could be good to have a look:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/mackyle/top=
git (new version -- recommended)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/greenrd/top=
git (original version)
> =C2=A0=C2=A0=C2=A0 - Matthieu has some experiences with it if you need so=
me support.
> =C2=A0=C2=A0=C2=A0 - Feel free to try it, instructions are in the README
>
>
>
> LPC:
> =C2=A0=C2=A0=C2=A0 - From Mat: still not clear what it will be.
> =C2=A0=C2=A0=C2=A0 - it is possible that they will have more miniconferen=
ces and they =

> will prefer that
> =C2=A0=C2=A0=C2=A0 - but will be a lot of people there (davem), very inte=
resting to =

> participate, get feedback, help, advises, etc.
> =C2=A0=C2=A0=C2=A0 - the networking track submission deadline for LPC is =
July 11: =

> http://vger.kernel.org/lpc-networking.html =E2=86=92 350 word proposal fo=
r a =

> 40 minute talk plus 2-10 page paper.
>
>
>
> Next steps:
> =C2=A0=C2=A0=C2=A0 - Mat: wiki update: with links, etc. (could be good, w=
hen the base =

> is there, to have some help to maintain that, at least reporting =

> outdated links, etc.
> =C2=A0=C2=A0=C2=A0 - Christoph: will first look at the lockless patches t=
hen maybe =

> look at the net-next branch
> =C2=A0=C2=A0=C2=A0 - Peter will also look at mptcp-net-next branch + cont=
inue to work =

> on the patch-set with Mat
> =C2=A0=C2=A0=C2=A0 - Matthieu: update Netlink PM patches.
>
>
>
> Next meeting:
> =C2=A0=C2=A0=C2=A0 - proposition: the 26th of April at 9am PDT - 16:00 UT=
C (9am PDT, =

> 6pm CEST)
> =C2=A0=C2=A0=C2=A0 - open to everyone!
> =C2=A0=C2=A0=C2=A0 - https://annuel2.framapad.org/p/mptcp_upstreaming_201=
80426
>
>
>
> Feel free to comment these points and propose new ones for the next =

> meeting!
>
>
>
> Talk to you next week,
> Matthieu


--===============1466592687647907116==--
