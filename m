Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9977462
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663689777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdRCAVOYpwFiDd7x10YNcR2P4zfagvjr1W10ICSfiAw=;
	b=VIKT+7B/NkGdNkn3zKGwYa5EffQB50RCifVNT6nb9L0PS7VQjURlkEXnyowtcSz8uU775R
	Uz/bYFI2rXUcTbOz1/atozBJFlBxBwy0LX967nFFg5/gZZ+hfBsoQTPWja95NunDtAW6xC
	OlmGKypuQ7DDYDyoPYMJeeROgKA7fFU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-cQxdvwzdPlmFNhdQusyEgQ-1; Tue, 20 Sep 2022 12:02:56 -0400
X-MC-Unique: cQxdvwzdPlmFNhdQusyEgQ-1
Received: by mail-qt1-f197.google.com with SMTP id cg13-20020a05622a408d00b0035bb2f77e7eso2172805qtb.10
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 09:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=MdRCAVOYpwFiDd7x10YNcR2P4zfagvjr1W10ICSfiAw=;
        b=S3iQzG/OJpyLlZVR42SFELp8TDddaHxjmDwXQrGaTsAqxXWW/BaLRpeQHMwdAMMmh2
         lktrUlUCQgj1URaiz+AZNagEBLjsgsXgX071UOhRcA11bSLJXV3K7UPrt9lxjhkTYMBK
         MHpoGwkVvsEuybkp3X2akA7CCiex8rDC5aFrpb+2joHWD1JTk6ZewQ3ndGygtuOHeCAI
         qwBAPl+0vw/SFhAvfIrBjEtzTRW3dGVJjNQOJ/wExjzJzzZ6BIpRh/0KwqqnZ+CFuAnS
         Q2BUS1kUSRngmSvXqTW9dL2cb2bhnBtm3zatysG/6DD4Uk/9OnwBgeyK45h+USflFwK6
         dWjw==
X-Gm-Message-State: ACrzQf2xL7vvVrknYXQ24dp6qexlG1vXp/1KkhCravG1c2IJlFRcARrw
	MVDXlq+04gyRNqAK9bTGd/7KsWSOjIvlbLkQq1m/bQTxLXO7bYyfv8oEyGSZMq/OMxh5CJdI/ag
	7nUAuMeLjbKpIdXg=
X-Received: by 2002:ad4:4ea2:0:b0:4ad:3423:cab with SMTP id ed2-20020ad44ea2000000b004ad34230cabmr10784317qvb.32.1663689775667;
        Tue, 20 Sep 2022 09:02:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ULS6PargTZWibB8r7P24useuMZiJeepHZWRcuA+3bVeyNXOylURtqg0Mj6PRdLZ3yZvj9tQ==
X-Received: by 2002:ad4:4ea2:0:b0:4ad:3423:cab with SMTP id ed2-20020ad44ea2000000b004ad34230cabmr10784278qvb.32.1663689775225;
        Tue, 20 Sep 2022 09:02:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id x10-20020ac8730a000000b0035a70a25651sm101235qto.55.2022.09.20.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:02:54 -0700 (PDT)
Message-ID: <f486773706f78c6ea780dfed5e97bbedf4fcee70.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v8 6/7] add skb to mskq in
 tcp_fastopen_add_skb()
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 20 Sep 2022 18:02:51 +0200
In-Reply-To: <20220920125243.2880-7-dmytro@shytyi.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
	 <20220920125243.2880-7-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
