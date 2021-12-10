Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253C2CA1
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639133224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unyIkQsY0N4R0gxBaIz+Ig8m1jaFx+wk8UecMffZKog=;
	b=Y1r7u0KSJrjH7qggDCURNDsbi089/h3ke43HuBREnItSeesHJs1t6EzrMpYLS57nIBLl2D
	PFkBur6Hj0VzqVeIiHNApjn5PSLk0WzAtn05YkipzXRwj6P98lbRND598qv41TNiyJPnL+
	Esa+go4wISE0GLFdZAfC8cUrjWRBftk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-430-dvk9VJryPAuOxP0sa-jQjw-1; Fri, 10 Dec 2021 05:47:03 -0500
X-MC-Unique: dvk9VJryPAuOxP0sa-jQjw-1
Received: by mail-qv1-f69.google.com with SMTP id jt9-20020a05621427e900b003c027cd9516so13821546qvb.20
        for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 02:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=unyIkQsY0N4R0gxBaIz+Ig8m1jaFx+wk8UecMffZKog=;
        b=wKVVXHf93E5BmQQIApN59ov/AG3b4FBA/BOgqy5voq4xAcxT2oS+2AXMy0FdIGVaKL
         ohngt68uPVegp2BTyY9mwyWc31jv2B5Y0EaHM7a0pZWosjEB8UmKucXnvHIhUcH5aDZi
         trLaHGZzRPNwnRqkEET4nKs/AIRSoZyUuBM8k/QeWVU11WTPD7R6yp9vVB1RakRIdUvb
         mQjOmTDJRMfV1pifSg3uC4IQGiAXCfQDA2BgQrUpVShW3oCbldFqapm0WIK1LmVdz/lH
         cNfQ0V/ugu49wp9jqvwOH06C69J14p9sPXuGUvUsO0djnCq/dgcyMs+Pv2w0+ilwSp/R
         /Kog==
X-Gm-Message-State: AOAM531Xe3TZsOOKsVBv6wzV/udq5Epzphx3xqEBVMVq+TxihKb8/Sw+
	g4+tCQW/5sYJSiLT75YkpC2PAUxxRw0b2g51uIgFVcMwv6zPbOrNmltm9m1WMRQhL8DQ8c2YP8t
	uwJQifJ3n4Yd6M/c=
X-Received: by 2002:a05:622a:1014:: with SMTP id d20mr26602678qte.399.1639133222520;
        Fri, 10 Dec 2021 02:47:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+RXbOn63MIICof+dLFpYbGjTsLBwEDlkPdAIg7gQk1xCtdM9KnWy8aMPaQKg+K0eNQRsMUA==
X-Received: by 2002:a05:622a:1014:: with SMTP id d20mr26602656qte.399.1639133222216;
        Fri, 10 Dec 2021 02:47:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id v5sm1596944qtc.60.2021.12.10.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 02:47:01 -0800 (PST)
Message-ID: <d836b98995c155d007f77f028e4c809e3c066fbf.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] mptcp: clear 'kern' flag from fallback sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 10 Dec 2021 11:46:58 +0100
In-Reply-To: <20211210090004.GF26636@breakpoint.cc>
References: <d5c4d25c-7498-46c5-54b6-4fd067d075f2@linux.intel.com>
	 <20211206212650.1895-1-fw@strlen.de>
	 <bf919f98-d135-fffe-e586-873810a81f4d@linux.intel.com>
	 <6c32d24c-d4d-727d-27a9-75478838157e@linux.intel.com>
	 <20211210090004.GF26636@breakpoint.cc>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Fri, 2021-12-10 at 10:00 +0100, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > On Mon, 6 Dec 2021, Mat Martineau wrote:
> > 
> > > On Mon, 6 Dec 2021, Florian Westphal wrote:
> > > 
> > > > The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
> > > > It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
> > > > working for plain tcp sockets (any userspace-exposed socket).
> > > > 
> > > > But in case of fallback, accept() can return a plain tcp sk.
> > > > In such case, sk is still tagged as 'kernel' and setsockopt will work.
> > > > 
> > > > This will crash the kernel, The subflow extension has a NULL ctx->conn
> > > > mptcp socket:
> > > > 
> > > > BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
> > > > Call Trace:
> > > > tcp_data_ready+0xf8/0x370
> > > > [..]
> > > > 
> > > > Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming
> > > > connections")
> > > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > > ---
> > > > v2: also handle early-return
> > > 
> > > Thanks - v2 looks good to me.
> > > 
> > > Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > > 
> > > > 
> > > > net/mptcp/protocol.c | 4 +++-
> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index 8319e601bc2d..4a8f2476cc75 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -3013,7 +3013,7 @@ static struct sock *mptcp_accept(struct sock
> > > > *sk, int flags, int *err,
> > > > 		 */
> > > > 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
> > > > 			tcp_sk(newsk)->is_mptcp = 0;
> > > > -			return newsk;
> > > > +			goto out;
> > > > 		}
> > > > 
> > > > 		/* acquire the 2nd reference for the owning socket */
> > > > @@ -3025,6 +3025,8 @@ static struct sock *mptcp_accept(struct sock
> > > > *sk, int flags, int *err,
> > > > 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> > > > 	}
> > > > 
> > > > +out:
> > > > +	newsk->sk_kern_sock = kern;
> > 
> > Florian -
> > 
> > I was about to upstream this for -net, but have another question first.
> > 
> > Is there anything else in newsk that needs to be updated when changing
> > sk_kern_sock? sk_alloc() handles some reference counts differently for kern
> > socks, and sock_lock_init() sets things up differently for lockdep.
> 
> AFAICS no.
> 
> The tcpsk inherits these settings from its parent (listen) sk, so they
> always have 'kern = 1'.
> 
> Even before this change, lock depclass is not correct (kernel, not user).
> 
> Need to export code from core to change this.

I personally would go this way, with a separate patch, possibly addinig
a new helper for that.

Somewhat related: I don't see where the lockdep class for
sk_callback_lock is set properly for any in-kernel user doing accept()
on plain TCP socket (I mean: not an mptcp listener!). sk_clone_lock()
calls sk_init_common() which uses unconditionally the user-space
lockdep class. ?!?

Cheers,

Paolo

