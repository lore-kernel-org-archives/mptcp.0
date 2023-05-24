Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5DC2FD
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 10:05:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q1lNE-0002m3-1J; Wed, 24 May 2023 12:05:40 +0200
Date: Wed, 24 May 2023 12:05:40 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 4/6] mptcp: track some aggregate data
 counters.
Message-ID: <20230524100540.GF17561@breakpoint.cc>
References: <cover.1684863309.git.pabeni@redhat.com>
 <6c8b8ab79ee6526dff0cd3240e35e2e82c300a5d.1684863309.git.pabeni@redhat.com>
 <20230523184911.GC17561@breakpoint.cc>
 <df6358ce88b497eed93dff304840ddb79fba06f4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6358ce88b497eed93dff304840ddb79fba06f4.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > __aligned_u64 is preferred for uapi.
> 
> Ouch! We already have a few __u64 in the same struct.
> 
> Should we mix __u64 and __aligned ones? By pure luck, the both existing
> __u64 and the new one should be aligned, even without the annotation.

I'd leave the existing fields as-is, changing this now doesn't buy
us anything.
