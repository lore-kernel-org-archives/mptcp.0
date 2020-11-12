Content-Type: multipart/mixed; boundary="===============6220661638211703531=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Weekly meeting - 12 November 2020 16:00 UTC (8am PDT,
 5pm CET, 12pm CST)
Date: Wed, 11 Nov 2020 16:21:24 -0800
Message-ID: <7e83d1b1-4cf1-2a1f-15a4-cf7228c63db9@linux.intel.com>
In-Reply-To: 78a800944b5ffc88c1155def85866cb28bd327ad.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6662

--===============6220661638211703531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Nov 2020, Paolo Abeni wrote:

> On Wed, 2020-11-11 at 16:09 +0100, Matthieu Baerts wrote:
>> Hello everybody!
>>
>> Our public MPTCP upstreaming weekly web conference is scheduled for
>> tomorrow.
>>
>> The list of topics is available here:
>> https://annuel2.framapad.org/p/mptcp_upstreaming_20201112
>>
>> Feel free to add/modify topics!
>
> I'd like to post upstream the following patches:
>
> mptcp: send explicit ack on delayed ack_seq incr
> mptcp: keep track of advertised windows right edge
> mptcp: rework poll+nospace handling
> mptcp: try to push pending data on snd una updates
> mptcp: move page frag allocation in mptcp_sendmsg()
> mptcp: refactor shutdown and close
> mptcp: introduce MPTCP snd_nxt
> mptcp: add accounting for pending data
> mptcp: reduce the arguments of mptcp_sendmsg_frag
> mptcp: introduce mptcp_schedule_work
> tcp: factor out __tcp_close() helper
> mptcp: use tcp_build_frag()
> tcp: factor out tcp_build_frag()
>
> in a single series. My plan is let the self-tests run for while on net-
> next plus the above and then post (likely, tomorrow before the mtg).
>
> If there are objections or different opinions please let me know!

Sounds like a good plan, thanks Paolo.

--
Mat Martineau
Intel
--===============6220661638211703531==--
