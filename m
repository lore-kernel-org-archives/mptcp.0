Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120B2F22
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:22:43 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id l32so12920416wms.2
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sptB07iYznLDAF+JZ9JIDPEfvkos7leOqnu7QxhnmwY=;
        b=r0B7E7N25HJRROYFnNu9I+RorLEXslcWWB07adUPgheVZFRv8MWEJHFHFjtzpV5Xkf
         fxvPH+mBOKG9Jhj+5jyjNF0ct/spvL24MPbOuCQ6HrMi2QOQuog62RgAbLwwwuLL5n6K
         jSlbBCwVo/yTQ84OsIVUjClEBX10ruMV2CtBrY1YCMouQFLFLi1FYpmVpjC4ZkI3yCkH
         5oQAoB8fN2CLnwLw6TJjhiHhjrMmwi+J7n6H4MLen6sVOENd3j3HPpIsv6GPZhLo51fW
         evSiPFfLE7ELgXm9jlqZzcKu2HyM2BvNOz6Mnr/SuKqQ85umuzkT1Q+U8u8G1Db+L2/q
         x6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sptB07iYznLDAF+JZ9JIDPEfvkos7leOqnu7QxhnmwY=;
        b=koXpZYcog/qUSFtnrSD6/n3VSVEwp02Ync6WhKBWvERh1h1LdlehAW/jvXJzLdQjKl
         QEToRtrgEojNhVheu7D/CHXlQwlhxAEYikoW2rBgUIQIXpJlOO272W9ZYP8UiGi85eCz
         drSkD4zN1+DvfQITUvvoYlpNVMJCH0hQtg55ouWFdvij1xLPDYOnrSaZAY4+cnIQ0eeT
         nywk53Yh930ygi+ieSK46zoyYffMWroI8Cg+52Kva2fcpYmLWCSsZe1GZxI0ZEplAE9l
         FKkWnEzQSyu4PlVzkpiNNyYJ73wc9Y4MJD3qiEBcvt0miCSBbKWT6F9avqwdHgNDSXo2
         wyqg==
X-Gm-Message-State: ACrzQf29vqnWPGCEQqoyo3ce3iQG1CQY/2c1XHYclWGrKNavkPZFLyet
	WC5BDTmaIjowmrFKBdeaEoCXCw==
X-Google-Smtp-Source: AMsMyM4p7ZxcfyXFQ5PhbXiOS4Z6F45u61V6e4urvVg9FQVDPymxU7fDHu1Lv0kBk96fLiH8R+NTtQ==
X-Received: by 2002:a1c:e90b:0:b0:3b4:fb6c:7654 with SMTP id q11-20020a1ce90b000000b003b4fb6c7654mr5617087wmc.98.1666185761990;
        Wed, 19 Oct 2022 06:22:41 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:cbb4:9dfe:a976:2185? ([2a02:578:8593:1200:cbb4:9dfe:a976:2185])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003b3307fb98fsm14219609wmq.24.2022.10.19.06.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:22:41 -0700 (PDT)
Message-ID: <2b8c8764-052a-97b3-bf5b-8335a75c11d9@tessares.net>
Date: Wed, 19 Oct 2022 15:22:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 net-next 1/5] inet6: Remove inet6_destroy_sock() in
 sk->sk_prot->destroy().
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20221018190956.1308-1-kuniyu@amazon.com>
 <20221018190956.1308-2-kuniyu@amazon.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221018190956.1308-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

+cc MPTCP ML.

On 18/10/2022 21:09, Kuniyuki Iwashima wrote:
> After commit d38afeec26ed ("tcp/udp: Call inet6_destroy_sock()
> in IPv6 sk->sk_destruct()."), we call inet6_destroy_sock() in
> sk->sk_destruct() by setting inet6_sock_destruct() to it to make
> sure we do not leak inet6-specific resources.
> 
> Now we can remove unnecessary inet6_destroy_sock() calls in
> sk->sk_prot->destroy().
> 
> DCCP and SCTP have their own sk->sk_destruct() function, so we
> change them separately in the following patches.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>

Thank you for the cc!
Please next time also cc MPTCP ML if you don't mind.

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f599ad44ed24..7cc9c542c768 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -17,9 +17,6 @@
>  #include <net/protocol.h>
>  #include <net/tcp.h>
>  #include <net/tcp_states.h>
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -#include <net/transp_v6.h>
> -#endif

Please keep this include: it is needed to access "tcpv6_prot" (as
reported by the kernel bot).

>  #include <net/mptcp.h>
>  #include <net/xfrm.h>
>  #include <asm/ioctls.h>
> @@ -3898,12 +3895,6 @@ static const struct proto_ops mptcp_v6_stream_ops = {
>  
>  static struct proto mptcp_v6_prot;
>  
> -static void mptcp_v6_destroy(struct sock *sk)
> -{
> -	mptcp_destroy(sk);
> -	inet6_destroy_sock(sk);
> -}
> -
>  static struct inet_protosw mptcp_v6_protosw = {
>  	.type		= SOCK_STREAM,
>  	.protocol	= IPPROTO_MPTCP,
> @@ -3919,7 +3910,6 @@ int __init mptcp_proto_v6_init(void)
>  	mptcp_v6_prot = mptcp_prot;
>  	strcpy(mptcp_v6_prot.name, "MPTCPv6");
>  	mptcp_v6_prot.slab = NULL;
> -	mptcp_v6_prot.destroy = mptcp_v6_destroy;
>  	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
>  
>  	err = proto_register(&mptcp_v6_prot, 1);

I see that for MPTCP IPv6 sockets, sk->sk_destruct is now set to
inet6_sock_destruct() which calls inet6_destroy_sock() via
inet6_cleanup_sock().

So all good for the MPTCP part (if you re-add the include ;) ).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
