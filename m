Content-Type: multipart/mixed; boundary="===============7251274387363897686=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [mptcp-dev] [PATCH] mptcp: fix typo in
 mptcp_options_write() stub
Date: Wed, 27 Mar 2019 15:20:01 +0100
Message-ID: <CAKuKrB=UHxybmhr1i7Cj+iPgKxfrgRuHBD52+NBE8-RW1KqQBA@mail.gmail.com>
In-Reply-To: 8799e37c4c421bc25b0403dcc596700780ea9a33.1553695162.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1034

--===============7251274387363897686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On Wed, Mar 27, 2019 at 2:59 PM Davide Caratti <dcaratti(a)redhat.com> wrot=
e:
>
> it causes build errors when CONFIG_MPTCP is unset

Thank you for the patch.
But I think you sent it to the wrong ML: mptcp-dev(a)listes.uclouvain.be
(current implementation) vs mptcp(a)lists.01.org (upstream project, now
in cc).

Because what you want to fix has not been merged yet, feel free to
directly report this typo there:
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437402/9/inclu=
de/net/mptcp.h#218
;-)

Cheers,
Matt

>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  include/net/mptcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 9d38b191c97a..8b34ae46a075 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -249,7 +249,7 @@ static inline bool mptcp_skb_ext_exist(const struct s=
k_buff *skb)
>
>  static void mptcp_options_write(__be32 *ptr, struct sk_buff *skb,
>                                 struct tcp_sock *tp,
> -                               struct tmpcp_out_options *opts)
> +                               struct mptcp_out_options *opts)
>  {
>  }
>
> --
> 2.20.1
>
> MPTCP-developpers Mailing-List
> Visit http://multipath-tcp.org to access the source-code of MPTCP in the =
Linux Kernel
>
> To Unsubscribe, visit https://listes-2.sipr.ucl.ac.be/sympa/info/mptcp-dev
>


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7251274387363897686==--
