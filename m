Content-Type: multipart/mixed; boundary="===============4016824328847832588=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash-to: "mptcp: push pending frames
 when subflow has free space"
Date: Thu, 10 Dec 2020 15:31:03 -0800
Message-ID: <9c251dd9-954a-b6d7-a5b6-509076a2a516@linux.intel.com>
In-Reply-To: c389f95f768ed57163765418c1f1670e08bba8e1.1607639386.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7138

--===============4016824328847832588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Dec 2020, Paolo Abeni wrote:

> whoops, checking the free space on the wrong sock
>

Looks good to squash, thanks for spotting this.

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/options.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f4e6808691ed..973867f73952 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -881,7 +881,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
>
> 	/* this assumes mptcp_incoming_options() is invoked after tcp_ack() */
> 	if (after64(msk->wnd_end, READ_ONCE(msk->snd_nxt)) &&
> -	    sk_stream_memory_free(sk))
> +	    sk_stream_memory_free(ssk))
> 		__mptcp_check_push(sk, ssk);
>
> 	if (after64(new_snd_una, old_snd_una)) {
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4016824328847832588==--
