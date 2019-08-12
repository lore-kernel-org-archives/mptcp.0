Content-Type: multipart/mixed; boundary="===============4206951552811580807=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 08/10] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Mon, 12 Aug 2019 21:36:48 +0200
Message-ID: <a56941a8-4860-0b04-7115-e1474e22ac02@tessares.net>
In-Reply-To: alpine.OSX.2.21.1908121116420.4973@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1626

--===============4206951552811580807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Peter,

On 12/08/2019 20:33, Mat Martineau wrote:
> On Wed, 7 Aug 2019, Peter Krystad wrote:

(...)

>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 678fca99c23a..448c9e7f567a 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c

(...)

>> @@ -195,6 +212,55 @@ static void subflow_data_ready(struct sock *sk)
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>> }
>>
>> +int subflow_connect(struct sock *sk, struct sockaddr_in *local,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct sockaddr_in *remote, u8 remote_id)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +=C2=A0=C2=A0=C2=A0 struct subflow_context *subflow;
>> +=C2=A0=C2=A0=C2=A0 struct socket *sf;
>> +=C2=A0=C2=A0=C2=A0 u32 remote_token;
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 lock_sock(sk);
>> +=C2=A0=C2=A0=C2=A0 err =3D subflow_create_socket(sk, &sf);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_sock(sk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 subflow =3D subflow_ctx(sf->sk);
>> +=C2=A0=C2=A0=C2=A0 subflow->remote_key =3D msk->remote_key;
>> +=C2=A0=C2=A0=C2=A0 subflow->local_key =3D msk->local_key;
>> +=C2=A0=C2=A0=C2=A0 subflow->token =3D msk->token;
>> +
>> +=C2=A0=C2=A0=C2=A0 sock_hold(sf->sk);
>> +=C2=A0=C2=A0=C2=A0 release_sock(sk);
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D kernel_bind(sf, (struct sockaddr *)local,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sizeof(struct sockaddr_in));
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto failed;
>> +
>> +=C2=A0=C2=A0=C2=A0 crypto_key_sha1(subflow->remote_key, &remote_token, =
NULL);
>> +=C2=A0=C2=A0=C2=A0 pr_debug("msk=3D%p remote_token=3D%u", msk, remote_t=
oken);
>> +=C2=A0=C2=A0=C2=A0 subflow->remote_token =3D remote_token;
>> +=C2=A0=C2=A0=C2=A0 subflow->remote_id =3D remote_id;
>> +=C2=A0=C2=A0=C2=A0 subflow->request_join =3D 1;
>> +=C2=A0=C2=A0=C2=A0 subflow->request_bkup =3D 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D kernel_connect(sf, (struct sockaddr *)remote,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct sockaddr_in), O_NONBLOCK);
>> +=C2=A0=C2=A0=C2=A0 if (err && err !=3D -EINPROGRESS)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto failed;
>> +
>> +=C2=A0=C2=A0=C2=A0 sock_put(sf->sk);
>> +=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +failed:
>> +=C2=A0=C2=A0=C2=A0 sock_release(sf);
> =

> Should there be a sock_put(sf->sk) on this path too? Looks like
> sock_release() will free the subflow context but not the struct sock
> itself.

Please note that I just applied this patch series. But do not hesitate
to create a new patch to fix this if needed!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4206951552811580807==--
