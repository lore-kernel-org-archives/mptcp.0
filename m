Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B513C1E
	for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 09:40:07 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id k16so15105644ejv.10
        for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4h7mRTTh1xN8BYdij0sEqIon7qtDOntjn+pMJ2mDjXM=;
        b=PlWW54zI7lqinYu/KN9jLkDOmzXKYySgWlQGwXC2oo0RJLnkSJar5NjbhsbKipZIsi
         Havygvk4HK3itkQpjhdOx87t9CjZ1ZHMMpmXj8DniATp8lYJp30TyVTMt6boFHXMYLcX
         waq2l8zML4vb/a487Wgd6STJrg1y65moXA27BLdpQ2eRb0/7VL3sx8+BOzxZYbS9i7RP
         c2KDftzwEd6C+nPoDl1F5VExImkMjDnIdciov//x81Pxaddc3vfMeFW6DNorMl4h51nu
         DUvVmHETrrN6UF1Uw6PzSSeaG2z459o8vJpXV1Yd5c2ZOc9ZrwsZgUQ//RYD6lZR0kIv
         pzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h7mRTTh1xN8BYdij0sEqIon7qtDOntjn+pMJ2mDjXM=;
        b=cHW+RO5vnOYJi1SSdbetKk8sMp/hHz/MmVQmbgYnsbFaNn7Xt9Y5qIxeraPMxpKcu2
         jU6rUvZYzGBVALk8+Lh6Zx+rPTdmqjCaHtSgsBb2RkeEqwQfJYtjSZWcTcA6yUsXX3lr
         4jm4kgWoLiCfiChMBOxg9Tr4shOl60W/Td6D8X8sWN6kTYVrVEbMRj5m8hImzVCa5VkF
         Zq+l9XUHGqdDdY6fqhRaf/YgTBLWAz4SZP6H3wOXMGTF+ulU5gDj7Zp7BfxOod6iae0R
         5tbqWTuT6ZNGH8Id+uXa2F2ieIXOTZNVjig8X1opLtgEb8L+lala957ozrq6tlIRlr6W
         V6fQ==
X-Gm-Message-State: AO0yUKXvMCRNJzK1W9Im9Ot1MyaF9YLoENQjNah9+WiifBcETL2VAwyV
	orIaUkuR10IV1wO+qttLcO6E0g==
X-Google-Smtp-Source: AK7set/plGz1j3oh2R+HEybEKejC8zQ2i9LONd7kvl/P77E/MDokUgfCwXxedOTn3DVqp7xPpBmqHg==
X-Received: by 2002:a17:906:8a50:b0:878:5f8e:26c0 with SMTP id gx16-20020a1709068a5000b008785f8e26c0mr1838206ejc.7.1676454006228;
        Wed, 15 Feb 2023 01:40:06 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id rs1-20020a170907036100b008b12c318622sm2169484ejb.29.2023.02.15.01.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 01:40:05 -0800 (PST)
Message-ID: <5171168c-ecf4-b8e9-48c8-b4345cdbc4a9@tessares.net>
Date: Wed, 15 Feb 2023 10:40:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 net-next] net: no longer support SOCK_REFCNT_DEBUG
 feature
Content-Language: en-GB
To: Jason Xing <kerneljasonxing@gmail.com>, kuniyu@amazon.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 nhorman@tuxdriver.com, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sctp@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20230214041410.6295-1-kerneljasonxing@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230214041410.6295-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 14/02/2023 05:14, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Commit e48c414ee61f ("[INET]: Generalise the TCP sock ID lookup routines")
> commented out the definition of SOCK_REFCNT_DEBUG in 2005 and later another
> commit 463c84b97f24 ("[NET]: Introduce inet_connection_sock") removed it.
> Since we could track all of them through bpf and kprobe related tools
> and the feature could print loads of information which might not be
> that helpful even under a little bit pressure, the whole feature which
> has been inactive for many years is no longer supported.
> 
> Link: https://lore.kernel.org/lkml/20230211065153.54116-1-kerneljasonxing@gmail.com/
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8cd6cc67c2c5..e913752df112 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2876,7 +2876,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
>  	sk_stream_kill_queues(sk);
>  	xfrm_sk_free_policy(sk);
>  
> -	sk_refcnt_debug_release(sk);
>  	sock_put(sk);
>  }
>  

Thank you for the patch!

For the modification in MPTCP subtree:

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
