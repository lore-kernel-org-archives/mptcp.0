Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F068
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 19:26:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="231722039"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="231722039"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 11:26:24 -0800
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="504556874"
Received: from neelchat-mobl2.amr.corp.intel.com ([10.209.109.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 11:26:24 -0800
Date: Thu, 11 Nov 2021 11:26:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 7/7] mptcp: add disconnect selftests
In-Reply-To: <09a37df1b6b200b795da5e3fea81cf1d010b7193.camel@redhat.com>
Message-ID: <1e7a692b-f3e8-6f42-2ac2-cead8b4c6ed3@linux.intel.com>
References: <cover.1636545174.git.pabeni@redhat.com>  <992a16d382afe5932897687bb6b5f383af6e887e.1636545174.git.pabeni@redhat.com>  <6f3a2c6-3bf9-df0-8fe-942c22824c79@linux.intel.com> <09a37df1b6b200b795da5e3fea81cf1d010b7193.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Nov 2021, Paolo Abeni wrote:

> On Wed, 2021-11-10 at 17:31 -0800, Mat Martineau wrote:
>> For the series, I only have one small request: please update usage() in
>> mptcp_connect.sh with the new options.
>
> ?!? there aren't new option in mptcp_connect.sh. Do you mean
> mptcp_connect.c ?

Ugh, yes, I meant the .c file - sorry about the typo. Thanks for fixing in 
the v2.

--
Mat Martineau
Intel
