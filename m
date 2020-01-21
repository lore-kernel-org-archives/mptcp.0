Content-Type: multipart/mixed; boundary="===============6561232956313567695=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: fix compilation warning without IPV6
Date: Wed, 22 Jan 2020 00:28:25 +0100
Message-ID: <f982f667-b157-0083-c895-8249162c4adf@tessares.net>
In-Reply-To: alpine.OSX.2.21.2001211516210.14256@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3469

--===============6561232956313567695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 22/01/2020 00:16, Mat Martineau wrote:
> On Wed, 22 Jan 2020, Matthieu Baerts wrote:
> =

>> Spot by Mat:
>>
>> =C2=A0=C2=A0 net/mptcp/protocol.c: In function =E2=80=98mptcp_copy_inadd=
rs=E2=80=99:
>> =C2=A0=C2=A0 net/mptcp/protocol.c:672:21: warning: unused variable =E2=
=80=98msk6=E2=80=99 =

>> [-Wunused-variable]
>> =C2=A0=C2=A0=C2=A0=C2=A0 672 |=C2=A0 struct ipv6_pinfo *msk6 =3D inet6_s=
k(msk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
>> =C2=A0=C2=A0 net/mptcp/protocol.c:671:27: warning: unused variable =E2=
=80=98ssk6=E2=80=99 =

>> [-Wunused-variable]
>> =C2=A0=C2=A0=C2=A0=C2=A0 671 |=C2=A0 const struct ipv6_pinfo *ssk6 =3D i=
net6_sk(ssk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~
>>
>> v2:
>> - reorder the code to avoid 2 #ifdef (Mat)
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0 to be squashed in "mptcp: Create SUBFLOW socket for incomin=
g =

>> connections"
>>
>> net/mptcp/protocol.c | 16 ++++++++--------
>> 1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 84799a5212a2..e08a25eabcd5 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -217,17 +217,10 @@ static void mptcp_close(struct sock *sk, long =

>> timeout)
>>
>> static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
>> {
>> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> =C2=A0=C2=A0=C2=A0=C2=A0const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
>> =C2=A0=C2=A0=C2=A0=C2=A0struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
>>
>> -=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
>> -=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dpor=
t;
>> -=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_sport =3D inet_sk(ssk)->inet_spor=
t;
>> -=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_daddr =3D inet_sk(ssk)->inet_dadd=
r;
>> -=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_sadd=
r;
>> -=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_=
rcv_saddr;
>> -
>> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>> =C2=A0=C2=A0=C2=A0=C2=A0msk->sk_v6_daddr =3D ssk->sk_v6_daddr;
>> =C2=A0=C2=A0=C2=A0=C2=A0msk->sk_v6_rcv_saddr =3D ssk->sk_v6_rcv_saddr;
>>
>> @@ -236,6 +229,13 @@ static void mptcp_copy_inaddrs(struct sock *msk, =

>> const struct sock *ssk)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msk6->flow_label =3D ssk6->fl=
ow_label;
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>> #endif
>> +
>> +=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
>> +=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dpor=
t;
>> +=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_sport =3D inet_sk(ssk)->inet_spor=
t;
>> +=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_daddr =3D inet_sk(ssk)->inet_dadd=
r;
>> +=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_sadd=
r;
>> +=C2=A0=C2=A0=C2=A0 inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_=
rcv_saddr;
>> }
>>
>> static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
>> -- =

>> 2.24.0
> =

> v2 looks good, thanks Matthieu!

Thank you for the review!

- 9f2ecf220b2a: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections
- fa392a833065..92b5d1d8b2b8: result

Tests and export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6561232956313567695==--