> In the following patches we add skb to msk->receive_queue in the MPTCP
> fastopen context.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  include/net/tcp.h       |  2 +-
>  net/ipv4/tcp_fastopen.c | 55 +++++++++++++++++++++++++++++++++++------
>  net/ipv4/tcp_input.c    | 11 +++++++--
>  net/mptcp/protocol.c    |  4 +--
>  net/mptcp/protocol.h    |  2 ++
>  5 files changed, 62 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a7d49e42470a..6456f90ed9ed 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1749,7 +1749,7 @@ int tcp_fastopen_reset_cipher(struct net *net, struct sock *sk,
>  			      void *primary_key, void *backup_key);
>  int tcp_fastopen_get_cipher(struct net *net, struct inet_connection_sock *icsk,
>  			    u64 *key);
> -void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb);
> +void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct request_sock *req);
>  struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>  			      struct request_sock *req,
>  			      struct tcp_fastopen_cookie *foc,
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 45cc7f1ca296..566706172828 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -3,6 +3,7 @@
>  #include <linux/tcp.h>
>  #include <linux/rcupdate.h>
>  #include <net/tcp.h>
> +#include "../mptcp/protocol.h"
>  
>  void tcp_fastopen_init_key_once(struct net *net)
>  {
> @@ -166,8 +167,12 @@ static void tcp_fastopen_cookie_gen(struct sock *sk,
>  /* If an incoming SYN or SYNACK frame contains a payload and/or FIN,
>   * queue this additional data / FIN.
>   */
> -void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
> +void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct request_sock *req)
>  {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct tcp_request_sock *tcp_r_sock = tcp_rsk(req);
> +	struct sock *socket = mptcp_subflow_ctx(sk)->conn;
> +	struct mptcp_sock *msk = mptcp_sk(socket);
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
>  	if (TCP_SKB_CB(skb)->end_seq == tp->rcv_nxt)
> @@ -194,7 +199,34 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
>  	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
>  
>  	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
> +
> +	if (req && tp->syn_fastopen && sk_is_mptcp(sk))
> +		tcp_r_sock = tcp_rsk(req);
> +	else
> +		goto add_skb_to_sk;
> +
> +	msk->is_mptfo = 1;
> +
> +	//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651
> +	tp->copied_seq += tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
> +
> +	subflow->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> +
> +	//Solves: BAD mapping: ssn=0 map_seq=1 map_data_len=3
> +	subflow->ssn_offset = tp->copied_seq - 1;
> +
> +	skb_orphan(skb);
> +	skb->sk = socket;
> +	skb->destructor = mptcp_rfree;
> +	atomic_add(skb->truesize, &socket->sk_rmem_alloc);
> +	msk->rmem_fwd_alloc -= skb->truesize;
> +
> +	__skb_queue_tail(&msk->receive_queue, skb);
> +	atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow));
> +	goto avoid_add_skb_to_sk;

AFAICS the above:

- mark the passive socket as an TFO one.
- set the mapping the DSS mapping for the TFO syn data
- bypass the usual MPTCP receive path

I think we can do all the above elsewhere, with no need to touch the
tcp code in an IMHO cleaner way, something alike the following (mostly
pseudo code, only ipv4 example, the ipv6 part should be added, too):

---
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c7d49fb6e7bd..4e23fa9f0083 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -307,6 +307,28 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 	return NULL;
 }
 
+static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
+				  struct flowi *fl,
+				  struct request_sock *req,
+				  struct tcp_fastopen_cookie *foc,
+				  enum tcp_synack_type synack_type,
+				  struct sk_buff *syn_skb)
+{
+	if (synack_type == TCP_SYNACK_FASTOPEN) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+		<mark subflow/msk as "mptfo">
+		<evenutally clear tstamp_ok, as needed depending on cookie size>
+		<dequeue the skb from sk receive queue>
+		<set the skb mapping>
+		<acquire the msk data lock>
+		<move skb into msk receive queue>
+		<call msk data_ready>
+		<release the msk data lock>
+	}
+	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 					      struct sk_buff *skb,
@@ -1939,6 +1960,7 @@ void __init mptcp_subflow_init(void)
 
 	subflow_request_sock_ipv4_ops = tcp_request_sock_ipv4_ops;
 	subflow_request_sock_ipv4_ops.route_req = subflow_v4_route_req;
+	subflow_request_sock_ipv4_ops.send_synack = subflow_v4_send_synack;
 
 	subflow_specific = ipv4_specific;
 	subflow_specific.conn_request = subflow_v4_conn_request;




