Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D168
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 01:31:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="296267919"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="296267919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:31:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="470615921"
Received: from pkkelley-mobl.amr.corp.intel.com ([10.209.109.110])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 17:31:19 -0800
Date: Wed, 10 Nov 2021 17:31:19 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 7/7] mptcp: add disconnect selftests
In-Reply-To: <992a16d382afe5932897687bb6b5f383af6e887e.1636545174.git.pabeni@redhat.com>
Message-ID: <6f3a2c6-3bf9-df0-8fe-942c22824c79@linux.intel.com>
References: <cover.1636545174.git.pabeni@redhat.com> <992a16d382afe5932897687bb6b5f383af6e887e.1636545174.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Nov 2021, Paolo Abeni wrote:

> Performs several disconnect/reconnect on the same socket,
> ensuring the overall transfer is succesful.
>
> Additionally leverages ioctl(SIOCOUTQ) to ensure all the
> pending data is acked before disconnecting.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> notes:
> - this is on top of Florian's patches
>
> - yep, I just contradicted myself leveraging again mptcp_connect
> for self-tests, despite I proposed otherwise.
>
> I admit is tempting. The downside is that the program is
> growing as uncontrolled blob. Suggestion for better solution
> more then welcome!

The only similar thing I see is in the net/forwarding/ selftests, where 
they factored out a bunch of common code into lib.sh (and various othere 
*lib.sh files), then 'source' that in various tests scripts. Not sure it's 
worth it yet?

For the series, I only have one small request: please update usage() in 
mptcp_connect.sh with the new options. The disconnect self test seems to 
be running fine on my system.

I'll run this in syzkaller too, since the export branch isn't changing 
much right now.

> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 119 +++++++++++++++---
> .../selftests/net/mptcp/mptcp_connect.sh      |  38 +++++-
> 2 files changed, 140 insertions(+), 17 deletions(-)

--
Mat Martineau
Intel
