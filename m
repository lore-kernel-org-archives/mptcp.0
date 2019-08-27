Content-Type: multipart/mixed; boundary="===============4176954719756650035=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 00/10] mptcp: refactor token code
Date: Tue, 27 Aug 2019 20:06:45 +0200
Message-ID: <20190827180645.GC20113@breakpoint.cc>
In-Reply-To: cbd96f1d-056b-200c-105b-6c7cd746902c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1720

--===============4176954719756650035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> For the 'mptcp_' prefix, we made sure to add them to all functions
> exposed outside net/mptcp and Peter got the excellent idea to move all
> functions only needed in net/mptcp into net/mptcp/protocol.h. We didn't
> add 'mptcp_' prefix for all these "internal" functions but it certainly
> makes sense to do that. I guess it is useful when debugging if you see
> these functions in a call trace or in the list of functions available
> for tracing.
> =

> Do you think we should do the same for "crypto" and "subflow" and "pm"?
> I guess "pm" and "subflow" are keywords mainly used in "mptcp" but it is
> maybe not clear for everybody.

Yes.  Subflow is maybe fine though.

pm is 'power mangement', so I think it makes sense to prefix mptcp_
there.

> The patches look very good to me, just a few questions and one or two
> typos, nothing important. I guess other people will also have a look at
> them :)

Thanks a lot for the review, I will respin a new version later this
week.

--===============4176954719756650035==--
