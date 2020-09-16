Content-Type: multipart/mixed; boundary="===============6909171140514962195=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Fix unsigned 'max_seq' compared with
 zero in mptcp_data_queue_ofo
Date: Wed, 16 Sep 2020 14:23:39 +0200
Message-ID: <f947d64e-5970-7022-1a06-964c7dfbbd03@tessares.net>
In-Reply-To: 20200916114104.1556846-1-yebin10@huawei.com
X-Status: 
X-Keywords:                  
X-UID: 5898

--===============6909171140514962195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ye,

Thank you for this v2.

On 16/09/2020 13:41, Ye Bin wrote:
> Fixes coccicheck warnig:
> net/mptcp/protocol.c:164:11-18: WARNING: Unsigned expression compared wit=
h zero: max_seq > 0
> =

> Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue")
> Reported-by: Hulk Robot <hulkci(a)huawei.com>
> Signed-off-by: Ye Bin <yebin10(a)huawei.com>
> ---
>   net/mptcp/protocol.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ef0dd2f23482..3b71f6202524 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -155,13 +155,14 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>   {
>   	struct sock *sk =3D (struct sock *)msk;
>   	struct rb_node **p, *parent;
> +	int space;
>   	u64 seq, end_seq, max_seq;
>   	struct sk_buff *skb1;

In the network subsystem, variables have to be declared following the =

"reverse Xmas tree" order: longest to shortest line length.

Could you then please move your new variable to the end of the list, =

under skb1?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6909171140514962195==--
