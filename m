Content-Type: multipart/mixed; boundary="===============2087431883618130352=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 06/11] mptcp: Add MPTCP to skb
 extensions
Date: Fri, 20 Dec 2019 07:33:37 -0800
Message-ID: <eb8a3c9d-4234-1f3a-27f9-3c65fd4496b5@gmail.com>
In-Reply-To: 20191219223434.19722-7-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3219

--===============2087431883618130352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> Add enum value for MPTCP and update config dependencies
> =

> Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

...

> +/* MPTCP sk_buff extension data */
> +struct mptcp_ext {
> +	u64		data_ack;
> +	u64		data_seq;
> +	u32		subflow_seq;
> +	u16		data_len;
> +	u8		use_map:1,
> +			dsn64:1,
> +			data_fin:1,
> +			use_ack:1,
> +			ack64:1,
> +			__unused:2;
	__unused:3; =


Also worth noting there is one byte hole in this structure.

> +};
> +
--===============2087431883618130352==--
