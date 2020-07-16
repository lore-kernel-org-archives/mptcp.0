Content-Type: multipart/mixed; boundary="===============5438029549580310152=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 12/12] mptcp: Safely store sequence
 number when sending data
Date: Thu, 16 Jul 2020 16:15:18 +0200
Message-ID: <f6a1927611c1aad78b179ff87e1205065a72cd9e.camel@redhat.com>
In-Reply-To: 20200716002036.705306-13-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5047

--===============5438029549580310152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
> The MPTCP socket's write_seq member can be read without the msk lock
> held, so use WRITE_ONCE() to store it.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 30c5810771dd..ed3ca80d72f8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -797,7 +797,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
>  out:
>  	if (!retransmission)
>  		pfrag->offset +=3D frag_truesize;
> -	*write_seq +=3D ret;
> +	WRITE_ONCE(*write_seq, *write_seq + ret);
>  	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;

I think the msk lock should be already held here ?!?

/P

--===============5438029549580310152==--
