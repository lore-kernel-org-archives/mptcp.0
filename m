Content-Type: multipart/mixed; boundary="===============3193687704376857927=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix joined subflows with
 unblocking sk
Date: Mon, 27 Jul 2020 12:26:45 +0200
Message-ID: <90b58a4d-2bed-389c-c762-9f753c39dc96@tessares.net>
In-Reply-To: 0c60e99d58d3b143070bcb975a9c1c308e04579b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5311

--===============3193687704376857927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 27/07/2020 10:59, Paolo Abeni wrote:
> On Mon, 2020-07-27 at 10:38 +0200, Matthieu Baerts wrote:
>> Unblocking sockets used for outgoing connections were not containing
>> inet info about the initial connection due to a typo there: the value of
>> "err" variable is negative in the kernelspace.
>>
>> This fixes the creation of additional subflows where the remote port has
>> to be reused if the other host didn't announce another one. This also
>> fixes inet_diag showing blank info about MPTCP sockets from unblocking
>> sockets doing a connect().
>>
>> Fixes: 41be81a8d3d0 ("mptcp: fix unblocking connect()")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>   net/mptcp/protocol.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 3980fbb6f31e..c0abe738e7d3 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1833,7 +1833,7 @@ static int mptcp_stream_connect(struct socket *soc=
k, struct sockaddr *uaddr,
>>   	/* on successful connect, the msk state will be moved to established =
by
>>   	 * subflow_finish_connect()
>>   	 */
>> -	if (!err || err =3D=3D EINPROGRESS)
>> +	if (!err || err =3D=3D -EINPROGRESS)
>>   		mptcp_copy_inaddrs(sock->sk, ssock->sk);
>>   	else
>>   		inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> =

> LGTM! thanks for fixing my bugs :)
> =

> Feel free to go upstream ASAP ;)

Thank you for the quick review!

I just added this patch in the export branch:

- 3a0ff6c990db: mptcp: fix joined subflows with unblocking sk
- 4297750f3218..b5d8e98a4a38: result

I also just sent it to netdev ML, to be applied in -net.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3193687704376857927==--
