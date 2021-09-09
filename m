Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2903FE0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631193963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrrJNZllbVQKmerEF61u3IaARnE1iOgoNoVgCyEgtr0=;
	b=HXt/C9e5Oxro6kA5neCzGsB2Yl4j1RIxm8Jywwcu7xKr39e5R9uPiPqzJ9UotUcRFI7zOe
	QVPWHE0ZilldjeRCaldV1278I3X0XbTJ0jUPHitAvqq6SVavV+zoCslWB9hVR1IRZQgjMI
	eKDC/ju2MUmZE9ci6tpWZ/53wgNhHn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-TfxK6JhwMF-XVelRXzvyOw-1; Thu, 09 Sep 2021 09:26:02 -0400
X-MC-Unique: TfxK6JhwMF-XVelRXzvyOw-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a1c7210000000b002ea2ed60dc6so572566wmc.0
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 06:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KrrJNZllbVQKmerEF61u3IaARnE1iOgoNoVgCyEgtr0=;
        b=6miq/agKHcePmdm8vpxEDjOkBfU65MRZHFRh/UFjyx2ztDcR3H4QgFo097IEkF0msr
         k0G3WsvjEDdslSMA0VB9I3gVgxZXoPCtKumEarL6I6DHehnQt/7UIEqEArpHNZNbZZpt
         nKhZbMl/WophkfnJUKi8gT8GmNHyUXfPA1btmFW3Z7W5/T9EeEW52PYQzCXBINO/EwDd
         4lmCaHHZr4n0vHMrcAl5NvDyrI52urmvn5EvFaqTrDji3IyNnLOj625Ns13oRzOElvhl
         ECuxLeoREvfrdpnao2V40Ei+wzy/RJF2nrl+kIegMqFT4w1URz5J1u7P9yAMdFMxpFVF
         Xnhw==
X-Gm-Message-State: AOAM531XFhCmxItfrCIujglAt8AX/V8GlnzLe4PpeJsSQNLS+wu55HXs
	gz3DLodnxeQjEWk8zHLP/C9DsmoIch50Qf6QuZZ9o6k4JIrluFMwvk7ERhLY3XXLxGxaxVTs0jd
	oZTa6VV0QmurA1D0=
X-Received: by 2002:a1c:7e12:: with SMTP id z18mr3094021wmc.60.1631193960936;
        Thu, 09 Sep 2021 06:26:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2QZBh+Kgd5TLOs1bNYpfN/vsKq/UCkjnvDclbHEPCmKbXIIFK8NntvB8N4wJqi4CWe1wvug==
X-Received: by 2002:a1c:7e12:: with SMTP id z18mr3093995wmc.60.1631193960650;
        Thu, 09 Sep 2021 06:26:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id s10sm1821472wrg.42.2021.09.09.06.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:26:00 -0700 (PDT)
Message-ID: <7147f377124eaa4445aa11e8f8f4efbd72d69261.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/9] mptcp: add noncontiguous flag
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 09 Sep 2021 15:25:59 +0200
In-Reply-To: <138e3913108d313b11a261e6c9e3db2cc788183f.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	 <138e3913108d313b11a261e6c9e3db2cc788183f.1631188109.git.geliangtang@xiaomi.com>
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
> This patch added a "noncontiguous" flag in the msk to track whether the
> data is contiguous on a subflow. When retransmission happens, we could
> set this flag, and once all retransmissions are DATA_ACK'd that flag
> could be cleared.
> 
> When a bad checksum is detected and a single contiguous subflow is in
> use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/protocol.c |  7 +++++++
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/subflow.c  | 12 ++++++------
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bb8a2a231479..81ea03b9fff6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1095,6 +1095,9 @@ static void __mptcp_clean_una(struct sock *sk)
>  
>  		dfrag_uncharge(sk, delta);
>  		cleaned = true;
> +
> +		if (dfrag->resend_count == 0)
> +			WRITE_ONCE(msk->noncontiguous, false);
>  	}
>  
>  	/* all retransmitted data acked, recovery completed */
> @@ -1171,6 +1174,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
>  	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
>  	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
>  	dfrag->already_sent = 0;
> +	dfrag->resend_count = 0;
>  	dfrag->page = pfrag->page;
>  
>  	return dfrag;
> @@ -2454,6 +2458,8 @@ static void __mptcp_retrans(struct sock *sk)
>  		dfrag->already_sent = max(dfrag->already_sent, info.sent);
>  		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
>  			 info.size_goal);
> +		dfrag->resend_count++;
> +		WRITE_ONCE(msk->noncontiguous, true);
>  	}
>  
>  	release_sock(ssk);
> @@ -2872,6 +2878,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>  	WRITE_ONCE(msk->fully_established, false);
>  	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
>  		WRITE_ONCE(msk->csum_enabled, true);
> +	WRITE_ONCE(msk->noncontiguous, false);
>  
>  	msk->write_seq = subflow_req->idsn + 1;
>  	msk->snd_nxt = msk->write_seq;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d3e6fd1615f1..011f84ae1593 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -213,6 +213,7 @@ struct mptcp_data_frag {
>  	u16 offset;
>  	u16 overhead;
>  	u16 already_sent;
> +	u16 resend_count;
>  	struct page *page;
>  };

Ouch, the above increases mptcp_data_frag size by 8 bytes, due to
holes.

Is this necessary? I think the packet scheduler never reinject with a
single subflow. It used to do that, but it should not do anymore.

Even if the scheduler re-inject with a single subflow, can we instead
keep track of the last retrans sequence number - in __mptcp_retrans().

msk stream is 'continuous' if and only if 'before64(last_retrnas_seq,
msk->snd_una)'

/P

