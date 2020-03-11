Content-Type: multipart/mixed; boundary="===============4523898496810510316=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 6/12] Squash-to: "mptcp: allow dumping subflow
 context to userspace"
Date: Wed, 11 Mar 2020 21:02:39 +0100
Message-ID: <18bdfe7d-c4eb-fa1c-6a69-c28c7d84366b@tessares.net>
In-Reply-To: 9bc5d0bf5dbd649ea83dffcae3a0e6980f3696cf.1583418573.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3926

--===============4523898496810510316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 05/03/2020 15:46, Paolo Abeni wrote:
> fix after field name change.
> =

> Additionally rename the exposed uAPI flags to be more consistent

[...]

> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index 4b6d9f7e418f..a536586742f2 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -43,8 +43,8 @@ static int subflow_get_info(const struct sock *sk, stru=
ct sk_buff *skb)
>   		flags |=3D MPTCP_SUBFLOW_FLAG_BKUP_REM;
>   	if (sf->request_bkup)
>   		flags |=3D MPTCP_SUBFLOW_FLAG_BKUP_LOC;
> -	if (sf->fourth_ack)
> -		flags |=3D MPTCP_SUBFLOW_FLAG_4THACK;
> +	if (sf->fully_established)
> +		flags |=3D MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;

I guess you will have to do some changes on your side in ss code ;)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4523898496810510316==--
