Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0F2C80
	for <mptcp@lists.linux.dev>; Thu, 25 Nov 2021 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637828917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UshZFRpLRyqLt9YYkgRKZXj37baEMoIIX3aR9HIOnvc=;
	b=iL9082nYDIEiOfTsqtlbIQrlEngcIxVpH33OY3MbPGaOyuFRey4ZmCJD2IDFhPa2hTKzkw
	Q0ZtPyYeczkQqRZ1SLhxuqsDPqLyZ4OBLuq0BeiXU+zqkz6T+yBoSLaK90OPeqINjVtF0K
	xEedMLewfasFIrTRCUFA4s6KG53P7RQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-AUiNfU5nM2WkTYWV1HJKyw-1; Thu, 25 Nov 2021 03:28:34 -0500
X-MC-Unique: AUiNfU5nM2WkTYWV1HJKyw-1
Received: by mail-wm1-f71.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so2799006wmg.9
        for <mptcp@lists.linux.dev>; Thu, 25 Nov 2021 00:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UshZFRpLRyqLt9YYkgRKZXj37baEMoIIX3aR9HIOnvc=;
        b=6KjKKVwIwSRGqaj0to0J9/UDfuRVEO4rhcNMGC5j0sTNi6xP1wjiDouS9a5RpyHoj9
         P548j7Mn4pipt8t/nW5jPliNOFJUyVnMpGkvVPVTEipOWA4vrMDVGHOd4elAOGttHlQH
         rNZB+CY4eYGey8heLk2NFfPivcwGeOni2BPwLMPJjKaxeK8xrsZ84BCZ/ydg/Sacllor
         K4uIgJs2TdE+CfvE0tCTNbIIJsfXEOwkVpgRROD+qcMzcTnJNDYFKOodnMKxSJ1PlkNE
         Z9/p8SJLhXG9HZ3Ckvi0iBtaZ5BLLzy/xyw8IeMqWpMKoaj5wPgeGO9YXq7NpaMJp2id
         fuaA==
X-Gm-Message-State: AOAM5301Y59a/FQkwgWCbe6z2FMUp3DgazyG0wJGTqhC8oXQYzpYdHKh
	lHWF7ty5tj20+UCzkHtct7R9KyLy5d8EPhno9E7rf+5fBpRiWkPetSnSwZG8f/RutOUOvzFSXit
	i3t74OVZkaTNYNKc=
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr5264907wme.188.1637828913268;
        Thu, 25 Nov 2021 00:28:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD71kXE2ebJYXT1vMbW3/gjEuk0F50CcXWm026izdoq8ypYu05C+LLNitAGZv1BhdirbKvDQ==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr5264883wme.188.1637828913050;
        Thu, 25 Nov 2021 00:28:33 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id j8sm2054632wrh.16.2021.11.25.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:28:32 -0800 (PST)
Message-ID: <be97b6085557540a9cf71e5ca6aac4556e1f7653.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/4] mptcp: do not block subflows creation
 on errors
From: Paolo Abeni <pabeni@redhat.com>
To: kernel test robot <lkp@intel.com>, mptcp@lists.linux.dev, Matthieu
 Baerts <matthieu.baerts@tessares.net>
Cc: kbuild-all@lists.01.org, Phil Greenland <phil@quantulum.co.uk>
Date: Thu, 25 Nov 2021 09:28:31 +0100
In-Reply-To: <202111250633.wEMz7JQe-lkp@intel.com>
References: <574156bd514d855a159add3e1c54caa9b2c5f880.1637770883.git.pabeni@redhat.com>
	 <202111250633.wEMz7JQe-lkp@intel.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Thu, 2021-11-25 at 06:52 +0800, kernel test robot wrote:
> Hi Paolo,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mptcp/export]
> [cannot apply to shuah-kselftest/next linus/master v5.16-rc2 next-20211124]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Paolo-Abeni/mptcp-improve-subflow-creation-on-errors/20211125-005137
> base:   https://github.com/multipath-tcp/mptcp_net-next.git export
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211125/202111250633.wEMz7JQe-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/6af8e28040c093866aa60ede3f980b53ab3594a5
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Paolo-Abeni/mptcp-improve-subflow-creation-on-errors/20211125-005137
>         git checkout 6af8e28040c093866aa60ede3f980b53ab3594a5
>         # save the config file to linux build tree
>         make W=1 ARCH=um SUBARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> > > net/mptcp/pm.c:203:6: warning: no previous prototype for 'mptcp_pm_subflow_closed' [-Wmissing-prototypes]
>      203 | void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/mptcp_pm_subflow_closed +203 net/mptcp/pm.c
> 
> 6af8e28040c093 Paolo Abeni   2021-11-24  202  
> 1b1c7a0ef7f323 Peter Krystad 2020-03-27 @203  void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
> 1b1c7a0ef7f323 Peter Krystad 2020-03-27  204  {
> 1b1c7a0ef7f323 Peter Krystad 2020-03-27  205  	pr_debug("msk=%p", msk);
> 1b1c7a0ef7f323 Peter Krystad 2020-03-27  206  }
> 1b1c7a0ef7f323 Peter Krystad 2020-03-27  207  

All the CI warning are caused by this function lacking a declaration.
The solution would be just dropping 'mptcp_pm_subflow_closed()', as
mptcp_pm_subflow_check_next() is already doing the real work.

@Mat: assuming there are no other issues, could you please do that in
patchwork or do you prefer me to post a v3?

Thanks!

Paolo

