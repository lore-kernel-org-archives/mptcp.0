Content-Type: multipart/mixed; boundary="===============0910491670206832634=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Sat, 17 Oct 2020 09:56:48 +0200
Message-ID: <7ed09690-642d-3a51-1e62-0c6dafacea14@tessares.net>
In-Reply-To: 5ca9f3dcf03cc45acb1cd569552b7ce06140a085.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6340

--===============0910491670206832634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Paolo,

On 15/10/2020 16:51, Paolo Abeni wrote:
> On Thu, 2020-10-15 at 16:30 +0200, Davide Caratti wrote:
>> when the data-fin is acked on all subflows, the socket goes in
>> FIN_WAIT_2 state. Call __mptcp_destroy_sock() to transmit a TCP FIN.
> =

> Note for the reviewers: the above happens only for orphaned msk, and
> follows quite closely what plain TCP does.

Thank you for having destroyed orphans!

>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/98
>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
>> ---
>>   net/mptcp/protocol.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 5b32741f2af3..95566f120e72 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1859,7 +1859,8 @@ static void mptcp_worker(struct work_struct *work)
>>   	 */
>>   	if (sock_flag(sk, SOCK_DEAD) &&
>>   	    (mptcp_check_close_timeout(sk) ||
>> -	    (state !=3D sk->sk_state && sk->sk_state =3D=3D TCP_CLOSE))) {
>> +	    (state !=3D sk->sk_state &&
>> +	    ((1 << inet_sk_state_load(sk)) & (TCPF_CLOSE | TCPF_FIN_WAIT2)))))=
 {
>>   		inet_sk_state_store(sk, TCP_CLOSE);
>>   		__mptcp_destroy_sock(sk, 0);
>>   		goto unlock;
> =

> LGTM! Thanks Davide!

Thank you for the patch and the review!

- 323d37ef423c: "squashed" in "mptcp: refactor shutdown and close"
- Results: e41dc6548e3b..b160e00bdf28

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0910491670206832634==--
