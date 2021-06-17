Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD472
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 18:27:52 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id nd37so11623284ejc.3
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z9dDka7WqooF8QCzzctsFQ5AKA9e87F9WYFEk1ZSQcs=;
        b=AyaTj1aLjzpje1OtpqcJshH5hFvoLUhyOYXtR59yQuHG27PVY7Rd7fRhPV1SqeOEvF
         W4iuM/Sc7iDgwNK4ExCcYGQzPYwi5JEGEvgpVh9TBrkdMDHekt6NxEaaUvJpqAyV3HE9
         jhUOEdDntyO7yrxvC1JFGSt/m6hmeCN2UejRfoPxewkZzN8M3ukSsdx/1FaSPV4h7Ny/
         y1k/KRm+W3/G7kCbJCGsq0DcEOReF6xsxVsbIFT9ZkuE00w0r+d2nHyEGRuv+xvL5QL5
         40Nnt9eMlxJACYj3NaH/2iqCEsmYX/cKKOvqFA+Xhxq0HnhEHPE3wV3MjneUxti535ml
         whYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z9dDka7WqooF8QCzzctsFQ5AKA9e87F9WYFEk1ZSQcs=;
        b=ptt+1CbH7d4g+w8RrjPtMJIgqLr2h6YgOJbpv8L2JT8AZNGHU5z/IWUbgrSGHvBfMc
         RRsyQYHbTSj4M0eycQll4xhNkOXF5vcRTPiGHt4NTQNDW04d0Apa8AjK6hXSRbpWtVkJ
         MEylnTZGNeibJVVPSyUS8kOk472Wm0TZg/Ha0xOQKDumkoPTHjbp2BSufHg9XgJwasXJ
         8TuX4EvH4S9hfyomH2WP5ukiDcalP7OFluO/bS/9KhMXkMEfrRV8rdBorr/GVRjVaZE7
         Lj3NonfZVXEXmQP1N6F3biEOrWTr0iMTw+gaUdvwK52BM5wHFBzKp0n8BumzbN2zHZhi
         rEog==
X-Gm-Message-State: AOAM533vJvJRfFt5ZtmIsnqMcl8/hyHkAiHe/e6Bl5NT9eGUSmtGsT+y
	iYJzGHhKex6OXrli+twwYtU=
X-Google-Smtp-Source: ABdhPJypw9hZOdaqWcpGkUc3xFICl20D/p5X8o0IST2ZLxYVKIwHB4cA0WK4vA9Y4STPcKtfNnxTzA==
X-Received: by 2002:a05:6402:1355:: with SMTP id y21mr1917680edw.136.1623954471027;
        Thu, 17 Jun 2021 11:27:51 -0700 (PDT)
Received: from localhost ([185.246.22.209])
        by smtp.gmail.com with ESMTPSA id r23sm34618edy.13.2021.06.17.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:27:50 -0700 (PDT)
Date: Thu, 17 Jun 2021 20:27:45 +0200
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
Subject: Re: [net-next, v3, 02/10] ptp: support ptp physical/virtual clocks
 conversion
Message-ID: <20210617182745.GC4770@localhost>
References: <20210615094517.48752-1-yangbo.lu@nxp.com>
 <20210615094517.48752-3-yangbo.lu@nxp.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615094517.48752-3-yangbo.lu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 15, 2021 at 05:45:09PM +0800, Yangbo Lu wrote:

> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 3f388d63904c..6949afc9d733 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -46,6 +46,9 @@ struct ptp_clock {
>  	const struct attribute_group *pin_attr_groups[2];
>  	struct kthread_worker *kworker;
>  	struct kthread_delayed_work aux_work;
> +	u8 n_vclocks;

Hm, type is u8, but ...

> +	struct mutex n_vclocks_mux; /* protect concurrent n_vclocks access */
> +	bool vclock_flag;
>  };
>  

>  #define info_to_vclock(d) container_of((d), struct ptp_vclock, info)
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 1d108d597f66..4b933dc1b81b 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -69,6 +69,11 @@
>   */
>  #define PTP_PEROUT_V1_VALID_FLAGS	(0)
>  
> +/*
> + * Max number of PTP virtual clocks per PTP physical clock
> + */
> +#define PTP_MAX_VCLOCKS			20

Only 20 clocks are allowed?  Why?

Thanks,
Richard
