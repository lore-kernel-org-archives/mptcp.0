Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10E3FE9
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631195755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hq6WLXPGDVVCSdEEC1I4nuwkgreFMyqJQkqEdNnPT5Q=;
	b=LMhNvNiY2ew4h8ny/QjLgGp/jP3+RDX3sWILhVvNaCmk/bDBS8N8Y0qxu1tKl2PpJtkSOo
	hnBoUe6/OabZcPMqy/XeW6Cl+6SI+0zFDu2QoePDMQqsDCl5KM/lxsRJn0bXNC51eHJ79k
	c6CD7IRBl/rObgULcvYcVm7vxvdD0V0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-3Eh5tFnDNgOY3zDMFlBomw-1; Thu, 09 Sep 2021 09:55:54 -0400
X-MC-Unique: 3Eh5tFnDNgOY3zDMFlBomw-1
Received: by mail-wm1-f71.google.com with SMTP id p29-20020a1c545d000000b002f88d28e1f1so800588wmi.7
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 06:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hq6WLXPGDVVCSdEEC1I4nuwkgreFMyqJQkqEdNnPT5Q=;
        b=PWvYDizjNQdSoGRzcQh8GgIHNs68a2mpKRUk1YRLPJyFSdWsfkOIOWYvPmjjHTmCDi
         0e6U07+4ajoBIgdHWnpxWHfwsHqYq3v/NJydnO2BAdYFqj0BRTISJuZaP6ELuMY1laj7
         NgsJHiQSmedf15VmHpzLbHSB7vDSN1jAcfGiq5eQ7H80pOHgZhntq9O/3URQoCfiIpNb
         WBfLq5sEJLjf+x9LuoYUEt91OYa7vxWdJsPdPDVNJRXoMjNp5F2WEszFhVG7gHc2r/t3
         6cnOicv4tKhR7Mpb8+LJpns5tnLB0GmZNyTqyJnGxs+U2/ARmhd0D14RaFVBACe4i7kh
         PeVA==
X-Gm-Message-State: AOAM531kjrv3gqXdqhfGK6CLnxY8+EsyS3UzQ3e2wUwxuJ7r1EUgOoo8
	GaYbDK6cb50GG/vwdCvsZlJL3hyFj2hQfzpIS8j0VVvjuo/YWULDt8tD7DmXAz2Ca4aurX2lcAg
	sKRAVqQzO6LEcrsM=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr3861933wrn.66.1631195753080;
        Thu, 09 Sep 2021 06:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW7WddQII1gX/6RL0j4yaIkY3e0o2UwANIjTajC9P0jYXSCcbeX5yMyoP3Ks67J9POQfY0zg==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr3861917wrn.66.1631195752860;
        Thu, 09 Sep 2021 06:55:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id w20sm1872670wrg.1.2021.09.09.06.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:55:52 -0700 (PDT)
Message-ID: <6a31bc368b05d1dc89b5ae4f442dd1cc2f098ab3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 6/9] mptcp: infinite mapping receiving
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 09 Sep 2021 15:55:46 +0200
In-Reply-To: <945fdaa82c817feb705da45d0b1597c7d8a5533b.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	 <945fdaa82c817feb705da45d0b1597c7d8a5533b.1631188109.git.geliangtang@xiaomi.com>
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

On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added the infinite mapping receiving logic. When the infinite
> mapping is received. invoke __mptcp_do_infinite to set the
> MPTCP_INFINITE_DONE flag and return MAPPING_INFINITE.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/subflow.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ad8efe56eab6..bf535cc46c5c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -972,7 +972,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>  	data_len = mpext->data_len;
>  	if (data_len == 0) {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> -		return MAPPING_INVALID;
> +		pr_infinite(msk);
> +		__mptcp_do_infinite(msk);
> +		return MAPPING_INFINITE;
>  	}
>  
>  	if (mpext->data_fin == 1) {

As for patch 3/9, I think we could simply return MAPPING_DUMMY.

/P

