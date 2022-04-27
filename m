Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0C3D60
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651080820; x=1682616820;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wjMvRhiHABnAGynZ3KIK5c7aUG/RoRC3XO/EBj3XQRI=;
  b=DDygjC9VfgFrM8AhCeSC1/DBRht0SmI9bHfxtbl8ETlB8aiKXnyOongV
   7ISsj9Hvuq4N5u06/BKTEFq4+VeHgFy0T9qzvF1TC/IIjOID8KCg1Hgel
   Aaz2Sb0X11KIyNAOF4/c2aD1XRErU+oK06mTJI1qV+suRau7EFqPCBtX/
   0vDMNS7MJsYC7aceN8lek74ts7W8/Kr2TiXMOey7T+w0SJod9q32tUHD0
   1AS+zvgpEAaf7rfXVCqDw3/p+3MZrOCvaPVluz9hEZNIQjW0yFg3bZa1k
   9xwMFy9HcriyWm9pLW+rpmRG1yMuYMSFgx452Xuoe3S4oQY+XUtBUD3hx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="328955196"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="328955196"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="580725917"
Received: from ddavid-mobl2.amr.corp.intel.com ([10.209.54.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:33:28 -0700
Date: Wed, 27 Apr 2022 10:33:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test
 base"
In-Reply-To: <edebd64f-9b82-c4c1-1d03-e39270bf5c58@tessares.net>
Message-ID: <1c8d39c9-647b-44a-b4fa-729a2b4decf@linux.intel.com>
References: <38168fb95c78454db24726d2bd45f2d65d977fda.1651022882.git.geliang.tang@suse.com> <edebd64f-9b82-c4c1-1d03-e39270bf5c58@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 27 Apr 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> Thank you for the patch!
>
> On 27/04/2022 03:28, Geliang Tang wrote:
>> Add CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC as Mat suggested.
>
> Mat's second reply on...
>
>  Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
>
> ...patch confuses me but I think he meant: we need this patch as it is
> and that's why it is marked as Queued on Patchwork. But for this fix
> here, it is probably best to have a dedicated patch and not a Squash-to
> one because these two config should have been added before as they are
> needed by other BPF selftests.
>
> Did I misunderstand?
>

You understood correctly, Mattheiu. If I send a v2 of the bpf-next patches 
today I will add the commit and also queue it in our patchwork.

--
Mat Martineau
Intel
