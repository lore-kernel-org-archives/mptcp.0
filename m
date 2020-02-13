Content-Type: multipart/mixed; boundary="===============1537679540511861673=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 4/5] mptcp: update mptcp ack sequence from work queue
Date: Thu, 13 Feb 2020 15:37:08 +0100
Message-ID: <dacf63e06bc2cd1984968414e8ba96d38140a21c.camel@redhat.com>
In-Reply-To: 20200213102742.18937-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3650

--===============1537679540511861673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-13 at 11:27 +0100, Florian Westphal wrote:
> +static void __mptcp_move_skbs(struct mptcp_sock *msk)
> +{
> +	struct mptcp_steal_arg arg =3D {
> +		.msk =3D msk,
> +		.fin =3D false,
> +	};
> +	read_descriptor_t desc =3D {
> +		.arg.data =3D &arg,
> +	};
> +
> +	for (;;) {
> +		struct mptcp_subflow_context *subflow;
> +		bool more_data_avail;
> +
> +		arg.ssk =3D mptcp_subflow_recv_lookup(msk);
> +		if (!arg.ssk)
> +			break;
> +
> +		subflow =3D mptcp_subflow_ctx(arg.ssk);
> +
> +		lock_sock(arg.ssk);
> +
> +		do {
> +			u32 map_remaining;
> +			int bytes_read;
> +
> +			/* try to read as much data as available */
> +			map_remaining =3D subflow->map_data_len -
> +					mptcp_subflow_get_map_offset(subflow);
> +			desc.count =3D map_remaining;
> +
> +			bytes_read =3D tcp_read_sock(arg.ssk, &desc, mptcp_steal_actor);
> +			if (bytes_read <=3D 0) {
> +				release_sock(arg.ssk);
> +				return;
> +			}
> +
> +			if (arg.fin) {
> +				struct tcp_sock *tp =3D tcp_sk(arg.ssk);
> +				u32 seq =3D READ_ONCE(tp->copied_seq);
> +
> +				WRITE_ONCE(tp->copied_seq, seq + 1);
> +			}
> +
> +			more_data_avail =3D mptcp_subflow_data_available(arg.ssk);
> +		} while (more_data_avail);
> +
> +		release_sock(arg.ssk);
> +	}
> +}

Overall the above move the pending skbs to the msk receive queue,
increment ssk copied_seq and eventually let TCP send ack via
tcp_cleanup_rbuf().

I think we could avoid touching tcp_read_sock() in patch 2/5 moving the
skb directly from __mptcp_move_skbs() - no call to tcp_read_sock(),
just queue manipulation and copied_seq accounting.

Than __mptcp_move_skbs() will call directly, as needed - need to export
it.

We could additionally clean-up the code calling __mptcp_move_skbs()
from mptcp_recvmsg() before looking into the msk receive queue. Than no
need for the current recvmsg inner loop.

I fear we need some tweek to handle TCP fallback. If I read the RFC
correctly the msk can fallback to TCP even after receiving some DSS
data (e.g. msk receive queue contains some skbs and the msk fallback to
TCP. We can't call anymore sock_recvmsg())

WDYT?

Thanks,

Paolo

--===============1537679540511861673==--
