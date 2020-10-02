Content-Type: multipart/mixed; boundary="===============1491607761198977393=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 12/13] mptcp: keep track of advertised windows
 right edge
Date: Fri, 02 Oct 2020 18:08:50 +0200
Message-ID: <20201002160850.GC12773@breakpoint.cc>
In-Reply-To: 6e1d4bb3e0e972a65a7d9005ea633b239b4e3433.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6168

--===============1491607761198977393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> From: Florian Westphal <fw(a)strlen.de>
> =

> Before sending 'x' new bytes also check that the new snd_una would
> be within the permitted receive window.
> =

> For every ACK that also contains a DSS ack, check whether its tcp-level
> receive window would advance the current mptcp window right edge and
> update it if so.
> =

> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/options.c  | 24 ++++++++++++++++++----
>  static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  			      struct mptcp_data_frag *dfrag,
>  			      struct mptcp_sendmsg_info *info)
>  {
>  	u64 data_seq =3D dfrag->data_seq + info->sent;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	bool zero_window_probe =3D false;
>  	struct mptcp_ext *mpext =3D NULL;
>  	struct sk_buff *skb, *tail;
>  	bool can_collapse =3D false;
> @@ -950,6 +976,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
>  			avail_size =3D info->size_goal - skb->len;
>  	}
>  =

> +	/* Zero window and all data acked? Probe. */
> +	avail_size =3D mptcp_check_allowed_size(msk, data_seq, avail_size);
> +	if (avail_size =3D=3D 0 && atomic64_read(&msk->snd_una) =3D=3D msk->snd=
_nxt) {

This needs to check "!skb" (or !mpext) as well, now that this is not connec=
ted to
previous conditional anymore.

> @@ -973,6 +1007,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
>  	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
>  		WARN_ON_ONCE(!can_collapse);
>  		mpext->data_len +=3D ret;
> +		WARN_ON_ONCE(zero_window_probe);

I saw this trigger right now during a test run, should not happen
anymore after adding the check.
--===============1491607761198977393==--
