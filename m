Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0A72
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631012388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQVTwcq+EWk6X2hI9s0DDS/Uxw3HFiFYlpHj1QXnDcg=;
	b=FltGW+gfFAu55U4MtF1IhdEvEsDTUiwQmi492Iw8Wx7Z97FxNnCXgIHHa6RnNoo2iW+gSo
	NhEF+6/9wVU7EexEc2296ym1Fa+5/kDHFIgU1NTPLW4IYS6F/xzNFGElJKRD+zJc16UXs4
	TSUaSs5t/TJTYjGCC8P5ffcFhnbJyf4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-e26tOg_xPpy16IuCYRtGlw-1; Tue, 07 Sep 2021 06:59:47 -0400
X-MC-Unique: e26tOg_xPpy16IuCYRtGlw-1
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bca56000000b002e7508f3faeso3253842wml.2
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 03:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PQVTwcq+EWk6X2hI9s0DDS/Uxw3HFiFYlpHj1QXnDcg=;
        b=PxDKn6XcL8m124T2f9Fnx3CdzHR6okAQ5AeZ9OoF2Eij9P+yfA7W5PsHrV2ZLFKUvY
         otmg1p2grDy1cvjNR6TCjmwEP9m3YJBRy4pCLByg4PiwWdAJy4jnfMftf/u1/gZdwtVe
         40h0q49386MOfz2JVtsRw3/l/4Z/9trPXD66Sz+GBD3nlVGSBK43AFuRr0dK+hl8c/md
         BLyh9suXoeYTByhgAr1tvWfzHfHnuT0eFry2HRVuuNNzz1Lc69W6rQ0JeZr1/y/djUv7
         Xd3yLeyuBSt1grD4RJ8JATZDORKLsJ+62WVeo14ebGhrLk7pZh96p8Q/u0kDceu8nLUb
         5BmQ==
X-Gm-Message-State: AOAM532gIhVEXiT9LiQYAmkxoatOs531TaG0Q2UeDdAyGL+n8+tsxdLm
	5gAG7Ov3IO5B3AzQ1uXWgWZ72BAOyddwQN5h2vIaYvNww5HIazc/Tn0HsmxYGcy/bFLlyrN+vgj
	b5cNjJbaINSUvhGI=
X-Received: by 2002:a1c:218b:: with SMTP id h133mr3289209wmh.83.1631012386046;
        Tue, 07 Sep 2021 03:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuwlajsQXiWoADe0Vj3ym/Q1XH/LLvS+OmuCn7Q6e/Msd5ls1ZbQaqYYN99fTtxR+5Q6rgDQ==
X-Received: by 2002:a1c:218b:: with SMTP id h133mr3289190wmh.83.1631012385727;
        Tue, 07 Sep 2021 03:59:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id d8sm11102622wrv.20.2021.09.07.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:59:45 -0700 (PDT)
Message-ID: <6db72d48caecfee1f6009415aba9a98d8be0aed7.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp-next 1/4] mptcp: add a new sysctl scheduler
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 07 Sep 2021 12:59:44 +0200
In-Reply-To: <268ae875a7e4546922c30a974f9d675562b632e0.1631011068.git.geliangtang@xiaomi.com>
References: <cover.1631011068.git.geliangtang@xiaomi.com>
	 <268ae875a7e4546922c30a974f9d675562b632e0.1631011068.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 2021-09-07 at 18:41 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added a new sysctl, named scheduler, to support for selection
> of different schedulers.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
>  net/mptcp/ctrl.c                          | 14 ++++++++++++++
>  net/mptcp/protocol.h                      |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index b0d4da71e68e..ecd593c44e26 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -57,3 +57,11 @@ stale_loss_cnt - INTEGER
>  	This is a per-namespace sysctl.
>  
>  	Default: 4
> +
> +scheduler - STRING
> +	Select the scheduler of your choice.
> +
> +	Support for selection of different schedulers. This is a per-namespace
> +	sysctl.
> +
> +	Default: "default"
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 8b235468c88f..369369b0b17e 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -26,6 +26,7 @@ struct mptcp_pernet {
>  	u8 mptcp_enabled;
>  	u8 checksum_enabled;
>  	u8 allow_join_initial_addr_port;
> +	char scheduler[MPTCP_SCHED_NAME_MAX];
>  };
>  
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -58,6 +59,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
>  	return mptcp_get_pernet(net)->stale_loss_cnt;
>  }
>  
> +char *mptcp_get_scheduler(struct net *net)

I think it should returns 'const char *' and even the 'net' argument
should be const.

Cheers,

Paolo

