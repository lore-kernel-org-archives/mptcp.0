Content-Type: multipart/mixed; boundary="===============0151701509287705751=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Optimize DSS fields in
 mptcp_options_received
Date: Fri, 17 Jan 2020 10:08:40 -0800
Message-ID: <alpine.OSX.2.21.2001170950400.60719@mjmartin-mac01.local>
In-Reply-To: 20200117070030.5825-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3407

--===============0151701509287705751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jan 2020, Peter Krystad wrote:

> Use union to minimize space used in structure.
> Allow 32-bit DSS to be received at the same time as MP_CAPABLE.
>
> squashto: Implement MPTCP receive path
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> include/linux/tcp.h | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6abf8d9f1a42..a9200a86a6d2 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -80,12 +80,18 @@ struct tcp_sack_block {
>
> #if IS_ENABLED(CONFIG_MPTCP)
> struct mptcp_options_received {
> -	u64	sndr_key;
> -	u64	rcvr_key;
> -	u32	data_ack32;
> -	u32	data_seq32;
> -	u64	data_ack;
> -	u64	data_seq;
> +	union {
> +		struct {
> +			u64	sndr_key;
> +			u64	rcvr_key;
> +			u32	data_ack32;
> +			u32	data_seq32;
> +		};
> +		struct {
> +			u64	data_ack;
> +			u64	data_seq;
> +		};
> +	};

If one of the goals is to ensure that mixed 32/64 ack/seq is working (as =

mentioned in next commit message), I think it would be better to express =

that as a union with the data_ack/data_seq and sndr_key/rcvr_key values =

rather than depend on struct alignment:

 	struct {
 		union {
 			struct {
 				u64	sndr_key;
 				u64	rcvr_key;
 			};
 			struct {
 				u64	data_ack;
 				u64	data_seq;
 			};
 		};
 		u32	data_ack32;
 		u32	data_seq32;
 	};

That does require some rearranging in later commits (reintroducing the =

top-level union to add the ipv6 ADD_ADDR data).

> 	u32	subflow_seq;
> 	u16	data_len;
> 	u8	mp_capable : 1,
> -- =

> 2.17.2

--
Mat Martineau
Intel
--===============0151701509287705751==--
