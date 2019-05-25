Content-Type: multipart/mixed; boundary="===============3653349837083807066=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Make mptcp initialization part of tcp
 initialization
Date: Sat, 25 May 2019 11:14:56 +0200
Message-ID: <20190525091456.ujuntink7e7sqs7u@breakpoint.cc>
In-Reply-To: 20190524230521.4141-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1243

--===============3653349837083807066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Peter Krystad <peter.krystad(a)linux.intel.com> wrote:
>  static inline bool sk_is_mptcp(const struct sock *sk)
>  {
>  	return tcp_sk(sk)->is_mptcp;
> @@ -84,6 +86,10 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts);
>  =

>  #else
>  =

> +void mptcp_init(void)
> +{
> +}
> +

ITYM 'static inline void mptcp_init(void) {}'.

--===============3653349837083807066==--
