Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995A70
	for <mptcp@lists.linux.dev>; Sat, 10 Jul 2021 01:00:24 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209618051"
X-IronPort-AV: E=Sophos;i="5.84,228,1620716400"; 
   d="scan'208";a="209618051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 18:00:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,228,1620716400"; 
   d="scan'208";a="462348464"
Received: from eefrey-mobl.amr.corp.intel.com ([10.212.193.182])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 18:00:19 -0700
Date: Fri, 9 Jul 2021 18:00:18 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: mptcp@lists.linux.dev, geliangtang@gmail.com
Subject: Re: [PATCH v8 0/4] mptcp: fix conflicts when using pm.add_signal in
 ADD_ADDR/echo and RM_ADDR process
In-Reply-To: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn>
Message-ID: <c4a942d7-b086-f18f-c097-609af9451dde@linux.intel.com>
References: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 8 Jul 2021, Yonglong Li wrote:

> fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
> in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
> process.
>
> fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
> only one event can write pm.add_signal. so ADD_ADDR will process
> after add_timer timeout or ADD_ADDR-echo will not be process.
>
> Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.
>
> Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
> conflicts in using pm.addr_signal porcess.
>
> Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.
>
> v1->v2:
> - remove READ_ONCE under the pm spin lock.
>
> v2->v3:
> - Patch 2: mptcp_pm_should_add_addr => mptcp_pm_should_add_signal_addr
> - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change
>   mptcp_pm_add_addr_signal to return void.
>
> v3->v4:
> - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO))
>   instead of BIT(MPTCP_RM_ADDR_SIGNAL)
> - Patch 3: simple the code; init flags; fix wrong goto logic code;
>
> v4->v5:
> - Patch 3: simple the code of 'mptcp_established_options_add_addr'
>
> v5->v6:
> - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_ack
>   without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for
>   ADD_ADDR. That cause ADD_ADDR can not be sent in time.
> - Patch3: refactor some code according Geliang's suggestions.
> - Patch4: modify commit comment
>
> v6->v7:
> - Patch1: use reverse xmas tree order for variables definition
> - Patch3: refactor some code according Geliang's suggestions.
> - add a Patch4: remove some double-check
>
> v7->v8:
> - Patch1,2: exchange patch1 and patch2
> - Patch3: refactor some code according Geliang's suggestions.
> - remove patch "remove some double check", Geliang think it's unnecessary
>
> Yonglong Li (4):
>  mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
>  mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
>  mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
>  mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
>
> include/net/mptcp.h    |  3 ++-
> net/mptcp/options.c    | 51 +++++++++++++++++++++++++++-----------------------
> net/mptcp/pm.c         | 51 +++++++++++++++++++++++++++++++-------------------
> net/mptcp/pm_netlink.c | 10 ++++------
> net/mptcp/protocol.h   | 44 +++++++++++++++++++++++--------------------
> 5 files changed, 90 insertions(+), 69 deletions(-)
>
> -- 
> 1.8.3.1

Hi Yonglong -

Thanks for your revisions. I don't have any code changes to suggest for 
v8, I think we should add these to the export branch and if any more 
changes are required we can squash those before upstreaming.


--
Mat Martineau
Intel
