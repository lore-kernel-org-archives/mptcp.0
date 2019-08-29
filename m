Content-Type: multipart/mixed; boundary="===============8971624063130428274=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 03/10] mptcp: token: rename token_join_response
Date: Thu, 29 Aug 2019 12:11:47 +0200
Message-ID: <db56ea7a-4d43-2766-7017-36552e2c62a2@tessares.net>
In-Reply-To: 20190829090659.766-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1753

--===============8971624063130428274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 29/08/2019 11:06, Florian Westphal wrote:
> This function validates the truncated hmac and computes a hmac for use
> in the ack packet.  Rename it, place it where its used, and do the
> hmac computation in the caller.
> =

> This also adds a pr_fmt specifier, so the included pr_debug will
> auto-gain 'MPTCP' prefix.
> =

> v2: change name and place hmac calculation in the caller (Peter)
>     add pr_fmt too
>     squash two pr_debug() into one.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.h |  1 -
>  net/mptcp/subflow.c  | 34 ++++++++++++++++++++++++++++++----
>  net/mptcp/token.c    | 31 -------------------------------
>  3 files changed, 30 insertions(+), 36 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1655283dbd6a..89bd68f85856 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -227,7 +227,6 @@ void mptcp_finish_join(struct sock *sk);
>  =

>  void token_new_request(struct request_sock *req, const struct sk_buff *s=
kb);
>  int token_join_request(struct request_sock *req, const struct sk_buff *s=
kb);
> -int token_join_response(struct sock *sk);
>  int token_join_valid(struct request_sock *req,
>  		     struct tcp_options_received *rx_opt);
>  void token_destroy_request(u32 token);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fc507e091cf5..8a8109466487 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) 2017 - 2019, Intel Corporation.
>   */
>  =

> +#define pr_fmt(fmt) "MPTCP: " fmt

Good idea to add this!

A small detail: should we also add "subflow:" (or "sf:")?

    "MPTCP:sf: "

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8971624063130428274==--
