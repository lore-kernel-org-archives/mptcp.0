Content-Type: multipart/mixed; boundary="===============8284464464140201710=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Mon, 27 May 2019 16:52:54 +0200
Message-ID: <efc387a96bddc542bd921a065048ab6005e294f2.camel@redhat.com>
In-Reply-To: 20190522213825.4057-4-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1249

--===============8284464464140201710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry for the late feedback, I'm still looking at this code...

On Wed, 2019-05-22 at 14:38 -0700, Peter Krystad wrote:
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 9c2a0d36fb20..baf8b975fce6 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -764,6 +764,12 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>  	if (!child)
>  		goto listen_overflow;
>  =

> +	if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
> +		inet_csk_reqsk_queue_drop(sk, req);
> +		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> +		return child;
> +	}
> +

Don't we need to check this is not a fastopen before dropping the req?

Can't we avoid the above hunck anyway, handling the special MP_JOIN
scenario in mptcp_accept() ? so that we reduce hooking, the user-space
is notified of a new subflow - 'accept()' would probably return a
specific error code, not a new fd!!! - and we enforce some limits on
the number of pending/new subflows.

WDYT?

Thanks,

Paolo


--===============8284464464140201710==--
