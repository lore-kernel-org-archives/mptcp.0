Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CA2C80
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644514947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3sa0VvQ6pqdqW4G+7UDtWAA/vMl4jfi+/gWnSN81ZE=;
	b=SXinev0A7bhfU/N9c2CGwzudn1J3gAGMi3UGeKHe2WnI+dyzW3t/V2sGMMortcFUg3M8JN
	9ynktgr1btzI+MLtC9kDG585inXX7CXmOSmYv87mquXEfeDUi76cHjdD6RAygJnG6BQPB7
	fGNWfL/58r+QDSRbinGIyyMZ8Ugoegw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-blzXpIqxPWKbPZeBfOGrBg-1; Thu, 10 Feb 2022 12:42:24 -0500
X-MC-Unique: blzXpIqxPWKbPZeBfOGrBg-1
Received: by mail-wm1-f71.google.com with SMTP id r187-20020a1c44c4000000b0037bb51b549aso1149198wma.4
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 09:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=M3sa0VvQ6pqdqW4G+7UDtWAA/vMl4jfi+/gWnSN81ZE=;
        b=AmfudFc6rKcAyWtLWCCaJugzLwxlnZaDGQeGi4UGMAV/Ov7U1JrvydVrwaUhowEvfU
         E20lsbRpZx/pD97LEKhwGvTGgGZMht1320xcmWM6bc8DvV4yiWvPI1oB6ZTluppwCusB
         nwOVw9KuuwX/dvgyfNoGLw7U8xcJo0PyGHrgCy+jrUViiqAweC6eZ8Ig9eWY3iO+iU06
         RBQnhTNMLKbpLlHepLmpZHAulIeGKPtU9vbFC/7C45xZOgBCQ5Z3tcV0tCZ0gRdZ7rgt
         yQBwIFFkFvelgQcQPfQT54+TMSA/jR55j9uWKBUpCxnKD6/5XRNIK9J4jif+59UtqK//
         KvIA==
X-Gm-Message-State: AOAM533iPf62NC9Y/8u64nx68AUnHX62fbY7aFkRVwr+f45R2K1+0fra
	S2UDh8uAkPXpVaZtYjpMkgcuWSbWYi97ujksZgWoU23ndKNYWJW+dLhchORwLg50u0kGttBhvhD
	nMQ6CU1DgMry3nmk=
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr7451221wri.438.1644514942907;
        Thu, 10 Feb 2022 09:42:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx16ngdERgVTbXdq3hGwzknpFtQZg+st6rw+9iWg0OLWbN+aJA5fZ/HpgCPFfFeeZp0NQb9tg==
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr7451216wri.438.1644514942695;
        Thu, 10 Feb 2022 09:42:22 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id k34sm1210299wms.35.2022.02.10.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:42:22 -0800 (PST)
Message-ID: <21b550b62f2b2deff29375980a454a6933695329.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: strict local address ID selection.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 18:42:21 +0100
In-Reply-To: <2747570e9a46ee5b3d18ed9f44e73e4043be333d.camel@redhat.com>
References: <75e02d63aa8b03b873ad94f5b4d901776f9a81ea.1644487551.git.pabeni@redhat.com>
	 <47e854cf68fdc2a1e0b2c9e79813d4212393faac.camel@redhat.com>
	 <60ef8629-d9d4-3bc2-00cb-d8c286d934aa@tessares.net>
	 <2747570e9a46ee5b3d18ed9f44e73e4043be333d.camel@redhat.com>
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

On Thu, 2022-02-10 at 16:08 +0100, Paolo Abeni wrote:
> On Thu, 2022-02-10 at 13:03 +0100, Matthieu Baerts wrote:
> > Hi Paolo,
> > 
> > On 10/02/2022 11:36, Paolo Abeni wrote:
> > > On Thu, 2022-02-10 at 11:07 +0100, Paolo Abeni wrote:
> > > > The address ID selection for MPJ subflows created in response
> > > > to incoming ADD_ADDR option is currently unreliable: it happens
> > > > at MPJ socket creation time, when the local address could be
> > > > unknown.
> > > > 
> > > > Additionally, if the no local endpoint is available for the local
> > > > address, a new dummy endpoint is created, confusing the user-land.
> > > > 
> > > > This change refactor the code to move the address ID seleciton inside
> > > > the rebuild_header() helper, when the local address eventually
> > > > selected by the route lookup is finally known. If the address used
> > > > is not mapped by any endpoint - and thus can't be advertised/removed
> > > > pick the id 0 instead of allocate a new endpoint.
> > > > 
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > Note: send v2 to address the build issue, to help the discussion
> > > 
> > > It looks like I was too hasty and this is badly broken. Please ignore,
> > > I'll try to cook something better later.
> > 
> > Funny, the CI doesn't agree with you :)
> 
> Well, sometimes I don't agree even with myself ;)
> 
> The root cause of the breakage I mentioned above is actually pebkac: I
> was testing an older kernel :(((
> 
> It looks like the self-tests are happy even here - when checking the
> correct kernel - so in the end this patch should be valid - execept for
> the intentional RFC breakage.

Following-up the past public mtg, I think I found a way to have
stable/correct local address id generation and avoid the RFC violation
above - with a little more patching. I hope to be able to share the
code later today.

Cheers,

Paolo

