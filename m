Content-Type: multipart/mixed; boundary="===============5384714105249807965=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 1/5] mptcp: perform mptcp ack update during read
 operations
Date: Fri, 14 Feb 2020 16:29:23 -0800
Message-ID: <alpine.OSX.2.22.394.2002141625080.55209@echiprou-mobl.amr.corp.intel.com>
In-Reply-To: 20200213102742.18937-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3662

--===============5384714105249807965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2020, Florian Westphal wrote:

> tcp_read_sock() will drain the receive queue, i.e. it frees memory.
> Therefore, at the end of the function it can generate ACKs to open
> up the tcp receive window.
>
> Unfortunately, the MPTCP ack sequence was updated later, i.e. those
> ACKs carry an outdated mptcp ack sequence.
>
> This isn't a bug per se, but we can improve this and update the
> mptcp ack in the read actor callback, thus allowing the acks sent
> by tcp_read_sock() to include the most recent mptcp ack sequence.
>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 4 +++-
> net/mptcp/protocol.h | 1 +
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1f405b812243..f68ee86376f0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -608,6 +608,8 @@ int mptcp_read_actor(read_descriptor_t *desc, struct =
sk_buff *skb,
> 			desc->error =3D err;
> 			return err;
> 		}
> +
> +		arg->msk->ack_seq +=3D copy_len;
> 	} else {
> 		pr_debug("Flushing skb payload");
> 	}
> @@ -664,6 +666,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 	}
>
> 	arg.msg =3D msg;
> +	arg.msk =3D msk;
> 	desc.arg.data =3D &arg;
> 	desc.error =3D 0;
>
> @@ -704,7 +707,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>
> 			pr_debug("msk ack_seq=3D%llx -> %llx", msk->ack_seq,
> 				 msk->ack_seq + bytes_read);

This debug print will show misleading information because ack_seq has =

already advanced.

> -			msk->ack_seq +=3D bytes_read;
> 			copied +=3D bytes_read;
> 			if (copied >=3D len) {
> 				done =3D true;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3fbb33deb764..06a57bf6d5f0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -305,6 +305,7 @@ int mptcp_proto_v6_init(void);
>
> struct mptcp_read_arg {
> 	struct msghdr *msg;
> +	struct mptcp_sock *msk;
> };
>
> int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
> -- =

> 2.24.1

--
Mat Martineau
Intel
--===============5384714105249807965==--
