Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C315A9
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 01:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28E8C433C8;
	Tue, 15 Aug 2023 01:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692061365;
	bh=Y2Pl9/BkJ4Izxkt0vJrzU/45JmfO80bHk/wgCEi2TuM=;
	h=Date:From:To:Subject:From;
	b=f1Gcb6n6Htwe+OaKY5+HC+GtCyD19yI4lVDIP9f/z4tLsqR0ne6mHYqORAVTz+JGu
	 fb4Ub4TG8II9gKhx2i6SnPOXJENchWAnpGSgFhEwrozMauINMxjiflCqBqukuxyzVK
	 J1FZu60H41T6L5DqsnFaelOZPkkflFzJ6ishD6KzWDPOajRcX0L1Fc3lD8Vqfm3RTl
	 VWb1Espgt50EYqlseVr0A4tEsMhoLFuZxtpdLsdAGUC41oAbsLd//HcK4pz2MlcvkX
	 ayE+1V098K/SgOErV3UbLwXlf5Xg01+sPD5TPbwBzp+bCIpLhC+vYukrWIeCDEc0aM
	 N5thE1H8uf6Jg==
Date: Mon, 14 Aug 2023 18:02:45 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: geliang.tang@suse.com, mptcp@lists.linux.dev
Subject: Scheduler refactor commits: code questions
Message-ID: <973390df-fe63-229e-9987-392d57074728@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Geliang -

I was looking at the scheduler refactor commits for upstreaming to netdev:

b3eda17b9f4e mptcp: refactor push_pending logic
8a826e0f4298 mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
2f1da15cd21e mptcp: add struct mptcp_sched_ops
ff4770e3fee6 mptcp: add a new sysctl scheduler
71187ddaa425 mptcp: add sched in mptcp_sock
78c8f8a71068 mptcp: add scheduled in mptcp_subflow_context
077f054fad53 mptcp: add scheduler wrappers
ac4613e3e9db mptcp: use get_send wrapper
4c58a0581cff mptcp: use get_retrans wrapper
5570526ef063 mptcp: register default scheduler


and I have a couple of questions before sending these patches.


1. Do you remember why "mptcp: add struct mptcp_sched_ops" has two 
function pointers (data_init and get_subflow)? They take the same 
parameters, and are always called together. What do you think about 
eliminating the data_init pointer and combining all of the data_init() and 
get_subflow() implementations for all the schedulers? It gets rid of an 
indirect function call for the default scheduler, and eliminates the 
overhead of a BPF call for BPF schedulers.


2. After "mptcp: register default scheduler", the faster direct call code 
paths ("if (!msk->sched) ...") in mptcp_sched_get_send() and 
mptcp_sched_get_retrans() are no longer used for the default scheduler. If 
that condition also checked for the default scheduler, it could directly 
call mptcp_sched_default_get_subflow() to make a direct function call and 
eliminate some duplicate code:

 	data.reinject = false;
 	if (msk->sched == mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_subflow(msk, &data);
 	else
 		return msk->sched->get_subflow(msk, &data);


Thanks,

Mat
