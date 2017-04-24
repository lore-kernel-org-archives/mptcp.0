Content-Type: multipart/mixed; boundary="===============0426334989573202832=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: Register handlers for extra TCP options
Date: Mon, 24 Apr 2017 16:06:03 -0700
Message-ID: <alpine.OSX.2.21.1704241552400.39098@mjmartin-mac01.sea.intel.com>
In-Reply-To: 20170421041327.7989-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8

--===============0426334989573202832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 20 Apr 2017, Mat Martineau wrote:

> Allow additional TCP options to be handled by registered hook
> functions.
>
> Option parsing will call the provided 'parse' function when a TCP option
> number is not recognized by the normal option parsing code.
>
> The 'prepare' and 'prepare_req' functions determine the required space
> for registered options and store associated data. There are two variants
> because options must be generated for connections that are associated
> with either tcp_sock or request_sock structures.
>
> A static key and RCU synchronization are used to minimize the
> performance impact of these extensible TCP features.
>
> Before this is posted upstream, I plan to split the patch in two parts
> (at least), since making tcp_out_options public should be separate. The
> extra parameter for tcp_parse_options may also warrant its own
> patch. I'd also like to discuss where to store information for the
> options that are parsed or generated using these hooks, since the
> tcp_options_received and tcp_out_options structs don't have places to
> store extra information yet.
>
> I've confirmed that this code builds, but haven't tested yet.
>
> This commit is also available at
> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git
> branch: mptcp
>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---

...

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 04843ae77b9e..e0d0504f005a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3279,6 +3287,132 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
>
> #endif
>
> +/* Linear search, few entries are expected. The RCU read lock must
> + * be held before calling.
> + */
> +static struct tcp_extra_option_ops *tcp_extra_options_find_kind(unsigned=
 char kind)
> +{
> +	struct tcp_extra_option_ops *entry;
> +
> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> +		if (entry->option_kind =3D=3D kind)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +void tcp_extra_options_parse(int opcode, int opsize, const unsigned char=
 *opptr,
> +			     const struct sk_buff *skb,
> +			     struct tcp_options_received *opt_rx,
> +			     struct tcp_sock *tp)
> +{
> +	struct tcp_extra_option_ops *entry;
> +
> +	rcu_read_lock();
> +	entry =3D tcp_extra_options_find_kind(opcode);
> +	if (entry && entry->parse)
> +		entry->parse(opsize, opptr, skb, opt_rx, tp);
> +	rcu_read_unlock();
> +}
> +
> +unsigned int tcp_extra_options_prepare(struct sk_buff *skb, u8 flags,
> +				       unsigned int remaining,
> +				       struct tcp_out_options *opts,
> +				       struct tcp_sock *tp)
> +{
> +	struct tcp_extra_option_ops *entry;
> +	unsigned int used =3D 0;
> +
> +	rcu_read_lock();

I think I'll change this to have the caller handle rcu_read_lock/unlock, =

so the registered option list stays the same between the paired calls to =

tcp_extra_options_prepare{,_req}() and tcp_extra_options_write(). I'll =

double-check that nothing blocks or sleeps between those calls.

> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> +		if (unlikely(!entry->prepare))
> +			continue;
> +
> +		used +=3D entry->prepare(skb, flags, remaining - used, opts, tp);
> +	}
> +	rcu_read_unlock();
> +
> +	return used;
> +}
> +
> +unsigned int tcp_extra_options_prepare_req(struct sk_buff *skb, u8 flags,
> +					   unsigned int remaining,
> +					   struct tcp_out_options *opts,
> +					   struct request_sock *req)
> +{
> +	struct tcp_extra_option_ops *entry;
> +	unsigned int used =3D 0;
> +
> +	rcu_read_lock();

Same applies to this read lock and tcp_extra_options_write below.

> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> +		if (unlikely(!entry->prepare_req))
> +			continue;
> +
> +		used +=3D entry->prepare_req(skb, flags, remaining - used, opts,
> +					   req);
> +	}
> +	rcu_read_unlock();
> +
> +	return used;
> +}
> +
> +void tcp_extra_options_write(__be32 *ptr, struct tcp_out_options *opts,
> +			     struct tcp_sock *tp)
> +{
> +	struct tcp_extra_option_ops *entry;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &tcp_option_list, list) {
> +		if (unlikely(!entry->write))
> +			continue;
> +
> +		entry->write(ptr, opts, tp);
> +	}
> +	rcu_read_unlock();
> +}

--
Mat Martineau
Intel OTC

--===============0426334989573202832==--
