Content-Type: multipart/mixed; boundary="===============8099095481412622185=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] Remove unused variable, causes compile warning
Date: Wed, 07 Aug 2019 19:12:17 +0200
Message-ID: <3351c7f2-2650-fd01-9f13-7b692203c985@tessares.net>
In-Reply-To: alpine.OSX.2.21.1908010903570.37892@aindraka-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1590

--===============8099095481412622185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

Sorry I was busy with other activities. I will merge the different
pending patches that have been accepted tomorrow before the meeting.

Cheers,
Matt

On 01/08/2019 18:04, Mat Martineau wrote:
> On Wed, 31 Jul 2019, Peter Krystad wrote:
> =

>> squashto: Add handling of incoming MP_JOIN requests
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>> ---
>> net/mptcp/token.c | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
>> index 2324a477d513..d5ae77446590 100644
>> --- a/net/mptcp/token.c
>> +++ b/net/mptcp/token.c
>> @@ -77,7 +77,6 @@ static void new_req_token(struct request_sock *req,
>> static void new_req_join(struct request_sock *req, struct sock *sk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 const struct sk_buff *skb)
>> {
>> -=C2=A0=C2=A0=C2=A0 const struct inet_request_sock *ireq =3D inet_rsk(re=
q);
>> =C2=A0=C2=A0=C2=A0=C2=A0struct subflow_request_sock *subflow_req =3D sub=
flow_rsk(req);
>> =C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_sock *msk =3D mptcp_sk(sk);
>> =C2=A0=C2=A0=C2=A0=C2=A0u8 hmac[MPTCPOPT_HMAC_LEN];
>> --=C2=A0
>> 2.17.2
>>
> =

> Both patches look good to me, thanks!
> =

> -- =

> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8099095481412622185==--
