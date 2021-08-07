Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8573480
	for <mptcp@lists.linux.dev>; Sat,  7 Aug 2021 14:43:36 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id z11so17532081edb.11
        for <mptcp@lists.linux.dev>; Sat, 07 Aug 2021 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KCNLnCUiZ+ov8onPR3PzcmV7yH057fWxJ3U1+LFsGFg=;
        b=QsEp3LsokWXgTBYa573FAuouSLXfRxMfWZmnKLl8UhRbZgh+Uo92IcVfwKVWPEbC3w
         u818UjNdH9gMLW/ea+WncjsGTRBbR9+gYQFUsVRbjwR2J8MQLLusyJJSIjU1IjvTeCkM
         NOTbwx2BVDTXSIQPyhlua3mkjm6DlEhS+wboajYVOZyzjJnUvrs2fk9XsyzZmzgFut9T
         XZJR5eg7f7MR0KvFwv5M/LQBOr7EPsC7WNNkc7BbRozHCWXA/lsl+2dHBOoLskpMHX5V
         olt2DFuKJxPZ3QcDCdtRFXScux7ld7X4ZQLsf9wfvF1SRNskOr+asXwPJ1X5eZj8pfSA
         Me0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KCNLnCUiZ+ov8onPR3PzcmV7yH057fWxJ3U1+LFsGFg=;
        b=IXKSpmLFi9ymKRmZwWT1pAYBs5NcAd4Pz5SZqcN75vp1/47q8yVes5R97GSRrsIcz8
         8+QnJG+36CARR3I3ELh64eYvBmekYIf/9vDULSleyxJ/c/+1dsojWgSMHrV5K1IzcHAk
         4yOwXrjIBWF2OkmwLSwVtDvXehTkuFB1LZl2QrmO3w3h+orF02nVrJW98QwIdL0IBtFg
         KZqEee94QE2NBDHX5WrZEyHwqeOhPF5nrleA7W+D0Thg526x+6jfdvF4vAXAJSvr5s5d
         lYTsM8Ssfk7gdpJqkLO5sfZdmPjYdu7MUcW2obzze5ENL7vyctcfBYxnKTuYm5otkDv3
         InVQ==
X-Gm-Message-State: AOAM530MfhIT8BX0OG0lUuszDMt8aFZV4kGbhNaB0AjcCDIiVrjrZ8qn
	/bUDt+5vJIte13IMu/XF0po=
X-Google-Smtp-Source: ABdhPJztTtlI6TKOgyeMDZCsy49dmZOxhDW7ufw1JqVFBH5TmTflfqph5UKt8P7Z/RD05A8J2QE4HA==
X-Received: by 2002:a05:6402:1719:: with SMTP id y25mr19430725edu.331.1628347414721;
        Sat, 07 Aug 2021 07:43:34 -0700 (PDT)
Received: from skbuf ([188.25.144.60])
        by smtp.gmail.com with ESMTPSA id k23sm3599454ejr.2.2021.08.07.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 07:43:34 -0700 (PDT)
Date: Sat, 7 Aug 2021 17:43:32 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Yangbo Lu <yangbo.lu@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Shuah Khan <shuah@kernel.org>, Michal Kubecek <mkubecek@suse.cz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Rui Sousa <rui.sousa@nxp.com>,
	Sebastien Laveze <sebastien.laveze@nxp.com>
Subject: Re: [net-next, v5, 02/11] ptp: support ptp physical/virtual clocks
 conversion
Message-ID: <20210807144332.szyazdfl42abwzmd@skbuf>
References: <20210630081202.4423-1-yangbo.lu@nxp.com>
 <20210630081202.4423-3-yangbo.lu@nxp.com>
 <87r1f6kqby.fsf@vcostago-mobl2.amr.corp.intel.com>
 <20210807142259.GB22362@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807142259.GB22362@hoboy.vegasvil.org>

On Sat, Aug 07, 2021 at 07:22:59AM -0700, Richard Cochran wrote:
> On Fri, Aug 06, 2021 at 06:15:29PM -0700, Vinicius Costa Gomes wrote:
> 
> > >  int ptp_clock_unregister(struct ptp_clock *ptp)
> > >  {
> > > +	if (ptp_vclock_in_use(ptp)) {
> > > +		pr_err("ptp: virtual clock in use\n");
> > > +		return -EBUSY;
> > > +	}
> > > +
> > 
> > None of the drivers (that I looked) expect ptp_clock_unregister() to
> > return an error.
> > 
> > So, what should we do?
> >  1. Fix all the drivers to return an error on module unloading (that's
> >  usually the path ptp_clock_unregister() is called)?
> >  2. Remove all the PTP virtual clocks when the physical clock is
> >  unregistered?
> 
> This:
> 
>  3. Let the vclocks hold a reference to the underlying posix dynamic clock.

So even if the vclock holds a reference to the underlying POSIX clock,
that won't prevent the hardware driver from unbinding, and further
gettime() calls on the vclock from faulting, will it?

What about:

4. Create a device link with the vclock being a consumer and the parent
   clock being a supplier? This way, ptp_vclock_unregister() is
   automatically called whenever (and before) ptp_clock_unregister() is.

https://www.kernel.org/doc/html/latest/driver-api/device_link.html
