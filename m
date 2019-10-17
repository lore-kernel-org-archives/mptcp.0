Content-Type: multipart/mixed; boundary="===============3960546414280207812=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: deal better with out-of-sequence
 mapping
Date: Thu, 17 Oct 2019 15:22:07 +0200
Message-ID: <043c40fd-e826-defd-f346-4b93e9202c28@tessares.net>
In-Reply-To: d02b8158d9a29799f3b9b6e7d98bb4f3d094db8d.1571258477.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2211

--===============3960546414280207812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the patches!

On 17/10/2019 11:00, Paolo Abeni wrote:
> map colaescing is an evil early optimization, drop it.
> Instead ensure we process correctly any map we receive while
> there is a pending, active, one:
> =

> - allow replacing only with identic mapping
> - explicitly bail if the new map covers only data in future skbs
>    as we don't support map caching (yet)
> =

> Squash-to: "mptcp: Implement MPTCP receive path"
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   net/mptcp/subflow.c | 51 ++++++++++++++++++++++-----------------------
>   1 file changed, 25 insertions(+), 26 deletions(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8e6e0f782f5e..3858187df4ce 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -180,6 +180,19 @@ static void warn_bad_map(struct mptcp_subflow_contex=
t *subflow, u32 ssn)
>   		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
>   }
>   =

> +static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	unsigned skb_consumed;
> +
> +	skb_consumed =3D tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq; > +	if=
 (WARN_ON_ONCE(skb_consumed >=3D skb->len))
> +		return true;
> +
> +	return skb->len - skb_consumed <=3D subflow->map_data_len -
> +					  mptcp_subflow_get_map_offset(subflow);

Do we need to do something special here and/or above to deal with =

wraparounds?

By only looking at this chunk of code, it looks like skb_consumed can =

have a huge value if one of the two seq numbers have done a wraparound. =

Then we might have a warning.
Same below with map_data_len and the offset, no?
But maybe it is not possible in this context.

For the rest, it looks good to me! I can apply them to avoid problems =

with the tests (even if for the moment, the tests are not launched =

because the compilation with i386 and without IPV6 fail :-) )

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3960546414280207812==--
