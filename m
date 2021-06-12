Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C12FB8
	for <mptcp@lists.linux.dev>; Sat, 12 Jun 2021 04:05:56 +0000 (UTC)
IronPort-SDR: nw4X3uDUGgs6gojeZxKuU6ZgWaeyfwk86iPCGRGgal0+eTCX3bFxGAZba/FoeOqE+9FTpT/jmn
 cfdfCr4+uJ2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="269493176"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="269493176"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 21:05:56 -0700
IronPort-SDR: aj8caxELQCVWwlzEowjMtQkA7QU9AtHrG1wcYsId2NZwSPGc2+92xeE9D8Qjgq7sIoVmnp0XD9
 GIVK7duKxkkQ==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="620567657"
Received: from yseah-mobl.gar.corp.intel.com ([10.212.136.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 21:05:56 -0700
Date: Fri, 11 Jun 2021 21:05:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: Checksum support: default behaviour
In-Reply-To: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
Message-ID: <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
References: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 11 Jun 2021, Matthieu Baerts wrote:

> Hello,
>
> With the current checksum support series from Geliang and Paolo
> available in our tree, the default behaviour is not to use this checksum
> feature.
>
> Should we eventually do the opposite and have it enabled by default?
>
> I do understand this has a cost in terms of performances but this could
> help detecting nasty middleboxes, i.e. the ones that modify the TCP
> packets without modifying MPTCP options if needed.
>
> On the other hand, I don't have numbers showing if these middleboxes are
> rare or not.
>
> But also, the main issue I see if we enable the checksum support by
> default is that we are no longer able to talk to servers not supporting
> it (<5.13), no?
>
> WDYT?
>

I lean toward leaving checksums off by default, based on what I've heard 
from community members. It sounds like large deployments haven't seen 
checksums catch many problems? Some actual data about the frequency of 
checksum failures would really help.

Your last point about connecting to older upstream kernels is also an 
important one. I'd rather keep it possible to connect to those kernels 
using default configuration options unless it's too risky to do so.


--
Mat Martineau
Intel
