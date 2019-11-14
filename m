Content-Type: multipart/mixed; boundary="===============6573146493435261099=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/8] Add IPv6 Support
Date: Thu, 14 Nov 2019 10:46:23 +0100
Message-ID: <532c3e9d-e01b-ca06-0d5a-b089484bf57d@tessares.net>
In-Reply-To: 16bf2154cb9b88171a6790e5f95f59e9bc345348.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2527

--===============6573146493435261099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 13/11/2019 21:49, Peter Krystad wrote:
> On Wed, 2019-11-13 at 21:44 +0100, Matthieu Baerts wrote:

[...]

>> After this, "mptcp: Add IPv6 support" is almost empty:
>>
>> =3D=3D=3D
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index c7e6b9dd14df..564a6204649e 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -751,10 +751,7 @@ static int mptcp_bind(struct socket *sock, struct
>> sockaddr *uaddr, int addr_len)
>>    {
>>           struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
>>           struct socket *ssock;
>> -       int err =3D -ENOTSUPP;
>> -
>> -       if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
>> -               return err;
>> +       int err;
>>
>>           ssock =3D mptcp_socket_create_get(msk);
>>           if (IS_ERR(ssock))
>>
>> =3D=3D=3D
>>
>> Can I move this to "mptcp: Create SUBFLOW socket for incoming connection=
s"?
> =

> That's the "missing chunk", yes merge this change.

Thank you, just did:

- 8c31a5e1339b: "squashed" in "mptcp: Create SUBFLOW socket for incoming =

connections"
- add0d83fe78e..253efd541209: result (empty as expected)
- t/mptcp-Add-IPv6-support is now empty (no longer exported)

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6573146493435261099==--
