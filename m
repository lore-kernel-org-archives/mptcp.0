Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493011C3C1C
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676347; cv=none; b=KA3o8fEqPgKCKHSpbEDdtd7LtqLCJI840kMSiZpIM0OwLKAaAFanxfgFvVBYSD47k6u7vWKPH4l9IqtnZA0KX42YPNmNJrvatjyGoqrw1NROkl8InSIoPnSPd3ZmKtGVftLFAX5OEk3yCTrtamMvCHDzuSfyuU9yEYdCLL46av4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676347; c=relaxed/simple;
	bh=YtR9PvoWF2Q9cMclj96lsJRvi6sj3SfJ3TOLTiq1q0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meCwRqOTbtqq7tYXiKATUGxDNmLJYywxBsmx2YnMAqoGMx9S62II9+yHNGdDzL2VOq3k1/PVIL66OOL+MxB4DKXIylCmZhykUziD55WEPHT4Qfa6GCh1wYDu/lAleOKAFLJSteC2w9XYSsAbg/tOzw/3SnYO6Xp7ekE+Zb7GaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8p2KKcl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8p2KKcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C831DC4CEE9;
	Tue, 11 Mar 2025 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741676346;
	bh=YtR9PvoWF2Q9cMclj96lsJRvi6sj3SfJ3TOLTiq1q0Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=n8p2KKclopHbSxLiHmLtUH4JdnF0Dg8yT0S8YHwJECfIGoU+7Y0f8eB4HnCayqOa0
	 TNobPKrse+DGr0jAP1VwLIGQJzvubKFLdWWmNPFxsPItoHCTbM6bj4Cdgq29wXIDDO
	 CeJfSOf/Ge3igorTZ6dT0EgXBtN2T9Gh7Uv/zgIKtgkuEFqzNDiHIyPEckPA6GJx+3
	 if8EcU5YhPMUv8imvRvITYbnf9FwgDgEhb7Qs2yD8getK+IKHL5dWEiKOaW+OpXsrO
	 7qoBK218j6ev+4e0LS4Db4jC+OXhCTtEY24IOuaSMoDJJcDLaAaUS10feKr1L1UTbA
	 SEtEGsIqnImYw==
Message-ID: <550ac963af5a37bcc9afd5b5045d67e5a8da8d37.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v11 00/10] BPF path manager, part 5
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 11 Mar 2025 14:59:03 +0800
In-Reply-To: <cover.1741674285.git.tanggeliang@kylinos.cn>
References: <cover.1741674285.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-03-11 at 14:31 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v11:
>  - add bitmap_fill(id_avail_bitmap) in mptcp_pm_kernel_init.
>  - squash mptcp_pm_validate into "mptcp: pm: define struct
>    mptcp_pm_ops".
>  - map path_manager to pm_type after mptcp_set_path_manager().
>  - change 'char *pm_name = "unknown"' to 'char *pm_name = ""'.
>  - update pm mapping selftests.

Sorry, I forgot to add "Based-on" here. So I resend this v11 to trigger
CI tests. Sorry for the mess.

Thanks,
-Geliang

> 
> v10:
>  - drop pm->init in mptcp_pm_validate, move mptcp_pm_validate into a
> new
>    patch.
>  - remove tlb, use ctl instead in proc_pm_type.
>  - use "strncmp() == 0" instead of "!strncmp()".
>  - set pm_type __MPTCP_PM_TYPE_NR for other names.
>  - add WARN_ON_ONCE in mptcp_pm_unregister.
>  - drop mptcp_userspace_pm_init.
>  - rename "struct mptcp_pm_ops *pm" to "struct mptcp_pm_ops *pm_ops".
>  - drop pm_ops NULL check in mptcp_pm_release.
>  - add struct_group for struct mptcp_pm_data.
>  - move selftests into userspace_pm.sh.
> 
> v9:
>  - rename mptcp_pm_nl_ prefix to mptcp_pm_kernel_.
>  - rename mptcp_userspace_pm_ prefix to mptcp_pm_userspace_.
>  - update commit logs.
> 
> v8:
>  - address Matt's comments in v7.
> 
> v7:
>  - addresss Matt's comments in v6 [1].
>  - drop "type" from struct mptcp_pm_ops as Matt suggested.
>  - map "pm_type" to new sysctl as Matt suggested.
> 
> v6:
>  - add "name" in struct mptcp_pm_ops.
>  - add some "sysctl" patches.
>  - drop "struct mptcp_pm_param".
>  - drop "pm_type" in mptcp_pm_data.
> 
> v5:
>  - use "struct mptcp_pm_param *param" as unified parameters for all
>    interfaces.
>  - register in-kernel mptcp_pm_ops too.
>  - only implement two interfaces "get_local_id" and "get_priority" in
>    this set.
> 
> v4:
>  - include a new patch "define BPF path manager type".
> 
>  - add new interfaces:
> 	created established closed
> 	listerner_created listener_closed
> 
>  - rename interfaces as:
> 	address_announced address_removed
> 	subflow_established subflow_closed
> 	get_priority set_priority
> 
>  - rename functions as:
> 	mptcp_pm_validate
> 	mptcp_pm_register
> 	mptcp_pm_unregister
> 	mptcp_pm_initialize
> 	mptcp_pm_release
> 
> v3:
>  - rename the 2nd parameter of get_local_id() from 'local' to 'skc'.
>  - keep the 'msk_sport' check in mptcp_userspace_pm_get_local_id().
>  - return 'err' instead of '0' in userspace_pm_subflow_create().
>  - drop 'ret' variable inmptcp_pm_data_reset().
>  - fix typos in commit log.
> 
> v2:
>  - update get_local_id interface in patch 2.
> 
> get_addr() and dump_addr() interfaces of BPF userspace pm are dropped
> as Matt suggested.
> 
> In order to implement BPF path manager, it's necessary to unify the
> interfaces of the path manager. This set contains some cleanups and
> refactoring to unify the interfaces in kernel space. Finally, define
> a struct mptcp_pm_ops for a path manager.
> 
> Geliang Tang (10):
>   mptcp: pm: define struct mptcp_pm_ops
>   mptcp: pm: register in-kernel and userspace PM
>   mptcp: sysctl: set path manager by name
>   mptcp: pm: init and release mptcp_pm_ops
>   mptcp: pm: add get_local_id() interface
>   mptcp: pm: add get_priority() interface
>   mptcp: sysctl: map path_manager to pm_type
>   mptcp: sysctl: map pm_type to path_manager
>   mptcp: sysctl: add available_path_managers
>   selftests: mptcp: add pm sysctl mapping tests
> 
>  Documentation/networking/mptcp-sysctl.rst     |  23 +++
>  include/net/mptcp.h                           |  19 +++
>  net/mptcp/ctrl.c                              | 113 +++++++++++++-
>  net/mptcp/pm.c                                | 145 ++++++++++++++--
> --
>  net/mptcp/pm_kernel.c                         |  37 ++++-
>  net/mptcp/pm_userspace.c                      |  26 +++-
>  net/mptcp/protocol.h                          |  18 ++-
>  .../selftests/net/mptcp/userspace_pm.sh       |  30 +++-
>  8 files changed, 368 insertions(+), 43 deletions(-)
> 

