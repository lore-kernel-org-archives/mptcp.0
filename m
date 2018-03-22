Content-Type: multipart/mixed; boundary="===============3865996034588514664=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 22th of March 2018
Date: Thu, 22 Mar 2018 11:07:46 -0700
Message-ID: <e0f57439-07de-763f-0b0e-5cfef10b402e@oracle.com>
In-Reply-To: afe2f5d0-b98a-ca29-605d-98d85688946d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 397

--===============3865996034588514664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/22/2018 10:25 AM, Matthieu Baerts wrote:
> Hello,
>
> We just had our third meeting with Mat, Ossama and Peter (Intel OTC), =

> Christoph (Apple) and myself (Tessares).
>
> Thanks again for this new good meeting!
>
> Here are the minutes of the meeting:
>
>
>
> Work from last 7 days:
>
> =C2=A0=C2=A0=C2=A0 - Mat: pretty close to finish his work to get the DSS =
ACK from the =

> SKB. Not fully functional but ready to be tested. We can now parse =

> what it coming back. To have something working with MPTCP and not =

> having a fallback to TCP, we need to at least read the DSS options =

> from the "3rd" ACK. Work was based on net-next. Will first need to =

> have a rebase on latest net-next before sharing code. Will be ready to =

> be tested "soon".
> =C2=A0=C2=A0=C2=A0 - Christoph is looking at the lock-less part, patches =
should =

> arrive very soon.
> =C2=A0=C2=A0=C2=A0 - Matthieu: should send patches for the Netlink PM ver=
y soon.
>
So if I say for some superfluous reason that I do not like any of these =

implementations, they will be rejected and not posted to netdev and no =

discussion will be necessary just as out patch was handled ?

Right ?

As I said in my previous email, the patch we have submitted resolves all =

these issue already, I want to know why it is not good enough and what =

is special about this work ?

Shoaib

>
>
> Indirect function calls:
>
> =C2=A0=C2=A0=C2=A0 - we didn't get new input after asking around.
> =C2=A0=C2=A0=C2=A0 - message from the maintainer: we cannot simply remove=
 them, =

> sometimes needed (e.g. for the drivers)
> =C2=A0=C2=A0=C2=A0 - maybe not the best time to introduce new ones (excep=
t in RFC).
> =C2=A0=C2=A0=C2=A0 - we should certainly reduce their usage to only when =
it is really =

> needed (seems what DaveM said)
>
>
>
> Patches that could be sent to netdev:
>
> =C2=A0=C2=A0=C2=A0 - we need to design them for the maintainers: if they =
are too big =

> with not so many explanations, the maintainers may not take the time =

> to go over them in detail. These "details" seem very important for them.
>
>
>
> Netdevconf:
> =C2=A0=C2=A0=C2=A0 - there was a talk in Ottawa (Netdev 0.1)
> =C2=A0=C2=A0=C2=A0 - what was presented there is still valid at the end.
> =C2=A0=C2=A0=C2=A0 - maybe tutorial (proposed by Jamal): at least to conv=
ince other =

> devs that there is a very big interest. Then: "we are interested by =

> upstreaming that, any recommendations from you guys about (...)?"
> =C2=A0=C2=A0=C2=A0 - please propose ideas on ML. We can discuss about the=
m next week.
> =C2=A0=C2=A0=C2=A0 - We should propose something and discuss about upstre=
aming MPTCP =

> there and get feedback, advises, ideas, more people interested by that =

> or by the issues we have in common with other projects, etc.
> =C2=A0=C2=A0=C2=A0 - Deadline: Proposals must be received on or before Ma=
y 1, 2018
> =C2=A0=C2=A0=C2=A0 - Need to check with managers if we can participate to=
 both Netdev =

> and Linux Plumbers conf.
>
>
>
> kTLS:
> =C2=A0=C2=A0=C2=A0 - https://patchwork.ozlabs.org/patch/888002/
> =C2=A0=C2=A0=C2=A0 - what they are doing is very similar of what we need =
to do with =

> the DSS.
> =C2=A0=C2=A0=C2=A0 - they are maintaining a look-up table not to affect S=
KB size.
> =C2=A0=C2=A0=C2=A0 - callback is used to know when the sent data got ackn=
owledged, so =

> that they can then purge elements out of the lookup-table
>
>
>
> Next steps:
> =C2=A0=C2=A0=C2=A0 - Mat will try to write an email on the ML to summary =
the next =

> steps, what need to be done (from what has already been discussed =

> previously). Note that it is still difficult to have a roadmap because =

> we don't know exactly what the maintainers want, the list can change a =

> lot depending on their feedback. Mat will also testing his new version =

> regarding the problem with SKB size.
> =C2=A0=C2=A0=C2=A0 - Christoph: will continue to polish patches (lock-les=
s) and share =

> them ASAP.
> =C2=A0=C2=A0=C2=A0 - Matthieu: publish Netlink PM patches and fix issues.
> =C2=A0=C2=A0=C2=A0 - Peter will continue the rebase, share it soon. Will =
also have a =

> look at patches posted on ML.
> =C2=A0=C2=A0=C2=A0 - Ossama: will also continue the rebase. Will be off n=
ext week. =

> Happy holidays!
>
>
>
> Next meeting:
> =C2=A0=C2=A0=C2=A0 - proposition: the 29th of March at 9am PDT - 16:00 UT=
C (9am PDT, =

> 6pm CEST)
> =C2=A0=C2=A0=C2=A0 - open to everyone!
> =C2=A0=C2=A0=C2=A0 - https://annuel2.framapad.org/p/mptcp_upstreaming_201=
80329
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


--===============3865996034588514664==--
