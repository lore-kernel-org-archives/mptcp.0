Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E894D70
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622731669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oaHdSf7iWkgGcQyBjStXMgLt6qvPOXxhbjwfjdG6vhg=;
	b=WHxT9cM7gz8mWR/Jy09T/2rKa6uXev0Ktqwzc6ikbBcO/bOQrg3Usc1dkihRCA+vFXMLTu
	dMouJQVvzdP8vLUghIKgA50C7ApeiDtP1/ArxTHDomk4t27WcBAgRLPM+zhGsyOGAZxMjf
	faYcuIYvzGLVtWSBD4o2+gFRQmOHJsA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-VjuS59ZxNwST_iMbt2dNJg-1; Thu, 03 Jun 2021 10:47:38 -0400
X-MC-Unique: VjuS59ZxNwST_iMbt2dNJg-1
Received: by mail-wr1-f69.google.com with SMTP id r17-20020a5d52d10000b0290119976473fcso338282wrv.15
        for <mptcp@lists.linux.dev>; Thu, 03 Jun 2021 07:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oaHdSf7iWkgGcQyBjStXMgLt6qvPOXxhbjwfjdG6vhg=;
        b=YmK+3q30dXGX0GLjxHphbJsB9Vwz5BZMJmVPOzBdWIElDFN/48TStVYNbbPPlHFX51
         JZ1zpKRPFTsfzQWu6C9zoHWCP/uKMGdI6Y226oTr7KvHpuKcnTsLUS344iKF/LN+AFUO
         9rxof7rsnsPa3IVg7BrJxoUv4XRHLTQbZ0aNbTl9CIaGJ7CfC8/5nujPH3NSrgRhJEBK
         o0CacrDxKFgkXiB3KRG0LjkQybkbo/GTxVRAVDrdvMZOan+9VQzlCv2Zb5O5EisWItJn
         qSKB7J4+HUHMwZ/nPCLi6siegOocqodYFq1U7wK0/lkLa4+vPsTPBgnQ4lqik8KY/3V8
         dLxg==
X-Gm-Message-State: AOAM530wjPQ8+nxfDczx6J8CVnajdbcGq2WL9niNLhAsV4OoHbMz0eHY
	+3UqZmgU+eAgNs9fwth+rsYanro1GZjTF7RRmmN/R7W1730Qlkntspsn2dbzNGR93HibA0hTjzM
	cbJu2GjCBdzRZTUw=
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr351712wrq.330.1622731657649;
        Thu, 03 Jun 2021 07:47:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE8gxGR7L+r3JRP9mOrYU9NZmqERZpGHwd72lAuxDOlZfPt7//e1hrZhvb5sH7lsm+1bWd8A==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr351696wrq.330.1622731657428;
        Thu, 03 Jun 2021 07:47:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id b8sm2291223wmd.35.2021.06.03.07.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:47:37 -0700 (PDT)
Message-ID: <d7729f213d397204190bb1a832db59f5e5c41db2.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: enable syncookie only in
 absence of reorders
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Date: Thu, 03 Jun 2021 16:47:35 +0200
In-Reply-To: <20210603112912.GA7062@breakpoint.cc>
References: <15333b645caafe2b7fbb028e67bb788c0d5cf526.1622719000.git.pabeni@redhat.com>
	 <20210603112912.GA7062@breakpoint.cc>
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

On Thu, 2021-06-03 at 13:29 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > Syncookie validation may fail for OoO packets, causing spurious
> > resets and self-tests failures, so let's force syncookie only
> > for tests iteration with no OoO.
> > 
> > Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/198
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 69351c3eb68c..9e53334c9512 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -202,9 +202,6 @@ ip -net "$ns4" link set ns4eth3 up
> >  ip -net "$ns4" route add default via 10.0.3.2
> >  ip -net "$ns4" route add default via dead:beef:3::2
> >  
> > -# use TCP syn cookies, even if no flooding was detected.
> > -ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
> > -
> >  if $checksum; then
> >  	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
> >  		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
> > @@ -748,6 +745,13 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
> >  		exit $ret
> >  	fi
> >  
> > +	# force TCP syn cookies only if there is no reorder
> > +	if [ $sender = $ns1 ]; then
> > +		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
> 
> I wasn't clear to me at first glance what $sender = $ns1 had to
> do with reordering.
> 
> Maybe:
> 
> # ns1<->ns2 is not subject to reordering/tc delays.  Use it to test
> # mptcp syncookie support.

Yep, that does not hurt ;) Will add in v2, thanks!

/P
> 

