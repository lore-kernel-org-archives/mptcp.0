Content-Type: multipart/mixed; boundary="===============5097703802922484743=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: Use 32-bit DATA_ACK when possible
Date: Sat, 16 May 2020 13:51:26 -0700
Message-ID: <20200516.135126.783678623237967089.davem@davemloft.net>
In-Reply-To: 20200514155303.14360-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 4404

--===============5097703802922484743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Paasch <cpaasch(a)apple.com>
Date: Thu, 14 May 2020 08:53:03 -0700

> RFC8684 allows to send 32-bit DATA_ACKs as long as the peer is not
> sending 64-bit data-sequence numbers. The 64-bit DSN is only there for
> extreme scenarios when a very high throughput subflow is combined with a
> long-RTT subflow such that the high-throughput subflow wraps around the
> 32-bit sequence number space within an RTT of the high-RTT subflow.
> =

> It is thus a rare scenario and we should try to use the 32-bit DATA_ACK
> instead as long as possible. It allows to reduce the TCP-option overhead
> by 4 bytes, thus makes space for an additional SACK-block. It also makes
> tcpdumps much easier to read when the DSN and DATA_ACK are both either
> 32 or 64-bit.
> =

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

Applied, thanks.
--===============5097703802922484743==--
