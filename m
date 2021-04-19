Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5F2F81
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 22:28:47 +0000 (UTC)
IronPort-SDR: 6a+9yF3xc76Qe8+8NOgJVaXSzLM3jFmNkCBVfBIntnZDC+pAbCOEhs3qYDw4MOOH7webqauY3+
 leGQ5Ul8tNvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="175515571"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="175515571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 15:28:47 -0700
IronPort-SDR: PhVIGDN1RPuHvDA52di48xFttjK7sal2Sh2UPvMWhZxbnnh98JqbQJc69bi/ZP6rvfa7AejYKT
 qHy7lMiXuGkQ==
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="523582399"
Received: from pdanley-desk.amr.corp.intel.com ([10.212.162.30])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 15:28:47 -0700
Date: Mon, 19 Apr 2021 15:28:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Yonglong Li <liyonglong@chinatelecom.cn>
Subject: Re: [PATCH mptcp-next 0/3] Squash to "selftests: mptcp: add a test
 case for MSG_PEEK"
In-Reply-To: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
Message-ID: <313ddde-a5d4-2c27-3b7-edc1e6751d38@linux.intel.com>
References: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 19 Apr 2021, Matthieu Baerts wrote:

> I started this because I prefer avoiding setting a global variable before
> calling a function and reset it later in order to take a specific path in the
> called function. While at it, I also reduced duplicated code.
>
> But good thing, I also fixed two unwanted behaviours, see patches 1/3 and 2/3.
>
> Matthieu Baerts (3):
>  selftests: mptcp: use 2 different 'peek' modes
>  selftests: mptcp: same NS for Peek tests in IPv6
>  selftests: mptcp: avoid non-const global variables
>
> .../selftests/net/mptcp/mptcp_connect.sh      | 44 +++++++++----------
> 1 file changed, 22 insertions(+), 22 deletions(-)
>
> -- 
> 2.30.2

Hi Matthieu -

These look good to squash, thanks for the fixups!


--
Mat Martineau
Intel
