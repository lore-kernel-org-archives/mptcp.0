Content-Type: multipart/mixed; boundary="===============8682992279484273471=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 2/5] mptcp: v1 ADD_ADDR changes: options and
 parsing
Date: Thu, 12 Mar 2020 16:33:27 +0100
Message-ID: <46be534ae8bb1e36fa363f4bc7a518a7577b919e.camel@redhat.com>
In-Reply-To: 20200311172600.4185-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3934

--===============8682992279484273471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, 2020-03-11 at 10:25 -0700, Peter Krystad wrote:
> Remove family field and add hmac and echo fields to struct
> mptcp_options_received. Parse incoming hmac on ADD_ADDR option,
> and send hmac with outgoing option.
> =

> squashto: Add ADD_ADDR handling
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  include/linux/tcp.h  |  19 ++++---
>  include/net/mptcp.h  |   2 +
>  net/mptcp/options.c  | 132 +++++++++++++++++++++++++++++++++----------
>  net/mptcp/protocol.h |  16 ++++--
>  4 files changed, 128 insertions(+), 41 deletions(-)
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 1e733f9fb4ab..2fa145aae5ae 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -86,9 +86,13 @@ struct mptcp_options_received {
>  	u64	data_seq;
>  	u32	subflow_seq;
>  	u16	data_len;
> -	u8	mp_capable : 1,
> +	u16	mp_capable : 1,
>  		mp_join : 1,
> -		dss : 1;
> +		dss : 1,
> +		add_addr : 1,
> +		rm_addr : 1,
> +		family : 4,
> +		echo : 1;
>  	u8	use_map:1,
>  		dsn64:1,
>  		data_fin:1,
> @@ -96,16 +100,15 @@ struct mptcp_options_received {
>  		ack64:1,
>  		mpc_map:1,
>  		__unused:2;
> -	u8	add_addr : 1,
> -		rm_addr : 1,
> -		family : 4;
>  	u8	addr_id;
>  	union {
> -		struct	in_addr	addr;
> -#if IS_ENABLED(CONFIG_IPV6)
> -		struct	in6_addr addr6;
> +		struct in_addr	addr;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +		struct in6_addr	addr6;
>  #endif
>  	};
> +	u64	ahmac;
> +	u8	rm_id;

I think we will have 2 bytes hole before the above union. If so,
'rm_id' could be moved there.

Other than that, LGTM.

Thanks,

Paolo

--===============8682992279484273471==--
