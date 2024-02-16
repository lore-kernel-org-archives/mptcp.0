Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB693135A6E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111908; cv=none; b=sNr4hh9pYT+F52D54YBID2qkXuwsncDlYK6EPAeaFQmhRLk7vQNHHNMbZPE2+3+bxNUNTtx19VmfQ2rqtmPFytAaL/CsFs1JFSn/U0hreY4V5IjeRRCyNu9AXZCFcrC6Lmg5845jUOKCh9JBIIj3yc40RiZ3IVdSNnGupaw4MZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111908; c=relaxed/simple;
	bh=7+csAigUWuwY8Ut4yMvDHcTCOF3ZRZp2A7fq+V1xH5E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F1loYG1WZYgNbsLKwfRK5Z8VwCX9l/DoTB5cmkPuApD2Gy/nAJStahPGPKiFGbNc5XOzXsrY77sD8jOB8w1BarPQD9E9Yi2j3AZVs+dr4XsK6+iTUVjAu6gMbr75V4t2gJdzOWM9FuRHKv5KbK4ZR9AlW1YtPpWA6+ZLtocZ3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4bwR4NG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4bwR4NG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F47C433F1;
	Fri, 16 Feb 2024 19:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708111908;
	bh=7+csAigUWuwY8Ut4yMvDHcTCOF3ZRZp2A7fq+V1xH5E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=H4bwR4NGW3c19PbdYjho8TK4chS09SadEl2kJOV4TYEkOEIOh1gULfgX8bRzk7VnS
	 qiu30wXDiVfjLw0cpSNrtWu8BM1raCiuMJtLjNx4p4xGmO6H81ayDUtiTMGE1mqxw8
	 1cTG3zVZ+/wv56VccynYXvWJyH8YMHyIh90/MQ8YcpU2X4VaZF8rNj48LSbVn47LmF
	 Ovps59ULRK4+dk/vDQDii+h84G/i2NzKeFEqxoVGaQPlH3zSnMMcrkIp2z5sPECsvd
	 Le+GGUgE3UDpVLwLiAJ97uRAi58QvXS3IsGd1kGq3ujXGnu0CIM7WGNWvrXJZMqI0Z
	 sz35WaQDyQrEg==
Date: Fri, 16 Feb 2024 11:31:47 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v13 00/14] dump for userspace pm
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
Message-ID: <9e8283b2-563f-cf6d-15ae-d5b3241951a6@kernel.org>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 16 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v13:
> - fix the typo in patch #3.
> - add 'mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"' checks.
> - add 'mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"' checks.
> - drop "userspace pm dump address/subflow" tests, test it in "userspace
>   pm add & remove address" and "userspace pm create destroy subflow"
>   tests instead.
>

Thanks for the adjustments to the tests, v13 looks good for the export 
branch!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> v12:
> - rebased on export/20240214T102432
>
> v11:
> - update patch 5 as Mat suggested.
> - depends on "fixes for userspace PM" series.
>
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
> - fix the warnings reported by CI in v3.
>
> v3:
> - fix the errors reported by CI in v2.
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
> Geliang Tang (14):
>  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
>  mptcp: implement mptcp_userspace_pm_dump_addr
>  mptcp: add token for get-addr in yaml
>  mptcp: dump addrs in userspace pm list
>  mptcp: check userspace pm flags
>  selftests: mptcp: add userspace pm subflow flag
>  selftests: mptcp: add token for dump_addr
>  selftests: mptcp: add check_output helper
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
> .../testing/selftests/net/mptcp/mptcp_join.sh |  93 +++++++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 +++-
> 9 files changed, 344 insertions(+), 32 deletions(-)
>
> -- 
> 2.40.1
>
>
>
