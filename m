Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45573678
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645036718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qE2piSYPvgHCQ4U7bqY59hfFiMSFrtpANxMOBjPJFQ=;
	b=Xog347xeXt4LCTgJnjZl4+G25RdxvTBT9D4pqciEGjLrgeUrv6GYMtpBZ1z76YupeAcxkh
	UKQgXj5dw5fArMj8U8MgmKXTQd6lnio1u8EM3/nxo0EM/UBNFGLkOTSqztla6XXzCnUESW
	tyOc3T3XXn4i7YAyuffRXsXwWesAT7M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-H59NrGySMEW_BF3eY7mySA-1; Wed, 16 Feb 2022 13:38:37 -0500
X-MC-Unique: H59NrGySMEW_BF3eY7mySA-1
Received: by mail-wm1-f71.google.com with SMTP id i188-20020a1c3bc5000000b0037bb9f6feeeso3231579wma.5
        for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 10:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8qE2piSYPvgHCQ4U7bqY59hfFiMSFrtpANxMOBjPJFQ=;
        b=O6m1YY6WWltLM/DFRVzd2+KzdTVflZzqZoe+DiqKtWTpnP71OYIk53OgjylUr0gg/F
         q8oNUUElRYOOkiSi0+nLoVZSsTXIjgaumFNr1+kk8rtQDgqSbBkLAxrcge2WQqBViLzL
         b+WEDV3ZmIStwnhvu48zSh93EAAvsiOLBTKD5cTCbzFja1glLPrecvY+sKateSu3vnah
         dU8O+G59QKiOYY34cW+Ysyuv4UM67JDUtausChjWN/vxcpHImVSZAd253wYSULzhyFh2
         rHXehpW722Z7zNrCukc1p7DkkML46UpiCHcl7NPUDNZ80FvXhWzB6sP//TFQzxL66XMx
         vL5g==
X-Gm-Message-State: AOAM532nW6DyVTT+d814ioAFHZsacmj7TES9XssBAPgJLKPkXnar7AGx
	4wp7wIF4ZaW6DYUrUAKFwhAyd7C1654Bkxmyek2+FW72XSqk3j5u2QFKKmIW3vDNO6vae1v8nNz
	R2LDXqxT1HjpjZsM=
X-Received: by 2002:a5d:4ccc:0:b0:1e3:222b:40fc with SMTP id c12-20020a5d4ccc000000b001e3222b40fcmr3223926wrt.296.1645036715693;
        Wed, 16 Feb 2022 10:38:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0wiXj/Hqb0Y9GgzRfzvOrIt0BvRLxQUYxfr/SAM/8Z1qFt3Re71db6NVX8MfnXPX7uyBSrQ==
X-Received: by 2002:a5d:4ccc:0:b0:1e3:222b:40fc with SMTP id c12-20020a5d4ccc000000b001e3222b40fcmr3223918wrt.296.1645036715388;
        Wed, 16 Feb 2022 10:38:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id u3sm22813116wmm.0.2022.02.16.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:38:35 -0800 (PST)
Message-ID: <965a43a6d37214f16db59a035ea2969bfa8a6bd3.camel@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR generation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 16 Feb 2022 19:38:33 +0100
In-Reply-To: <79c7eb81-a894-a5cf-433-7bffade2b215@linux.intel.com>
References: <cover.1644852970.git.pabeni@redhat.com>
	   <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>
	  <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>
	  <5a284b53-23e5-fded-a242-3a5fbc431eae@linux.intel.com>
	 <1db883cd0e1c8849a64ab2c0acb0204c9e82469f.camel@redhat.com>
	 <79c7eb81-a894-a5cf-433-7bffade2b215@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

