Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA393480
	for <mptcp@lists.linux.dev>; Sat,  7 Aug 2021 14:23:03 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id q2so11165126plr.11
        for <mptcp@lists.linux.dev>; Sat, 07 Aug 2021 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9A35ntPVTpy6pf5hhiO3MIDTUkr5r9FQm0lIbQCzDw=;
        b=PF9nV00K0eXuUGd3incbg1xZbDJu8rd6s6DbDcpOxh1l0mTWDqsFEpXH0lAiZl7Uas
         qEgYWHknaJucHQOMKIqkgtI0/yIdggm0I0ytrljbgUvzZEaVcaj4IDsR5cifY0PNMbM/
         WR7GbO8Rid5wVVSanL6oQfJpy+Q6lgmdLmpfn7FUNBwRB98wUhzOXsxeuFGmkmKJFhUm
         pjFvvZocjsGKXSmu29kS1OOr1VQ2AiQuUpOznNKXr5I+YVkU0L2CS77HlaRH+FvjNqit
         jWYI81WEjkjGA967G7RUHGliTJ/J3VWJ3PkeHY8cOsTkzecIy0w6wsgJhN+h5d3eMHst
         TiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9A35ntPVTpy6pf5hhiO3MIDTUkr5r9FQm0lIbQCzDw=;
        b=FQ4GuK3F1H+WYQpXu3/xAck4E4o7zvOHfWd568R9uKgTgmSefX2kboj09PTRRvqWn0
         P9imaWUGPBGy9YIeR85X6vzmbLuuU3DaQ+C8JgTF3z0xPVxp1wShnD2tdvGQdlkuslvM
         Rlo9e+nhd9bZxPq35uLX19mp5a/WRpjai/Hk7qnGSFQCABp6GH8HqzELqLfNBSUJ3Chc
         RhN5JB0CBabtw6H4pc6jll4OfLZkd32uwFDco2J1VgjShK10ldQXLRuTOVLC2Q2SIyGp
         Wqh5o9X7z2tMhuyYICi5Vg0mLBCdl5zGZzc4hyQAT3c1x8p0hHcjfjbFyCOrMEAJoyN4
         dS9Q==
X-Gm-Message-State: AOAM531Ngl05jqfKkZgBzREVe3dbyKFJdc4KE8cCmveRT3nnFsfeGa4l
	6R44ZkdghxeILkVHuymmo7Y=
X-Google-Smtp-Source: ABdhPJy92k9k5qZ3bBCOKumWsKbrfTfPUPSu3kLMSRUcWn8KbV5+YJehLWBXAO5z+tU5vEQ8x37dhA==
X-Received: by 2002:a65:67c6:: with SMTP id b6mr189426pgs.332.1628346182845;
        Sat, 07 Aug 2021 07:23:02 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:2163:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id b17sm15707800pgl.61.2021.08.07.07.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 07:23:02 -0700 (PDT)
Date: Sat, 7 Aug 2021 07:22:59 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, netdev@vger.kernel.org,
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
Message-ID: <20210807142259.GB22362@hoboy.vegasvil.org>
References: <20210630081202.4423-1-yangbo.lu@nxp.com>
 <20210630081202.4423-3-yangbo.lu@nxp.com>
 <87r1f6kqby.fsf@vcostago-mobl2.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1f6kqby.fsf@vcostago-mobl2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 06, 2021 at 06:15:29PM -0700, Vinicius Costa Gomes wrote:

> >  int ptp_clock_unregister(struct ptp_clock *ptp)
> >  {
> > +	if (ptp_vclock_in_use(ptp)) {
> > +		pr_err("ptp: virtual clock in use\n");
> > +		return -EBUSY;
> > +	}
> > +
> 
> None of the drivers (that I looked) expect ptp_clock_unregister() to
> return an error.
> 
> So, what should we do?
>  1. Fix all the drivers to return an error on module unloading (that's
>  usually the path ptp_clock_unregister() is called)?
>  2. Remove all the PTP virtual clocks when the physical clock is
>  unregistered?

This:

 3. Let the vclocks hold a reference to the underlying posix dynamic clock.


Thanks,
Richard
