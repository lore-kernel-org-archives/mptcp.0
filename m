Content-Type: multipart/mixed; boundary="===============0630449173307753197=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 00/10] mptcp: refactor token code
Date: Tue, 27 Aug 2019 18:59:10 +0200
Message-ID: <cbd96f1d-056b-200c-105b-6c7cd746902c@tessares.net>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1714

--===============0630449173307753197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 25/08/2019 20:59, Florian Westphal wrote:
> This series is intentionally marked RFC so noone bothers
> to squash all of this into the mptcp tree.
> =

> The idea is to first do a review-friendly series, with
> each change done in an individual patch.
> =

> Then, once consensus is reached (maybe over several iterations),
> I would send a few larger patches suitable for squashing (rather
> than being review friendly...).
> =

> The patches remove unneeded small helpers, add 'mptcp' prefix
> to non-static functions, add error handling to those that may
> fail and adds a few comments.

That's a very good idea!

For the 'mptcp_' prefix, we made sure to add them to all functions
exposed outside net/mptcp and Peter got the excellent idea to move all
functions only needed in net/mptcp into net/mptcp/protocol.h. We didn't
add 'mptcp_' prefix for all these "internal" functions but it certainly
makes sense to do that. I guess it is useful when debugging if you see
these functions in a call trace or in the list of functions available
for tracing.

Do you think we should do the same for "crypto" and "subflow" and "pm"?
I guess "pm" and "subflow" are keywords mainly used in "mptcp" but it is
maybe not clear for everybody.

The patches look very good to me, just a few questions and one or two
typos, nothing important. I guess other people will also have a look at
them :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0630449173307753197==--
