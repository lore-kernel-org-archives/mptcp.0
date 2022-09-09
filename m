Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069065A
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662709262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqdtzK1RfbyTrnC8Ne2oeCCfMLrCfH0hAwxFPTULslw=;
	b=ZGkLw8LaZ8JIUbnripkBhaO5S6FPKpgxdvmU6C0XzLxzdXXbwC5aE1Jk+8pLrD7R8OXwh4
	pHiMZOxuuvJYIOFdiMz0MqO8fG/ZNJpWt8Ezqx/K+Y+wK1DBRl47dyus0bh80ZhPoJOwyg
	UvDKGIAB+DUkaBssgoRYiO2II1KB2hs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-MoLzelD0MQesz5xejAQmvg-1; Fri, 09 Sep 2022 03:40:59 -0400
X-MC-Unique: MoLzelD0MQesz5xejAQmvg-1
Received: by mail-qv1-f70.google.com with SMTP id oj15-20020a056214440f00b004ac6db57cacso627565qvb.17
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 00:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=PqdtzK1RfbyTrnC8Ne2oeCCfMLrCfH0hAwxFPTULslw=;
        b=ZBUFAG0ZR8NyTZ0Cjvwdji8MrcijEJtLnjWOc7+73+EiVUWRJ+5BOO9KF5FKtvtkH/
         EEpxZ8iFBsp3Jm06mCvrhnwYe5imWS7ZW3nkt9Tace7C09XOPsyjcd+SaucTtmaJknZd
         54sNIpnGuV6XioS7WZg7xaGqSLQMzCDm1rE0DxGwFTl5cVxYV+LBGhZydlpchGXlwpjr
         BUDt/kQ+pYYbDrAhlSXOWbUGXxMXQn37nwjX5/NxW5JDXGjCKtx+YlfsMdVUfCkg4rxr
         bc3F2Unbga2bUBtjJ+51PUIWSY80Zc7FG78ioArFnzyfDc+vYPmAgMBKTCvk58gn8Dd2
         Rvww==
X-Gm-Message-State: ACgBeo39X/75YBBhgUWmTftBMrKQtk7YGJVBR4IOLtrJ4AFGnEtNAFv4
	Ngz+MSoUeyhci6wK4IP3NgCRkROZSGm/gRrfPtwOfcSX+Mmp3nOngQGohZP+KYTZ6MeuhNvW9aW
	IXhuxtKA792alzj4=
X-Received: by 2002:a05:6214:d85:b0:4aa:acc6:750 with SMTP id e5-20020a0562140d8500b004aaacc60750mr10869967qve.58.1662709259114;
        Fri, 09 Sep 2022 00:40:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5r2Xu7N5J5wvqHohjc6MHcv9sr8WKUX4jlIGk/eC6aGtY42HqDh5XOsKU+OZMH9fyRQ5nIGA==
X-Received: by 2002:a05:6214:d85:b0:4aa:acc6:750 with SMTP id e5-20020a0562140d8500b004aaacc60750mr10869951qve.58.1662709258795;
        Fri, 09 Sep 2022 00:40:58 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a0bc800b006bba46e5eeasm906492qki.37.2022.09.09.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:40:58 -0700 (PDT)
Message-ID: <49ab9f4c361267cb177ee018d6066af391011c1e.camel@redhat.com>
Subject: Re: [PATCH net v4 3/3] net: mptcp: fix unreleased socket in accept
 queue
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, Jiang Biao
	 <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Fri, 09 Sep 2022 09:40:55 +0200
In-Reply-To: <20220909054932.246221-4-imagedong@tencent.com>
References: <20220909054932.246221-1-imagedong@tencent.com>
	 <20220909054932.246221-4-imagedong@tencent.com>
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

