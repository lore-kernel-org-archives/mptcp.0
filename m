Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446952F80
	for <mptcp@lists.linux.dev>; Tue, 28 Sep 2021 21:18:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="221602983"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="221602983"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 14:18:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="478900570"
Received: from snanja-mobl.amr.corp.intel.com ([10.212.220.56])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 14:18:25 -0700
Date: Tue, 28 Sep 2021 14:18:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: parthaz lokesh <parthazlokesh@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: Help with MPTCPV1 server setup
In-Reply-To: <CAJck1w3K8uzVbgmk_UHPPA-T7xh7Gcj_4zdUn-mL-vLZXPoHNQ@mail.gmail.com>
Message-ID: <c318f8eb-5def-a41f-36b2-260736679c1@linux.intel.com>
References: <CAJck1w3K8uzVbgmk_UHPPA-T7xh7Gcj_4zdUn-mL-vLZXPoHNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Fri, 24 Sep 2021, parthaz lokesh wrote:

> Hello,
>
> I am trying to set up a ubuntu server with MPTCPV1(5.14v kernel). I am
> not seeing mp_capable in the syn packet after setting
> /proc/sy/net/mptcp/enabled value to 1. Is this expected behaviour?   I
> assume ip mptcp commands don't need to be executed for initial
> mpcapable subflow. In MPTCPV0 it used to work after setting it to 1.
>
> Mptcp Wi-ki page redirected to this systemtap script. script
> https://github.com/multipath-tcp/mptcp_net-next/issues/18#issuecomment-650529642.
> But unable to install debug symbol packages(required for above script
> to work) for 5.14kernel in ubuntu.
>
> Is there an easy way to enable mptcp system wide and send mpcapable
> without tapping the socket with IPPROTO_MPTCP?

Hi Parthaz -

There is not a way to force all TCP sockets to use MPTCP in the upstream 
kernel (v5.6 and later), since these kernels have a completely separate 
IPPROTO_MPTCP socket type for MPTCP connections. The multipath-tcp.org 
kernel (for MPTCP v0) has a different design with significant changes 
to the TCP core.

mptcpd v0.8 (just released) has a 'mptcpize' utility that might work for 
you. It allows you to run legacy binaries (that use TCP sockets) with 
MPTCP enabled by using LD_PRELOAD to remap TCP sockets to IPPROTO_MPTCP. 
More information at https://github.com/intel/mptcpd#multipath-tcp-daemon



--
Mat Martineau
Intel
