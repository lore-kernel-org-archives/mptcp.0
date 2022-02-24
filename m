Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127F7A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 00:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645662340; x=1677198340;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=EOve+BGY9oQTV9WAlpXZcrGMkfEGvP39EEoZClgMknc=;
  b=BAPx1KmM0WYnnTMxmwrnX/R3ya0Te/0Y+TGT46Jagcu6sH9Z5zJBI6k5
   xRsLhRLL4ANaaPqFkbI0/Oa6Gi3QwGUywiBOq3cyDssWL45BhqnC+RK90
   u7yByBzLfUkzR62LI2APnubx5oBdORHoZ4ui6oDziSLqVToxBUNMn6xO7
   gekRbq3fU5Sm7xIXbLzH4qmzN+2mTbXmdG5AZxOZRy3U5JsIfU7eaCMMF
   B8SibnKi5ehLQgVHkuVhJdZDE2jTfYRNxfbdKZI9PY6jdmmZPVPtdzeOI
   CeJ/7F8bZA4SvWmiLDfRt/aA8hbhB6pBTEYidOd0T7K7eLFapP9gSnaTY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252307460"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="252307460"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:25:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="506123225"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:25:39 -0800
Date: Wed, 23 Feb 2022 16:25:39 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/3] Upstreaming cleanup
In-Reply-To: <ec7dea0e-36cd-4a47-daf2-ae4e2cb20aa3@tessares.net>
Message-ID: <7120fc8c-cb24-c54f-67fd-5aaa7d32f8b@linux.intel.com>
References: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com> <ec7dea0e-36cd-4a47-daf2-ae4e2cb20aa3@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-32647968-1645659885=:31148"
Content-ID: <4c637b9b-ca78-a075-1f74-a4aa19369639@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-32647968-1645659885=:31148
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <84bf9ed5-1d31-8378-e9e4-ba1265f8c8b1@linux.intel.com>

On Sat, 19 Feb 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/02/2022 23:18, Mat Martineau wrote:
>> The most recent patch series I upstreamed for -net needed a couple of
>> tweaks to mitigate net/net-next merge conflicts. The first two patches
>> here update the commits in "fixes net" on the export branch to match
>> what I sent upstream, and the third patch restores Paolo's function
>> rename in mptcp_join.sh.
>
> Thank you for these patches!
>
> I was thinking a bit about how to avoid such "issues" in the future.
> Here are some ideas:
>
> - there could be 2 separated trees periodically updated:
>  - one for net-next, the one we have for the moment
>  - one for -net: a new one
>  → all patches for the -net tree would be duplicated in both trees
>  → when applying patches in the -net tree, we will notice the conflicts
>  → applying the different patches can be automated with the scripts I'm
> currently using
>
> - there could be 2 mixed trees periodically updated:
>
>
>            top
>
>             ^
>             |
>
>    commits for net-next
>
>             ^
>             |
>
>    merge net + net-next
>
>             ^
>            / \
>               \
>    net-next    \
>                 \
>
>                commits for -net (+ commits for the CI)
>
>                   ^
>                   |
>
>                  net
>
>
>  → no duplicated -net commits
>  → the "export" branch will be on top of net and net-next
>  → "mptcp: use kmalloc on kasan build" could be cherry-picked on top of
> the "export" branch for the -net tree not to have it "under" the ones
> for net-next.
>
> In both cases, it would be easy to export the different commits and have
> different tags that can be used by the CI.
>
> The second case looks interesting to me but there are at least two main
> points to be careful with:
>
> - if the "export" branch is on top of the net-next branch, it means the
> patches we have in the tree might no longer apply as is in net-next:
> that's the opposite situation as of today where the patches for -net are
> on top of net-next. I think that's fine because we would have this issue
> in any case if a patch for net-next depend on one that has been
> queued/applied in -net but is not in net-next yet.
>

I don't think it changes the situation for the mptcp-next patches - even 
today, they are on top of the mptcp-net patches which is what would 
potentially cause problems sending to net-next.

Since I apply the patches to net-next and resolve conflicts before sending 
to netdev, it's not too big of a concern. I think your proposal here is an 
improvement because fewer adjustments will be needed when sending the -net 
patches to netdev.


I would adjust your diagram this way:


            export

              ^
              |

     kmalloc on ksan build

              ^
              |

     commits for net-next

              ^
              |

     merge net + net-next

              ^
             / \        export-net
                \      /
     net-next    \    kmalloc on ksan build
     (rebase      \  /
      daily)
                 commits for -net (+ commits for the CI)

                    ^
                    |

                   net (rebase on upstream net-next sync,
                        as you suggest below)

Then people could check out export-net when developing mptcp-net patches.

> - there might be conflicts / build / validation issues from elsewhere
> to resolve when merging net-next with -net: conflicts in non MPTCP
> parts. They will have to be resolved before they are resolved in
> net-next tree. Workaround is not update the "net" base in case of
> conflicts until the sync is done by the -net maintainers: easy to put in
> place in case of conflicts, a bit less for the build / validation issues
> but that's probably rare. A lot of stuff are modified in the -net tree
> with all the different protocols, drivers and BPF! It is not rare to
> have conflicts if you look at:
>
>  $ git log --grep 'Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net' net-next
>

That sync-net-when-upstream-does workaround sounds good to me. I agree, 
it's not rare for those net/net-next conflicts to happen, and since we are 
carrying our own patches until the -net rebase anyway I think it all works 
out. 'git merge-base net/master net-next/master' gives the relevant -net 
commit.

If we wanted advance warning, the CI could attempt a rebase of the 
mptcp-net commits on the current net/master (sort of a dry run) and notify 
if that had any conflicts.

> What do you think?
> First, do we need a solution?

It's not absolutely critical, but I think it's a worthwhile improvement.

This wouldn't prevent the net/net-next conflicts that I was asking about 
in this thread, since those were due to upstreaming some net-next patches 
before the conflicting -net patch was even available. Normally it will be 
better to prioritize the -net patches for upstreaming, and check for 
net-next conflicts while there are MPTCP patches in -net that haven't been 
synced yet. This kind of conflicting net-next patch can typically be 
delayed until the net/net-next sync.


Even so, updating the export structure is worth it given that the -net 
patches are somewhat more sensitive (as we have less opportunity to 
correct problems before release). This makes placing the mptcp-net commits 
on top of the -net history a safer way to go.

> Then would it be OK with the second solution, especially in case of
> conflicts/build/validation issues? If not, would the first solution
> helps? Or another one?
>

I prefer the second solution (with the adjustments for the export-net 
branch). The way the first proposal maintains two versions of the 
mptcp-net patches would be harder to keep track of.

--
Mat Martineau
Intel
--0-32647968-1645659885=:31148--
