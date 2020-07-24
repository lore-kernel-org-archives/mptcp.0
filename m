Content-Type: multipart/mixed; boundary="===============6550669205686754260=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3 00/12] DATA_FIN support
Date: Thu, 23 Jul 2020 17:52:41 -0700
Message-ID: <alpine.OSX.2.23.453.2007231739580.6746@mlemay-mobl.amr.corp.intel.com>
In-Reply-To: alpine.OSX.2.23.453.2007231323080.6746@mlemay-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5274

--===============6550669205686754260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2020, Mat Martineau wrote:

> On Thu, 23 Jul 2020, Christoph Paasch wrote:
>
>> Hello,
>> =

>> On 07/23/20 - 10:43, Mat Martineau wrote:
>>> Here is a series adding full DATA_FIN support at connection shutdown /
>>> close. See the patch 8 commit message for information about the
>>> disconnection state machine.
>>> =

>>> Self tests are passing. Still need to check compatibility and review
>>> wireshark traces when interacting with a mptcp_trunk peer.
>> =

>> I started an interop test with these patches, and things are breaking.
>> Haven't looked into it yet or which patch exactly causes it, but my
>> apache-benchmark test is not making any progress on the connections.
>> =

>
> Ok, I'll get up to date with mptcp_trunk and see what Wireshark shows.
>

Looks like I had an off-by-one error in the outgoing "DATA_FIN without =

mapped data" mapping. I've fixed that, and now mptcp_trunk interacts =

better.

Sending out v4 shortly.


Mat

>
>> =

>>> =

>>> v2 -> v3
>>>
>>>  * Fixed checkpatch issues
>>> =

>>> v1 -> v2
>>> =

>>> Fixes from Paolo's review comments, including:
>>>
>>>  * Squashed patch 8 (main functional changes for state machine) with the
>>>    previous commit, since the split was causing extra churn and was
>>>    misleading when trying to review.
>>>
>>>  * Made more use of the mptcp_pending_data_fin helper. Also refactored
>>>    that helper to optionally copy the read sequence number for the call=
er.
>>>
>>>  * Fixed sequence number check off-by-one problem.
>>>
>>>  * Removed redundant DATA_FIN sequence number checks in
>>>    __mptcp_move_skbs_from_subflow().
>>>
>>>  * Split commit 3 to clarify intentional comment removal.
>>> =

>>> RFC -> v1
>>>
>>>  * Split in to a series
>>>
>>>  * A few enhancements suggested by Paolo
>>>
>>>  * Lots of fixes, including handling of fallback sockets and
>>>    connections that are already doing the disconnect handshake before
>>>    accept() even returns.
>>> =

>>> Mat Martineau (12):
>>>   mptcp: Allow DATA_FIN in headers without TCP FIN
>>>   mptcp: Return EPIPE if sending is shut down during a sendmsg
>>>   mptcp: Remove outdated and incorrect comment
>>>   mptcp: Add mptcp_close_state() helper
>>>   mptcp: Track received DATA_FIN sequence number and add related helpers
>>>   mptcp: Use MPTCP-level flag for sending DATA_FIN
>>>   mptcp: Add helper to process acks of DATA_FIN
>>>   mptcp: Use full MPTCP-level disconnect state machine
>>>   mptcp: Only use subflow EOF signaling on fallback connections
>>>   mptcp: Skip unnecessary skb extension allocation for bare acks
>>>   mptcp: Safely read sequence number when lock isn't held
>>>   mptcp: Safely store sequence number when sending data
>>>
>>>  net/mptcp/options.c  |  54 ++++++--
>>>  net/mptcp/protocol.c | 295 ++++++++++++++++++++++++++++++++++++-------
>>>  net/mptcp/protocol.h |   6 +-
>>>  net/mptcp/subflow.c  |  14 +-
>>>  4 files changed, 303 insertions(+), 66 deletions(-)
>>> =

>>> =

>>> base-commit: 936cc81106499d2332697d82592ace2f54595ffe
>>> --
>>> 2.27.0
>>> _______________________________________________
>>> mptcp mailing list -- mptcp(a)lists.01.org
>>> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>> =

>
> --
> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============6550669205686754260==--
