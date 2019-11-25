Content-Type: multipart/mixed; boundary="===============7420053487346011255=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 6/7] add mptcp_subflow_shutdown
Date: Mon, 25 Nov 2019 13:09:10 +0100
Message-ID: <f10b15f98f58b168624f3a2366ea5e9cae4975c8.camel@redhat.com>
In-Reply-To: 20191125021508.29153-7-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2681

--===============7420053487346011255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-25 at 03:15 +0100, Florian Westphal wrote:
> +static void mptcp_subflow_shutdown(struct sock *ssk, int how)
> +{
> +	lock_sock(ssk);
> +
> +	switch (ssk->sk_state) {
> +	case TCP_LISTEN:
> +		if (!(how & RCV_SHUTDOWN))
> +			break;
> +		/* fall through */
> +	case TCP_SYN_SENT:
> +		tcp_disconnect(ssk, O_NONBLOCK);
> +		break;
> +	default:
> +		ssk->sk_shutdown |=3D how;
> +		tcp_shutdown(ssk, how);
> +		break;
> +	}
> +
> +	/* Wake up anyone sleeping in poll. */
> +	ssk->sk_state_change(ssk);
> +	release_sock(ssk);
> +}

I think we can move this one can be moved to subflow.c.

Yep, it will lose the 'static' scope, but protocol.c is becoming quite
big...

WDYT?

Thanks,

Paolo

--===============7420053487346011255==--
