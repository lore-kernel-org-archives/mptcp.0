Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A765127
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646863900; x=1678399900;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jFU3V6xyT/IJ4hIKDygO7c2ewdJathM5JjyZQfi4wBE=;
  b=PIq3GnbDu5pqNdDInJUsQlZkBwQRv+Fy69GovtvHj/THQ8FX+689i8YA
   RViuXL+45WdGKgxP5DFtGc6H0f2amiRteY7/rbvO7CFIRNn4/27E0WqTL
   hFvPEXd8ENZuoE3TWKpFKlwV2mDMg8JKAwfBjpyM5k6iwfteT3SYRZW/s
   XiTCKlS2N7KRIVCddNgg0RcGmMJIlDmi05n0Mt/e2IfP5B7URyHxRLsKN
   E4MB3mQxqpKMQvIkDJ1DnjEjYlt3LBjIM5o7MLgmHaQ2ou4NVqoUjVoGG
   nrnx/bh/98rPKTzRmoUK1SMetUT+rNXy87RFCj36mDn3lKIKvcsByjXhY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255291470"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255291470"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:11:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="815219820"
Received: from amadhuso-mobl2.amr.corp.intel.com ([10.212.252.248])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:11:39 -0800
Date: Wed, 9 Mar 2022 14:11:39 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: Fix crash due to tcp_tsorted_anchor was initialized
 before release skb
In-Reply-To: <9a9d0b82106b6c3d486da009da5592ef97c5deaf.camel@redhat.com>
Message-ID: <0f254c5-cdf3-f6-9e42-19fdd81d2d@linux.intel.com>
References: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn> <9a9d0b82106b6c3d486da009da5592ef97c5deaf.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Mar 2022, Paolo Abeni wrote:

> On Wed, 2022-03-09 at 18:20 +0800, Yonglong Li wrote:
>> get crash when do pressure test of mptcp:
>
> Ouch!
>
>> ===========================================================================
>> dst_release: dst:ffffa06ce6e5c058 refcnt:-1
>> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>> BUG: unable to handle kernel paging request at ffffa06ce6e5c058
>> PGD 190a01067 P4D 190a01067 PUD 43fffb067 PMD 22e403063 PTE 8000000226e5c063
>> Oops: 0011 [#1] SMP PTI
>> CPU: 7 PID: 7823 Comm: kworker/7:0 Kdump: loaded Tainted: G            E
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.2.1 04/01/2014
>> Call Trace:
>>  ? skb_release_head_state+0x68/0x100
>>  ? skb_release_all+0xe/0x30
>>  ? kfree_skb+0x32/0xa0
>>  ? mptcp_sendmsg_frag+0x57e/0x750
>>  ? __mptcp_retrans+0x21b/0x3c0
>>  ? __switch_to_asm+0x35/0x70
>>  ? mptcp_worker+0x25e/0x320
>>  ? process_one_work+0x1a7/0x360
>>  ? worker_thread+0x30/0x390
>>  ? create_worker+0x1a0/0x1a0
>>  ? kthread+0x112/0x130
>>  ? kthread_flush_work_fn+0x10/0x10
>>  ? ret_from_fork+0x35/0x40
>> ===========================================================================
>>
>> in __mptcp_alloc_tx_skb skb was alloced and skb->tcp_tsorted_anchor will be
>> initialized,  in under memory pressure situation sk_wmem_schedule will
>> return false and then kfree_skb. In this case skb->_skb_refdst is not null
>> because_skb_refdst and tcp_tsorted_anchor are stored in the same mem, and
>> kfree_skb will try to release dst and casue crash.
>
> Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache"
>
>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/protocol.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 3cb9752..fbb14df 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1199,6 +1199,7 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
>>  		tcp_skb_entail(ssk, skb);
>>  		return skb;
>>  	}
>> +	tcp_skb_tsorted_anchor_cleanup(skb);
>>  	kfree_skb(skb);
>>  	return NULL;
>>  }
>
> LGTM!
>
> Reviewed-by: Paolo Abeni <pabeni@redhat.com>

I agree, looks good for mptcp-net (with the recommended Fixes tag)

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
