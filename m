Content-Type: multipart/mixed; boundary="===============5309761479107154405=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/7] mptcp: use mptcp backlog.
Date: Thu, 19 Nov 2020 00:11:07 +0100
Message-ID: <20201118231107.GB15137@breakpoint.cc>
In-Reply-To: fd0bfb708ae11768dda5546c905fd9fb99af0601.1605737933.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6804

--===============5309761479107154405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> @@ -2812,6 +2859,17 @@ static void mptcp_release_cb(struct sock *sk)
>  {
>  	unsigned long flags, nflags;
>  =

> +	/* push_pending may touch wmem_reserved, do it before the later
> +	 * cleanup
> +	 */

Can you expand here a bit on why the lock break is needed & safe?

We still own the socket, so I think its safe, but I am not sure why its
needed.  Only due to GFP_KERNEL alloc in mptcp_push_pending, or is there
more to it?

> +	set_bit(MPTCP_NOSPACE, &msk->flags);
> +	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */

I'm not sure why the barrier is needed.  What load/store needs the ordering?

Maybe I'm blind -- nothing catches my eye either here or in
subflow_write_space.
--===============5309761479107154405==--
