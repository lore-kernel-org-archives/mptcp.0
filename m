Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E110170
	for <mptcp@lists.linux.dev>; Sun,  4 Jul 2021 13:33:35 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id y4so13946602pfi.9
        for <mptcp@lists.linux.dev>; Sun, 04 Jul 2021 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kmTHLKYe7uN/HHD833T9elNqKTkZ445a6iSqpPqctYI=;
        b=WmkvO46u0eH3efciHLO00/eGk4YxD9EiZzsUVUhJi+zF8htkowH3u5rWRteWzW4Y4O
         jLaRbQh4E0O3kR1mumNtQwRngGslHtSFT56Rr/R0ONOJ5rhgle3ELXnK+JA4jO3xjEUV
         wPLaGLpRCRKr8l5Wjkp4tUAxCyFvIKOovMWjhVVHqNNP8nOg6xrE1/9ZanwGPygtZ5N/
         GzCH3wpclWgXN0b5hPSdK0GDumopXYYo52AQCIhHsxJMNTiQrWUBBA3ObMqBfzMyJlDb
         PRn09Wb2d6UL83vIg/04RuMIkW7R/JjB3nbJUvC2amWsSYKPPyiBQHYIEIDbFi2XRCut
         rcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kmTHLKYe7uN/HHD833T9elNqKTkZ445a6iSqpPqctYI=;
        b=L0zQ9mnOaiVgPTx+53e0HtIDqj9tQFL3tMXPSqNNdJFBnMQA+C26dKP2GS6Nc3OnKS
         51Fmx6Ozx6+czwYg6jLeFyOHtheRbeLkXPWJjWd/Z45vm+Da/rD/vLAOAMVqofBLfmna
         IpwyqsRdpAFs2MkXUjfCoWZlBrLPpvbJQH+POl8X44VRW45b5ZaCNqhqO6TaN5+iOH29
         czw6isCLHjuXU5wt/4RRQNY4clNTalRNgcB/mrrkSTlCFUa35zYsAl6+gf5j0viiGtFu
         YhvIEHOvc/XY6V07/OvsnqQr88dUpjiOQYRyj3LTTo4WQbFPQ8VYx7YWmrSroSMR3flO
         bFlg==
X-Gm-Message-State: AOAM531opwiekrbeBKzfo/qCcp4SMjNGzfPXDiGKsl3OntT6L+uoaNzC
	HsNANqHS7loi+nSZjCsOmno=
X-Google-Smtp-Source: ABdhPJz0udZB2GaWgVkA667w2T9OAr9Ou+h7u+QEeVNoOzuY405q+y4T4O+jlAoQ/+l/JVCs+Y5cgg==
X-Received: by 2002:a63:5912:: with SMTP id n18mr10513858pgb.108.1625405615365;
        Sun, 04 Jul 2021 06:33:35 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:35:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id e1sm9572761pfd.16.2021.07.04.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 06:33:34 -0700 (PDT)
Date: Sun, 4 Jul 2021 06:33:31 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev,
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
Message-ID: <20210704133331.GA4268@hoboy.vegasvil.org>
References: <20210630081202.4423-1-yangbo.lu@nxp.com>
 <20210630081202.4423-9-yangbo.lu@nxp.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630081202.4423-9-yangbo.lu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jun 30, 2021 at 04:11:59PM +0800, Yangbo Lu wrote:
> Since PTP virtual clock support is added, there can be
> several PTP virtual clocks based on one PTP physical
> clock for timestamping.
> 
> This patch is to extend SO_TIMESTAMPING API to support
> PHC (PTP Hardware Clock) binding by adding a new flag
> SOF_TIMESTAMPING_BIND_PHC. When PTP virtual clocks are
> in use, user space can configure to bind one for
> timestamping, but PTP physical clock is not supported
> and not needed to bind.

Would it not be better to simply bind automatically?

Like this pseudo code:

	if (hw_timestamping_requested() && interface_is_vclock()) {
		bind_vclock();
	}

It would be great to avoid forcing user space to use a new option.

Especially because NOT setting the option makes no sense.  Or maybe
there is a use case for omitting the option?


Thoughts?

Thanks,
Richard
