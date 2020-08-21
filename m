Content-Type: multipart/mixed; boundary="===============3145907505778841433=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 1/1] mptcp: fix stale
 subflow->writeable caching
Date: Fri, 21 Aug 2020 12:10:05 -0700
Message-ID: <alpine.OSX.2.23.453.2008211209290.9615@mjmartin-mac01.local>
In-Reply-To: 20200821153824.27468-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5596

--===============3145907505778841433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Aug 2020, Florian Westphal wrote:

> Even with fixed subflow_write_space(), we may still indicate EPOLLOUT
> even if no subflow is writeable.
>
> We need to re-check the last ssk that was used after the final tcp_push().
> tcp_push() can allocate new skbs that get charged to the subflow sk
> which may bring it above the wmem limit.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ad91f4588216..4dd5d35a8f39 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1239,7 +1239,7 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 		msk->snd_burst -=3D ret;
> 		copied +=3D ret;
>
> -		if (!sk_stream_memory_free(ssk))
> +		if (!sk_stream_is_writeable(ssk))
> 			WRITE_ONCE(subflow->writable, false);
>
> 		tx_ok =3D msg_data_left(msg);
> @@ -1294,6 +1294,9 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 		/* start the timer, if it's not pending */
> 		if (!mptcp_timer_pending(sk))
> 			mptcp_reset_timer(sk);
> +
> +		if (!sk_stream_is_writeable(ssk))
> +			WRITE_ONCE(mptcp_subflow_ctx(ssk)->writable, false);
> 	}
>
> 	release_sock(ssk);
> -- =

> 2.26.2

Thanks Florian. All three patches look good to me.

--
Mat Martineau
Intel
--===============3145907505778841433==--
