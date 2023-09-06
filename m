Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FDEDB
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 17:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D0C433C7;
	Wed,  6 Sep 2023 17:21:52 +0000 (UTC)
Date: Wed, 6 Sep 2023 18:21:50 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZPi1LvrcGcSKBLqR@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>

On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
> On Sep 4, 2023, at 2:22 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Not sure which RCU variant you are using but most likely the false
> > positives are caused by the original reference to the object being lost
> > and the pointer added to a new location that kmemleak does not track
> > (e.g. bnode->records[] in the tree-based variant).
> > 
> > A quick attempt (untested, not even compiled):
> 
> I tried out your patch. It does resolve the false positive !
> 
> However, I am occasionally getting a report of a single object being
> leaked. When I try to visualize it with `cat
> /sys/kernel/debug/kmemleak`, the object does not show up anymore…

How often do you trigger the scanning? Since kmemleak does not stop the
world (as some garbage collectors do), there's potential for false
positives (e.g. a reference to it is in a register on some CPU while
being moved from one list to another). The heuristics employed for this
is to checksum the object and only report if the checksum has not
changed in successive scans. But this is still problematic if scanning
is done quickly in succession. The default 10min scanning (even 1min)
shouldn't be an issue.

I had a plan to do a "stop_scan" option (using stop_machine) but never
got the time to do this.

> If you have an updated patch, let me know. I can test it.

I sent it in reply to Joel.

Thanks.

-- 
Catalin
