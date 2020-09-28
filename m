Content-Type: multipart/mixed; boundary="===============5917360850985843965=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 6/8] mptcp: refactor shutdown and close
Date: Mon, 28 Sep 2020 16:47:46 +0200
Message-ID: <8685bde51729292e11779df5dce99ce66b497cce.camel@redhat.com>
In-Reply-To: 6ba1cefb2825480dc5b5c3a29a14b63373e44dc6.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6074

--===============5917360850985843965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-24 at 15:59 +0200, Paolo Abeni wrote:
> @@ -417,9 +435,8 @@ static void mptcp_check_data_fin(struct sock *sk)
>  			inet_sk_state_store(sk, TCP_CLOSING);
>  			break;
>  		case TCP_FIN_WAIT2:
> -			inet_sk_state_store(sk, TCP_CLOSE);
> -			// @@ Close subflows now?
> -			break;
> +			inet_sk_state_store(sk, TCP_TIME_WAIT);
> +			return;

the 'return;' statement slipped-in unintentionally here: this does not
send data_fin ack, if the fin in received in fin_wait2 state.

I have quite a few pending fixes, so I'll send a v1 soon, even if there
are likely more bugs pending.

/P

--===============5917360850985843965==--
