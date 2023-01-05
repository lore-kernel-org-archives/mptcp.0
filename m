Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D37621
	for <mptcp@lists.linux.dev>; Thu,  5 Jan 2023 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672878479; x=1704414479;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JUy0TmDms+wDGJY5KwOkzWuWNDXZYGDX0NH62lDckfM=;
  b=SFChw9oxrGVzs1vLHrIVUBjg14+GVZEM76zN5SSA9lBhW9RSItWf84RK
   L9VmlpbaOmFxbnqWCmJMU01j9mzPGWPV2QEz+AwONQgloweji26EsaTHz
   5nRGC8V4RPo+5vc4jufOF4dWg6DQ2dmG9F8cepfOTu7T7mAYChmw1ioOO
   kAfcP9eERkr9lMBag9DTNpRbVf8OhO8qHBZschb1BcHEaNjMmWI1RghC9
   LIQ8hjsxNhMjnJ+w6sKXluZofqC+D/J7q3ghb12IWUCpuYrYVQ4lK1ylp
   JjgLQEUV3wIfA+bzAvkxrGKZoKKOYjXE29hzTas+Po4So5fUJEgunOZiq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="386517928"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="386517928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:27:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="797718353"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="797718353"
Received: from lakkired-mobl1.amr.corp.intel.com ([10.212.143.9])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:27:58 -0800
Date: Wed, 4 Jan 2023 16:27:57 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 3rd of January 2022
In-Reply-To: <d01f9328-3469-2ea8-d207-f5ea24b341e7@tessares.net>
Message-ID: <1918d8f6-47aa-054a-f859-902a4a13f8b1@linux.intel.com>
References: <d01f9328-3469-2ea8-d207-f5ea24b341e7@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Wed, 4 Jan 2023, Matthieu Baerts wrote:

> Patches to send to netdev:
>
>    - Fixes for other trees: /
>
>    - Fixes for -net: /
>
>    - Fixes for net-next: /
>
>    - Features for net-next:
>
>        - [760b7619015e] mptcp: use msk_owned_by_me helper (Geliang Tang)
>        - [2d1f1999916a] mptcp: use net instead of sock_net (Geliang Tang)
>        - [7d1a091c596d] mptcp: use local variable ssk in write_options
> (Geliang Tang)
>        - [017ea57bcf09] mptcp: introduce 'sk' to replace 'sock->sk' in
> mptcp_listen() (Menglong Dong)
>        - [944e5425715a] mptcp: init sk->sk_prot in build_msk()
> (Menglong Dong)
>        - [cb22370bcc5a] mptcp: rename 'sk' to 'ssk' in
> mptcp_token_new_connect() (Menglong Dong)
>        - [647661f97d3f] mptcp: add statistics for mptcp socket in use
> (Menglong Dong)
>        - [a39c64febbd5] selftest: mptcp: exit from copyfd_io_poll()
> when receive SIGUSR1 (Menglong Dong)
>        - [2f1882aa4aca] selftest: mptcp: add test for mptcp socket in
> use (Menglong Dong):
>            - can be sent but net-next is still closed
>            - Note: net-next has been re-opened a few hours after the
> meeting
>

While net-next is open, it hasn't been synced with -net in a couple of 
weeks and there's a conflict with our locking fixes in -net.

Jakub mentioned that the -net PR goes to Linus tomorrow, so that will 
clear the way for upstreaming the net-next feature patches.

--
Mat Martineau
Intel

