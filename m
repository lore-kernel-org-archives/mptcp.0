Content-Type: multipart/mixed; boundary="===============2408685578636287749=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: switch mptcp_poll to use parent
 sock wait queue
Date: Fri, 25 Oct 2019 17:26:46 +0200
Message-ID: <21a80919-4765-c8dd-cdc2-8535bf0b6198@tessares.net>
In-Reply-To: 20191023154226.GN25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2321

--===============2408685578636287749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 23/10/2019 17:42, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> On Wed, 2019-10-23 at 16:23 +0200, Florian Westphal wrote:
>>> No major changes, except the rebase on current export branch.
>>> Selftest still passes.
>>>
>>> This series is needed for sendmsg refactor, without it we can't
>>> make mptcp sendmsg wait on the mptcp socket wait queue because we don't
>>> get the needed wakeup events from the subflow layer.
>>>
>>> The following changes since commit 85c93de446d3fd90e47605ba8ff161bef755=
8f09:
>>>
>>>    mptcp: Implement basic path manager (2019-10-23 01:31:04 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.breakpoint.cc/fw/mptcp-next.git mptcp_poll_07
>>>
>>> for you to fetch changes up to 864dd47df1293e4b8bfc70be0d459286b6dddc3a:
>>>
>>>    mptcp: switch mptcp_poll to mptcp socket wait queue (2019-10-23 15:2=
0:28 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Florian Westphal (4):
>>>        mptcp: add and use subflow_write_space
>>>        subflow: wake parent mptcp socket on subflow state change
>>>        net: tcp: add __tcp_poll helper
>>>        mptcp: switch mptcp_poll to mptcp socket wait queue
>>>
>>>   include/net/tcp.h    |  1 +
>>>   net/ipv4/tcp.c       | 12 ++++++++----
>>>   net/mptcp/protocol.c |  4 +++-
>>>   net/mptcp/subflow.c  | 34 ++++++++++++++++++++++++++++++++++
>>>   4 files changed, 46 insertions(+), 5 deletions(-)
>>>
>>> _______________________________________________
>>> mptcp mailing list -- mptcp(a)lists.01.org
>>> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>>
>> Series LGTM
>>
>> I think we could include patch 3/4 in the "first chunk"/preparatory
>> patches - e.g. apply just after "tcp, ulp: Add clone operation to
>> tcp_ulp_ops" - and squash 4/4 in "mptcp: add mptcp_poll"
>>
>> WDYT?
> =

> Seems good, yes.

Where can I apply patch 1/4 and 2/4? At the end?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2408685578636287749==--
