Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FA3212
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651529681; x=1683065681;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RiXvCB8oh9nqPgcnx8EIB1Wmt/grBN2Os/vtX20nf5g=;
  b=PJQ+zltAoTirVA+aqkuRulY8OqDJhQ4SIvZ8PlgCRGmU3NjzUP/BNEKj
   UxRy2j2aIeU2TiE9QayGGiW9p/eD4f6eDmIA0JkjbefZiGAX9X36JfoAw
   Szi4Lt3sy3tlsoJ3FzDWLrLjU7K5rANmNaCh1NbCQgup5f8SpXbh4l5O/
   DLGu1F68Oo2JQbDmy0Jvu+rJc45knTMIM397Ft1fA8AGnuf9PuqjTRIWr
   7hB0o9SyOxMYedXB7aQB9Iwv/wnWCGIBW0GpYlsFrW2nwwBIKcE6OZn8P
   SYUtxB/sMh9hWc1NNioS4lAk1SLXzvwN6MnUAeBmIc5j1sOLyOWQ08n8C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="292527051"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="292527051"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:14:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="546666530"
Received: from raltenor-mobl.amr.corp.intel.com ([10.212.200.195])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:14:40 -0700
Date: Mon, 2 May 2022 15:14:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
    andrii@kernel.org
cc: Geliang Tang <geliang.tang@suse.com>, ast@kernel.org, 
    mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH bpf-next v3 6/8] selftests: bpf: verify token of struct
 mptcp_sock
In-Reply-To: <20220502211235.142250-7-mathew.j.martineau@linux.intel.com>
Message-ID: <108060a1-8e8c-6d2b-a3a0-a18dab3e409b@linux.intel.com>
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com> <20220502211235.142250-7-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 2 May 2022, Mat Martineau wrote:

> From: Geliang Tang <geliang.tang@suse.com>
>
> This patch verifies the struct member token of struct mptcp_sock. Add a
> new function get_msk_token() to parse the msk token from the output of
> the command 'ip mptcp monitor', and verify it in verify_msk().
>

Daniel, Andrii,

The z15 CI build failed on this commit, not due to any endianness issue 
but because it appears the z15 CI VM has an older iproute2 version (5.5.0) 
than the x86_64 VM (where the build succeeded).

Do you need us (MPTCP) to change anything?

Thanks!

> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
> .../testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 66 +++++++++++++++++++
> .../testing/selftests/bpf/progs/mptcp_sock.c  |  5 ++
> 3 files changed, 72 insertions(+)

--
Mat Martineau
Intel
