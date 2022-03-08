Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF22F2F
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 19:23:29 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nRepv-0006tL-Vq; Tue, 08 Mar 2022 19:45:32 +0100
Date: Tue, 8 Mar 2022 19:45:31 +0100
From: Florian Westphal <fw@strlen.de>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220308184531.GA22024@breakpoint.cc>
References: <20220224155010.23676-1-fw@strlen.de>
 <20220224155010.23676-4-fw@strlen.de>
 <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kishen Maloor <kishen.maloor@intel.com> wrote:
> Hi Florian, Paolo,
> 
> I had responded as below to v2 of this series but wondered if perhaps it got lost
> in the barrage of emails. So thought I'd resend it as I still have questions
> regarding our rationale here.
> 
> On 2/24/22 7:50 AM, Florian Westphal wrote:
> > Currently mptcp adds kernel-based listener socket for all
> > netlink-configured mptcp address endpoints.
> > 
> > This has caveats because kernel may interfere with unrelated programs
> > that use same address/port pairs.
> > 
> 
> I assume that this refers to a potential race between a kernel listener and
> the application which Paolo had raised. But I'm not sure if these changes
> eliminate that possibility. Pasting Paolo's example below from the prior discussion:
> 
> """
> s1 = socket()
> bind(s1, A)
> listen(s1)
> // at this point incoming MPTCP connection can be established on s1
> // and ADD_ADDR sub-options could be sent back
> 
> s2 = socket()
> bind(s2, B)
> listen(s2)
> """
> 
> Over a newly established MPTCP connection following listen(s1), the PM can issue an 
> ADD_ADDR with B. In light of this change there would be no listener created for B. 
> But if the remote endpoint immediately established a subflow in response (to the 
> ADD_ADDR), then that would create a subflow (connection) socket at B.
> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).

Why would that fail? You can bind x:y even if there is an established
connection from x:y to q:r.

> In other words, a subflow creation at an address could race with a subsequent bind()
> at that address causing startup issues in the application.

I don't think so.  Its fairly common to implement "graceful restart/update" via
"close(listen); fork(); exit();"-sequence. child continues to handle existing
connections while new process can start & to serve new clients.
