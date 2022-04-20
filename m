Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA58185B
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650471536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2rDHsSgPb0JPFS1NVpgNDa7nvr2yLwBtECSoGGH2V4=;
	b=aCkyeOu0wbxMz1boIkqxcDhOgxvy/dRnmyKN8XWz/ZnpXkPyqbQKKI55uNLlpZ2i8UjgNc
	u1ee5q4O2ITslwWdeVsGPSpq7sXbtDB4W0bcuIbGN9D2BgJkKNc3srL3Bn8k2/5pJ6BNhf
	V1lp0PLAsrO67BYkNs08ZJNpVt1BMf8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-0N5U4dRxNOeG393RCj98JQ-1; Wed, 20 Apr 2022 12:18:55 -0400
X-MC-Unique: 0N5U4dRxNOeG393RCj98JQ-1
Received: by mail-wm1-f69.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1165476wmj.5
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 09:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L2rDHsSgPb0JPFS1NVpgNDa7nvr2yLwBtECSoGGH2V4=;
        b=QB930wbt7RUNT7g5k1EWWp+ONKHHGbPDnZpbJh5zOKCAAD7PN3NsL256EC/f/FkqfH
         GJnj5BNQMVEWISlF2JDXMktz1DXLwqKXnVPfTtzXD4Q5McAFsZUHiOtdUfUeDZ54attR
         KpMYlLynNQlVCEYbyteJG/OwMnhP9Zynvr1KLdNUeSAfH5Z4m5HBHDSYeIY7Y76JLmmR
         xi2CcjHk3xpl/eBYkKvc6ZMgUn4u3MByLJ5Oa1sG+ihRERIyBaXcX6tENtT+XVZCyer/
         obiJEjZv+T3RgY8nge0b/iy2eXkhBkpS+1ns3ZzY4FyreZlaiTPNsQVmveVk/SP4Hcah
         kC4Q==
X-Gm-Message-State: AOAM531vcjWPeXtYEse2/tsl/oxO5XvTd7NLeYAjtthnLwqD2IZKvSXl
	7q8eIJ1TqCWQUnSstD+wHUfBz25ANT4DOPEI9UtVe9KH5gi/UgpDRCgyK0kzn3xkT9+wy5I0+J/
	/bWe+yljwYGDQmfI=
X-Received: by 2002:adf:fa09:0:b0:207:9af2:d7b4 with SMTP id m9-20020adffa09000000b002079af2d7b4mr16085432wrr.544.1650471533616;
        Wed, 20 Apr 2022 09:18:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4A8HvAXIZWZxrDDX3aEfkn1mDC28b9BAmcXSS9RK0/DDKnjSpx6t3M4f7IAJ8AyFnq1D+BQ==
X-Received: by 2002:adf:fa09:0:b0:207:9af2:d7b4 with SMTP id m9-20020adffa09000000b002079af2d7b4mr16085416wrr.544.1650471533385;
        Wed, 20 Apr 2022 09:18:53 -0700 (PDT)
Received: from gerbillo.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003918d69b334sm284639wmq.42.2022.04.20.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:18:53 -0700 (PDT)
Message-ID: <eecf23321c4ca23ec6fdf6b15957d281e54c96c7.camel@redhat.com>
Subject: Re: [PATCH net-next 3/5] tcp: allow MPTCP to update the announced
 window.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 20 Apr 2022 18:18:52 +0200
In-Reply-To: <ac9a7c902a51f152abcf0d9d4aeeef606e4eeaf3.camel@redhat.com>
References: <cover.1650034062.git.pabeni@redhat.com>
	 <89b12b9c11c6b35fc507f96d198719394caf6b08.1650034062.git.pabeni@redhat.com>
	 <5ec4e9a-e1f5-c698-bdf5-fd7fabc7374@linux.intel.com>
	 <ac9a7c902a51f152abcf0d9d4aeeef606e4eeaf3.camel@redhat.com>
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

On Tue, 2022-04-19 at 12:42 +0200, Paolo Abeni wrote:
> On Mon, 2022-04-18 at 17:11 -0700, Mat Martineau wrote:
> > On Fri, 15 Apr 2022, Paolo Abeni wrote:
> > > @@ -605,7 +606,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
> > >  * At least SACK_PERM as the first option is known to lead to a disaster
> > >  * (but it may well be that other scenarios fail similarly).
> > >  */
> > > -static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
> > > +static void tcp_options_write(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
> > > 			      struct tcp_out_options *opts)
> > 
> > Having both th and ptr seems redundant to my eyes. I'd rather just have a 
> > th parameter and move the "ptr = (__be32 *)(th + 1);" code inside 
> > tcp_options_write().
> > 
> > If you're thinking/hoping that Eric finds the additional parameter more 
> > acceptible, we can go with this patch as-is.
> 
> Yep, the main concerns here is obtaining the buy-in from Eric. I hoped
> that less differences would help, but likely the code you suggested is
> better. I'll send an RFC on netdev with this and the next patch to get
> some direct feedback from him.

Sharing the patches on netdev at least pointed out a build issue on
some 32bit arches lacking cmpxchg64. I'll move to atomic64_cmpxchg(),
which instead has a generic implementation.

Cheers,

Paolo

