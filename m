Content-Type: multipart/mixed; boundary="===============5419057087819742813=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 29th of March 2018
Date: Tue, 03 Apr 2018 09:16:39 -0700
Message-ID: <20180403161639.GT71178@MacBook-Pro-6.lan>
In-Reply-To: 1b56b542-453d-d56d-33aa-f5972a727d1d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 500

--===============5419057087819742813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,


thanks for the notes. Just a little clarification inline:

On 30/03/18 - 16:55:43, Matthieu Baerts wrote:
> Hello,
> =

> We just had our 4th meeting with Mat and Peter (Intel OTC), Christoph
> (Apple) and myself (Tessares).
> =

> Thanks again for this new good meeting!
> =

> Here are the minutes of the meeting:
> =

> =

> =

> - discussion of Rao Shoaib's patches:
>     - Christoph posted some comments
>     - Peter has comments but mainly similar to the ones of Christoph. Will
> try to post comments the coming days.
>     - Rao was not able to join, we hope we will be able to discuss about
> reviews that were done for these patches (or a v2) next week.
> =

> =

> =

> - Netlink PM (Matthieu's patches)
>     * Discussion on missed events: it is very rare. A bit like loosing UDP
> packets between apps on the same host. We can have a PM with Netlink. Cou=
ld
> be interesting to get stats of lost events.
>     * _CREATED vs. _ESTABLISHED: we would like to have a simple v1, with
> only the minimum required. Not having the _CREATED event could be OK, we
> would not announce ADD_ADDR ASAP but on the other hand, if the client
> receives this while the session is not "ESTABLISHED", it cannot create a
> second subflow.
>     * Goal: simple API that can be extended later.
>     * (lot of discussions about that but it was difficult to take notes at
> the same points for me).
> =

> =

> =

> - lockless subflows (Christoph's patches)
>     - one more fix coming

Yes - the fix is independent of the lockless subflow patches though. It's
fixing a generic bug in MPTCP.


Cheers,
Christoph


--===============5419057087819742813==--
