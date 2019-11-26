Content-Type: multipart/mixed; boundary="===============6627916333214017110=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] subflow: don't increment msk refcount on join
 connect completion
Date: Tue, 26 Nov 2019 10:17:30 +0100
Message-ID: <52fe1027-cfd3-2875-e14a-9dbd81dc591a@tessares.net>
In-Reply-To: ac92da450617b7fb9e59b3e9b508e339f87fd3da.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2694

--===============6627916333214017110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 25/11/2019 18:19, Paolo Abeni wrote:
> On Mon, 2019-11-25 at 16:01 +0100, Florian Westphal wrote:
>> squashto: mptcp: Add handling of outgoing MP_JOIN requests
>>
>> The connecting socket already has a refcount, this additional
>> increase is never decremented, resulting in the mptcp socket to never ge=
t freed.
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>>   net/mptcp/subflow.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index e6a512bf6230..ba46c0b3a6d7 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -38,7 +38,6 @@ static int subflow_rebuild_header(struct sock *sk)
>>   		err =3D mptcp_token_new_connect(sk);
>>   	} else if (subflow->request_join && !subflow->local_nonce) {
>>   		pr_debug("subflow=3D%p", sk);
>> -		mptcp_token_get_sock(subflow->token);
>>   =

>>   		do {
>>   			get_random_bytes(&subflow->local_nonce, sizeof(u32));
> =

> yep, it looks like this refcnt is really leaked, ACK!

Good catch! Thank you for the patch and the review!

- 8aa42d827a74: "squashed" in "mptcp: Add handling of outgoing MP_JOIN =

requests"
- 4d53ef252ed5..3af80e92c8cd: result

Tests and sync in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6627916333214017110==--
