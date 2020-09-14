Content-Type: multipart/mixed; boundary="===============1044961285834036812=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 00/13] mptcp: introduce support for
 real multipath xmit
Date: Mon, 14 Sep 2020 13:28:34 -0700
Message-ID: <20200914.132834.559855888563837718.davem@davemloft.net>
In-Reply-To: cover.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5861

--===============1044961285834036812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Mon, 14 Sep 2020 10:01:06 +0200

> This series enable MPTCP socket to transmit data on multiple subflows
> concurrently in a load balancing scenario.
> =

> First the receive code path is refactored to better deal with out-of-order
> data (patches 1-7). An RB-tree is introduced to queue MPTCP-level out-of-=
order
> data, closely resembling the TCP level OoO handling.
> =

> When data is sent on multiple subflows, the peer can easily see OoO - "fu=
ture"
> data at the MPTCP level, especially if speeds, delay, or jitter are not
> symmetric.
> =

> The other major change regards the netlink PM, which is extended to allow
> creating non backup subflows in patches 9-11.
> =

> There are a few smaller additions, like the introduction of OoO related m=
ibs,
> send buffer autotuning and better ack handling.
> =

> Finally a bunch of new self-tests is introduced. The new feature is tested
> ensuring that the B/W used by an MPTCP socket using multiple subflows mat=
ches
> the link aggregated B/W - we use low B/W virtual links, to ensure the tes=
ts
> are not CPU bounded.
> =

> v1 -> v2:
>   - fix 32 bit build breakage
>   - fix a bunch of checkpatch issues

Looks good, series applied, thanks Paolo.
--===============1044961285834036812==--
