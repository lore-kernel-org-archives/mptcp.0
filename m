Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5D29CA
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 22:55:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236674549"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="236674549"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:55:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513061647"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.65.201])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:55:01 -0800
Date: Thu, 2 Dec 2021 14:55:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 2nd of December 2021
In-Reply-To: <2391147c-2480-5188-d538-595727e01b05@tessares.net>
Message-ID: <fe1bc586-1aa7-55ba-bf41-a18849e6d3bc@linux.intel.com>
References: <2391147c-2480-5188-d538-595727e01b05@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Thu, 2 Dec 2021, Matthieu Baerts wrote:

>
>    - news about Intel's kbuild? (Mat):
>        - Saw one mptcp_join.sh failure but probably already seen by the
> public CI (unstable test)
>

This failure was a missing ADD_ADDR echo:

user  :notice: [  501.625742] # 41 add multiple addresses IPv6          syn[ ok ] - synack[ ok ] - ack[ ok ]
user  :notice: [  501.676759] #                                         add[ ok ] - echo  [fail] got 1 ADD_ADDR echo[s] expected 2
user  :notice: [  501.690104] #
user  :notice: [  501.695183] # Server ns stats
user  :notice: [  501.705037] # MPTcpExtMPCapableSYNRX          1                  0.0
user  :notice: [  501.715549] # MPTcpExtMPCapableACKRX          1                  0.0
user  :notice: [  501.726495] # MPTcpExtMPJoinSynRx             2                  0.0
user  :notice: [  501.737151] # MPTcpExtMPJoinAckRx             2                  0.0
user  :notice: [  501.747762] # MPTcpExtEchoAdd                 1                  0.0
user  :notice: [  501.757498] # Client ns stats
user  :notice: [  501.764657] # MPTcpExtMPCapableSYNTX          1                  0.0
user  :notice: [  501.776142] # MPTcpExtMPCapableSYNACKRX       1                  0.0
user  :notice: [  501.786696] # MPTcpExtMPJoinSynAckRx          2                  0.0
user  :notice: [  501.797269] # MPTcpExtAddAddr                 2                  0.0


Given that the client received two ADD_ADDRs, it could have been a few 
different things:

* Echo packet was sent but dropped, and the test finished before the
   retransmit (the default add_addr timeout is quite long) (not a bug)

* Echo packet was never sent (maybe a bug, maybe not)


There isn't enough logged to narrow it down more, so I will watch for 
similar failures. Looks like most of the recent Cirrus CI mptcp_join.sh 
failures are related to missing RM_ADDRs.


--
Mat Martineau
Intel