On Tue, 2022-02-15 at 11:15 -0800, Mat Martineau wrote:
> On Tue, 15 Feb 2022, Paolo Abeni wrote:
> 
> > On Mon, 2022-02-14 at 17:19 -0800, Mat Martineau wrote:
> > > On Mon, 14 Feb 2022, Paolo Abeni wrote:
> > > 
> > > > On Mon, 2022-02-14 at 16:38 +0100, Paolo Abeni wrote:
> > > > > In some edge scenarios, an MPTCP subflows can use a local address
> > > > > mapped by a "implicit" endpoint created by the in-kernel path manager.
> > > > > 
> > > > > When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
> > > > > suboption. That is somewhat unexpected, as an MPTCP listener will keep
> > > > > accepting incoming subflows targeting such address and the unexpected
> > > > > options can confuse some self-tests.
> > > > > 
> > > > > Be more conservative about RM_ADDR generation: explicitly track the
> > > > > implicit endpoint with an appropriate flag and exclude them from the
> > > > > RM_ADDR generation.
> > > > > 
> > > > > Additionally allow the user-space to replace implicit endpoint with
> > > > > user-provided data at endpoint creation time.
> > > > > 
> > > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > 
> > > > The CI still reports an issue on top of this patch:
> > > > 
> > > > https://cirrus-ci.com/task/5380046008352768?logs=test#L7283
> > > > 
> > > > Even if the symtom is the same, the root cause is different. I think
> > > > such failure is caused by the flush operation deleting both all
> > > > existing endpoints and all the existing subflows for each MPTCP socket.
> > > > 
> > > > Even when the subflow is not attached to any known, non implicit,
> > > > endpoint.
> > > > 
> > > > When we have simult flush on both sides, deleting the subflow (with no
> > > > endpoint) on one end can make disappear the subflow on the other end
> > > > (tied to a local endpoint) before the PM could generate the relevant
> > > > RM_ADDR.
> > > > 
> > > 
> > > If we aren't closing all subflows during the flush, shouldn't there be at
> > > least one subflow where the RM_ADDR can be sent?
> > > 
> > > Maybe mptcp_pm_nl_addr_send_ack() needs to pick a better subflow for
> > > sending the RM_ADDR. Do you think it would help to make
> > > mptcp_subflow_send_ack() return a bool, and only return true if the ack
> > > was sent? Then it could retry the ack on other subflows in the conn_list,
> > > until it finds one that works or they all fail.
> > 
> > I'm sorry it looks like I was unclear.
> > 
> > What I mean is that in the following scenario:
> > 
> > Client					Server
> > [endpoint1] ------- MPTCP-subflow ----> [addr0/no endpoint]
> > [endpoint2] ------- subflow 1  -------> [addr0/no endpoint]
> > [endpoint3] ------- subflow 2  -------> [addr0/no endpoint]
> > 
> > if we flush simultaneusly the endpoints on both the server and the
> > client (which is what the failing selftest is currently doing), the
> > number of RM_ADDR generated by the client is unpredictable.
> > 
> > On endpoint flush the server will try to delete all the subflows,
> > regardless of no endpoints attached there. The server can delete the
> > subflow 1 and/or the subflow 2 before the client processes the relevant
> > endpoint on the other side. If that happens, the client will not
> > generate (correctly) the related RM_ADDR.
> 
> I'm not sure that's correct, though. Even if subflows 1 and/or 2 have been 
> closed, if the client has sent an ADD_ADDR to advertise endpoints 2 and 3, 
> it should send RM_ADDR to "unadvertise" them on the remaining open 
> subflow. 

If the peer sent ADD_ADDR for a given address, it will generate the
RM_ADDR, regardless of the related subflow being already closed. We
don't have bugs - al least not shown by the current self-tests failures
- in that situation. 

The criticial scenario is a bit different: the client created the
subflows, but it did not avertize any address with ADD_ADDR (the client
endpoints have the 'SUBFLOW' flag, not the 'SIGNAL' one).
	
If I read correctly the discussion about ADD_ADDR handling, a correct
and simple solution would be sending RM_ADDR only for 'SIGNAL'
endpoints, and update the test-cases accordingly.

It's not clear to me if in case of 'endpoint flush', we should keep
deleting all the subflows - including the ones not tied to 'SIGNAL'
endpoints on any end.

Cheers,

P

