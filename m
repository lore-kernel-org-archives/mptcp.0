Content-Type: multipart/mixed; boundary="===============6513924396485874168=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] protocol: add comment to smb_mb__after_atomic
Date: Tue, 14 Jan 2020 17:44:19 -0800
Message-ID: <alpine.OSX.2.21.2001141741390.26562@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: 20200114232800.20658-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3359

--===============6513924396485874168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 15 Jan 2020, Florian Westphal wrote:

> squashto: mptcp: add subflow write space signalling and mptcp_poll
>
> msk->flags and sock->flags depend one one another, we first need to
> disable SEND_SPACE flag (no more wmem available for sending), then
> enable the write_space callbacks in the tcp core.

This dependency between msk->flags and sock->flags would also explain the =

barrier in subflow_write_space(), correct? That barrier is also added in =

this 'squashto' commit, and could benefit from a similar comment since the =

access to sock->flags is hidden inside sk_stream_write_space().

Mat


>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6df4eb20916c..5dfca0aa7ce4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -547,6 +547,7 @@ static void ssk_check_wmem(struct mptcp_sock *msk, st=
ruct sock *ssk)
> 	if (sock) {
> 		clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> 		smp_mb__after_atomic();
> +		/* set NOSPACE only after clearing SEND_SPACE flag */
> 		set_bit(SOCK_NOSPACE, &sock->flags);
> 	}
> }
> -- =

> 2.24.1
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============6513924396485874168==--
