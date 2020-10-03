Content-Type: multipart/mixed; boundary="===============7179180521776157516=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 00/13] mptcp: support for queuing data at
 mptcp-level
Date: Sat, 03 Oct 2020 12:48:45 +0200
Message-ID: <0a7f4c7a-45b1-747e-0c68-46abf4880b99@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2010021717220.58928@huizhan1-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6177

--===============7179180521776157516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo, Florian,

On 03/10/2020 02:27, Mat Martineau wrote:
> =

> On Fri, 2 Oct 2020, Paolo Abeni wrote:
> =

>> This is necessary to cope correctly with large sendbuffer (larger then =

>> snd wnd)
>> while respecting the MPTCP level snd window.
>>
>> A major rework of both xmit and shudown path is required to support this
>> feature (patches 8 and 9). To try to keep the related patches as small as
>> possible, a bunch of new helpers is created by patches 3-7.
>> Note that patch 5 can stand for it's own merit and possibly be =

>> upstreamed soon.
>>
>> Finally patch 10 uses the MPTCP equivalent of =

>> tcp_push_pending_frames(), to
>> spool queued data ad MPTCP level, as soon as the windows allow that.
>>
>> Patches 1 and 2 are bugfixes for the current upstream tree will
>> target -net/-net-next soon.
>>
>> Patch 13 is possibly a bit too aggressive, perhaps it could be left =

>> staging
>> in export branch for a while.
>>
>> This iteration fixes all known pending issue present in previous =

>> snapshow.
>> Note that we still hit some unexpected out of receive window events, =

>> but the
>> issue was already present in the export branch and its fix is =

>> unrelated to
>> this work.
>>
>> Florian Westphal (2):
>> =C2=A0mptcp: rework poll+nospace handling
>> =C2=A0mptcp: keep track of advertised windows right edge
>>
>> Paolo Abeni (11):
>> =C2=A0mptcp: more DATA FIN fixes
>> =C2=A0mptcp: don't skip needed ack
>> =C2=A0tcp: factor out __tcp_close() helper
>> =C2=A0mptcp: introduce mptcp_schedule_work
>> =C2=A0mptcp: reduce the arguments of mptcp_sendmsg_frag
>> =C2=A0mptcp: add accounting for pending data
>> =C2=A0mptcp: introduce MPTCP snd_nxt
>> =C2=A0mptcp: refactor shutdown and close
>> =C2=A0mptcp: move page frag allocation in mptcp_sendmsg()
>> =C2=A0mptcp: try to push pending data on snd una updates
>> =C2=A0mptcp: send explicit ack on delayed ack_seq incr
>>
>> include/net/tcp.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> net/ipv4/tcp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
>> net/mptcp/options.c=C2=A0 |=C2=A0 40 +-
>> net/mptcp/pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> net/mptcp/protocol.c | 909 +++++++++++++++++++++++++------------------
>> net/mptcp/protocol.h |=C2=A0 69 +++-
>> net/mptcp/subflow.c=C2=A0 |=C2=A0 34 +-
>> 7 files changed, 648 insertions(+), 417 deletions(-)
>>
> =

> Paolo & Matthieu -
> =

> I just saw your Friday discussion on irc (had some kind of client/znc =

> issue today), I think it would be good to apply this series to the =

> export branch and squash fixes as needed. That would make it easier for =

> all of us to test.

Thank you for the patches and reviews!

I just applied this series in our Git tree with 3 modifications:
- patch 1/13: add Mat's tag
- patch 1/13: fix SHA of the fixes tag
- patch 9/13: fix typo: numer =E2=86=92 number
- Note for patch 12/13: I didn't add "&& !skb" from the discussion with =

Florian. I guess, Paolo, you already have a patch, right? If not, I can =

do the modification.

Commits:

25eaa86d1bd6 mptcp: more DATA FIN fixes
3ead2888ce8f mptcp: don't skip needed ack
758d33de84be tcp: factor out __tcp_close() helper
85ec0f558d8c mptcp: introduce mptcp_schedule_work
b77dd0616800 mptcp: reduce the arguments of mptcp_sendmsg_frag
1c0a535c29fb mptcp: add accounting for pending data
15d488743a27 mptcp: introduce MPTCP snd_nxt
283118580486 mptcp: refactor shutdown and close
6fb85947f053 mptcp: move page frag allocation in mptcp_sendmsg()
b7f0f5ac61ba mptcp: try to push pending data on snd una updates
023848627b45 mptcp: rework poll+nospace handling
210f8531fbe5 mptcp: keep track of advertised windows right edge
fbca83205e97 mptcp: send explicit ack on delayed ack_seq incr

- Results: d157a0e07d13..d577ff3cf895

tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7179180521776157516==--
