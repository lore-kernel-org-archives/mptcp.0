Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FF194
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670289228; x=1701825228;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cMQnFXc+y/Mtd4Z4eaCqqdLBUnjYTBE/dobugLxtXsI=;
  b=W8Q+dIG5UsILiFpnBeTVpLZH4td1hsyq3XDpBtcQo2LDNddP0z4pUqMe
   VwjhmL+zI7TKpE2Vz1aFjLpfdUd7zvTEds9H+GOSxI9uibsiWB0yO1GuA
   ZonZgwZIEyBtMTwNIsWGdLlYdkbOrgfl8zFuGnXjyqRxjmLNZtRZOzW7Q
   W85FpNPDD6cg9rRIFWtFCezmLAP75cSIk7QHGRieon5sS3eEFNnCWvxYs
   XEaeExj1pgzr6rtH/pu0UXSa+MbXpEeC0LUwvOOaw7L5HC6xHe530LIVQ
   /A7SzafWRw/ZR3ooGmz/M8+bPzCotZvsFYDGlO4arZiDf5d6qOX4pjbRX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318366043"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318366043"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:13:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="648148318"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="648148318"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:13:47 -0800
Date: Mon, 5 Dec 2022 17:13:47 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v22 0/5] BPF redundant scheduler, part 2
In-Reply-To: <cover.1669987293.git.geliang.tang@suse.com>
Message-ID: <a65197b3-6504-9b89-315a-76f7b5f92eec@linux.intel.com>
References: <cover.1669987293.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 2 Dec 2022, Geliang Tang wrote:

> v22:
> - update patch 2 as Mat suggested.
> - patch 4 and 5 in v21 will send later.

Ok, thanks for the note on v21 patches 4/5. My only other comments on v22 
are on patches 2 & 3 (already replied on those).

- Mat

>
> v21:
> - address Mat's comments in v20.
> - redundant sends on retransmit code path.
>
> v20:
> - rebased on "Squash to "mptcp: refactor push_pending logic" v19"
>

--
Mat Martineau
Intel
