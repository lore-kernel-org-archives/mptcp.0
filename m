Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD7158E
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644944865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YINTtbJqnFZZcBirkkdr3ZSiZjXTWsLe7gzghDCIeu4=;
	b=dI7T5UPxekPmydTal9Mo+dqJczvsSHNUkDtZD2xs/VCcijMrqPrARtvxK9qi9HjhDZyynJ
	th4gVL2cQn2pirWMlxGdAvBvQZABY4Tjt7vCbLOm9/UFSr5dwrjSHJ59iNIoxgZPIhmppr
	8rN3uA8xb+me0Nzez2/Onn++yC4Ybgo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-AQ2CZ1k8MoeZdP06hweGzw-1; Tue, 15 Feb 2022 12:07:43 -0500
X-MC-Unique: AQ2CZ1k8MoeZdP06hweGzw-1
Received: by mail-qv1-f70.google.com with SMTP id kd18-20020a056214401200b0042de5c14702so3155395qvb.12
        for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 09:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YINTtbJqnFZZcBirkkdr3ZSiZjXTWsLe7gzghDCIeu4=;
        b=gETG2BesJY4jQ+3QflvUZcERby4Vwh7San7Q6unQ1NSBOiJP8PZ36Gkha20N8hoqjJ
         r6Hv3xQRWEm0imKRZO6fMqS8/DE5nhgQwrBPJ9xPhtLPJ1mkrRjhDRvOLISoaP6AUW5F
         DyGU8YYWnXebWeRxt6MeukmhAMXr06eLq8JNXGS482yje+3Gqnt4Ad0R44blPRHy++Jn
         flfg/3q5eOfUJPt/YQq6/NiUniipYOM8aaoF1c97ufWLiWhvol5krthjdB8Dq2tjYoh2
         kCwyvwPtT9vo62Zl25x0t87vlFQ0VVRbHyUBYwGJdADMw/MzAyEsr16bs0gEObVAPm95
         zQUA==
X-Gm-Message-State: AOAM530LeC907RvEzzQSWaRRduh6TUucq9Z4QIPBZ9YeK3p86K4QvhER
	9n6dvE3r5rB+qYzbd88LTVQTEF71PFqnILlaOXJ0TW5PPk+D9EYjXmlLNM7VCc7QV8BjALDDeZv
	F1E0VP2YervB4YYA=
X-Received: by 2002:a05:6214:2129:: with SMTP id r9mr30263qvc.27.1644944862494;
        Tue, 15 Feb 2022 09:07:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynDWdXhbyEXtns4Vj5oqCYr1N1Bn8THCrWbqzTgkSUUVA+mKjajNFWkK5LSBrVS0R/nBuf5w==
X-Received: by 2002:a05:6214:2129:: with SMTP id r9mr30228qvc.27.1644944862085;
        Tue, 15 Feb 2022 09:07:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-109-103.dyn.eolo.it. [146.241.109.103])
        by smtp.gmail.com with ESMTPSA id b22sm4676465qkl.59.2022.02.15.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:07:41 -0800 (PST)
Message-ID: <1db883cd0e1c8849a64ab2c0acb0204c9e82469f.camel@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR generation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 15 Feb 2022 18:07:39 +0100
In-Reply-To: <5a284b53-23e5-fded-a242-3a5fbc431eae@linux.intel.com>
References: <cover.1644852970.git.pabeni@redhat.com>
	  <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com>
	 <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>
	 <5a284b53-23e5-fded-a242-3a5fbc431eae@linux.intel.com>
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

On Mon, 2022-02-14 at 17:19 -0800, Mat Martineau wrote:
> On Mon, 14 Feb 2022, Paolo Abeni wrote:
> 
> > On Mon, 2022-02-14 at 16:38 +0100, Paolo Abeni wrote:
> > > In some edge scenarios, an MPTCP subflows can use a local address
> > > mapped by a "implicit" endpoint created by the in-kernel path manager.
> > > 
> > > When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
> > > suboption. That is somewhat unexpected, as an MPTCP listener will keep
> > > accepting incoming subflows targeting such address and the unexpected
> > > options can confuse some self-tests.
> > > 
> > > Be more conservative about RM_ADDR generation: explicitly track the
> > > implicit endpoint with an appropriate flag and exclude them from the
> > > RM_ADDR generation.
> > > 
> > > Additionally allow the user-space to replace implicit endpoint with
> > > user-provided data at endpoint creation time.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > The CI still reports an issue on top of this patch:
> > 
> > https://cirrus-ci.com/task/5380046008352768?logs=test#L7283
> > 
> > Even if the symtom is the same, the root cause is different. I think
> > such failure is caused by the flush operation deleting both all
> > existing endpoints and all the existing subflows for each MPTCP socket.
> > 
> > Even when the subflow is not attached to any known, non implicit,
> > endpoint.
> > 
> > When we have simult flush on both sides, deleting the subflow (with no
> > endpoint) on one end can make disappear the subflow on the other end
> > (tied to a local endpoint) before the PM could generate the relevant
> > RM_ADDR.
> > 
> 
> If we aren't closing all subflows during the flush, shouldn't there be at 
> least one subflow where the RM_ADDR can be sent?
> 
> Maybe mptcp_pm_nl_addr_send_ack() needs to pick a better subflow for 
> sending the RM_ADDR. Do you think it would help to make 
> mptcp_subflow_send_ack() return a bool, and only return true if the ack 
> was sent? Then it could retry the ack on other subflows in the conn_list, 
> until it finds one that works or they all fail.

I'm sorry it looks like I was unclear. 

What I mean is that in the following scenario:

Client					Server 
[endpoint1] ------- MPTCP-subflow ----> [addr0/no endpoint]
[endpoint2] ------- subflow 1  -------> [addr0/no endpoint]
[endpoint3] ------- subflow 2  -------> [addr0/no endpoint]

if we flush simultaneusly the endpoints on both the server and the
client (which is what the failing selftest is currently doing), the
number of RM_ADDR generated by the client is unpredictable.

On endpoint flush the server will try to delete all the subflows,
regardless of no endpoints attached there. The server can delete the
subflow 1 and/or the subflow 2 before the client processes the relevant
endpoint on the other side. If that happens, the client will not
generate (correctly) the related RM_ADDR.

The testcase is currently expectiong exactly 2 RM_ADDR in the above
scenario (well actually 3, because the testcase uses 3 MPJ subflows)

Picking a different subflow to send the RM_ADDR will not change the
results.

Not sure if the above is somewhat more clear.

I don't see other viable options other then the 2 mentioned in my
previous email.

Thanks,

Paolo

