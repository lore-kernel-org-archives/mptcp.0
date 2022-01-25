Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD23173
	for <mptcp@lists.linux.dev>; Tue, 25 Jan 2022 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643074697; x=1674610697;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bfEYZY299E0etJA1ci3pq4k6xB5zmqjRg3yoheXc4y8=;
  b=lfArFTzSaPVCKWVRUEGA3/h+M/pe4rN7yic+rwgl9lYeE6mt/wrHpEX6
   i1ON3xvjJIAa2qwDxKOfqT76g3FwY+ph9kD6XfqDdDk2eZKQ0w2AF7rHd
   8zR0JhVod0tCGpwts785G9Jp+tOR6V3a3gx+XthOQCJ6mZjeApcM9ZGQH
   SRVuyq8lPlC7l/iXNC9TlCGyD2YECoUiZ7sXhdKgoEXJTsUESsXcO6eE8
   SVkucpG2dMBjW9pOR8tMp15WqMD0PrZZnlr3xVhDF9Mk47luuRgb3U2eM
   UsZcOcYaRSMh9Oix8iv86TMMNIn79tNd5fcD+RWodcQ0XRvsNXg9i8p4w
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246137883"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="246137883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:38:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534507861"
Received: from nchakrav-mobl1.amr.corp.intel.com ([10.209.84.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:38:04 -0800
Date: Mon, 24 Jan 2022 17:38:04 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: add set_flags tests
 in pm_netlink.sh
In-Reply-To: <6c188cb9b8df2f07782f77443431fbd1eb04bef0.1642841713.git.geliang.tang@suse.com>
Message-ID: <223cf32c-b4c0-67c-45ea-5fc3523278db@linux.intel.com>
References: <cover.1642841713.git.geliang.tang@suse.com> <6c188cb9b8df2f07782f77443431fbd1eb04bef0.1642841713.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 22 Jan 2022, Geliang Tang wrote:

> This patch added the setting flags test cases, using both addr-based and
> id-based lookups for the setting address.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index cbacf9f6538b..55df8b4e33fa 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -164,4 +164,14 @@ id 253 flags  10.0.0.5
> id 254 flags  10.0.0.2
> id 255 flags  10.0.0.3" "wrap-around ids"
>
> +ip netns exec $ns1 ./pm_nl_ctl flush
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
> +ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
> +ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
> +ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
> +ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
> +ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
> +check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
> +subflow,backup,fullmesh 10.0.1.1" "set flags"
> +

I think it would be worth it to check more of the intermediate states with 
"pm_nl_ctl dump", not just after the last command. The first four 'set' 
commands could have been broken and that wouldn't be detected.

--
Mat Martineau
Intel
