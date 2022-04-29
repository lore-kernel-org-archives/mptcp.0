Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822D7B
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651261571; x=1682797571;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T0e3xqZbVN5c/Lovx3oJ/GMwnrfw6NaBSBN+GOURU44=;
  b=XFA/pNoTjermZFwxg1pwU/zAKPq+axLh3OziZ7iT+mJG8XWhf5kTPP8j
   pTOo1EbSTBws+ReyOercXmgmfUF9s2h20Okx4QztznfpUy5LehzGduJU4
   SZz1e6x9UhthCD7I/UWkecKYUqi/yDQPv0IHDvnJacjDV2KZN/nUVMFqg
   xQywMcykF+9VuPeupeo50iTVQ5fQd8zay9lgz5zX8Pt4kiqjWbjWVPUZB
   j7/ARRY9bDhaob6kYILNdMoUrPMIdtKfGrrXHw+E4ASSFu4+U4qGcYOK3
   tmtj/OF7rZeiZiUP7OdgRkZ2PKsgV00QNF7B0nBU4zARlbR6QHrQXqA7j
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="265598539"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="265598539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:46:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="534657816"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:46:10 -0700
Date: Fri, 29 Apr 2022 12:46:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix MP_FAIL test-case
In-Reply-To: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
Message-ID: <7d6e2ab9-ac1-a86f-2ce4-4551e63eb087@linux.intel.com>
References: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Apr 2022, Paolo Abeni wrote:

> The mentioned tests sometimes fails because the data
> transfer completes before any packet is sent on the 2nd
> link (the failing one).
>
> Address the issue reducing the "virtual" b/w available
> on the primary link.
>
> Fixes: bfd4cdbe7032 ("selftests: mptcp: add MP_FAIL reset testcase")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> together with the previous patch this fixes issues/265 for
> good here. I'm not adding the Close tag due to the mentioned
> dep, which may take a different/longer route
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a98fee834950..0d65295c1b33 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2734,7 +2734,7 @@ fail_tests()
>
> 	# multiple subflows
> 	if reset_with_fail "MP_FAIL MP_RST" 2; then
> -		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
> +		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 10mbit delay 5

The "MP_FAIL MP_RST" test still fails within a couple of minutes on my 
desktop with this change. I changed 10mbit to 1mbit and so far it is still 
running. You ok with slowing it down even more?

> 		pm_nl_set_limits $ns1 0 1
> 		pm_nl_set_limits $ns2 0 1
> 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
