Content-Type: multipart/mixed; boundary="===============3638849664286669236=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Deal with family field being removed from
 mptcp_options_received
Date: Fri, 17 Jan 2020 11:56:37 -0800
Message-ID: <alpine.OSX.2.21.2001171142320.60719@mjmartin-mac01.local>
In-Reply-To: 20200117070123.5937-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3410

--===============3638849664286669236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 16 Jan 2020, Peter Krystad wrote:

> Use individual add_addr flags instead.
>
> squashto: Add path manager interface
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>

I ran in to conflicts each time I tried to apply the six patches, applying =

each patch at the noted squashto commit. Made an attempt with an older =

export branch too). I'm not sure of the best way to share "squashto" =

changes that introduce merge conflicts, but it's hard to take a look at =

the overall changes from this group of patches.

Now that there's overlap in the data for MP_CAPABLE, MP_JOIN, DSS, and =

ADD_ADDR, should there also be more checking in mptcp_parse_options() to =

ensure only supported combinations are allowed to write in to the =

structure? We've made some assumptions regarding what will fit, but =

different combinations/orders of MPTCP options could overwrite values in =

interesting (and potentially harmful) ways.


Mat


> ---
> net/mptcp/options.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 3f15cd1620d3..b03e97eefbf4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -621,15 +621,18 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb,
> 	if (!check_fourth_ack(subflow, skb, mp_opt))
> 		return;
>
> -	if (msk && mp_opt->add_addr) {
> -		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
> +	if (msk) {
> +		if (mp_opt->add_addr) {
> 			mptcp_pm_add_addr(msk, &mp_opt->addr, mp_opt->addr_id);
> +			mp_opt->add_addr =3D 0;
> +		}
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6)
> +		else if (mp_opt->add_addr6) {
> 			mptcp_pm_add_addr6(msk, &mp_opt->addr6,
> -					   mp_opt->addr_id);
> +					   mp_opt->addr6_id);
> +			mp_opt->add_addr6 =3D 0;
> +		}
> #endif
> -		mp_opt->add_addr =3D 0;
> 	}
>
> 	if (!mp_opt->dss)
> -- =

> 2.17.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============3638849664286669236==--
