Content-Type: multipart/mixed; boundary="===============7200792434695280323=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Weekly meeting - 12 November 2020 16:00 UTC (8am PDT,
 5pm CET, 12pm CST)
Date: Wed, 11 Nov 2020 18:32:31 +0100
Message-ID: <78a800944b5ffc88c1155def85866cb28bd327ad.camel@redhat.com>
In-Reply-To: 2ed2989a-0989-c3bc-d97b-4c0be44ebf42@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6659

--===============7200792434695280323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-11 at 16:09 +0100, Matthieu Baerts wrote:
> Hello everybody!
> =

> Our public MPTCP upstreaming weekly web conference is scheduled for
> tomorrow.
> =

> The list of topics is available here:
> https://annuel2.framapad.org/p/mptcp_upstreaming_20201112
> =

> Feel free to add/modify topics!

I'd like to post upstream the following patches:

mptcp: send explicit ack on delayed ack_seq incr
mptcp: keep track of advertised windows right edge
mptcp: rework poll+nospace handling
mptcp: try to push pending data on snd una updates
mptcp: move page frag allocation in mptcp_sendmsg()
mptcp: refactor shutdown and close
mptcp: introduce MPTCP snd_nxt
mptcp: add accounting for pending data
mptcp: reduce the arguments of mptcp_sendmsg_frag
mptcp: introduce mptcp_schedule_work
tcp: factor out __tcp_close() helper
mptcp: use tcp_build_frag()
tcp: factor out tcp_build_frag()

in a single series. My plan is let the self-tests run for while on net-
next plus the above and then post (likely, tomorrow before the mtg).

If there are objections or different opinions please let me know!

/P

--===============7200792434695280323==--
