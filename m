Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEBF7C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656060047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqfCE86Bdfy5PqzY1173pw/zJRavGFJgIxJVzbZQrDQ=;
	b=QDLcw7G+rKKrKSXkO2ZA5vIXNzFyPjMm1PswzhOxlyc2D9DrQtJ7qSNNeSZb/IS/F3uhwe
	2nj3W0jaqwy6MmKS5TffGqMzIcLHt9CSGgv+tYIqRLhgmdFh7lh+G2YfY0PoTQf2K3TJNM
	wogxdtVFv5uRpNWeQfuXAkgyZiLZ+6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-RKg9U3oGN3SsgGX0qhbjFw-1; Fri, 24 Jun 2022 04:40:46 -0400
X-MC-Unique: RKg9U3oGN3SsgGX0qhbjFw-1
Received: by mail-wm1-f70.google.com with SMTP id 2-20020a1c0202000000b0039c94528746so2742423wmc.6
        for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 01:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uqfCE86Bdfy5PqzY1173pw/zJRavGFJgIxJVzbZQrDQ=;
        b=YDu1dOVJux7SJiOJHBfXFM6mfYQNQtroeAHjcdplUyCk0OKOUTbxxzyn1KPUP8Obx0
         tL4eypKnQrhRCTaYPl01dhJS5V6z+fTlFZiu3dm/y8WaboKyvcJ6VjpuUnkkk5d/xhe7
         thiROIoAuRmXR6PstpOApmPCPHyyAcuYsaOWgLZi+/9nfI60O+oaLywH1HyflXUdXQ8Y
         FYuwbydr2LVfq5RA5CKyI1/0kR+hJN65d+g+kzjdcpmnaBlDqYWthh1Ogg7IyyV8Ylwl
         gFn/DBQiuvWUsaFefr7GTks21ME2H+G8O9/I6FR41VWe6wTaZhJ6/5xEX6sSj4WxdEic
         WqyA==
X-Gm-Message-State: AJIora/zedAm4JJuar6M/FYNz8Ok1vSd8wsIweq9ewrnC95NfARaZUCX
	t42Em0tQdwOUZgyJqDooZh9ZWj662KHTfoPWPzQhGxM3imbE7p9pNGcBHMIYt2n9wZQsG3puQe1
	86hEL+nbTD0BY2pE=
X-Received: by 2002:a5d:456e:0:b0:21b:9219:b28a with SMTP id a14-20020a5d456e000000b0021b9219b28amr11995841wrc.497.1656060045002;
        Fri, 24 Jun 2022 01:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u29bNuuiHq+s/LUI6+Uz1j1JxJIqDLtbXWxMAjAo6hH84y9k1COg+Im1lMqvYHOEzIAgwMlA==
X-Received: by 2002:a5d:456e:0:b0:21b:9219:b28a with SMTP id a14-20020a5d456e000000b0021b9219b28amr11995817wrc.497.1656060044686;
        Fri, 24 Jun 2022 01:40:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b0039c4d022a44sm2146807wmn.1.2022.06.24.01.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:40:44 -0700 (PDT)
Message-ID: <437af8add242099c84cf106108ab4988a65010ff.camel@redhat.com>
Subject: Re: Should the MIB_RMSUBFLOW commit go to -net?
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>, Geliang Tang <geliang.tang@suse.com>, 
	mptcp@lists.linux.dev
Date: Fri, 24 Jun 2022 10:40:43 +0200
In-Reply-To: <ad151d35-f094-675d-5ced-71df98ea5857@linux.intel.com>
References: <ad151d35-f094-675d-5ced-71df98ea5857@linux.intel.com>
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
Content-Transfer-Encoding: 7bit

On Thu, 2022-06-23 at 16:19 -0700, Mat Martineau wrote:
> I was preparing the patches we had agreed to be ready for net-next in the 
> meeting today:
> 
>          - [f1eb3f2cb4d2] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy (Geliang Tang)
>          - [f3c5dde10031] selftests: mptcp: userspace pm address tests (Geliang Tang)
>          - [92378ff55152] selftests: mptcp: userspace pm subflow tests (Geliang Tang)
>          - [1908a4ccaa2c] selftests: mptcp: avoid Terminated messages in userspace_pm (Geliang Tang)
>          - [bac5548c7c47] selftests: mptcp: update pm_nl_ctl usage header (Geliang Tang)
> 
> I think the selftest commits are definitely best for net-next. But for the 
> first one ("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy"), should we add
> 
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> 
> and include that in a patch set for -net? Seems like it would be good to 
> improve the MIB accuracy with the userspace PM in 5.19.
> 
> Link to commit in patchwork: 
> https://patchwork.kernel.org/project/mptcp/patch/723d61d82730b996132925686b43f9c3c79bc747.1655355422.git.geliang.tang@suse.com/
> 
> 
> If that patch goes to -net, it would also require waiting until the next 
> net/net-next sync before sending the selftest patches listed above.

I would vote for keeping the process simple and keeping all the above
patches on net-next.

If we choose otherwise, I think we should also update a bit the
("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy") commit message to
something more tuned for -net. Alike: "The user-space patch manager
currently miss the required update of the subflow destruction MIB,
address the issue "...

/P

