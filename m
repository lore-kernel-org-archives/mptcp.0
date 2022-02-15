Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA8ED0
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 01:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644887982; x=1676423982;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tqLRAcGcxu1c/xA9XOxt7bvTi4uO0GBU4LjyRaGHoKc=;
  b=Av68gMYIGa9baumHr0kwZ7GNdQ+n/4gtHioeeg1g+f4C54/pT92lb1Tq
   PAZvpexZhJHRi1AyMQd/R8rpf170DVC6mXcK6GP+fsLBmfRdZ3AyprKY7
   9HNIPUUQJgpHtNwG1GA1YhH5iu4mM9oVacCd8V5iBjgnDqF8ZM1N/C+U7
   tb7mHZKUmOncjmiScZH/PM0ULKGqEuu7t7rWJvF/s2fzVElxw16jcVhtv
   gc2WludhBbnF7jXgqzM/Bq4CEd6oVm5ewaBOX+BSBkmFqpS845NXTynjW
   TyDsyjeL8/MfsedG+khQW2ByFup1krZUzgBKGyg4IZpPSORocmZUnNh5y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336650905"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="336650905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:19:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="544017460"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:19:41 -0800
Date: Mon, 14 Feb 2022 17:19:40 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 2/3] mptcp: more careful RM_ADDR
 generation
In-Reply-To: <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>
Message-ID: <5a284b53-23e5-fded-a242-3a5fbc431eae@linux.intel.com>
References: <cover.1644852970.git.pabeni@redhat.com>  <9ac38525eac5d4e812fd11f20125e28edd8514df.1644852970.git.pabeni@redhat.com> <38393366b636adfcf8b5eecf08e92c6b4394dd9a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 14 Feb 2022, Paolo Abeni wrote:

> On Mon, 2022-02-14 at 16:38 +0100, Paolo Abeni wrote:
>> In some edge scenarios, an MPTCP subflows can use a local address
>> mapped by a "implicit" endpoint created by the in-kernel path manager.
>>
>> When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
>> suboption. That is somewhat unexpected, as an MPTCP listener will keep
>> accepting incoming subflows targeting such address and the unexpected
>> options can confuse some self-tests.
>>
>> Be more conservative about RM_ADDR generation: explicitly track the
>> implicit endpoint with an appropriate flag and exclude them from the
>> RM_ADDR generation.
>>
>> Additionally allow the user-space to replace implicit endpoint with
>> user-provided data at endpoint creation time.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> The CI still reports an issue on top of this patch:
>
> https://cirrus-ci.com/task/5380046008352768?logs=test#L7283
>
> Even if the symtom is the same, the root cause is different. I think
> such failure is caused by the flush operation deleting both all
> existing endpoints and all the existing subflows for each MPTCP socket.
>
> Even when the subflow is not attached to any known, non implicit,
> endpoint.
>
> When we have simult flush on both sides, deleting the subflow (with no
> endpoint) on one end can make disappear the subflow on the other end
> (tied to a local endpoint) before the PM could generate the relevant
> RM_ADDR.
>

If we aren't closing all subflows during the flush, shouldn't there be at 
least one subflow where the RM_ADDR can be sent?

Maybe mptcp_pm_nl_addr_send_ack() needs to pick a better subflow for 
sending the RM_ADDR. Do you think it would help to make 
mptcp_subflow_send_ack() return a bool, and only return true if the ack 
was sent? Then it could retry the ack on other subflows in the conn_list, 
until it finds one that works or they all fail.


> Overall the number of generated RM_ADDR become impredictable, even if
> the testcase is quite stable, to the point I could not replicate the
> failure reported by the CI.
>
> AFAICS, there are 2 possible solutions:
>
> - avoid flushing both ends in test-cases "flush subflows" and "flush
> addresses". This is very simple, but could hide other (currently
> unknown) problems.
> - change mptcp_nl_cmd_flush_addrs() to only delete subflows tied to
> known, non implicit, endpoint. That is possibly a saner behavior for ip
> mptcp endpoint flush, but will need more testcases to be adjusted and
> is still a change of behaviour.
>
> Any hint on the preferred option more than welcome!



--
Mat Martineau
Intel
