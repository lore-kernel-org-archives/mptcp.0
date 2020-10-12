Content-Type: multipart/mixed; boundary="===============4662670731063644448=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 1/3] mptcp: change
 add_addr_signal type
Date: Mon, 12 Oct 2020 18:02:06 +0200
Message-ID: <1dbbdb9f32998bde8afaf9e462bfa3999de9bc8a.camel@redhat.com>
In-Reply-To: 4e6e17e8ca4879f101c7e649031fe1b174ee4c1d.1602323760.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6293

--===============4662670731063644448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-10-10 at 18:07 +0800, Geliang Tang wrote:
> This patch changed the 'add_addr_signal' type from bool to char, so that
> we could encode the addr type there.
> =

> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm.c       | 12 ++++++------
>  net/mptcp/protocol.h | 10 +++++++---
>  2 files changed, 13 insertions(+), 9 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index f9c88e2abb8e..5f453db36e54 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -19,8 +19,9 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
>  =

>  	msk->pm.local =3D *addr;
> -	WRITE_ONCE(msk->pm.add_addr_echo, echo);
> -	WRITE_ONCE(msk->pm.add_addr_signal, true);
> +	msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
> +	if (echo)
> +		msk->pm.add_addr_signal |=3D BIT(MPTCP_ADD_ADDR_ECHO);

I think we need to preserve the barriers.

Under spin lock protection we need the WRITE_ONCE() when writing the
field, outside the spinlock protection we need the READ_ONCE() to
access it.

The above should be something alike:

	u8 add_addr =3D msk->pm.add_addr_signal;

	[...]
	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
	if (echo)
		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);

/P

--===============4662670731063644448==--
