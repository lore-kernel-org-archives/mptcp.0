Content-Type: multipart/mixed; boundary="===============0485776184270440856=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] One approach to indirect call optimization
Date: Tue, 11 Dec 2018 16:30:33 -0800
Message-ID: <alpine.OSX.2.21.1812111628350.20227@ibriano-mobl3.jf.intel.com>
In-Reply-To: CAKuKrBn1N30Lmme8vjU4Kxd7UvTix6m0QO2HnMh-uC6VgqMTEA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 892

--===============0485776184270440856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Matthieu -

Thanks for sharing that link. I'll be watching the thread to see how Paolo =

fixes things up for modules.


Mat


On Fri, 7 Dec 2018, Matthieu Baerts wrote:

> Hello,
>
> Here is another approach: https://lkml.org/lkml/2018/12/5/1206
>
> Matt
> On Wed, Apr 25, 2018 at 1:35 AM Mat Martineau
> <mathew.j.martineau(a)linux.intel.com> wrote:
>>
>>
>> I noticed this patch on netdev to avoid an indirect call to md5_lookup,
>> which was accepted. It is mitigating the cost of an existing indirect ca=
ll
>> rather than adding a new one, but shows how the maintainers are looking =
at
>> the problem.
>>
>> --
>> Mat Martineau
>> Intel OTC
>>
>> ---------- Forwarded message ----------
>> Date: Mon, 23 Apr 2018 14:46:25
>> From: Eric Dumazet <edumazet(a)google.com>
>> To: David S . Miller <davem(a)davemloft.net>
>> Cc: netdev <netdev(a)vger.kernel.org>, Eric Dumazet <edumazet(a)google.c=
om>,
>>      Eric Dumazet <eric.dumazet(a)gmail.com>
>> Subject: [PATCH net-next] tcp: md5: only call tp->af_specific->md5_looku=
p() for
>>      md5 sockets
>>
>> RETPOLINE made calls to tp->af_specific->md5_lookup() quite expensive,
>> given they have no result.
>> We can omit the calls for sockets that have no md5 keys.
>>
>> Signed-off-by: Eric Dumazet <edumazet(a)google.com>
>> ---
>>   net/ipv4/tcp_output.c | 26 ++++++++++++++------------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index 383cac0ff0ec059ca7dbc1a6304cc7f8183e008d..95feffb6d53f8a9eadfb15a2=
fffeec498d6e993a 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -585,14 +585,15 @@ static unsigned int tcp_syn_options(struct sock *s=
k, struct sk_buff *skb,
>>         unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
>>         struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;
>>
>> +       *md5 =3D NULL;
>>   #ifdef CONFIG_TCP_MD5SIG
>> -       *md5 =3D tp->af_specific->md5_lookup(sk, sk);
>> -       if (*md5) {
>> -               opts->options |=3D OPTION_MD5;
>> -               remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
>> +       if (unlikely(rcu_access_pointer(tp->md5sig_info))) {
>> +               *md5 =3D tp->af_specific->md5_lookup(sk, sk);
>> +               if (*md5) {
>> +                       opts->options |=3D OPTION_MD5;
>> +                       remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
>> +               }
>>         }
>> -#else
>> -       *md5 =3D NULL;
>>   #endif
>>
>>         /* We always get an MSS option.  The option bytes which will be =
seen in
>> @@ -720,14 +721,15 @@ static unsigned int tcp_established_options(struct=
 sock *sk, struct sk_buff *skb
>>
>>         opts->options =3D 0;
>>
>> +       *md5 =3D NULL;
>>   #ifdef CONFIG_TCP_MD5SIG
>> -       *md5 =3D tp->af_specific->md5_lookup(sk, sk);
>> -       if (unlikely(*md5)) {
>> -               opts->options |=3D OPTION_MD5;
>> -               size +=3D TCPOLEN_MD5SIG_ALIGNED;
>> +       if (unlikely(rcu_access_pointer(tp->md5sig_info))) {
>> +               *md5 =3D tp->af_specific->md5_lookup(sk, sk);
>> +               if (*md5) {
>> +                       opts->options |=3D OPTION_MD5;
>> +                       size +=3D TCPOLEN_MD5SIG_ALIGNED;
>> +               }
>>         }
>> -#else
>> -       *md5 =3D NULL;
>>   #endif
>>
>>         if (likely(tp->rx_opt.tstamp_ok)) {
>> --
>> 2.17.0.484.g0c8726318c-goog
>>
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>
>
>
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>
> Disclaimer: https://www.tessares.net/mail-disclaimer/
>

--
Mat Martineau
Intel OTC

--===============0485776184270440856==--
