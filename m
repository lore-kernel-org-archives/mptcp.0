Content-Type: multipart/mixed; boundary="===============6643123381708775315=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 07/11] tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions
Date: Wed, 18 Dec 2019 15:17:32 -0800
Message-ID: <20191218.151732.2019141834931247672.davem@davemloft.net>
In-Reply-To: 5e6ae66a8adea061388919fe0ce5b766feab4c31.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3167

--===============6643123381708775315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 18 Dec 2019 23:15:46 +0100

> Just to clarify, with the code we have currently posted TSO trains of
> MPTCP packets can be aggregated by the GRO engine almost exactly as
> currently happens for plain TCP packets.
> =

> We still have chances to aggregate packets belonging to a MPTCP stream,
> as not all of them carry a DSS option.
> =

> We opted to not coalesce at the TCP level for the moment to avoid
> adding additional hook code inside the coalescing code.
> =

> If you are ok without such hooks in the initial version, we can handle
> MPTCP coalescing, too. The real work will likely land in part 2.
> =

> Would that fit you?

Can't you someone encode the MPTCP metadata so that it will only apply
to a range or something like that?  Would that help?
--===============6643123381708775315==--
