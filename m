Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C42F43
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652285417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRTYafAkNUbIIgRjf6QIICcwiTdI81y2tq6V3zzDi0k=;
	b=SMmUTpzD4WwFBndONgent/WZBRjmR+nvTey///GWs9gvWwAWBn26/ZuBRiHOr0txkQLSjT
	aEgkbfTtVaaLsUpvbl3wJ3evAvrc6sAIU/b7hDj+R35PjDVpYLhbo69FePnkg0UIL7tzWz
	rj8nIcWQta2VyAB7+oCt46A1VMoNv9o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-1FKii_PmNqmTJJ_Gsj67Xw-1; Wed, 11 May 2022 12:10:16 -0400
X-MC-Unique: 1FKii_PmNqmTJJ_Gsj67Xw-1
Received: by mail-wr1-f70.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so1021060wrg.10
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 09:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HRTYafAkNUbIIgRjf6QIICcwiTdI81y2tq6V3zzDi0k=;
        b=TUaS4WKehAT3p5NEqNqUxsSKxXLPn+OT+PCx1nfSyXd5W0YRsKuBECfK/pNNv26Hfk
         X1V+xhsR7rAD38x9sdXznyX57anozqmfxY078tyB1jxsQGZmbOJ2Ea6YqO5kJHklENZ4
         0Ut70XDpNdugc60NnVy4nOLYRuZ9JqCRD9xpIKAykY27RcXT/AWGbi4J3BZk5Ej23uop
         uT+qcmN7CdBG7hF8BDZ7Us071kMNWgtJt9tgY3FqWpQaGJGBasSKx5s48SsJHmyi+W8P
         I2KMhTwXgc/9QxeiOc+Iaro77opoZQ6rkDXSi6eRxjmsoq11zw37+BjuZ1R+Qc8Ljyzb
         Etdw==
X-Gm-Message-State: AOAM531CHbV2pmoHKTT6a4HZzo1DoyTKPv2ai9r57d//e4IbA6KOdILB
	/d27Wp6S7MbFlsNogtV+alpRl3axL0Fx2Vcu+++aNMEVWNO7HV62qKVqHR+iIhK+8jZdx4qTVfO
	8kNi+CiyP2Wl5YNs=
X-Received: by 2002:a1c:2784:0:b0:392:b4f9:c6ef with SMTP id n126-20020a1c2784000000b00392b4f9c6efmr5447475wmn.201.1652285414885;
        Wed, 11 May 2022 09:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzXIhHPEDwPkgzkLJmkXCTPMN/seEQsBxmRTTPeZSLNRpICq0Pgpk2AbD+0vSv4/yacJDldQ==
X-Received: by 2002:a1c:2784:0:b0:392:b4f9:c6ef with SMTP id n126-20020a1c2784000000b00392b4f9c6efmr5447446wmn.201.1652285414609;
        Wed, 11 May 2022 09:10:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id b1-20020adfc741000000b0020c5253d8cbsm2193260wrh.23.2022.05.11.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:10:14 -0700 (PDT)
Message-ID: <487184c3ac424c9613bb4811564babbbf096b29e.camel@redhat.com>
Subject: Re: problems with MP_FAIL timer
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Date: Wed, 11 May 2022 18:10:13 +0200
In-Reply-To: <88834512-46aa-604e-9e25-a17c13a6986@linux.intel.com>
References: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>
	 <88834512-46aa-604e-9e25-a17c13a6986@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

On Wed, 2022-05-11 at 08:32 -0700, Mat Martineau wrote:
> On Wed, 11 May 2022, Paolo Abeni wrote:
> 
> > Hello,
> > 
> > re-reviewing again the commit:
> > 
> > mptcp: reset subflow when MP_FAIL doesn't respond
> > 
> > There are a few issue with sk_timer handling, specifically:
> > - no additional mptcp_data_lock is needed to stop/reset it
> > - I think overlapping infinite mapping reception and close may lead to
> > some inconsistent timer usage
> > 
> 
> I'm working on a patch for this.
> 
> The issues you describe are what I was trying to comment on in
> https://lore.kernel.org/mptcp/bdde3a40-1471-c8b9-65bd-f53ddebacdb4@linux.intel.com/, 
> but my proposed solution (deferred events for coordinating with 
> msk->sk_state) isn't the way to fix it.

I think there is anoter issue: in mptcp_timeout_timer(), via
mptcp_check_mp_fail_response() -> mp_fail_response_expect_subflow() ->
mp_fail_response_expect_subflow(), the code traverse the conn_list
under the msk socket spin_lock. That is not enough: it should instead
acquire the full msk socket lock. 

We can use the is_not_owned || defer to release_cb schema, but I think
we are simply better off reverting such patch. Any strong opinion
against that?

Paolo
> 

