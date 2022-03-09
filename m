Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212157E
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1646828105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/h1wU8yj5QdWFWbIUZTt+i19WFLXmnQxMNqV8tacOw=;
	b=Yv/o0JhtTBq8jA/qXG5bo2ZcWlm95M6KQ4XdyzXpEqMcPATrYV96o/rTwJrZtLn66gLNjY
	jTvr0n23xQKWrWvdWyyN/U5sgKNkpkDYiq79KVYiljiexc5Ks/MwnIp1Ze0LPG6MFFrfvZ
	wUqfgR7e4hLrxaoai/cBlTpS3xLV89g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-0ZCf7zmJMXiAOEpgbdGxTA-1; Wed, 09 Mar 2022 07:15:03 -0500
X-MC-Unique: 0ZCf7zmJMXiAOEpgbdGxTA-1
Received: by mail-wr1-f71.google.com with SMTP id a5-20020adfdd05000000b001f023fe32ffso696900wrm.18
        for <mptcp@lists.linux.dev>; Wed, 09 Mar 2022 04:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=p/h1wU8yj5QdWFWbIUZTt+i19WFLXmnQxMNqV8tacOw=;
        b=uXAfX8S/a9xn4cWlCq2+OZ6SzpPFMPOjTR4WIBHLDAPl/hl4dZcFfR04opE9v9R30I
         5Uae7EbP5XfwzullKfcZyHS1YduVDLn0ldJ5nJIDDEnDI7ePxDv722+fCSWlym1CvT8b
         CORetzD7r4mz2TqvVmYQZ+A1bEdETciHEikKDtPUzrVAfTeHtoTulhekH+3RFXx81GZU
         PVCC8WECDXwK6fSlKOUnMPhztzWTKXwQ7w6fM8Uej0ymBf+j+bdmlxhi1gcdI99twVo1
         KB1mOzrtvRSz1ou3b9HIqFhbJOvgnzsOwQ4wXoO3ijwJM3R8Tc6cnxm+4IlrBcH525pV
         fXFw==
X-Gm-Message-State: AOAM530ex8x/MPWboPeMSp2TqKYF6XtyvmUahIOy2b5QdhhRo3jY30rF
	eh5MoaFqTi+hv0FbWFrgBZML2oUMeFXG3Lm1t/e+ib99UVqQs2xNSqJNQ2YJKVJeeq/u9tt3lEa
	oSr7fRiSyjpR/Hko=
X-Received: by 2002:a05:600c:4f85:b0:389:d1b0:d88e with SMTP id n5-20020a05600c4f8500b00389d1b0d88emr2100880wmq.197.1646828102394;
        Wed, 09 Mar 2022 04:15:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysqaQ6A7K3Hku4je6kmOpmNfFVxhbCXNXQ6ZqGCLlBMdJpQeL5lgAVuLBiwHtYCReVI9khYw==
X-Received: by 2002:a05:600c:4f85:b0:389:d1b0:d88e with SMTP id n5-20020a05600c4f8500b00389d1b0d88emr2100858wmq.197.1646828102110;
        Wed, 09 Mar 2022 04:15:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm5686534wmq.17.2022.03.09.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:15:01 -0800 (PST)
Message-ID: <9a9d0b82106b6c3d486da009da5592ef97c5deaf.camel@redhat.com>
Subject: Re: [PATCH] mptcp: Fix crash due to tcp_tsorted_anchor was
 initialized before release skb
From: Paolo Abeni <pabeni@redhat.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net
Date: Wed, 09 Mar 2022 13:15:00 +0100
In-Reply-To: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Wed, 2022-03-09 at 18:20 +0800, Yonglong Li wrote:
> get crash when do pressure test of mptcp:

Ouch!

> ===========================================================================
> dst_release: dst:ffffa06ce6e5c058 refcnt:-1
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle kernel paging request at ffffa06ce6e5c058
> PGD 190a01067 P4D 190a01067 PUD 43fffb067 PMD 22e403063 PTE 8000000226e5c063
> Oops: 0011 [#1] SMP PTI
> CPU: 7 PID: 7823 Comm: kworker/7:0 Kdump: loaded Tainted: G            E
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.2.1 04/01/2014
> Call Trace:
>  ? skb_release_head_state+0x68/0x100
>  ? skb_release_all+0xe/0x30
>  ? kfree_skb+0x32/0xa0
>  ? mptcp_sendmsg_frag+0x57e/0x750
>  ? __mptcp_retrans+0x21b/0x3c0
>  ? __switch_to_asm+0x35/0x70
>  ? mptcp_worker+0x25e/0x320
>  ? process_one_work+0x1a7/0x360
>  ? worker_thread+0x30/0x390
>  ? create_worker+0x1a0/0x1a0
>  ? kthread+0x112/0x130
>  ? kthread_flush_work_fn+0x10/0x10
>  ? ret_from_fork+0x35/0x40
> ===========================================================================
> 
> in __mptcp_alloc_tx_skb skb was alloced and skb->tcp_tsorted_anchor will be
> initialized,  in under memory pressure situation sk_wmem_schedule will
> return false and then kfree_skb. In this case skb->_skb_refdst is not null
> because_skb_refdst and tcp_tsorted_anchor are stored in the same mem, and
> kfree_skb will try to release dst and casue crash.

Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache"


> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3cb9752..fbb14df 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1199,6 +1199,7 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
>  		tcp_skb_entail(ssk, skb);
>  		return skb;
>  	}
> +	tcp_skb_tsorted_anchor_cleanup(skb);
>  	kfree_skb(skb);
>  	return NULL;
>  }

LGTM!

Reviewed-by: Paolo Abeni <pabeni@redhat.com>

