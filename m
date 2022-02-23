Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960864E
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 01:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645578120; x=1677114120;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tsUx8zCVNFoGPD7BoTGb+5k3WXAugEY0FKutQ9eSDJA=;
  b=BBJu6Bq7wFYvpCMOhuZvFKgL6bS1f3ilOPSanTFfGXrgYyovUljEF0rw
   z7sOURc8Bw4MEicyV7r/vJiI94Xm0sFjKbvq45KbLrkXG1hpNst6Vz9P0
   7vQnPcsAbZWISJ9jSVq7Usm0i9ZT92v1ZqD2D6D6acjrfrNqIlbWJqaGt
   8TakgybneJY62jhZrdRzRJQi7Otk9e6I51eC7NXErstrbF32aaoyDxNgz
   2N7DlgQdGC0wd0tdx54vgCJnRiig3ZtKnmO4Wn9Cya27oNj5hIyyNTfmP
   OqykYGFpzgrlJRkQLyFaq3PchTUzrDou7cnd3IgA37gYjNEyhU0UpVpCj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232474962"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="232474962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 17:01:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="683720861"
Received: from fdwikusu-mobl.amr.corp.intel.com ([10.251.6.85])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 17:01:49 -0800
Date: Tue, 22 Feb 2022 17:01:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add fullmesh flag check for adding
 address
In-Reply-To: <7cba6dc-53a-29a5-a684-6f47a39cf568@linux.intel.com>
Message-ID: <1ddfecf1-9c3f-1b8b-caf3-fa1a4771b7f0@linux.intel.com>
References: <02d082c77c58ed6400d319d40e719a4ebe4e7942.1645419055.git.geliang.tang@suse.com> <7cba6dc-53a-29a5-a684-6f47a39cf568@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Feb 2022, Mat Martineau wrote:

> On Mon, 21 Feb 2022, Geliang Tang wrote:
>
>> The fullmesh flag mustn't be used with the signal flag when adding an
>> address. This patch added the necessary flags check for this case.
>> 
>
> Hi Geliang -
>
> What happens if FULLMESH and SIGNAL are used together with the existing code? 
> Is this a patch that should go to -net with a Fixes: tag?
>

Nevermind about the -net question, I see "mptcp: set fullmesh flag in 
pm_netlink" is only in net-next. Also, the check is already in 
mtpcp_nl_cmd_set_flags(), so this is adding similar code to 
mptcp_cmd_add_addr().

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> net/mptcp/pm_netlink.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index a0e7d5b7e22f..e3b0384ff79a 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1253,6 +1253,12 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff 
>> *skb, struct genl_info *info)
>> 		return -EINVAL;
>> 	}
>> 
>> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
>> +	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
>> +		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and 
>> fullmesh");
>> +		return -EINVAL;
>> +	}
>> +
>> 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
>> 		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
>> 		return -EINVAL;
>> -- 
>> 2.34.1
>> 
>> 
>> 
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel
