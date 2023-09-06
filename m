Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C411CBD
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 23:10:44 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-34f2d7c1bc8so1219095ab.1
        for <mptcp@lists.linux.dev>; Wed, 06 Sep 2023 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694041844; x=1694646644; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYm4i3hdu7juwyOUQk1xpuXZZsw548ZwUyNloE+R6Ac=;
        b=yWAb2xBMrZIWTMsjvF99RLKyO9Qt5oz/oU0PF2n3t3m/OM81n5dGcM0cvnJU2hBELi
         DNnWLZkzaNQ52rDp0yOXglGSkyw8vIsK3Ckar3LtmBBP5wT1z9ffBN23zebuCM3boiUp
         BkZixXa/z/vYEsF2MtgM1I+tEpfz5W1ErkPGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694041844; x=1694646644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYm4i3hdu7juwyOUQk1xpuXZZsw548ZwUyNloE+R6Ac=;
        b=B5yxp3dWb1unYS+Fr9sJfw0+qn1LQo5r1VcuNsttsjeNh2MmSJtftwErrmwOoL2vHq
         +uVNm9bkKVxZ+nnfHDg+pxh3WuiM4Il8cacccLeV3gVq88DuLuMIbjVwkzw1vR+NQIKs
         vqqMOdpRz7wgBbOx6fbASymDKrKSIcPN+qO51n4CcX2LhUG7AZ7qAX0ogY8O+fjivpr/
         ALICv56mSU5lT5wQaR8Mw8oxsanPF3oY9X87rouSfkVeQOpMfxr0404E9naNPc8N052x
         9IkU4OUksvAahWfB7Lur1ybrHG+7DWrqJMJu/+W3gBSky/0GGL1KFz761kS66Xd3A03s
         FujA==
X-Gm-Message-State: AOJu0YwJqfLfPlXzJcJ6PoHZyvA13FSabLX8N9Sw+5OQEQXVG81Ddqkj
	v5LuEGxAhhLmRyl3rFSYjPi/SA==
X-Google-Smtp-Source: AGHT+IHNaizib5VvwK0oLEc0my890WJH2cjyEtGdhjY466dsxuMemrbybowAPHrFM9H94DX9Sflh3g==
X-Received: by 2002:a05:6e02:1bcf:b0:349:9745:89f with SMTP id x15-20020a056e021bcf00b003499745089fmr20615111ilv.17.1694041844112;
        Wed, 06 Sep 2023 16:10:44 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id o2-20020a056638124200b0042b669f5084sm5326529jas.62.2023.09.06.16.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:10:43 -0700 (PDT)
Date: Wed, 6 Sep 2023 23:10:42 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org,
	urezki@gmail.com
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <20230906231042.GA1296802@google.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
 <20230906143529.GB1127143@google.com>
 <ZPizxVT5s9JA5MPw@arm.com>
 <24f3d4fc-56c0-46bd-8e5b-af57f09fa777@paulmck-laptop>
 <ZPjxJJjuHJbPVyfT@arm.com>
 <38f21251-4911-4300-9b53-e390e621e68a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f21251-4911-4300-9b53-e390e621e68a@paulmck-laptop>

On Wed, Sep 06, 2023 at 03:02:45PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 06, 2023 at 10:37:40PM +0100, Catalin Marinas wrote:
> > On Wed, Sep 06, 2023 at 12:11:12PM -0700, Paul E. McKenney wrote:
> > > On Wed, Sep 06, 2023 at 06:15:49PM +0100, Catalin Marinas wrote:
> > > > On Wed, Sep 06, 2023 at 02:35:29PM +0000, Joel Fernandes wrote:
> > > > > On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> > > > > > On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > > > > > > The correct fix then should probably be to mark the object as
> > > > > > > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > > > > > > to not be reported but still be scanned until eventually the lower layers
> > > > > > > will remove the object from kmemleak-tracking after the grace period. Per the
> > > > > > > docs also, that API is used to prevent false-positives.
> > > > > > 
> > > > > > This should work as well but I'd use kmemleak_ignore() instead of
> > > > > > kmemleak_not_leak(). The former, apart from masking the false positive,
> > > > > > also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> > > > > > object shouldn't have any valid references to other objects, so not
> > > > > > worth scanning.
> > > > > 
> > > > > Yes I am also OK with that, however to me I consider the object as alive as
> > > > > long as the grace period does not end. But I agree with you and it may not be
> > > > > worth tracking them or scanning them.
> > > > 
> > > > I guess from an RCU perspective, the object is still alive. From the
> > > > kvfree_rcu() caller perspective though, it can disappear at any point
> > > > after the grace period, so it shouldn't rely on its content being valid
> > > > and referencing other objects (other than transiently e.g. in RCU list
> > > > traversal).
> > > > 
> > > > It probably only matters if we have some very long grace periods (I'm
> > > > not up to date with the recent RCU developments). In such cases, the
> > > > object still being scanned could introduce false negatives. That's my
> > > > reasoning for suggesting kmemleak_ignore() rather than
> > > > kmemleak_not_leak().
> > > 
> > > Very long RCU readers still result in very long RCU grace periods.  And,
> > > after some tens of seconds, RCU CPU stall warnings.  So don't let your
> > > RCU readers run for that long.  But you knew that already.  ;-)
> > 
> > That's still ok. I was more thinking of deferred freeing well past the
> > RCU readers completing.
> 
> Ah, that can happen.  Some kernels are built with CONFIG_RCU_LAZY=y, which
> delays freeing in order to reduce power consumption.  And kfree_rcu()
> will also delay for a bit.  But in both cases, a flood of callbacks
> should get things going again.
> 
> But an isolated kfree_rcu() might well see a few seconds delay.
> Saving your battery!  ;-)

I agree with both of you. I also think kmemleak_ignore() is the right thing
to do for kfree_rcu().

thanks,

 - Joel

