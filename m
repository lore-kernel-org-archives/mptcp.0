Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697B72
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623320556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NmQ/yndm19VRu8Rulo/PwzOEXT2zj+m4w9Ho1v9d7k=;
	b=Y6cwVwEYouMKu6rfuklgNe+oYWXeoZtvqxjExonTwXIaFgI0FJLTAd2in1hz0sdmrVVn+B
	jgIiMMFhovhUwPRCH9nnnFAe937e7+pagewrdlA6yw8lFO30QSzrXAydtj9mDF/IRUPbUX
	7VtMFd8D3ujyP6kZJvAXdQ1mpmMisok=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-HezM3eNCM-udWWazQWjcVg-1; Thu, 10 Jun 2021 06:22:35 -0400
X-MC-Unique: HezM3eNCM-udWWazQWjcVg-1
Received: by mail-wr1-f69.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so667666wre.9
        for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 03:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+NmQ/yndm19VRu8Rulo/PwzOEXT2zj+m4w9Ho1v9d7k=;
        b=qNI/WW3nquEMxj1pZ13EygmBQa5L8fzPNwIHUTV7BZJ6NzsFEfosdl1MQLjyZZlo0d
         E1MgGA6JA7+O7vm8utJkKMR7J1XqLlF3Nbm8wAZNrHKAKg6Ckeq82TB32hYaAIHUXCJP
         VfHy3qKkYDTISf419mchwoOlHgTxPSejO0Qqzf4adeQlls6teP9SJ+DkNjJewtfcVhew
         8nAXHwgo4qJM7N8OV1v+sDfpfvMywLbQAaegKnIbptkjaQEruMdVlCp6BOtevSvEde8C
         gxCVeDR/zlUxY3JA6O+CvBJGTRdpf0Zdigr1mY+ivqElsk6rT9lLoZv72FtGnUzhRnW0
         uncw==
X-Gm-Message-State: AOAM53163mDAoX4EXtwm1pjkFJjqMN6OthGuvo5w/cu146WUkhGjKqfS
	4dYX7+myT4cUZIqeohUelR/wRa0HdKwBl2bziLEucs2WGXktNLx5do8/MW4bSZeuUkJiaYezjB5
	StrwdW/IrbboCjeY=
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr4457828wri.232.1623320554430;
        Thu, 10 Jun 2021 03:22:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2BGc4dVXg+BRKIF/XfopCinwuFoCZmQa28ZWO+Woih1+JTReyMyUAL+nre+cFgW6nv2qcCA==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr4457811wri.232.1623320554252;
        Thu, 10 Jun 2021 03:22:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id z3sm3088986wrl.13.2021.06.10.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:22:34 -0700 (PDT)
Message-ID: <9772b060feb03180d8dae96f688210f7356289e1.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] mptcp: avoid processing packet if a subflow reset
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Date: Thu, 10 Jun 2021 12:22:33 +0200
In-Reply-To: <2a904c11-f78d-a493-2e4c-c5d320961ce1@163.com>
References: <2a904c11-f78d-a493-2e4c-c5d320961ce1@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-06-10 at 17:28 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> If check_fully_established() causes a subflow reset, it should not
> continue to process the packet in tcp_data_queue().
> 
> setting:
> 	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> 
> so that the following check will drop the pkt in
> tcp_data_queue():
>   if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
> 	__kfree_skb(skb);
> 	return;
>   }
> 
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>

Here a 'Fixes:' tag will be nice, I think.

Thanks,

Paolo

