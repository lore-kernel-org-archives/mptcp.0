Content-Type: multipart/mixed; boundary="===============0830872427615063326=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/8] mptcp: update mptcp ack sequence
 from work queue
Date: Tue, 25 Feb 2020 13:31:27 +0100
Message-ID: <8049d9054ab08f3c7a68176d7fcae77478f50065.camel@redhat.com>
In-Reply-To: 20200225120526.2866-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3779

--===============0830872427615063326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-25 at 13:05 +0100, Florian Westphal wrote:
> +static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> +{
> +	unsigned int moved =3D 0;
> +	bool done;
> +
> +	do {
> +		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> +
> +		if (!ssk)
> +			break;
> +
> +		lock_sock(ssk);

I'm wondering if bh_lock_sock(ssk) would suffice here?

If so we could do the skbs move from mptcp_release_cb() in patch 8.

But it looks like the full lock_sock() is required by the skb_orphan()
call, which in turn modifies ssk->sk_forward_alloc, so no luck right?

Thanks!

Paolo

--===============0830872427615063326==--
