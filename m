Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92987F6
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655715767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn1nb1+e7D+qHGUZORba9iyo9eGP72C+BsH6K8DNJrk=;
	b=XRrYsPK7i3kk1UzinpVGeyvT+0EML8rfx9hics8t8otR+koqoVuVTz1lmW03DV7hjVdVSK
	xG6VohTF1kLdTlS4FqvQi0Bpf87/pP+SWsXEFdaUh5zCO52nncwZVjnFkCaf4CyiDNd83E
	iz8ES4KWF4ZDMaHe0RuMTsLE2qZFn3Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-4Q5HGuUpPRW0vioL5Rh30g-1; Mon, 20 Jun 2022 05:02:46 -0400
X-MC-Unique: 4Q5HGuUpPRW0vioL5Rh30g-1
Received: by mail-qv1-f69.google.com with SMTP id jv13-20020a05621429ed00b0047048fce5bdso689567qvb.5
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 02:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Jn1nb1+e7D+qHGUZORba9iyo9eGP72C+BsH6K8DNJrk=;
        b=oSOjlYH+u4gvxu2UEokr6o+VVwUunbjjdczEBC7A+oGpfaNifZ06X909GQQaXjhid3
         4mICJUSkR4z9NLfKJHfClJod0zCkNamjBNq9yONu8H9dn0U8IwVGrJ1u8c6fDvN7bw3h
         3tgqku9Zrz2S4ywqC+bq1qFnDklsJrNrWiQDHeQoySRR69Xr2zBfd57FObX1DZkv9dt4
         bUhkZ2nNFuUvcckC/H/U8BRMOgm4vd9ZD95U0OP9cie2kKq0ymG+zvIiTQ6wh5yR1CrO
         etD53vX8DxvzeotTSoIglkFsxlmXJYUmnMgPMM3TOUt5/E6yfbt9o2QNSFFUUmCD7fGX
         zNxQ==
X-Gm-Message-State: AJIora+y3UhuYQFjRXLJDu6X+/1PT+VKsySiwMxPtSgnSu873Bf5Z3vA
	3ttooFoqEEyS7kInoE9ZdJk0GR4tYhJzY9vZfRfjaVyVKhQqHWuo8j+PXj7E6L9f5qWSqoffZng
	ADOBrSWcPriOeji0=
X-Received: by 2002:ad4:5ca5:0:b0:464:c474:9240 with SMTP id q5-20020ad45ca5000000b00464c4749240mr18153641qvh.106.1655715765287;
        Mon, 20 Jun 2022 02:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vvXrdQHhrYvgPQHfDytGti9xRhHE33EgWFpjR7ntUmqkfrCTFQcVN5G9nmoPd4A98VtOpJiw==
X-Received: by 2002:ad4:5ca5:0:b0:464:c474:9240 with SMTP id q5-20020ad45ca5000000b00464c4749240mr18153622qvh.106.1655715765040;
        Mon, 20 Jun 2022 02:02:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id cj11-20020a05622a258b00b002f93ece0df3sm10337853qtb.71.2022.06.20.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:02:44 -0700 (PDT)
Message-ID: <3b4896bd043cc33837ba681ca5fa7208983771bd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: never fetch fwd memory from the
 subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 20 Jun 2022 11:02:39 +0200
In-Reply-To: <b24bcaf9-1312-5173-8693-11c077bf6785@linux.intel.com>
References: <8a8f923a2d66057e4025892a4e83fc81fc7461f6.1655385956.git.pabeni@redhat.com>
	 <b24bcaf9-1312-5173-8693-11c077bf6785@linux.intel.com>
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

On Fri, 2022-06-17 at 14:54 -0700, Mat Martineau wrote:
> On Thu, 16 Jun 2022, Paolo Abeni wrote:
> 
> > The memory accounting is broken in such exceptional code
> > path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
> > as small as possible") we can't find much help there.
> > 
> > Drop the broken code.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > This is possibly for net, but makes sense only on top of recent
> > net-next patches, so whatever ;)
> 
> Let's go with net-next.
> 
> > ---
> > net/mptcp/protocol.c | 11 +++--------
> > 1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 35e3060233c9..390ac5d95664 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -328,15 +328,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
> > 
> > 	amt = sk_mem_pages(size);
> > 	amount = amt << PAGE_SHIFT;
> > -	msk->rmem_fwd_alloc += amount;
> > -	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV)) {
> > -		if (ssk->sk_forward_alloc < amount) {
> > -			msk->rmem_fwd_alloc -= amount;
> > -			return false;
> > -		}
> > +	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
> > +		return false;
> 
> Like Eric did in 7c80b038d23e, does it makes sense to try to raise the 
> allocation only by the amount of incremental memory requested (size - 
> msk->rmem_forward_alloc) rather than the full amount from the 'size' arg?

Ok, but let's put such change on a different commit. Upstream just
reported a huge regression in SCTP due to the above change, and I
haven't benchmarked MPTCP yet. Keeping the change separate we can
revert/fix/backport fix more easily.

Cheers,

Paolo


