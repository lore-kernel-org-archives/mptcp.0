Content-Type: multipart/mixed; boundary="===============9092527615383281569=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v4 16/17] mptcp: Implement MPTCP receive path
Date: Fri, 30 Nov 2018 14:33:54 -0800
Message-ID: <alpine.OSX.2.21.1811301430470.50941@zyi1-mobl1.amr.corp.intel.com>
In-Reply-To: 20181130201112.21806-17-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 871

--===============9092527615383281569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 30 Nov 2018, Mat Martineau wrote:

> Parses incoming DSS options and populates outgoing MPTCP ACK
> fields. Clone incoming skbs containing MPTCP headers and propagate them
> to the MMPTCP socket using the error queue. This avoids the need for TCP
> coalesce/collapse bypass for MPTCP, although cloning incoming skbs does
> prevent some coalescing.
>
> Keeping DSS map handling separate from data reading makes it easier to
> add multiple-subflow receiving, since the receive code can determine
> which subflow contains relevant data or data that needs to be purged
> without touching the subflow data queues.
>
> MPTCP ACK values are now populated from an atomic value stored in the
> connection socket rather than carried in the extended control block,
> which makes use of the most up-to-date sequence number and allows the
> MPTCP ACK to be populated on TCP ACK packets that have no payload.
>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
> include/linux/tcp.h   |  12 ++
> include/net/mptcp.h   |  43 ++++-
> net/ipv4/tcp_input.c  |   4 +
> net/ipv4/tcp_output.c | 120 +++++++-------
> net/mptcp/options.c   |  98 +++++++++++-
> net/mptcp/protocol.c  | 360 +++++++++++++++++++++++++++++++++++++++---
> net/mptcp/subflow.c   |  29 +++-
> 7 files changed, 574 insertions(+), 92 deletions(-)
>

...

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index b7a392652aed..d3b7083859b7 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -38,14 +38,14 @@
> /* MPTCP connection sock */
> struct mptcp_sock {
> 	/* inet_connection_sock must be the first member */
> -	struct	inet_connection_sock sk;
> -	u64	local_key;
> -	u64	remote_key;
> -	u64	write_seq;
> -	u64	ack_seq;
> -	u32	token;
> -	struct	socket *connection_list; /* @@ needs to be a list */
> -	struct	socket *subflow; /* outgoing connect, listener or !mp_capable */
> +	struct inet_connection_sock sk;
> +	u64		local_key;
> +	u64		remote_key;
> +	u64		write_seq;
> +	atomic64_t	ack_seq;
> +	u32		token;
> +	struct socket	*connection_list; /* @@ needs to be a list */
> +	struct socket	*subflow; /* outgoing connect, listener or !mp_capable */
> };
>
> static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
> @@ -81,16 +81,23 @@ struct subflow_sock {
> 	/* tcp_sock must be the first member */
> 	struct	tcp_sock sk;
> 	u64	local_key;
> +	u64	map_seq;
> +	u32	map_subflow_seq;
> 	u32	token;
> 	u64	idsn;
> 	u64	remote_key;
> 	u32	rel_write_seq;
> +	u32	ssn_offset;
> +	u16	map_dll;
> 	bool	request_mptcp;	// send MP_CAPABLE
> 	bool	checksum;
> 	bool	version;
> 	bool	mp_capable;	// remote is MPTCP capable
> 	bool	fourth_ack;	// send initial DSS
> +	bool	conn_finished;
> +	bool	map_valid;
> 	struct	sock *conn;	// parent mptcp_sock
> +	void	(*tcp_sk_data_ready)(struct sock *sk);
> };
>
> static inline struct subflow_sock *subflow_sk(const struct sock *sk)
> @@ -98,6 +105,16 @@ static inline struct subflow_sock *subflow_sk(const s=
truct sock *sk)
> 	return (struct subflow_sock *)sk;
> }
>
> +static inline struct subflow_sock *subflow_tp(const struct tcp_sock *tp)
> +{
> +	return (struct subflow_sock *)tp;
> +}
> +
> +static inline struct sock *sock_sk(const struct subflow_sock *sk)
> +{
> +	return (struct sock *)sk;
> +}
> +
> struct subflow_request_sock {
> 	struct	tcp_request_sock sk;
> 	u8	mp_capable : 1,
> @@ -109,6 +126,7 @@ struct subflow_request_sock {
> 	u32	token;
> 	u64	idsn;
> 	u64	remote_key;
> +	u32	ssn_offset;
> };
>
> static inline
> @@ -137,6 +155,10 @@ void mptcp_get_options(const struct sk_buff *skb,
> 		       struct tcp_options_received *options);
>
> void mptcp_cb_copy(const struct sk_buff *from, struct sk_buff *to);
> +void mptcp_cb_set(struct sk_buff *skb, struct mptcp_skb_cb *mcb);
> +
> +void mptcp_attach_dss(struct sock *sk, struct sk_buff *original_skb,
> +		      struct tcp_options_received *opt_rx);

I got an automated kbuild email - I didn't define a stub for this when =

CONFIG_MPTCP is not set...

>
> extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
>
> @@ -197,5 +219,10 @@ void mptcp_cb_copy(const struct sk_buff *from, struc=
t sk_buff *to)
> {
> }
>
> +static inline void mptcp_queue_headers(struct sock *sk,
> +				       struct sk_buff *original_skb)
> +{
> +}
> +

...because mptcp_attach_dss should replace this stub.

> #endif /* CONFIG_MPTCP */
> #endif /* __NET_MPTCP_H */

...

--
Mat Martineau
Intel OTC

--===============9092527615383281569==--