On Fri, 2022-09-09 at 13:49 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> The mptcp socket and its subflow sockets in accept queue can't be
> released after the process exit.
> 
> While the release of a mptcp socket in listening state, the
> corresponding tcp socket will be released too. Meanwhile, the tcp
> socket in the unaccept queue will be released too. However, only init
> subflow is in the unaccept queue, and the joined subflow is not in the
> unaccept queue, which makes the joined subflow won't be released, and
> therefore the corresponding unaccepted mptcp socket will not be released
> to.
> 
> This can be reproduced easily with following steps:
> 
> 1. create 2 namespace and veth:
>    $ ip netns add mptcp-client
>    $ ip netns add mptcp-server
>    $ sysctl -w net.ipv4.conf.all.rp_filter=0
>    $ ip netns exec mptcp-client sysctl -w net.mptcp.enabled=1
>    $ ip netns exec mptcp-server sysctl -w net.mptcp.enabled=1
>    $ ip link add red-client netns mptcp-client type veth peer red-server \
>      netns mptcp-server
>    $ ip -n mptcp-server address add 10.0.0.1/24 dev red-server
>    $ ip -n mptcp-server address add 192.168.0.1/24 dev red-server
>    $ ip -n mptcp-client address add 10.0.0.2/24 dev red-client
>    $ ip -n mptcp-client address add 192.168.0.2/24 dev red-client
>    $ ip -n mptcp-server link set red-server up
>    $ ip -n mptcp-client link set red-client up
> 
> 2. configure the endpoint and limit for client and server:
>    $ ip -n mptcp-server mptcp endpoint flush
>    $ ip -n mptcp-server mptcp limits set subflow 2 add_addr_accepted 2
>    $ ip -n mptcp-client mptcp endpoint flush
>    $ ip -n mptcp-client mptcp limits set subflow 2 add_addr_accepted 2
>    $ ip -n mptcp-client mptcp endpoint add 192.168.0.2 dev red-client id \
>      1 subflow
> 
> 3. listen and accept on a port, such as 9999. The nc command we used
>    here is modified, which makes it use mptcp protocol by default.
>    $ ip netns exec mptcp-server nc -l -k -p 9999
> 
> 4. open another *two* terminal and use each of them to connect to the
>    server with the following command:
>    $ ip netns exec mptcp-client nc 10.0.0.1 9999
>    Input something after connect to triger the connection of the second
>    subflow. So that there are two established mptcp connections, with the
>    second one still unaccepted.
> 
> 5. exit all the nc command, and check the tcp socket in server namespace.
>    And you will find that there is one tcp socket in CLOSE_WAIT state
>    and can't release forever.
> 
> Fix this by closing all of the unaccepted mptcp socket in
> mptcp_subflow_queue_clean() with __mptcp_close().
> 
> Now, we can ensure that all unaccepted mptcp sockets will be cleaned by
> __mptcp_close() before they are released, so mptcp_sock_destruct(), which
> is used to clean the unaccepted mptcp socket, is not needed anymore.
> 
> The selftests for mptcp is ran for this commit, and no new failures.
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v4:
> - factor-out __mptcp_close() and use it in this commit.
> 
> v3:
> - remove mptcp_close_nolock() and call mptcp_close() directly in
>   mptcp_subflow_queue_clean(), as mptcp_close_nolock() will cause
>   dead lock.
> 
> v2:
> - remove mptcp_sock_destruct()
> - introduce mptcp_close_nolock() and replace mptcp_close() with it in
>   mptcp_subflow_queue_clean()
> ---
>  net/mptcp/subflow.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c7d49fb6e7bd..7c437debc368 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -602,30 +602,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
>  	return !crypto_memneq(hmac, mp_opt->hmac, MPTCPOPT_HMAC_LEN);
>  }
>  
> -static void mptcp_sock_destruct(struct sock *sk)
> -{
> -	/* if new mptcp socket isn't accepted, it is free'd
> -	 * from the tcp listener sockets request queue, linked
> -	 * from req->sk.  The tcp socket is released.
> -	 * This calls the ULP release function which will
> -	 * also remove the mptcp socket, via
> -	 * sock_put(ctx->conn).
> -	 *
> -	 * Problem is that the mptcp socket will be in
> -	 * ESTABLISHED state and will not have the SOCK_DEAD flag.
> -	 * Both result in warnings from inet_sock_destruct.
> -	 */
> -	if ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
> -		sk->sk_state = TCP_CLOSE;
> -		WARN_ON_ONCE(sk->sk_socket);
> -		sock_orphan(sk);
> -	}
> -
> -	/* We don't need to clear msk->subflow, as it's still NULL at this point */
> -	mptcp_destroy_common(mptcp_sk(sk), 0);
> -	inet_sock_destruct(sk);
> -}
> -
>  static void mptcp_force_close(struct sock *sk)
>  {
>  	/* the msk is not yet exposed to user-space */
> @@ -768,7 +744,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  			/* new mpc subflow takes ownership of the newly
>  			 * created mptcp socket
>  			 */
> -			new_msk->sk_destruct = mptcp_sock_destruct;
>  			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
>  			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
>  			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
> @@ -1763,13 +1738,23 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
>  
>  	for (msk = head; msk; msk = next) {
>  		struct sock *sk = (struct sock *)msk;
> -		bool slow;
> +		bool slow, cancel_work;

I think is better to rename 'cancel_work' to 'do_cancel_work'

>  
> +		sock_hold(sk);
>  		slow = lock_sock_fast_nested(sk);
>  		next = msk->dl_next;
>  		msk->first = NULL;
>  		msk->dl_next = NULL;
> +
> +		/* __mptcp_close() will put a extra reference on sk,
> +		 * so we hold one here.
> +		 */
> +		sock_hold(sk);
With the suggested changes to patch 1 one of the above 2 sock_hold() 
will not be needed anymore.

Thanks,

Paolo

