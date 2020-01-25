Content-Type: multipart/mixed; boundary="===============4639832954704401013=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 2/2] mptcp: Fix code formatting
Date: Sat, 25 Jan 2020 08:15:01 +0100
Message-ID: <20200125.081501.844064409437176102.davem@davemloft.net>
In-Reply-To: 20200125000403.251894-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3511

--===============4639832954704401013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Date: Fri, 24 Jan 2020 16:04:03 -0800

> checkpatch.pl had a few complaints in the last set of MPTCP patches:
> =

> ERROR: code indent should use tabs where possible
> +^I         subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);$
> =

> CHECK: Comparison to NULL could be written "!new_ctx"
> +	if (new_ctx =3D=3D NULL) {
> =

> ERROR: "foo * bar" should be "foo *bar"
> +static const struct proto_ops * tcp_proto_ops(struct sock *sk)
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Applied.
--===============4639832954704401013==--
