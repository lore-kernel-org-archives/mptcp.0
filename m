Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04F79E4
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874989; cv=none; b=ce3CmuK4xCKeLQDN7ruXq9K185BE7PPSvFeJlI+UojUFlKRLw5ZHMoqxxtrjCarvDIuEPa5RbIlUJ8suToRa73/Ag+NupJ6v4kgtTomH3D4/G5diGFP9r3hsDMu/VptFqsxQHZeqslzWwnZenNaqI+xSjKPh3KQS2gzG2yV2T2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874989; c=relaxed/simple;
	bh=MLc+87DA7IBaBk6HvTakx4RCwz3yTXs48Hka0IU8d9g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cy9XioVk/jD8OGyQQs95ErUWwNXQpeo+zMLBDtE1kHyBHRlQ/we6yQ/iHTh5mL2QilbpU07hdGw+Mv9/MTgGvROrzK8VcgPJ4BIF2GHTpq3yvIc4r0epxR3ETd2hwO4g0HJfvYPLbi0534bKZS1CRyfMO7QvQrAG7VkE1TU71nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVyegLPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVyegLPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9EFC433C7;
	Wed, 14 Feb 2024 01:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707874988;
	bh=MLc+87DA7IBaBk6HvTakx4RCwz3yTXs48Hka0IU8d9g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XVyegLPuFN10OivLmniS/Dzy5MhcqQX/VsQPUCuZPmOB2VZVN6/bfC2Q7PRBmVM30
	 5j7Ayf4YyfrOQxl+CI+mia6JTtOnaIY1G3+5e9FrjhDB+HB35wiJOC6z6rz4TZooiN
	 3nth7uZtnk/u/EVpyOWqYlk+Xwjcb+HRskcKB/hFvYaAOs8RKtJLC2oFMI0MyFUKI3
	 pcpg3LAB4D32BniG1Dzgcwu2/EqA2babVjgpug/nUacPXczHQIG1YXEGCrJLZHIaqA
	 2EJ3HRtGJtTS1xWtAhwbka6ZfoWnNNFfkZpB8YI6NKuv+ycxZndHsQqz2NbUIBRyZB
	 AFwsDqOkohb/w==
Date: Tue, 13 Feb 2024 17:43:07 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 00/15] dump for userspace pm
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
Message-ID: <c422e839-a086-275a-1ace-d25d7c3a843d@kernel.org>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 1 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v11:
> - update patch 5 as Mat suggested.
> - depends on "fixes for userspace PM" series.
>

Hi Geliang -

Thanks for the changes, code looks good to me!

I tried applying v11 after 'fixes for "map v4 address to v6"' but it still 
doesn't apply cleanly, can you rebase this series and repost?

- Mat


> v10:
> - fix a checkpatch.sh warning reported by CI.
> - fix build warnings reported by kernel test robot <lkp@intel.com>.
>
> v9:
> - add missing "sock_put(sk)" in patch 7, 17 and 21 to fix the "kmemleak"
>   errors reported by CI.
> - rename the helper to mptcp_pm_has_addr_attr_id.
> - use my new mail address.
>
> v8:
> - Address Mat's comments in v7
>
> v7:
> - fix checkpatch.sh warning reported by CI.
> - fix build errors reported by CI.
>
> v6:
> - patches 1-5, fixes for -net
> - patches 6, 15, selftests for "fixes for -net".
> - patches 7-14, 16-21, update "dump for userspace pm v5"
> - patches 22, 23, cleanups for set_flags
> - patch 24, flush selftest.
>
> v5:
> - patch 2, save bitmap instead of id.
> - patch 3, drop token in reply.
> - update patch 4 and patch 12, add mptcp_pm_dump_addr and
>   mptcp_pm_get_addr wrappers in pm.c
>
> v4:
> - update patch 2, patch 3 and patch 12.
> - fix the warnings reported by CI in v3:
>
> Unable to validate one commit: 7633a101a mptcp: get addr in userspace pm list
> Unable to compile mptcp source code with make W=1 net/mptcp/pm_netlink.o
> Unable to compile mptcp source code with make C=1 net/mptcp/pm_netlink.o: net/mptcp/pm_netlink.c:1656:5: warning: symbol 'mptcp_pm_nl_get_addr' was not declared. Should it be static?
>
> v3:
> - fix the errors reported by CI in v2:
>
> [10:55:51.288] [  897.523894][ T5664] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [10:55:51.288] [  897.532157][ T5664] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5664, name: pm_nl_ctl
> [10:55:51.289] [  897.539503][ T5664] preempt_count: 201, expected: 0
>
> - drop mptcp_pm_nl_put_entry_msg and mptcp_pm_nl_put_entry_info
>   helpers.
>
> v2:
> Address Mat's comments in v1:
> - patch 2: pass token to dump_addr too.
> - patch 2: add back id in mptcp_userspace_pm_dump_addr().
> - patch 5: update mptcp.yaml
>
> v1:
> Address Mat's comments in "userspace pm enhancements" v14.
>
> Geliang Tang (15):
>  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
>  mptcp: implement mptcp_userspace_pm_dump_addr
>  mptcp: add token for get-addr in yaml
>  mptcp: dump addrs in userspace pm list
>  mptcp: check userspace pm flags
>  selftests: mptcp: add userspace pm subflow flag
>  selftests: mptcp: add token for dump_addr
>  selftests: mptcp: add check_output helper
>  selftests: mptcp: dump after creating id 0 subflow
>  selftests: mptcp: dump userspace addrs list
>  mptcp: add userspace_pm_lookup_addr_by_id helper
>  mptcp: implement mptcp_userspace_pm_get_addr
>  mptcp: get addr in userspace pm list
>  selftests: mptcp: add token for get_addr
>  selftests: mptcp: userspace pm get addr tests
>
> Documentation/netlink/specs/mptcp_pm.yaml     |   3 +-
> net/mptcp/mptcp_pm_gen.c                      |   7 +-
> net/mptcp/mptcp_pm_gen.h                      |   2 +-
> net/mptcp/pm.c                                |  16 ++
> net/mptcp/pm_netlink.c                        |  26 ++-
> net/mptcp/pm_userspace.c                      | 177 ++++++++++++++++--
> net/mptcp/protocol.h                          |  13 ++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 102 ++++++++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 +++-
> 9 files changed, 353 insertions(+), 32 deletions(-)
>
> -- 
> 2.40.1
>
>
>
