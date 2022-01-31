Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B22CA1
	for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643656206; x=1675192206;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Riwx8VLJpudAzr40JBUoRpT7bRQGjuxqUAyXVR5kP28=;
  b=CitjnDBD6MwWYXg+3TpbSi25xm24ST9jGgmVJiPBPNFUscsI7+3r9zaN
   cwebVhOD5TpzyMXAnOcN1ijZdL9dfqZ0wKdIB5M/gGmcK9ABdPr9cm7ll
   dIuGtG+K93ICKuV4iW/rq2KXyUAIlfh+vlInzcm7lAYv/4W4sGIZCywpI
   OIkEFwXhny/jkjZeM3cT53LrBPMT372dQymGbob0eU0VYl9lJDjXEn/dC
   C3mN55dTiKSVCe5THAEWKVZaMwe3vyFV+XK59ews7/sGaJbAHouRCwgW4
   OZAxbFG/3oKbd3e6oUkaX5+utCpXO5fUcdWnWsMcAy7EQfGfiqh6smmVc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310840733"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="310840733"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:10:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="770868854"
Received: from abilal-mobl1.amr.corp.intel.com ([10.212.252.235])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:10:04 -0800
Date: Mon, 31 Jan 2022 11:10:04 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: Recent backport proposals from the stable team
In-Reply-To: <90560547-a3dc-82ae-8322-65f17f5b11f7@tessares.net>
Message-ID: <e76b4749-cc26-e7cb-1639-713f80135e82@linux.intel.com>
References: <90560547-a3dc-82ae-8322-65f17f5b11f7@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1697454789-1643655612=:8134"
Content-ID: <253d1188-9fb0-35cd-76c9-c75297316de4@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1697454789-1643655612=:8134
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <afe7b418-3895-41cd-19cc-2fab7576659a@linux.intel.com>

On Mon, 31 Jan 2022, Matthieu Baerts wrote:

> Hello,
>
> Recently, Sasha from the stable team queued a few MPTCP patches for
> v5.16 and v5.15.
>
> You can find the complete list there:
>
> -
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16
> -
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15
>
>
> Some patches are fixes with a "Fixes" tag and it makes sense to have
> them backported.
>
>
> Some are "clean up" patches without a "Fixes" tag. I guess they have
> been selected to reduce the difference with Linus' tree and ease
> backports. e.g.:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16/mptcp-clean-up-harmless-false-expressions.patch
>
> In this case, this patch is needed to avoid conflicts with another
> patch: "mptcp: keep track of local endpoint still available for each
> msk", see below.
>

If it's needed for a patch intended for -stable, something like this would 
be ok. But without such a dependency the backport doesn't make sense to 
me. The rules at 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html 
say:

* It must fix a real bug that bothers people

* It must fix a problem that causes a build error (but not for things 
marked CONFIG_BROKEN), an oops, a hang, data corruption, a real security 
issue, or some “oh, that’s not good” issue. In short, something critical.

(among others), and this does neither.

>
> But there are also new features, e.g.:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16/mptcp-allow-changing-the-backup-bit-by-endpoint-id.patch
>
> I don't know why it has been selected but I don't think this is an issue
> to have this backported, does it?
>

It seems odd to me to introduce this new feature in a stable kernel. 
Again, something that doesn't fit the "must fix..." criteria above.

>
> The last one is a fix but slightly changing the behaviour:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.16/mptcp-keep-track-of-local-endpoint-still-available-f.patch
>
> I think it is good to have this fix even if I'm surprised it has been
> selected. Do you have any objection with that?

I don't think this behavior change belongs in -stable. We didn't even 
consider it a suitable change for -net, and haven't reviewed this for 
possible dependencies or interactions with other path manager patches. 
What do you think Paolo?

I think we give fairly careful thought to what we give a Fixes: tag, with 
the (apparently invalid) assumption that those are the patches that are 
eligible for the stable trees.

Is the -stable criteria now "any patch under 100 lines"?


I'm inclined to NAK these. If for some reason we do decide they belong in 
-stable we can add them to a later release.

--
Mat Martineau
Intel
--0-1697454789-1643655612=:8134--
