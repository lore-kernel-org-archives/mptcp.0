Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF022569
	for <mptcp@lists.linux.dev>; Tue, 24 May 2022 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653416839; x=1684952839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sCg7ZKBO9Hfxf5/PvrRosz/IG2vsxISZz8JA0VQdayw=;
  b=l0eoDLM8CYbH0AXKGJI/wC8NgHja33lOtebGVZdcFdzS858Osp4gLMLl
   ZPBgdvPpT26XZMOS6/C4zIWgUOevls/5uG25JKFWx4nwX6PI8DntHG8Om
   AqGlMOc2JcQteTGKnhdrxQHYUuQ2VI7zicZ0KGBvSYUWNlj2ryVxVU2XT
   LWMTquUUoRKRMErUvTEhAoX+rkcRhoieyiqOt7HDr4RmQsUtawXMSg42a
   Sux3a9143TXh1JV9eIu4DNgO8tZNWMTkGIGLJBj5WWrKxd83Me+1yevf6
   l5UWwT+68Hzs8k8Ro1LnDWOiszivmv/eQej5Pk8tcMhORr1DtPVMaIHF2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273617119"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273617119"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:27:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="548589798"
Received: from ticela-or-166.amr.corp.intel.com ([10.251.23.3])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 11:27:13 -0700
Date: Tue, 24 May 2022 11:27:06 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: naresh.kamboju@linaro.org
cc: lkft@linaro.org, mptcp@lists.linux.dev, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Adding MPTCP to LKFT tests
Message-ID: <a94be5fe-69b0-b27-5121-fafdd47bc6@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1630801832-1653416833=:20361"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1630801832-1653416833=:20361
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Naresh -

I noticed in your response to the 5.17.10-rc1 stable announcment that 
you're running much of the kselftest suite on the stable rc's.

It looks like kselftest-mptcp is not part of the list, so a MPTCP 
kselftest regression was not noted. Is it something you would consider 
adding? Do your tests only run defconfigs for each platform or do you turn 
on other non-default features? MPTCP is not enabled by default.


Some considerations:

* MPTCP selftests are in tools/testing/selftests/net/mptcp/

* Kconfig dependencies are documented in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/net/mptcp/config

* One test, mptcp_join.sh, takes a long time to run.


Thanks for your time!


Mat


---------- Forwarded message ----------
Date: Mon, 23 May 2022 19:03:36
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 5.17 000/158] 5.17.10-rc1 review

On Mon, 23 May 2022 at 22:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.17.10 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 May 2022 16:56:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.17.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro’s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

...
--0-1630801832-1653416833=:20361--
