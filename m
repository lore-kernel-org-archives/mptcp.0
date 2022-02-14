Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B527C8A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644872028; x=1676408028;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zsOlXusEFHwPkmrqHd4B+OWnIdgoOQjLUuXV3aFlgwE=;
  b=iD9jT8yT80oLQrWy2K585oa08BAZFyL01SqmdipxnhlCJQDHz9Mwmosl
   w4mKtYdx9fXNnAigfKUFmJ/aG4Fb1fiQr/GvRTJ2s0l88DhH62G1K/2NR
   vcTFgZgPxnPzEe537HeGMPTgm+BhyZnNIhXy/LQKEU12N+XsvLu7J3z/3
   hI4B7Gd2fuy0PPhM1hWsVGGainqDY5p5SSYiAQFfdwRVUbQIdnOwyHmWf
   rQQNBh9st4Ps3e4MqS2xOTtcMqIG4WBjCJK3f2hhihj3/kIZXRvJQWIEm
   B1NmLjnpNNFL+xAba2/6y1/H1yNOrX59QMeusIEalrbKQuFWP2q9uAXR5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336610132"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="336610132"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:53:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="632337017"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:53:47 -0800
Date: Mon, 14 Feb 2022 12:53:46 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: dm kcopyd: use copy offload support: Build Failure
In-Reply-To: <ac316612-dd4d-3a1a-454c-d94d58dc421a@gmail.com>
Message-ID: <f33d3721-5790-ad9d-594d-47f2fee960a1@linux.intel.com>
References: <20220214080002.18381-11-nj.shetty@samsung.com> <ac316612-dd4d-3a1a-454c-d94d58dc421a@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Feb 2022, MPTCP CI wrote:

> Hi SelvaKumar,
>
> Thank you for your modifications, that's great!
>
> But sadly, our CI spotted some issues with it when trying to build it.
>
> You can find more details there:
>
>  https://patchwork.kernel.org/project/mptcp/patch/20220214080002.18381-11-nj.shetty@samsung.com/
>  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843130390
>
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/84deecc163f6
>

SelvaKumar,

Sorry about the unexpected email from our CI system. It appears there was
an issue with patchew.org that somehow applied and tagged your patch in
our github repo even though you didn't send to our mailing list.


--
Mat Martineau
Intel
