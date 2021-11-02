Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA78668
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635876021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bl66stvX2DZl0bQDSdzBQeQKIf6CcxKHseen8ft6ME=;
	b=O7IRK2OgTaLvzEkGCZAoEDN4FZPTUezk+rYeBNpZuQEOwgfHWADgFtcz9gmxbKSKVkHI9l
	kD+zyaLPxz+6TEcEjOPhLYf7eZxsFgYqOyWFz3zGRJdSnqSjWYQAAEmjAqzCugj8TG+Y5a
	qsdx9IT9tbGFepETuygcz5csTHzShYM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-vvrpMR73OZi4cW7k6CfPBQ-1; Tue, 02 Nov 2021 14:00:09 -0400
X-MC-Unique: vvrpMR73OZi4cW7k6CfPBQ-1
Received: by mail-ed1-f69.google.com with SMTP id w11-20020a05640234cb00b003e0cd525777so114522edc.12
        for <mptcp@lists.linux.dev>; Tue, 02 Nov 2021 11:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1bl66stvX2DZl0bQDSdzBQeQKIf6CcxKHseen8ft6ME=;
        b=HwkScliJFI4EwV/VaSzHh20ueVUg7s/ijLDMRI0C0g/th/k2kYf7tYXTdHV0p2iXAi
         TKwknG+NJVqxmUnFOrPOYrX8DmoEVF06n1t8zp+0EM7mlT7Z6Zq+1kBg7Cc/NtcpLql/
         XDCSieUSXrdPLBrKNvWxaJNQHUqDAWf4pxVIzrX3tofyffZ6KRnN7h9vCASCtiQRxWGb
         GRM56iKVVJ+X+IVe3l6JY3zhaZeG7EVehzHrxIe34m8pFLnwwjpMkBTxW/E3B77AVc8W
         aZ+gXdtOFKRnUMJrNsF8dae2MvjwZfrucs4wN3OgWxh2mkcGNNO594FvUls5pFRzxR20
         gQow==
X-Gm-Message-State: AOAM533spj4+FUFV5cwu6abYmGVNG7aP6uyxnHEN99EvPBlCpD6qTt79
	Vtu9YnTDi8tSXS3Bi/q7QB2lKUbKIU0fWtsynKofk//4iIAxuDLnvU5n89SPS51O0azCG+Gtas9
	TBUkYwpFL/iV5a7UvKfmcF7McXoOLuexZPuFr0V7u0RaGnqzGyrNMQivMSAlqU7lN
X-Received: by 2002:aa7:c952:: with SMTP id h18mr54157058edt.18.1635876007550;
        Tue, 02 Nov 2021 11:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhPA8iDWhbHgPF96imYk2j2sn7KllsphEEROqW+NlZOumGYkX76+YCq5LZ5O2CckgbGHeFuw==
X-Received: by 2002:aa7:c952:: with SMTP id h18mr54156992edt.18.1635876007137;
        Tue, 02 Nov 2021 11:00:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-236.dyn.eolo.it. [146.241.113.236])
        by smtp.gmail.com with ESMTPSA id dt4sm8588556ejb.27.2021.11.02.11.00.06
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 11:00:06 -0700 (PDT)
Message-ID: <8a4189c20285e73f1b4f51d4e442477003f40d1f.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: enforce HoL-blocking estimation
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Tue, 02 Nov 2021 19:00:05 +0100
In-Reply-To: <d3477a25f27b733d33a85800713949dae0e1ea4a.1635241330.git.pabeni@redhat.com>
References: <d3477a25f27b733d33a85800713949dae0e1ea4a.1635241330.git.pabeni@redhat.com>
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

Hello,

On Tue, 2021-10-26 at 11:42 +0200, Paolo Abeni wrote:
> The MPTCP packet scheduler has sub-optimal behavior with asymmetric
> subflows: if the faster subflow-level cwin is closed, the packet
> scheduler can enqueue "too much" data on a slower subflow.
> 
> When all the data on the faster subflow is acked, if the mptcp-level
> cwin is closed, and link utilization becomes suboptimal.
> 
> The solution is implementing blest-like[1] HoL-blocking estimation,
> transmitting only on the subflow with the shorter estimated time to
> flush the queued memory. If such subflows cwin is closed, we wait
> even if other subflows are available.
> 
> This is quite simpler than the original blest implementation, as we
> leverage the pacing rate provided by the TCP socket. To get a more
> accurate estimation for the subflow linger-time, we maintain a
> per-subflow weighted average of such info.
> 
> Additionally drop magic numbers usage in favor of newly defined
> macros and use more meaningful names for status variable.
> 
> [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - fix checkpatch issue (mat)
>  - rename ratio as linger_time (mat)

As this patch empirically improves the situation quite a bit, what
about applying it on the export branch, and staging it for a bit?

If we find issues or improvements we can revert/drop/update. Otherwise
we can keep it. Meanwhile it will get a better testing...

WDYT?

Paolo

