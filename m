Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B270
	for <mptcp@lists.linux.dev>; Mon,  5 Jul 2021 18:44:05 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id b12so16242381pfv.6
        for <mptcp@lists.linux.dev>; Mon, 05 Jul 2021 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9B674I/+/MTqKFyAT06vY9UMY1nLlYo82cmty5TYFU=;
        b=U76TMLXOV4pdFDQFVwfpz4YW7eAM3VMSh+sg+dkwJDnf5Wyu2diLJptad2GOzoaJhj
         9K27nXn0+L6f/KD5uuiR7ez//OnVNMSyK77IQ7ytOlmH6cDgOYcefVnITNhc4efdDhmC
         eW6mYSiUh26B1kMlcJ1VZJOWZpWRL+cIs4OkuPEut6GN8jaSsojbfSIZBXruzABLFXa4
         LXn+hPgjIIVsIsCTY0uNkwbuX0fmjFuYJ/urIhLx7BrAhzSDiCVBqg46y7GXL4uKG+Jw
         QoFDNEJwBjUrGaPSLLNZ1YASrGV/MQOMNJgLldQCac4k880XzGqFMF110w+TKtJHHDdC
         oO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9B674I/+/MTqKFyAT06vY9UMY1nLlYo82cmty5TYFU=;
        b=Yce14IP/qV0a4m5o2g6eyFuwU9tRmNfYe2md1R219ldtZ6cbZWsCwP/Fn4cpd0iQbd
         85wwj3QLwued6IAq1/xNMxB0hilSQx6orkHCzJxx24UwzqADzgR6b+HHBQ4nuQjyGpqo
         10xk2aCaE1wEruO3Y9TG+wmJlSNA9AmWXZwxJxtcDDlsPUKP3og8NXCFOgV0SkghdNmD
         xfMsxLvudT7S4flQkvNh4+XDXSYTt3mYopieqrtZGdw5x+Rhgm7MrTMjyV4S8Snl75Cd
         yedks7fcbbB5I5vwBeXrfy/W8YjkQQLjbVLIgjMu0C1CsI/Vd4EWEMay3G8rmzTQH4S1
         +T7g==
X-Gm-Message-State: AOAM530YTALnGoa0TIDDUyDXBFbFPeF0NhtQlpYHbhB68yqWkzk+dUq+
	P0wi/WN50HZOuk2v8CrgfKU=
X-Google-Smtp-Source: ABdhPJyFPZFlKa0i+0rwZcF+zTp1p31HnTBY1c4ty+efUwLDX1BzuLrPZs1aVYGImcZW2oWQ6iM2Jg==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr17197215pgj.238.1625510644823;
        Mon, 05 Jul 2021 11:44:04 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:35:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 31sm4292038pgu.17.2021.07.05.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 11:44:04 -0700 (PDT)
Date: Mon, 5 Jul 2021 11:44:01 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: "Y.b. Lu" <yangbo.lu@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Shuah Khan <shuah@kernel.org>, Michal Kubecek <mkubecek@suse.cz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Rui Sousa <rui.sousa@nxp.com>,
	Sebastien Laveze <sebastien.laveze@nxp.com>
Subject: Re: [net-next, v5, 08/11] net: sock: extend SO_TIMESTAMPING for PHC
 binding
Message-ID: <20210705184401.GA16128@hoboy.vegasvil.org>
References: <20210630081202.4423-1-yangbo.lu@nxp.com>
 <20210630081202.4423-9-yangbo.lu@nxp.com>
 <20210704133331.GA4268@hoboy.vegasvil.org>
 <DB7PR04MB50174906EE8CCEB4A02F4C17F81C9@DB7PR04MB5017.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR04MB50174906EE8CCEB4A02F4C17F81C9@DB7PR04MB5017.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 05, 2021 at 08:19:30AM +0000, Y.b. Lu wrote:
> When several ptp virtual clocks are created, the ptp physical clock is guaranteed for free running.
> 
> What I think is, for timestamping, if no flag SOF_TIMESTAMPING_BIND_PHC, the timestamping keeps using ptp physical clock.
> If application wants to bind one ptp virtual clock for timestamping, the flag SOF_TIMESTAMPING_BIND_PHC should be set and clock index should be provided.
> After all, several ptp virtual clocks created are likely for different timescale/use case. There should be a method for any of applications to select the right one to use.
> 
> Does it make sense?

Yes, indeed.  I totally forgot that the user space PTP stack has
network sockets bond to interfaces, and they are completely separate
from the PHC clockid_t.  Need more sleep...

Thanks,
Richard
