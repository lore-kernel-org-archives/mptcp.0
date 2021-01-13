Content-Type: multipart/mixed; boundary="===============6620608659734285854=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: better msk-level shutdown.
Date: Wed, 13 Jan 2021 11:26:59 +0100
Message-ID: <c863efca-6574-582b-6779-deb9c81dd900@gmail.com>
In-Reply-To: a42a3c10-0183-a232-aec6-b1e6bbfaa800@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7340

--===============6620608659734285854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 1/13/21 11:21 AM, Eric Dumazet wrote:
> =

> =

> On 1/12/21 6:25 PM, Paolo Abeni wrote:
>> Instead of re-implementing most of inet_shutdown, re-use
>> such helper, and implement the MPTCP-specific bits at the
>> 'proto' level.
>>
>> The msk-level disconnect() can now be invoked, lets provide a
>> suitable implementation.
>>
>> As a side effect, this fixes bad state management for listener
>> sockets. The latter could lead to division by 0 oops since
>> commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").
>>
>> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machi=
ne")
>> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>>  net/mptcp/protocol.c | 62 ++++++++++++--------------------------------
>>  1 file changed, 17 insertions(+), 45 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 2ff8c7caf74f..81faeff8f3bb 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2642,11 +2642,12 @@ static void mptcp_copy_inaddrs(struct sock *msk,=
 const struct sock *ssk)
>>  =

>>  static int mptcp_disconnect(struct sock *sk, int flags)
>>  {
>> -	/* Should never be called.
>> -	 * inet_stream_connect() calls ->disconnect, but that
>> -	 * refers to the subflow socket, not the mptcp one.
>> -	 */
>> -	WARN_ON_ONCE(1);
>> +	struct mptcp_subflow_context *subflow;
>> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +
>> +	__mptcp_flush_join_list(msk);
>> +	mptcp_for_each_subflow(msk, subflow)
>> +		tcp_disconnect(mptcp_subflow_tcp_sock(subflow), flags);
> =

> Ouch.
> =

> tcp_disconnect() is supposed to be called with socket lock being held.
> =

> Really, CONFIG_LOCKDEP=3Dy should have warned you :/

Or maybe CONFIG_PROVE_RCU=3Dy is needed to catch the bug.


--===============6620608659734285854==--
