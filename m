Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082431360
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659162737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfsgKzdz+D5utw8y0Fh2NPcNEdw9tmeOLIhg2N9F8bU=;
	b=WFGEfFGeBFaMMokAmRSfqy1cx0StS6s+YjgvxE1ZYeXodS3tH68bWXBWOXW7j3wWq3R6f2
	GUCtaGyhrUkaZvABKaVul2V6lK0lDEwozT2Np8PxBjY6HntYvc9Nw5xyGS/xdwDUHti1p1
	r1IvKfCc39c8HfMr2vSlgibKmyh1bEA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-Eju4XkxrMtOMBLTjv0Lmww-1; Sat, 30 Jul 2022 02:32:15 -0400
X-MC-Unique: Eju4XkxrMtOMBLTjv0Lmww-1
Received: by mail-ej1-f70.google.com with SMTP id qb31-20020a1709077e9f00b007304bcf4181so43124ejc.19
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 23:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DfsgKzdz+D5utw8y0Fh2NPcNEdw9tmeOLIhg2N9F8bU=;
        b=6Bf9Ype2PDH4p9zs80qGYYGfEoV/iFfm1vrW3wEWQrTmy3cdQ7PC9Bwp+MecWtGmAi
         Sn7k+d7TdEQkJzC319t/9WS4jHVpvoa3CB73Mkh2IHdGKoaZC8w9HCrR0vdaMnFZlu1x
         29ztmykgCCW+RZ+7vCeWZVbRSWyxS7f9V5Y+K6EgbWg/+Q9Qyap9qj0qAC2gmUCH+L+F
         ehKqapm731Ny3qjYteBXW7LG6km++KnTw4c0CmAPPD8wR+/DRNI7kVSx30vv+UtAUZZ+
         DZ/BpraAom+WrigpTave/AkWSmXckjgGZevv7nAgpGFeTpgtQg07hINAcuxIw65aa4nB
         qMNA==
X-Gm-Message-State: AJIora9fy23ofgCy9RJZHJme6X2fJ7xyBg+c4eOejZqrvc3EPJ2QweAR
	BzzF6WGGo1B1qR7WpX2hEtEEN3RJpzgZeTj18dYuiS61XUZXEvd45f7NJJdDCgBi9fEAtZsjrz5
	EYnaKzNvIjWpAFOk=
X-Received: by 2002:a17:907:c0d:b0:72b:d0b0:2b55 with SMTP id ga13-20020a1709070c0d00b0072bd0b02b55mr5369959ejc.110.1659162734515;
        Fri, 29 Jul 2022 23:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzQ0L8NJ6+UGjdTruHB+jaJIJpHYVclU5xzQfdQl8pqqlNJc9ve0CR8sLiCAKDezxsf9l/zA==
X-Received: by 2002:a17:907:c0d:b0:72b:d0b0:2b55 with SMTP id ga13-20020a1709070c0d00b0072bd0b02b55mr5369949ejc.110.1659162734124;
        Fri, 29 Jul 2022 23:32:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-118-222.dyn.eolo.it. [146.241.118.222])
        by smtp.gmail.com with ESMTPSA id vj16-20020a170907131000b006fec27575f1sm2533032ejb.123.2022.07.29.23.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 23:32:13 -0700 (PDT)
Message-ID: <acbaed21c110d489788cd0fafaeffa20745112a3.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: more accurate receive buffer
 updates
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Sat, 30 Jul 2022 08:32:12 +0200
In-Reply-To: <13f2141b-f22b-8e16-1c74-13453ad3dc45@linux.intel.com>
References: <cover.1659117128.git.pabeni@redhat.com>
	 <1da024c8ed9da4fcf78aa2d73e00c1f9e4d3e98f.1659117128.git.pabeni@redhat.com>
	 <13f2141b-f22b-8e16-1c74-13453ad3dc45@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Fri, 2022-07-29 at 16:01 -0700, Mat Martineau wrote:
> On Fri, 29 Jul 2022, Paolo Abeni wrote:
> 
> > Currently mptcp_cleanup_rbuf() makes a significant effort to avoid
> > acquiring the subflow socket lock, estimating if the tcp level
> > cleanup could actually send an ack.
> > 
> > Such estimate is a bit rough when accounting for receive window
> > change, as it consider the msk available buffer space instead
> > of the announced mptcp-level window.
> > 
> > Let's consider the announced window instead, mirroring closely
> > the plain TCP implementation. We need to lockless access a bunch
> > of additional, tcp fields.
> 
> Hi Paolo -
> 
> The code changes look good. For this last sentence above ("...lockless 
> access a bunch of ... tcp fields"), I only see access to msk->rcv_wnd_sent 
> and msk->ack_seq, and nothing obvious in the later commits. Could you 
> clarify?

You are right, that comment is inaccurate. Is there from a previous
internal version. I'll drop it in the next iteration.

Thanks!

Paolo

