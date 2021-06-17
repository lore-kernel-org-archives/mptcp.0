Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5172
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 17:32:46 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id g8so11192970ejx.1
        for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3i2scYylnSG4Z6Xt/QfleyGEEfWXFHNAywICtigK1cw=;
        b=tniGSWpJZH+WdHXyBhV8MvePfO1Ws4QdjS9f2FgYpJrTpYlNvAJvDHJGD+gQJq7p5V
         FTQRB35xGmjTph+Vs4BmhjhkVGwEW2r0D1NBa14cJoWO/+a/mPXGeviuuExP+AcOjUNk
         3hvMC+mUMpzvN1LK9sOR4QId5R7LOIlutiSOeOv+9yeOgWRD+57/JVlQi9e4OcBkjOhQ
         2zZ8ZJPNjY5QLbqqCjpnk0Q2nBGPEQtLWkPo9LbRkbrfPjB3L3v3+Di/JpmxalYC25xI
         EJjZjaNxpHNeMkX/Gsaa31hEm15Jxo5ybpLxQR3GIhwZt0uYzvvqPnqSI7MdBsWxEj2Z
         VLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3i2scYylnSG4Z6Xt/QfleyGEEfWXFHNAywICtigK1cw=;
        b=Dk5WVZL2Zit+4ycxxFMMLjvtf/WhXXJx3Jcyfr8sJly/tXgxG/QQRH8d+y6Sept1SA
         970yk7YC/eN2S1WkGDqJqDSi82s3H6vfi/mcG1+4tSOxgM0Q7pUj2lFEcyISCPt7azvv
         ZZCEStfgexYwHcpzgB+fYaqE58YoD7stVvlLUe/12WNlBSUKADscb4WRHoSfMldexMtM
         ClqQwzPRbHjvNGqoTOT96LumCGVPy7wbJsCcPwbAbBLwThO3io+zApDShkpLfqZ4diL1
         1dB3qryT2903ve7kLUv5ZGVOy5Ta4RgOoQzi9kOLhZCo3rwBa6fDq/dw+SwjSDMMf+Vm
         /2Ig==
X-Gm-Message-State: AOAM530wsCs9Tik2xM5gh+qUJhdC4f2q3armQKgDVnPud7uNSw9Szd4c
	iilkFEMzl3KvTdamZARk+Ao=
X-Google-Smtp-Source: ABdhPJx1+lax+LYVkXfY/djET+bMTKIUY+oPtfmMN3+W7WnRo7laNBtIDQAAmzELk38/ltYs3OXCsw==
X-Received: by 2002:aa7:dd8d:: with SMTP id g13mr8394054edv.30.1623951163866;
        Thu, 17 Jun 2021 10:32:43 -0700 (PDT)
Received: from localhost ([185.246.22.209])
        by smtp.gmail.com with ESMTPSA id s4sm4779099edu.49.2021.06.17.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:32:43 -0700 (PDT)
Date: Thu, 17 Jun 2021 19:32:38 +0200
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
Subject: Re: [net-next, v3, 01/10] ptp: add ptp virtual clock driver framework
Message-ID: <20210617173237.GA4770@localhost>
References: <20210615094517.48752-1-yangbo.lu@nxp.com>
 <20210615094517.48752-2-yangbo.lu@nxp.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615094517.48752-2-yangbo.lu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 15, 2021 at 05:45:08PM +0800, Yangbo Lu wrote:
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 8673d1743faa..3c6a905760e2 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -3,7 +3,7 @@
>  # Makefile for PTP 1588 clock support.
>  #
>  
> -ptp-y					:= ptp_clock.o ptp_chardev.o ptp_sysfs.o
> +ptp-y					:= ptp_clock.o ptp_vclock.o ptp_chardev.o ptp_sysfs.o

Nit: Please place ptp_vclock.o at the end of the list.

>  ptp_kvm-$(CONFIG_X86)			:= ptp_kvm_x86.o ptp_kvm_common.o
>  ptp_kvm-$(CONFIG_HAVE_ARM_SMCCC)	:= ptp_kvm_arm.o ptp_kvm_common.o
>  obj-$(CONFIG_PTP_1588_CLOCK)		+= ptp.o

> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 6b97155148f1..3f388d63904c 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -48,6 +48,20 @@ struct ptp_clock {
>  	struct kthread_delayed_work aux_work;
>  };
>  
> +#define info_to_vclock(d) container_of((d), struct ptp_vclock, info)
> +#define cc_to_vclock(d) container_of((d), struct ptp_vclock, cc)
> +#define dw_to_vclock(d) container_of((d), struct ptp_vclock, refresh_work)
> +
> +struct ptp_vclock {
> +	struct ptp_clock *pclock;
> +	struct ptp_clock_info info;
> +	struct ptp_clock *clock;
> +	struct cyclecounter cc;
> +	struct timecounter tc;
> +	spinlock_t lock;	/* protects tc/cc */
> +	struct delayed_work refresh_work;

Can we please have a kthread worker here instead of work?

Experience shows that plain work can be delayed for a long, long time
on busy systems.

> +};
> +
>  /*
>   * The function queue_cnt() is safe for readers to call without
>   * holding q->lock. Readers use this function to verify that the queue
> @@ -89,4 +103,6 @@ extern const struct attribute_group *ptp_groups[];
>  int ptp_populate_pin_groups(struct ptp_clock *ptp);
>  void ptp_cleanup_pin_groups(struct ptp_clock *ptp);
>  
> +struct ptp_vclock *ptp_vclock_register(struct ptp_clock *pclock);
> +void ptp_vclock_unregister(struct ptp_vclock *vclock);
>  #endif

> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> new file mode 100644
> index 000000000000..b8f500677314
> --- /dev/null
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * PTP virtual clock driver
> + *
> + * Copyright 2021 NXP
> + */
> +#include <linux/slab.h>
> +#include "ptp_private.h"
> +
> +#define PTP_VCLOCK_CC_MULT		(1 << 31)
> +#define PTP_VCLOCK_CC_SHIFT		31

These two are okay, but ...

> +#define PTP_VCLOCK_CC_MULT_NUM		(1 << 9)
> +#define PTP_VCLOCK_CC_MULT_DEM		15625ULL

the similarity of naming is confusing for these two.  They are only
used in the .adjfine method.  How about this?

  PTP_VCLOCK_FADJ_NUMERATOR, or even PTP_VCLOCK_FADJ_SHIFT (see below)
  PTP_VCLOCK_FADJ_DENOMINATOR

> +#define PTP_VCLOCK_CC_REFRESH_INTERVAL	(HZ * 2)

Consider dropping CC from the name.
PTP_VCLOCK_REFRESH_INTERVAL sounds good to me.

> +static int ptp_vclock_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct ptp_vclock *vclock = info_to_vclock(ptp);
> +	unsigned long flags;
> +	s64 adj;
> +
> +	adj = (s64)scaled_ppm * PTP_VCLOCK_CC_MULT_NUM;

Rather than

    scaled_ppm * (1 << 9)

I suggest

    scaled_ppm << 9

instead.  I suppose a good compiler would replace the multiplication
with a bit shift, but it never hurts to spell it out.

> +	adj = div_s64(adj, PTP_VCLOCK_CC_MULT_DEM);
> +
> +	spin_lock_irqsave(&vclock->lock, flags);
> +	timecounter_read(&vclock->tc);
> +	vclock->cc.mult = PTP_VCLOCK_CC_MULT + adj;
> +	spin_unlock_irqrestore(&vclock->lock, flags);
> +
> +	return 0;
> +}

Thanks,
Richard
