Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824B2F26
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643969789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuXpQ2JYvbjcPk9J9L5UeKyeesZ0voJmJxYDgC6gW/Q=;
	b=ahKfmLKTwvTH9+c/NgkR+cMR+HMU9GfTFMN5VDxVFzEOuY5ySp2gBcKH1RGemMHdHcsWUL
	zwCslROmNmE2AceNnuvgIXma+sA2yjEbK/aYU3nr0VbfBjEXymI6szJK1WRT9P424q/6Wk
	k9ZxZ6MaSAu7smxKGJNKgaQrUeOE1NM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-S2PMGW7COlChtvHB0BeUSQ-1; Fri, 04 Feb 2022 05:16:27 -0500
X-MC-Unique: S2PMGW7COlChtvHB0BeUSQ-1
Received: by mail-qk1-f199.google.com with SMTP id j66-20020a375545000000b004e0e071f37eso3225112qkb.23
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 02:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UuXpQ2JYvbjcPk9J9L5UeKyeesZ0voJmJxYDgC6gW/Q=;
        b=R/1CVU5D/whvKU+B+SlRJBwJiPMzF8dZggA0BNe/QvwpoQ8T75QQZDUoJltpF298L/
         HfHDK8x8IO2WNK6cIRfm9zkqjusAjW3sGX53soLGxpEHLsToP3JV/UBNuIMABepjf4cX
         4o3EH4oGjIJ96zkB3G1A7GqSnsZQITIC+awo6tkIDd4n7F94ef0gD8DJQZtGliGDRfFs
         3TTenEsn/6m3SZLc0AgeTMzbTUZnnrhm4wwj9mc/iBgIdG5JQtgNRuWRBqRfQRzrjh95
         yysXRrVySXfsZUdaG+1aiWZ1JZ7vExFaKKidqdWJSVT8uykrYQc4rwN6miBtZgRSjDKQ
         CVAQ==
X-Gm-Message-State: AOAM530s1hEKtRyXeesSC2tZiL8x7gl2dlOira2u8trhWxKpOfttT/ij
	K4komDdMmjJ+ZEg/Zrkatp5D8hxA6GSkY/X1bAq8UGTRLgvGauupFXZNagksapq7c3mLKc61pgT
	W04XYkNbfJY0wCbo=
X-Received: by 2002:a05:622a:1304:: with SMTP id v4mr1437424qtk.359.1643969786316;
        Fri, 04 Feb 2022 02:16:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2TXJ0s1rlaWSCh2OEjH8qyroiewmKF3GllKrv2lydSpgqYh14gVmD3JrQijzeU0KpIuNH5w==
X-Received: by 2002:a05:622a:1304:: with SMTP id v4mr1437415qtk.359.1643969786041;
        Fri, 04 Feb 2022 02:16:26 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id b16sm97103qtk.84.2022.02.04.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 02:16:25 -0800 (PST)
Message-ID: <9c95d09f91ebbbb702261765dccaf81852d479db.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: use nla_parse_nested
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Fri, 04 Feb 2022 11:16:21 +0100
In-Reply-To: <a83209f-7839-d87f-5d27-fd337cd972c@linux.intel.com>
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
	 <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net>
	 <20220130043318.GA7781@dhcp-10-157-36-190>
	 <8339d9dc-4055-57c9-9c97-9ca4075c7496@tessares.net>
	 <a83209f-7839-d87f-5d27-fd337cd972c@linux.intel.com>
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

On Wed, 2022-02-02 at 16:38 -0800, Mat Martineau wrote:
> On Mon, 31 Jan 2022, Matthieu Baerts wrote:
> 
> > Hi Geliang,
> > 
> > On 30/01/2022 05:33, Geliang Tang wrote:
> > > Hi Matt,
> > > 
> > > Thanks for your review.
> > > 
> > > I don't know why this commit didn't show in the patchwork. The CI seems to
> > > have complained about it.
> > 
> > It seems the issue was on kernel.org side, now fixed: your patch is on
> > patchwork and lore.
> > 
> > > On Sat, Jan 29, 2022 at 12:53:20PM +0100, Matthieu Baerts wrote:
> > > > Hi Geliang,
> > > > 
> > > > On 29/01/2022 07:26, Geliang Tang wrote:
> > > > > NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'.
> > > > 
> > > > Was it always the case for 'ip mptcp'? I mean, we cannot break the user API.
> > > > 
> > > > And even if it was always the case for 'ip mptcp', there could be other
> > > > tools not using NLA_F_NESTED. Maybe we can ignore them in this specific
> > > > case but I'm not sure.
> > > 
> > > I think now is the right time to switch to the new API: nla_parse_nested.
> > > Since now no other tool uses our mptcp netlink yet, only 'ip mptcp' and
> > > 'pm_nl_ctl'. There's no need to consider about the compatibility.
> > 
> > I would like to only consider Open-Source tools but I don't think we
> > can. It is unlikely someone wrote a new tool not using NLA_F_NESTED but
> > I don't think we can be 100% sure. This is an uAPI break to change this
> > I think, no?
> > 
> > > The old
> > > API - nla_parse_nested_deprecated - is reserved for the compatibility of
> > > the netlinks that already have some user tools using its interface in the
> > > non-NLA_F_NESTED way. We are not the case.
> > > 
> > > Switch to the new API can force the user tools to use the NLA_F_NESTED way
> > > from now on. That makes sure no user tool uses the non-NLA_F_NESTED way for
> > > our mptcp netlink. Otherwise, one day the old API will be abandoned, and
> > > then if there're some user tools use the non-NLA_F_NESTED way, we will have
> > > to deal with the compatibility at that time. If we switch to the new API
> > > now, we can avoid this potential trouble.
> > 
> > I guess the compatibility will need to be kept of a bit of time. This
> > function is used in 250+ places in the kernel. I guess it has the
> > "deprecated" word in the name to clearly indicate "you should not use
> > that for new features" but not to say "in a few months, we will drop
> > this, deal with it now.", no?
> > 
> 
> It seems like the meaning of "deprecated" is the former ("don't add new 
> calls to this")... but we did add our use of the function in 2020 after it 
> was already deprecated! Given the "do not break userspace" rule for kernel 
> changes, I don't expect the deprecated to go away and for now I think 
> we should leave it unchanged. When we discuss patches at this week's 
> meeting I'll see if others agree.

All known users (self-tests and iproute2) have NLA_F_NESTED since the
first implementation and I doubt there are other user-space users out
there.
 
Still the downside of breaking user-space are quite bad, and there are
other in kernel users of the deprecated api added even later then
MPTCP.

I think we can keep the existing code.

Cheers,

Paolo

