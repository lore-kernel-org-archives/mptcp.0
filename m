Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1D2F26
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643968071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPmTcB46aMEoLjNnYKp8MBPjgmB/G/ENdbV3GCDKle8=;
	b=IL7zviS7M6UPjem9CbWDxJMfU5X1sQOxkDzAflea1Q9nTo17NlHShXPpwL6KNQ765weZXq
	M33Nnt7bvOyqO3CjhRh68Y4CU9C3dCtYVZ7ncnBlIoUGAOSHa83tbpgL2Jtmno7lBjKNdK
	TYzjB15K58J0y9L8pdmsKEmi9MSCUq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-VBAIJTs6MLafm3T1INmoSg-1; Fri, 04 Feb 2022 04:47:48 -0500
X-MC-Unique: VBAIJTs6MLafm3T1INmoSg-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso7325374wma.6
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 01:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oPmTcB46aMEoLjNnYKp8MBPjgmB/G/ENdbV3GCDKle8=;
        b=pRiisIVJowct7SNVoa1wxej4cPUUk1/zsP6bHpH5FBI7wFg4Hp/QwL0iU9k8a1LJ2k
         +lol3EpLMtjt8fyUeO45YW3CMbEi95xy8S7jJbdt4EYyew1faJdrSWOy/EMo5EiDtGrk
         K86DycqLwRLpp7K/8YVDs5V5KypF3wweF2gpiY26Hb+q+j/5c+XHctG2K7wPTVjXvwAg
         tU35XTcRe1Htk+8GL39DxrlT9CBKvgIBh5izb4QqUJLwOln9KI8hqAI8cnssh15jnyyK
         aKRJgIB/9XCtDpw+T5UwFudAou6StYClRcbq/R6/4/crkMenVv21JfqrQvXS4gYUgHmV
         BM2g==
X-Gm-Message-State: AOAM531sZbRNoBtM/IUIxIlkArQkpXp345NLvyOFFbTd8raJ4WyIPI9T
	Ih2W+ZH7cX6FAGL0RtuAFJysVeVfLNsMOlQDUrHMDg0LgWelNgGwMZWliTvg+xyipgkYzazs44I
	3/CHNStloX/1lOCA=
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr1533444wmi.74.1643968067689;
        Fri, 04 Feb 2022 01:47:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjHCPiHOZNQLpEtjdzIhqG+WPixuyK/YCeFDpPm79uPYFCvHEjCxBJjqOWHsnEKSDDUzgdQA==
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr1533428wmi.74.1643968067458;
        Fri, 04 Feb 2022 01:47:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id f14sm1192763wmq.40.2022.02.04.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 01:47:47 -0800 (PST)
Message-ID: <ded03f5c162753c75e3c5b8b1fada967a08440fd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Florian Westphal
	 <fw@strlen.de>
Cc: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 04 Feb 2022 10:47:46 +0100
In-Reply-To: <947dd6a4-3b48-64d3-7a3-d92f6edd856@linux.intel.com>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
	 <20220203072508.3072309-6-kishen.maloor@intel.com>
	 <20220203174637.GC4901@breakpoint.cc>
	 <947dd6a4-3b48-64d3-7a3-d92f6edd856@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Thu, 2022-02-03 at 17:02 -0800, Mat Martineau wrote:
> On Thu, 3 Feb 2022, Florian Westphal wrote:
> 
> > Kishen Maloor <kishen.maloor@intel.com> wrote:
> > > The kernel can create listening sockets bound to announced addresses
> > > via the ADD_ADDR option for receiving MP_JOIN requests. Path
> > > managers may further choose to advertise the same addr+port over multiple
> > > MPTCP connections. So this change provides a simple framework to
> > > manage a list of all distinct listning sockets created in the kernel
> > > over a namespace by encapsulating the socket in a structure that is
> > > ref counted and can be shared across multiple connections. The sockets
> > > are released when there are no more references.
> > 
> > I think it makes sense to work on a hook in tcp v4/v6 input path
> > that gets called for th->syn && !th->ack && no-listener-found case.
> > 
> > The hook would:
> > 1. retrieve join token, fetch mptcp_sock and allow 3whs to continue
> >   if things look ok from mptcp p.o.v.
> > 2. return "go ahead and send tcp rst" or "mptcp magic, skb stolen"
> > to the tcp stack.
> > 
> 
> This is basically the approach the multipath-tcp.org kernel takes. I think 
> we initially decided to use listening sockets instead since it was less 
> invasive, but now we have found the limits of the listener approach.
> 
> It even looks like your proposal adheres more closely to 
> https://datatracker.ietf.org/doc/html/rfc8684.html#section-3.2 (last 
> paragraph): "Demultiplexing subflow SYNs MUST be done using the token"
> 
> I hadn't noticed that "MUST" before.
> 
> Do you think the token lookups should depend on anything other than the 
> token value and net namespace - for example, to make sure someone can't 
> use a public interface to try to brute-force potential tokens in use on 
> other interfaces? The HMACs later in the handshake would guard against an 
> actual connection (but would burn some extra CPU cycles). I guess this 
> isn't a fundamentally different problem than we have today if there are 
> any MPTCP listeners on public interfaces, it just means they don't have to 
> work out the port number first.

The matching MPJ token could/should still be validated vs (signal)
endpoints available in the relevant ns. Attackers should be able to
brute force only via IPs that are reachables and announced as signal
endpoints. It should be safe IMHO.

Overall LGTM

Thanks!

Paolo

