Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D917F
	for <mptcp@lists.linux.dev>; Sat,  7 Aug 2021 20:56:47 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id j3so11966397plx.4
        for <mptcp@lists.linux.dev>; Sat, 07 Aug 2021 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aDPS+XgQ7hE35dLkgpgBaogFW2sWOGSB2/ljVEyiaXE=;
        b=QkN+d27NFol80qPk1x1PjEoadt867p+EnfVJEqQr3mIcvz03YJ3gO1J6bUhpUlgSBC
         HRu9ZMDPANHSGwqKlJ8kkTfoUCwVQ4k10powPrORmLPwjpXjciqPdQz3SjKEG3GbQJL9
         YeQwJOzEDSrDTavXdi928gnCdhu0CmelWuE5FttBfOeYNG+J2R91b5yAniGIQlJt1Tf8
         69Ha4VqwQtHl1irko2AgAAuQcTISDnNRWJKbMrj3qOu+uK//g4/psooaxzmqYYUXISXO
         5tS6uCo4XXLB91hv981M3AsXAqYVdHscQrx5l55M9tn4kj1LoQriaQdO9y0afbLI881u
         JC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aDPS+XgQ7hE35dLkgpgBaogFW2sWOGSB2/ljVEyiaXE=;
        b=GxX5yewM9U8x+KMGFGTyrZp7En9HroR1a0dagf0BFN5v+mDsV4AMdGdrIMOctKPPsS
         2cLQPvhx20wQguwH34entFunnWiUJMoTN9922Msw4gVhM+5BKFib7MMFk/P2i86cfsNI
         hkP2RLGhefgYFc1WCKwa+tgEInDh+UuqYxMuGwSwM+9GS7kdDq+m8mg9wB+gM7K0qRk5
         UNeIelusglbpH+/F+nYsirU9TO6GdZgQQC6cstz5wnQUm9hmqcn67d65jhfe3IidutRR
         C7LFi3haDsd0my97YnHZYmriHaZkdMf7VNzpT+E2AsbTyAy6/T5GOu5tLTi//e66JB7n
         QTHA==
X-Gm-Message-State: AOAM530tYl2DbTi8iZoIdW796tgtdA8AtdVll0x+oXDqGKgNgsvEUsvY
	ZkDzcWnPJA+wTD1QXOChLCs=
X-Google-Smtp-Source: ABdhPJwYep8tTUVrpoNuljGQS+T87KcHeKmlJQ8E1VasglxRR6sopaSE2SP5GJqcCuWgm1dBo0iYFA==
X-Received: by 2002:a17:90a:5982:: with SMTP id l2mr17279489pji.18.1628369807552;
        Sat, 07 Aug 2021 13:56:47 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:2163:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id b15sm16955974pgm.15.2021.08.07.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 13:56:47 -0700 (PDT)
Date: Sat, 7 Aug 2021 13:56:44 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
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
Message-ID: <20210807205644.GD22362@hoboy.vegasvil.org>
References: <20210630081202.4423-1-yangbo.lu@nxp.com>
 <20210630081202.4423-3-yangbo.lu@nxp.com>
 <87r1f6kqby.fsf@vcostago-mobl2.amr.corp.intel.com>
 <20210807142259.GB22362@hoboy.vegasvil.org>
 <20210807144332.szyazdfl42abwzmd@skbuf>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807144332.szyazdfl42abwzmd@skbuf>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Aug 07, 2021 at 05:43:32PM +0300, Vladimir Oltean wrote:
> >  3. Let the vclocks hold a reference to the underlying posix dynamic clock.
> 
> So even if the vclock holds a reference to the underlying POSIX clock,
> that won't prevent the hardware driver from unbinding, and further
> gettime() calls on the vclock from faulting, will it?

Oh, your are right.  The vclocks call the real PHC clock's methods
directly, not through the posix dynamic clock layer.

> What about:
> 
> 4. Create a device link with the vclock being a consumer and the parent
>    clock being a supplier? This way, ptp_vclock_unregister() is
>    automatically called whenever (and before) ptp_clock_unregister() is.
> 
> https://www.kernel.org/doc/html/latest/driver-api/device_link.html

Sounds promising.

Thanks,
Richard
