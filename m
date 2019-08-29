Content-Type: multipart/mixed; boundary="===============1194963262304167061=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: remove msk->subflow->sk dereference in
 pr_debug statement
Date: Thu, 29 Aug 2019 15:11:55 +0200
Message-ID: <2770671d-d18a-4161-fdf4-3b217418a635@tessares.net>
In-Reply-To: alpine.OSX.2.21.1908271108420.10328@aaggar2-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1758

--===============1194963262304167061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

On 27/08/2019 20:09, Mat Martineau wrote:
> =

> On Thu, 22 Aug 2019, Peter Krystad wrote:
> =

>> msk->subflow may be NULL when creation of an mptcp_sock fails due
>> to the protocol not being enabled.
>>
>> squashto: Add key generation and token tree
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>> ---
>> net/mptcp/protocol.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index aaa71b161c1a..a58211d8568c 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -702,7 +702,7 @@ static void mptcp_destroy(struct sock *sk)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_sock *msk =3D mptcp_sk(sk);
>>
>> -=C2=A0=C2=A0=C2=A0 pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow-=
>sk);
>> +=C2=A0=C2=A0=C2=A0 pr_debug("msk=3D%p", sk);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0token_destroy(msk->token);
>> }
>> --=C2=A0
>> 2.17.2
>>
> =

> Looks good to merge, thanks for the fix.

Thank you for the patch and the review!

- 9425f0c9f15c: "squashed" in "mptcp: Add key generation and token tree"
- signed-off already there
- f704ab46b414..b94f6125bd9a: result

Export in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1194963262304167061==--
