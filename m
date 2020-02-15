Content-Type: multipart/mixed; boundary="===============7139817105392974517=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 4/5] mptcp: update mptcp ack sequence from work queue
Date: Fri, 14 Feb 2020 17:39:14 -0800
Message-ID: <alpine.OSX.2.22.394.2002141725070.55209@echiprou-mobl.amr.corp.intel.com>
In-Reply-To: dacf63e06bc2cd1984968414e8ba96d38140a21c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3663

--===============7139817105392974517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 13 Feb 2020, Paolo Abeni wrote:

> On Thu, 2020-02-13 at 11:27 +0100, Florian Westphal wrote:
>> +static void __mptcp_move_skbs(struct mptcp_sock *msk)
>> +{
>> +	struct mptcp_steal_arg arg =3D {
>> +		.msk =3D msk,
>> +		.fin =3D false,
>> +	};
>> +	read_descriptor_t desc =3D {
>> +		.arg.data =3D &arg,
>> +	};
>> +
>> +	for (;;) {
>> +		struct mptcp_subflow_context *subflow;
>> +		bool more_data_avail;
>> +
>> +		arg.ssk =3D mptcp_subflow_recv_lookup(msk);
>> +		if (!arg.ssk)
>> +			break;
>> +
>> +		subflow =3D mptcp_subflow_ctx(arg.ssk);
>> +
>> +		lock_sock(arg.ssk);
>> +
>> +		do {
>> +			u32 map_remaining;
>> +			int bytes_read;
>> +
>> +			/* try to read as much data as available */
>> +			map_remaining =3D subflow->map_data_len -
>> +					mptcp_subflow_get_map_offset(subflow);
>> +			desc.count =3D map_remaining;
>> +
>> +			bytes_read =3D tcp_read_sock(arg.ssk, &desc, mptcp_steal_actor);
>> +			if (bytes_read <=3D 0) {
>> +				release_sock(arg.ssk);
>> +				return;
>> +			}
>> +
>> +			if (arg.fin) {
>> +				struct tcp_sock *tp =3D tcp_sk(arg.ssk);
>> +				u32 seq =3D READ_ONCE(tp->copied_seq);
>> +
>> +				WRITE_ONCE(tp->copied_seq, seq + 1);
>> +			}
>> +
>> +			more_data_avail =3D mptcp_subflow_data_available(arg.ssk);
>> +		} while (more_data_avail);
>> +
>> +		release_sock(arg.ssk);
>> +	}
>> +}
>
> Overall the above move the pending skbs to the msk receive queue,
> increment ssk copied_seq and eventually let TCP send ack via
> tcp_cleanup_rbuf().
>

It's only moving in-order skbs, right?

> I think we could avoid touching tcp_read_sock() in patch 2/5 moving the
> skb directly from __mptcp_move_skbs() - no call to tcp_read_sock(),
> just queue manipulation and copied_seq accounting.
>
> Than __mptcp_move_skbs() will call directly, as needed - need to export
> it.

This makes sense to me. We have to do another layer of reassembly for =

MPTCP and we already know the skbs are in-order for the subflow stream, =

and there's no need to handle partial skb reads like tcp_read_sock does.

>
> We could additionally clean-up the code calling __mptcp_move_skbs()
> from mptcp_recvmsg() before looking into the msk receive queue. Than no
> need for the current recvmsg inner loop.
>
> I fear we need some tweek to handle TCP fallback. If I read the RFC
> correctly the msk can fallback to TCP even after receiving some DSS
> data (e.g. msk receive queue contains some skbs and the msk fallback to
> TCP. We can't call anymore sock_recvmsg())

RFC 8684 section 3.7 (Fallback) says that "If a subflow breaks during =

operation... the subflow SHOULD be treated as broken and closed with a =

RST". Does that cover your concern, or are you referring to a fallback at =

connection time?


--
Mat Martineau
Intel
--===============7139817105392974517==--
