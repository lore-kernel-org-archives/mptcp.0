Content-Type: multipart/mixed; boundary="===============4802887245221990589=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 14/25] tcp_extra_options: Check static branch
 before _parse
Date: Tue, 28 Nov 2017 17:49:22 -0800
Message-ID: <alpine.OSX.2.21.1711281744540.17380@ddombrow-mobl1.amr.corp.intel.com>
In-Reply-To: 20171128055726.430-15-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 207

--===============4802887245221990589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 27 Nov 2017, Christoph Paasch wrote:

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> net/ipv4/tcp_input.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 4e84f299c96f..7acc1f46641c 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3799,9 +3799,11 @@ void tcp_parse_options(const struct net *net,
> 				break;
>
> 			default:
> -				tcp_extra_options_parse(opcode, opsize, ptr,
> -							skb, opt_rx,
> -							tcp_to_sk(tp));
> +				if (static_branch_unlikely(&tcp_extra_options_enabled))

Since this case in the switch statement is only executed for unrecognized =

options, I had skipped the static branch in the initial implementation. It =

is more consistent to use the static branch, and there isn't much use in =

making the function call just to try to iterate over an empty list.

> +					tcp_extra_options_parse(opcode, opsize,
> +								ptr, skb,
> +								opt_rx,
> +								tcp_to_sk(tp));
> 				break;
>
> 			}
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============4802887245221990589==--
