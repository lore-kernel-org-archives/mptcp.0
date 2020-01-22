Content-Type: multipart/mixed; boundary="===============1970370254798271259=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 04/19] mptcp: Handle MP_CAPABLE
 options for outgoing connections
Date: Tue, 21 Jan 2020 23:29:20 -0800
Message-ID: <b9cbc75f-8a0d-9273-54dc-81764cfb473c@gmail.com>
In-Reply-To: 20200122005633.21229-5-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3490

--===============1970370254798271259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 1/21/20 4:56 PM, Christoph Paasch wrote:
> From: Peter Krystad <peter.krystad(a)linux.intel.com>
> =

> Add hooks to tcp_output.c to add MP_CAPABLE to an outgoing SYN request,
> to capture the MP_CAPABLE in the received SYN-ACK, to add MP_CAPABLE to
> the final ACK of the three-way handshake.
> =

> Use the .sk_rx_dst_set() handler in the subflow proto to capture when the
> responding SYN-ACK is received and notify the MPTCP connection layer.
> =

> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Co-developed-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

Please make sure to CC me (edumazet(a)google.com) on TCP patches in general,
and on the whole MPTCP series while pushing them upstream.

netdev@ has delivered only 5 patches to my gmail.com account.

Thanks.



--===============1970370254798271259==--
