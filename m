Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3252C81
	for <mptcp@lists.linux.dev>; Sat, 16 Oct 2021 00:12:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="288872131"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="288872131"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 17:12:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="525592977"
Received: from jwbates1-mobl1.amr.corp.intel.com ([10.212.131.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 17:12:56 -0700
Date: Fri, 15 Oct 2021 17:12:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [RFC PATCH v2] selftests: mptcp: more stable simult_flows
 tests
In-Reply-To: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
Message-ID: <32692122-28e1-4028-36c4-43649e2fa629@linux.intel.com>
References: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Oct 2021, Paolo Abeni wrote:

> Currently the simult_flows.sh self-tests are not very
> stables, expecially when running on slow VM.
>
> The tests mesures runtime for transfers on multiple subflows
> and check that the time is nearby the theoretical maximum.
>
> The current test infra introduces a bit of jitter in test
> runtime, due to multiple explicit delays. Additionally the
> runtime is measured by the shell script wrapper. On slow
> VM, the script overhead is measurable and subject to relevant
> jitter.
>
> One solution to make the test more stable would be adding more
> slack to the expected time; that could possibly hide reall
> regressions. Instead move the measurement inside the command
> doint the transfer, and drop most unneeded sleep.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> @matttbe: could you please double check this makes simult_flows
> tests really more stable in your testbed?
>
> Now the slack is really quite tight, I think we can raise it a
> little more, without loosing the ability of catching regressions


I still get occasional failures on my slow desktop VM (lots of debug 
features turned on), but a little more slack would help. Most of the time 
all cases succeed. If I see a failure, it's just one test out of the 
batch. These are each from separate runs of simult_flows.sh:

unbalanced bwidth                                           transfer slower than expected! runtime 4500 ms, expected 4005 ms max 4005        [ fail ]


unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 4632 ms, expected 4005 ms max 4005        [ fail ]


Curious to see Matthieu's results!

--
Mat Martineau
Intel
