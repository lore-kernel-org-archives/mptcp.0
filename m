Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C562C9C
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641950879; x=1673486879;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XsSR0E6vsLewSUfZPECD56JYBpRHcSnF8dCyuzpZ5zQ=;
  b=SI+u67fvKEzxiYHe3qKma9Puw8Hf4yPCBR46+n93RrCPW0ykfdVyOLvd
   8Wewubc70ZC/HMLLR7msXYWtJnxzsiOXc/B81KObs68bySbTDMPOErp02
   cvtWzXvmPtf8YygTq7yJEKc8Pj6zpmv7Or2z+5cTsYNL04/4/+7Qrne5k
   eCfUHhapXBb8lYcwqCO6EGopBcpMaxufXQXjaNV4otDE6539B+xpVbOir
   YCyDaPwmw1fR03RTaKFQUKJ7Gt7pbUd4edry3D5WAN8UJ+Ip2bjdxGqrU
   YMO329Oqu5D0rKfWXT/JMTfDszbG88ZjB3JOS+s9oWUDUW1FBSsAMsGx+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="329982449"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="329982449"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:27:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="592864179"
Received: from tcastee-mobl.amr.corp.intel.com ([10.209.73.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:27:59 -0800
Date: Tue, 11 Jan 2022 17:27:58 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: fix removing ids bitmap setting
In-Reply-To: <fd0d593b0f088f5024b7a9a5f292bae4e67d6dde.1641868302.git.geliang.tang@suse.com>
Message-ID: <e9e6633-227f-f9a4-cc1b-ae4e5eb97749@linux.intel.com>
References: <fd0d593b0f088f5024b7a9a5f292bae4e67d6dde.1641868302.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 11 Jan 2022, Geliang Tang wrote:

> In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
> id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.
>
> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - move out of the set fullmesh flag series.
> - update the subject name.
> - add Paolo's Acked-by tag.

Geliang -

Thanks for catching this! I agree with Paolo, looks good for the export 
branch (mptcp-net section).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/pm_netlink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f12effa71942..47ad00d01cf2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -777,7 +777,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 			removed = true;
> 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> 		}
> -		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
> +		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
> 		if (!removed)
> 			continue;
>

--
Mat Martineau
Intel
