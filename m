Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328BF3C02
	for <mptcp@lists.linux.dev>; Mon,  5 Sep 2022 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662366394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAeNPdvIGvr/nxKNL5n6SelzY22s+NzrRFLCjQ9oIaY=;
	b=BW8zUbahdp8uPB/L7Gd1HI/gS85ckRDznmwj0U8mYle3XMgX8WxcReWYqXahW0eeiNn9+3
	VrVzCCNoP3mjqmVXrsmF6TLo4ua9QIZPDSQV54Juz+fAQt5jJS3Wya3HLrvAuw7gdDvedc
	95/X9/kRXmt6QReptHdBpjm4h+2zDDg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-LvW_F-tiO32baIQdAux1BA-1; Mon, 05 Sep 2022 04:26:33 -0400
X-MC-Unique: LvW_F-tiO32baIQdAux1BA-1
Received: by mail-wm1-f70.google.com with SMTP id j22-20020a05600c485600b003a5e4420552so7137244wmo.8
        for <mptcp@lists.linux.dev>; Mon, 05 Sep 2022 01:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=fAeNPdvIGvr/nxKNL5n6SelzY22s+NzrRFLCjQ9oIaY=;
        b=u6V7Ek3YXCuv6DI3yjOnx0CsLHYKGJlq8vqm+dTsaV4UymybN/e7f1EWU7nE4flc0m
         /uNylNMq9K81qvf/DLjAe8djqu98U7wD2O9Qw/Fwm90jjhzx2avvN8wJoxHhgmNTb2/K
         57OiIcgF2oQTOu3m1MIP0fz8EW3FfihIhJ9rS/EA/OuWSQV+0bVOmZJjLQIxuiDb0oXT
         AgRQwRNrkb6WVbFwGyndPO4NTsYRydFCi+E4yzJC9F7u4orNPPM6JnmCIiDOX5OK00Ue
         C60gB+TK8D4t+D7ckbKRJk448tgQfTQGFT9vq3Z99kRqfs/gexyzfyR99uXkSObFc8ev
         AaWA==
X-Gm-Message-State: ACgBeo3AC3jfhbKqX6eYeFyPsseLDYjKWlOSrVvoLjLZFz0pnMhoSWmd
	KTf6DCMZ8hoejMXQeExWOgRSRoTa+Z0XCfEXPTkebYsUoXCy+22QmpxzQIkgR+rW+Clwy3XBz8+
	mh+WDqM6w27LOCZM=
X-Received: by 2002:a05:600c:254:b0:3a5:a401:a1e2 with SMTP id 20-20020a05600c025400b003a5a401a1e2mr9629978wmj.14.1662366392820;
        Mon, 05 Sep 2022 01:26:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4NVOMUCvaizvb26rANBB+lQiZc3OkLs5X1oe7PAUfIMZ0rWJCEMl/AfeZB4aFUEIf+M3E4pw==
X-Received: by 2002:a05:600c:254:b0:3a5:a401:a1e2 with SMTP id 20-20020a05600c025400b003a5a401a1e2mr9629969wmj.14.1662366392548;
        Mon, 05 Sep 2022 01:26:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id ch13-20020a5d5d0d000000b00226d1711276sm8485733wrb.1.2022.09.05.01.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:32 -0700 (PDT)
Message-ID: <da8998cba112cbdea9d403052732c794f3882bd2.camel@redhat.com>
Subject: Re: [PATCH net] net: mptcp: fix unreleased socket in accept queue
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com
Cc: matthieu.baerts@tessares.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date: Mon, 05 Sep 2022 10:26:30 +0200
In-Reply-To: <20220905050400.1136241-1-imagedong@tencent.com>
References: <20220905050400.1136241-1-imagedong@tencent.com>
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

Hello,

On Mon, 2022-09-05 at 13:04 +0800, menglong8.dong@gmail.com wrote:
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
>    here is modified, which makes it uses mptcp protocol by default.
>    And the default backlog is 1:
>    ip netns exec mptcp-server nc -l -k -p 9999
> 
> 4. open another *two* terminal and connect to the server with the
>    following command:
>    $ ip netns exec mptcp-client nc 10.0.0.1 9999
>    input something after connect, to triger the connection of the second
>    subflow
> 
> 5. exit all the nc command, and check the tcp socket in server namespace.
>    And you will find that there is one tcp socket in CLOSE_WAIT state
>    and can't release forever.

Thank you for the report! 

I have a doubt WRT the above scenario: AFAICS 'nc' will accept the
incoming sockets ASAP, so the unaccepted queue should be empty at
shutdown, but that does not fit with your description?!?

> There are some solutions that I thought:
> 
> 1. release all unaccepted mptcp socket with mptcp_close() while the
>    listening tcp socket release in mptcp_subflow_queue_clean(). This is
>    what we do in this commit.
> 2. release the mptcp socket with mptcp_close() in subflow_ulp_release().
> 3. etc
> 

Can you please point to a commit introducing the issue?

> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/mptcp/subflow.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c7d49fb6e7bd..e39dff5d5d84 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1770,6 +1770,10 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
>  		msk->first = NULL;
>  		msk->dl_next = NULL;
>  		unlock_sock_fast(sk, slow);
> +
> +		/*  */
> +		sock_hold(sk);
> +		sk->sk_prot->close(sk);

You can call mptcp_close() directly here.

Perhaps we could as well drop the mptcp_sock_destruct() hack?

Perhpas even providing a __mptcp_close() variant not acquiring the
socket lock and move such close call inside the existing sk socket lock
above?

Thanks,

Paolo

