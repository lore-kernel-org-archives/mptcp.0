Content-Type: multipart/mixed; boundary="===============0939267100254015254=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: fix caller of mptcp_handle_ipv6_mapped
Date: Fri, 17 Jan 2020 18:31:17 +0100
Message-ID: <aafff912-700b-0c68-c84b-37d16cf7a58c@tessares.net>
In-Reply-To: 112467d7ae964f42b650f4fc9ec509ddf06b3246.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3406

--===============0939267100254015254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 17/01/2020 18:29, Paolo Abeni wrote:
> On Fri, 2020-01-17 at 18:24 +0100, Matthieu Baerts wrote:
>> This was causing a warning: 'sk' has a 'const' attribute. Good because
>> it was not the right sk!
>>
>> Fixes: 77c6b6aec34b (mptcp: handle ipv4-mapped ipv6 address.)
>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "mptcp: Handle MP_CAPABLE options for outgoing co=
nnections"
>>
>>   net/ipv6/tcp_ipv6.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>> index b3eacd3549c3..33a578a3eb3a 100644
>> --- a/net/ipv6/tcp_ipv6.c
>> +++ b/net/ipv6/tcp_ipv6.c
>> @@ -1208,7 +1208,7 @@ static struct sock *tcp_v6_syn_recv_sock(const str=
uct sock *sk, struct sk_buff *
>>   =

>>   		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
>>   		if (sk_is_mptcp(newsk))
>> -			mptcp_handle_ipv6_mapped(sk, true);
>> +			mptcp_handle_ipv6_mapped(newsk, true);
>>   		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
>>   #ifdef CONFIG_TCP_MD5SIG
>>   		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
> =

> LGMT, thank you for fixing my faults!

Thank you for the quick review!

- 0a0a8d376ea2: "squashed" in "mptcp: Handle MP_CAPABLE options for =

outgoing connections"
- no signed-off added (because it was Paolo's fix :) )
- 2000db04936b..336d5b81cb58: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0939267100254015254==--
