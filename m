Content-Type: multipart/mixed; boundary="===============2217294038224993300=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 5/6] mptcp: Export low-level routines for IPv6
Date: Wed, 06 Nov 2019 10:37:12 +0100
Message-ID: <6c2c57ca-b1de-a8c7-54bc-eeddba222f0f@tessares.net>
In-Reply-To: c80e8e0f7ae025b051fe5492e27a0ef1f7a36d17.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2423

--===============2217294038224993300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 06/11/2019 10:03, Paolo Abeni wrote:
> On Tue, 2019-11-05 at 20:41 -0800, Peter Krystad wrote:
>> @@ -1111,7 +1111,8 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
>>   		sizeof(struct inet6_skb_parm));
>>   }
>>   =

>> -static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct =
sk_buff *skb,
>> +static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk,
>> +					 struct sk_buff *skb,
>>   					 struct request_sock *req,
>>   					 struct dst_entry *dst,
>>   					 struct request_sock *req_unhash,
> =

> Minor nit: it looks like this chunk is not needed[1].

Peter replied this in the previous version of the patch:

 > It seemed like since I was in the neighborhood I would fix this
 > over-80 char line. If that's not appropriate we can drop this chunk.

I guess we should not modify the style of non MPTCP code. Then better to =

drop this change, right?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2217294038224993300==--
