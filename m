Content-Type: multipart/mixed; boundary="===============5907873174962099837=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 3/6] subflow: store known available bytes in
 subflow
Date: Tue, 12 Nov 2019 01:51:12 +0100
Message-ID: <20191112005112.GD19558@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1911111637500.7818@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2477

--===============5907873174962099837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > 	skb =3D skb_peek(&sk->sk_receive_queue);
> > -	subflow->data_avail =3D skb &&
> > -		       before(tcp_sk(sk)->copied_seq, TCP_SKB_CB(skb)->end_seq);
> > -	return subflow->data_avail;
> > +	if (skb) {
> > +		const struct tcp_sock *tp =3D tcp_sk(sk);
> > +		u32 map_remaining =3D subflow->map_data_len -
> > +				    mptcp_subflow_get_map_offset(subflow);
> > +
> =

> It looks like the mapping can be assumed valid here, since
> subflow_check_data_avail() returned true. It's not obvious looking at this
> function that map_valid should be true at this point - is it worth a
> WARN_ONCE or a comment?

I think I'll go with a WARN_ON_ONCE().
--===============5907873174962099837==--
